Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7620C303F30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405009AbhAZNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405277AbhAZNpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BAC52311B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611668699;
        bh=i4H1XoFTu4a2Pfulc3qpW+g1XC69s0C4vh/FLSOiOHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GU89HQgetjSNyUA1WNDFjDZz7z8s585twPUkY9DOo+HpczdDTIZYWWvFYcDR5xkzO
         ZyuwyPmfgrInxE8skTdL1odgwaKNj4+V7Q/b0TwnEI+Oa2xp1lnCLSdX5hWz8X8bUV
         RaJSlw1PFv/JQVqR0by/cpsaUZAcjP9uQqS1KUZ2a5o5Uu2NVDXFsI4aLuBBA81BG/
         r9QrZWnr01A9tgFUUajvzkuy4gL7dFGDTUFN1RzrDz3dy+L1V6LxpjY6tVQwQ3r9z/
         Es9LuYBsKeRRLLLBm2V9nT/5kpZVEZIEdim2kNaOhh8nvOsMYPbdMuV+XD4qlbYwE4
         NTqi6FoW7RvFQ==
Received: by mail-ed1-f46.google.com with SMTP id d2so16236843edz.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:44:59 -0800 (PST)
X-Gm-Message-State: AOAM530pyCL8K93NYGgQny3gCC1vppj1X4trLMn4QVtfODGmtlpn4OyI
        rgcToksrA+apMrkNY77Erb4Auv4higHR0yng8g==
X-Google-Smtp-Source: ABdhPJy3/6RFfCb8vBSY2uAgQ8ZsYK66M68w/5yzjgmpBufA59LVj8ERYvk96YaMOys7pjpU9EnYN0Sf2HgvddE3z4U=
X-Received: by 2002:a05:6402:2c5:: with SMTP id b5mr4866794edx.258.1611668697613;
 Tue, 26 Jan 2021 05:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20210126054036.61587-1-mgross@linux.intel.com> <20210126054036.61587-3-mgross@linux.intel.com>
In-Reply-To: <20210126054036.61587-3-mgross@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jan 2021 07:44:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+h9gaZuqKRyh2UqRq5FvBGEoeBLn=xF+K8Zu8Cn9norQ@mail.gmail.com>
Message-ID: <CAL_Jsq+h9gaZuqKRyh2UqRq5FvBGEoeBLn=xF+K8Zu8Cn9norQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox bindings
To:     Mark Gross <mgross@linux.intel.com>
Cc:     markgross@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:40 PM <mgross@linux.intel.com> wrote:
>
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
>
> Add bindings for the Intel VPU IPC mailbox driver.

Sigh. DT list please so it's in my queue and automated checks run.

> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../mailbox/intel,vpu-ipc-mailbox.yaml        | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
> new file mode 100644
> index 000000000000..923a6d619a64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/intel,vpu-ipc-mailbox.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel VPU IPC mailbox
> +
> +maintainers:
> +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +
> +description: |
> +  Intel VPU SoCs like Keem Bay have hardware FIFOs to enable Inter-Processor
> +  Communication (IPC) between the CPU and the VPU.
> +
> +  Specifically, there is one HW FIFO for the CPU (aka Application Processor -
> +  AP) and one for the VPU. Each FIFO can hold 128 entries of 32 bits each. A
> +  "FIFO-not-empty" interrupt is raised every time there is at least a message
> +  in the FIFO. The CPU FIFO raises interrupts to the CPU, while the VPU FIFO
> +  raises interrupts to VPU. When the CPU wants to send a message to the VPU it
> +  writes to the VPU FIFO, similarly, when the VPU want to send a message to the
> +  CPU, it writes to the CPU FIFO.
> +
> +  Refer to ./mailbox.txt for generic information about mailbox device-tree
> +  bindings.
> +
> +properties:
> +  compatible:
> +    const: intel,vpu-ipc-mailbox
> +
> +  reg:
> +    items:
> +      - description: The CPU FIFO registers
> +      - description: The VPU FIFO registers
> +
> +  reg-names:
> +    items:
> +      - const: cpu_fifo
> +      - const: vpu_fifo
> +
> +  interrupts:
> +    items:
> +      - description: CPU FIFO-not-empty interrupt
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    vpu_ipc_mailbox@203300f0 {
> +        compatible = "intel,vpu-ipc-mailbox";
> +        #mbox-cells = <1>;
> +        reg = <0x203300f0 0x310>,
> +              <0x208200f0 0x310>;
> +        reg-names = "cpu_fifo", "vpu_fifo";
> +        interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 992fe3b0900a..2b82526a00dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9181,6 +9181,12 @@ L:       platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     drivers/platform/x86/intel-vbtn.c
>
> +INTEL VPU IPC MAILBOX
> +M:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +M:     Mark Gross <mgross@linux.intel.com>
> +S:     Supported
> +F:     Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
> +
>  INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
>  M:     Stanislaw Gruszka <stf_xl@wp.pl>
>  L:     linux-wireless@vger.kernel.org
> --
> 2.17.1
>
