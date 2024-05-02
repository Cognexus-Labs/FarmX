import { Feature } from "@/types/feature";

const featuresData: Feature[] = [
  {
    id: 1,
    icon: "/images/icon/icon-01.svg",
    title: "Crop Recommender System",
    description:
      "A machine learning model trained on a dataset of recommended crops and soil data to recommend the best crops to farmers based on their soil composition and environmental conditions.",
  },
  {
    id: 2,
    icon: "/images/icon/icon-02.svg",
    title: "Crop Disease Detector",
    description:
      "Built using Python and TensorFlow, and utilizes a deep learning model (Efficientnet) trained on a large dataset of crop images to identify common crop diseases, then we provide recommendations for treatment.",
  },
  {
    id: 3,
    icon: "/images/icon/icon-03.svg",
    title: "Mobile App",
    description:
      "Built using the Flutter framework, and allows farmers to access the crop recommender system and crop disease detector from their mobile devices.",
  },
  {
    id: 4,
    icon: "/images/icon/icon-04.svg",
    title: "IoT",
    description:
      "FarmX IoT device enables farmers to be more precise about thier farm climate and soil data.",
  },
  {
    id: 5,
    icon: "/images/icon/icon-05.svg",
    title: "Wiki",
    description:
      "The Wiki is built specially for learning, blogposts and articles that farmers can use to learn new developments in agriculture and regenerative ways to farm.",
  },
];

export default featuresData;
