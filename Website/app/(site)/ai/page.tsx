import ChatAssistant from "@/components/ChatAssistant";
import { Metadata } from "next";

export const metadata: Metadata = {
  title: "FarmX AI",
  description: "FarmX Chat Assistant",
  // other metadata
};

const Ai = async () => {
  return (
    <>
      {/* Heading with Farmer's AI companion */}
      <section className="py-2 lg:py-2 xl:py-3">
        <div className="mx-auto mt-20 max-w-c-1280 px-4 md:px-8 xl:mt-30 xl:px-0">
          <h2 className="text-2xl lg:text-3xl font-bold text-center">
            FarmX AI companion
          </h2>
        </div>
      </section>
      <section className="py-2 lg:py-2 xl:py-3">
        <div className="mx-auto max-w-c-1280 px-4 md:px-8 xl:mt-0 xl:px-0">
          <ChatAssistant />
        </div>
      </section>

    </>
  );
};

export default Ai;

