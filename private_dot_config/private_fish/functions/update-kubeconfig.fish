function update-kubeconfig

    set -e KUBECONFIG
    for x in ~/.kube/*
        if test -f $x
            echo $x
            set -l FILE (string split -m1 -r '/' "$x")[2]
            set -a FILES $HOME/.kube/$FILE
        end
    end

    echo $FILES

    set -Ux KUBECONFIG (string join ":" $FILES)
    echo $KUBECONFIG
end