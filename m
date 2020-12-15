Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F582DB50A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgLOU1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgLOU02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:26:28 -0500
X-Gm-Message-State: AOAM530Ne22DdOW8gTljKwakT7AbXS5z80+sywh4DWk6y+IOl1heVXPn
        QnI9T1AHeBdLkeYnUDtICrAZ1N8AdoCcuQ3rbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608063947;
        bh=4GhOLILUlkuJ65HRqAEzaNhc4ra+C1P7aIGOJQD/jXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u6pTBvxSNmfYUXqyAylPt/cgwI8H1Cc2HGL0ZazEbn/Kb+axl2Gt21xjbZFx54vsX
         7G6vbWyEHoTm994MZ1I12pPitHDOd7nm1ZlU9+sirUISex//BP9YNU/vwxTvkFN4Fb
         tbT1feOnao+Ajaje9mqnrta/YgqxOQl1WJb1CfxSW7bTxm92VI+YuAUYgNS/VIfl/5
         2qKgC8sWg++GfRz4VOMLb3hDqZiSaybvHX/pcy3m7LyqbYeC5x58T56hlyijo3zXSX
         +Pky7WG+b/kZ45YIoX6INyui+9yc+UkORunXe6KDPZfV5At2AuGDNwe7NklCDQhk9e
         ipwlFB4h77s3A==
X-Google-Smtp-Source: ABdhPJxXuO5NBKO94Bs8XbHsEEhQ71d5V6U+DDgQj6sG1aOEc+fnPpDDZOYhZxjyQJE2Ytjzw3OJujqYsRLhju0/lKs=
X-Received: by 2002:a50:f404:: with SMTP id r4mr4075570edm.62.1608063946210;
 Tue, 15 Dec 2020 12:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20201215155627.2513-1-nsaenzjulienne@suse.de> <20201215155627.2513-2-nsaenzjulienne@suse.de>
In-Reply-To: <20201215155627.2513-2-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Dec 2020 14:25:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7zZdWi0orXoqPWqvvxP3H6n7=JRqhdeAiAYAHRS3WHQ@mail.gmail.com>
Message-ID: <CAL_JsqK7zZdWi0orXoqPWqvvxP3H6n7=JRqhdeAiAYAHRS3WHQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: Add bindings for rmem driver
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 9:56 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Firmware/co-processors might use reserved memory areas in order to pass
> data stemming from an nvmem device otherwise non accessible to Linux.
> For example an EEPROM memory only physically accessible to firmware, or
> data only accessible early at boot time.
>
> Introduce the dt-bindings to nvmem's rmem.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../devicetree/bindings/nvmem/rmem.yaml       | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
>
> diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> new file mode 100644
> index 000000000000..3037ebc4634d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/rmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Reserved Memory Based nvmem Device
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvmem-rmem
> +
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the reserved memory region

There's no need for this indirection. Just add a compatible to the
reserved-memory node. See ramoops for example.

Please make the compatible specific enough to define what the memory
contains. If you want 'nvmem-rmem' as a fallback that's fine.

> +
> +required:
> +  - compatible
> +  - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        fw-config {
> +                compatible = "nvmem-rmem";
> +                memory-region = <&mem>;
> +        };
> +
> +...
> --
> 2.29.2
>
