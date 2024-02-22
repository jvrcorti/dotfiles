function venvactivate
    # Ruta al directorio que deseas verificar
    set directorio_objetivo "$HOME/Desktop/workspace/virtualenv/"

    # Verificar si el directorio existe
    if test -d $directorio_objetivo
        # Entrar al directorio
        cd $directorio_objetivo

        # Verificar si ya existe un entorno virtual
        if test -f virtualenv/bin/activate
            echo "Activando entorno virtual..."
            source virtualenv/bin/activate
        else
            echo "No se encontró un entorno virtual en el directorio."
        end
    else
        echo "El directorio no existe."
    end
end

