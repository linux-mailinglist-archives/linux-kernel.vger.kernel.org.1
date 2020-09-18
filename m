Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37826F5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIRG3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:29:10 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:39796 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRG3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:29:10 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 08I6StZl003562; Fri, 18 Sep 2020 15:28:55 +0900
X-Iguazu-Qid: 34trFrx2pqNWq2MYnj
X-Iguazu-QSIG: v=2; s=0; t=1600410535; q=34trFrx2pqNWq2MYnj; m=XWOMKSutyKBJnyIaL4q4wThvZCfnOaUx8ba8QIcGqvo=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 08I6Srbq032718;
        Fri, 18 Sep 2020 15:28:53 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 08I6Srv6006057;
        Fri, 18 Sep 2020 15:28:53 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 08I6Sq6W005477;
        Fri, 18 Sep 2020 15:28:53 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     stefanos@xilinx.com, michals@xilinx.com, michael.auchter@ni.com,
        devicetree@vger.kernel.org, emooring@xilinx.com,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, Jason Wu <j.wu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 4/5] dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc bindings
References: <20200917194341.16272-1-ben.levinsky@xilinx.com>
        <20200917194341.16272-5-ben.levinsky@xilinx.com>
Date:   Fri, 18 Sep 2020 15:28:50 +0900
In-Reply-To: <20200917194341.16272-5-ben.levinsky@xilinx.com> (Ben Levinsky's
        message of "Thu, 17 Sep 2020 12:43:40 -0700")
X-TSB-HOP: ON
Message-ID: <87r1qzlhst.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

One query below -

Ben Levinsky <ben.levinsky@xilinx.com> writes:

> Add binding for ZynqMP R5 OpenAMP.
>
> Represent the RPU domain resources in one device node. Each RPU
> processor is a subnode of the top RPU domain node.
>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---

[...]

>  .../xilinx,zynqmp-r5-remoteproc.yaml          | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> new file mode 100644
> index 000000000000..cd2406b4dc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Xilinx R5 remote processor controller bindings
> +
> +description:
> +  This document defines the binding for the remoteproc component that loads and
> +  boots firmwares on the Xilinx Zynqmp and Versal family chipset.
> +
> +  Note that the Linux has global addressing view of the R5-related memory (TCM)
> +  so the absolute address ranges are provided in TCM reg's.
> +maintainers:
> +  - Ed Mooring <ed.mooring@xilinx.com>
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: "xlnx,zynqmp-r5-remoteproc-1.0"
> +
> +  lockstep-mode:
> +    description:
> +      R5 core configuration (split is 0 or lock-step and 1)
> +    maxItems: 1

Looking at the driver, it seems that it is possible to set the R5s to
operate in split or lock-step mode dynamically.

If so, the device tree shouldn't really contain this property. Wouldn't
it be better to give the users flexibility to choose the mode at run
time?

Thanks,
Punit

> +
> +  interrupts:
> +    description:
> +      Interrupt mapping for remoteproc IPI. It is required if the
> +      user uses the remoteproc driver with the RPMsg kernel driver.
> +    maxItems: 6
> +
> +  memory-region:
> +    description:
> +      collection of memory carveouts used for elf-loading and inter-processor
> +      communication.
> +    maxItems: 4
> +    minItems: 4
> +  meta-memory-regions:
> +    description:
> +      collection of memories that are not present in the top level memory
> +      nodes' mapping. For example, R5s' TCM banks. These banks are needed
> +      for R5 firmware meta data such as the R5 firmware's heap and stack
> +  pnode-id:
> +    maxItems: 1
> +  mboxes:
> +    maxItems: 2
> +  mbox-names:
> +    maxItems: 2
> +
> +examples:
> +  - |
> +     reserved-memory {
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +          elf_load: rproc@3ed000000 {
> +               no-map;
> +               reg = <0x3ed00000 0x40000>;
> +          };
> +
> +          rpu0vdev0vring0: rpu0vdev0vring0@3ed40000 {
> +               no-map;
> +               reg = <0x3ed40000 0x4000>;
> +          };
> +          rpu0vdev0vring1: rpu0vdev0vring1@3ed44000 {
> +               no-map;
> +               reg = <0x3ed44000 0x4000>;
> +          };
> +          rpu0vdev0buffer: rpu0vdev0buffer@3ed48000 {
> +               no-map;
> +               reg = <0x3ed48000 0x100000>;
> +          };
> +
> +     };
> +
> +     /*
> +      * Below nodes are required if using TCM to load R5 firmware
> +      * if not, then either do not provide nodes are label as disabled in
> +      * status property
> +      */
> +     tcm0a: tcm_0a@ffe00000 {
> +         reg = <0xffe00000 0x10000>;
> +         pnode-id = <0xf>;
> +         no-map;
> +         status = "okay";
> +         phandle = <0x40>;
> +         compatible = "xlnx,tcm";
> +     };
> +     tcm0b: tcm_1a@ffe20000 {
> +         reg = <0xffe20000 0x10000>;
> +         pnode-id = <0x10>;
> +         no-map;
> +         status = "okay";
> +         compatible = "xlnx,tcm";
> +         phandle = <0x41>;
> +     };
> +
> +     rpu {
> +          compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          ranges;
> +          lockstep-mode = <1>;
> +          r5_0 {
> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               memory-region = <&elf_load>,
> +                               <&rpu0vdev0vring0>,
> +                               <&rpu0vdev0vring1>,
> +                               <&rpu0vdev0buffer>;
> +               meta-memory-regions = <&tcm_0a>, <&tcm_0b>;
> +               pnode-id = <0x7>;
> +          };
> +     };
> +
> +...
