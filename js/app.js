const exploreTree =
    document.getElementById("exploreTree");

const startLearning =
    document.getElementById("startLearning");


/* EXPLORE TREE */

exploreTree.addEventListener(
    "click",
    () => {

        document
            .getElementById("treeSection")
            .scrollIntoView({
                behavior: "smooth"
            });

    }
);


/* START LEARNING */

startLearning.addEventListener(
    "click",
    () => {

        document
            .getElementById("treeSection")
            .scrollIntoView({
                behavior: "smooth"
            });

    }
);