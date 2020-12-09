Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505672D4ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbgLIXaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:30:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43498 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgLIXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:30:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id q25so3148975otn.10;
        Wed, 09 Dec 2020 15:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0Asjv3XbyAFTbDKBsljyKhv/NpTZ/vtxsoSKiwLJis=;
        b=fGnoPUdonFAEfqh3NQnR94TGoLYvSapGKAu/xYLms7qVN+s1xBBCy8Hf93f7sRVtA7
         sv+zQWX9EfuIkaXXez1McZD3guubMUxM65uv7effelVI4MZtXQMOkf0EDP0F7Eq/3+Ev
         YwKiqaOVaGUv94rWbpuyNbnojQNdIhkBNvZ4Z7dt/rinl2Vf4xHo5kJtNS5PMDMZiu4q
         is7Pb6vcYCA0VwZwt1hVuXqJL24lOroVCQXnRrpbiJPCqn1DE0yxXCwoHOphguxrBj8K
         phq1CTvYj2kN6jqE6AAEaafkxChpYSTADOusfn7Hd6BgYYLyhsb9cuPVM9XZnOF8Dkuu
         /GSQ==
X-Gm-Message-State: AOAM530bMjPqP1sF1JW5q0SGTmN26xSdHjrGDs/AaLBH/VHpjXA+aeux
        WzOcJUY5Un+iHL7LWwkMug==
X-Google-Smtp-Source: ABdhPJyebnMDO1idYvlHeSFT8mQf086CjkENt81nzyUnEjEz9CGaSHhlfhM4muLZ79s59u3SrEfCxQ==
X-Received: by 2002:a9d:479a:: with SMTP id b26mr3786121otf.297.1607556614465;
        Wed, 09 Dec 2020 15:30:14 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm753901otp.36.2020.12.09.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 15:30:13 -0800 (PST)
Received: (nullmailer pid 1281044 invoked by uid 1000);
        Wed, 09 Dec 2020 23:30:11 -0000
Date:   Wed, 9 Dec 2020 17:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bin.meng@windriver.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ivan.Griffin@microchip.com, Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Subject: Re: [PATCH v3 2/5] dt-bindings: riscv: microchip: Add YAML
 documentation for the PolarFire SoC
Message-ID: <20201209233011.GA1276461@robh.at.kernel.org>
References: <20201204085835.2406541-1-atish.patra@wdc.com>
 <20201204085835.2406541-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204085835.2406541-3-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:58:32AM -0800, Atish Patra wrote:
> Add YAML DT binding documentation for the Microchip PolarFire SoC.
> It is documented at:
> 
> https://www.microsemi.com/products/fpga-soc/polarfire-soc-icicle-quick-start-guide
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/riscv/microchip.yaml  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
> new file mode 100644
> index 000000000000..66e63c2bf359
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)

See what checkpatch.pl says.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/microchip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PolarFire SoC-based boards device tree bindings
> +
> +maintainers:
> +  - Cyril Jean <Cyril.Jean@microchip.com>
> +  - Lewis Hanly <lewis.hanly@microchip.com>
> +
> +description:
> +  Microchip PolarFire SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - enum:
> +          - microchip,mpfs-icicle-kit
> +      - const: microchip,polarfire-soc
> +      - const: microchip,mpfs

Is this last compatible really useful? Usually better to just have SoC 
and board (or SoM plus baseboard) compatibles.

Rob
