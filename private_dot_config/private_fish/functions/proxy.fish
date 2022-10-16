function proxy -a cmd -d "Handles proxy settings"
    set -l STATUS "status"
    set -l LIST "list"
	set -l ON "on"
	set -l OFF "off"
    set -l TOGGLE "toggle"
    set -l IS_ON "is-on"
    set -l IS_OFF "is-off"
    set -l available_commands $STATUS $ON $OFF $TOGGLE $LIST $IS_ON $IS_OFF

    set -l PROXY_ENVS ALL_PROXY HTTP_PROXY HTTPS_PROXY FTP_PROXY
    set -l NO_PROXY_ENVS NO_PROXY

    set -l STANDARD_PROXY "http://proxy.sr.se:8080"
    set -l STANDARD_NO_PROXY "localhost,127.0.0.1,::1,.sr.se"

    if [ -z "$cmd" ]
		set cmd $LIST
	else if not contains $cmd $available_commands
		set_color red
		echo "$_: invalid command, use $available_commands instead"
		set_color normal
		return 1
	end

    # Get current proxy status: on/off
    if [ $cmd = $STATUS ]
        if [ -z $HTTPS_PROXY ]
            echo off
        else
            echo on
        end
    end

    # Exit 0 if on, else exit 1
    if [ $cmd = $IS_ON ]
        if test (proxy status) = $ON
            echo Yes. Proxy is on.
            return 0
        else
            echo No. Proxy is off.
            return 1
        end
    end

    # Exit 0 if off, else exit 1
    if [ $cmd = $IS_OFF ]
        if test (proxy status) = $OFF
            echo Yes. Proxy is off.
            return 0
        else
            echo No. Proxy is on.
            return 1
        end
    end

    # Show current proxy settings
    if [ $cmd = $LIST ]
		for i in (seq (count $PROXY_ENVS))
            set -l VAL $$PROXY_ENVS[$i]
			echo -s $PROXY_ENVS[$i] ': ' $VAL
		end

        for i in (seq (count $NO_PROXY_ENVS))
            set -l VAL $$NO_PROXY_ENVS[$i]
			echo -s $NO_PROXY_ENVS[$i] ': ' $VAL
		end

        return 0
	end

    # Set proxy settings to on
    if [ $cmd = $ON ]
        for i in (seq (count $PROXY_ENVS))
            set -xU $PROXY_ENVS[$i] $STANDARD_PROXY
		end

        for i in (seq (count $NO_PROXY_ENVS))
            set -xU $NO_PROXY_ENVS[$i] $STANDARD_NO_PROXY
		end
        
        return 0
    end

    # Set proxy settings to off
    if [ $cmd = $OFF ]
        for i in (seq (count $PROXY_ENVS))
            set -eU $PROXY_ENVS[$i]
		end

        for i in (seq (count $NO_PROXY_ENVS))
            set -eU $NO_PROXY_ENVS[$i]
		end
        
        return 0
    end
end