Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450302810F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgJBLIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:08:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43777 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbgJBLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:08:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id dn5so1214287edb.10;
        Fri, 02 Oct 2020 04:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+XTJgLgGvu+PgnQvEqvP3vrDLHMLZXGcZ/b+5gA0Fg=;
        b=M1bmpsyTeMcmFUXJyuV2mmoMjrV+iuoD0jk9wUyK0sWon4Orqmant3T4LFjOmsLVAJ
         l1peTF24e+kD02nfhjlyGytrRwxAMcO5zI0rUNaIbIji5YOkJNinX1xBbGQNNLTL8ppr
         jv6bDNAh1n7ol8+RrdN4SGwT25aZypqwkT9iMsJsNH9hjf6y5xcB2T3G0VG6qk/MgAMT
         BAyINdxYaN5l106DI2cwtD3Q5a3WzI7TvxivO4KQBhdQUaD6mqNOn1epYUxhxHGUq1pc
         j7OQWlHy/ZRkqZCzB1EyzCWuePl5hSO86WXbFcqGfq/eBEv4nhrrvYcyNdWJlTVkTb4K
         WhPw==
X-Gm-Message-State: AOAM530IWXgllMlEw2yOgIlMcVoD69YJaS2nW9yJEmzOHvH3xSKWV7Cn
        3+7oYFo05VGgpKkyaRmCarw=
X-Google-Smtp-Source: ABdhPJy+3cpdhcQpP3L2cVztpQbxIGRTeujm02q8HW2n6jNeMvzXQDu4DC+Ju5QkkLyIC+PCSEHvUQ==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr1753263edj.94.1601636915406;
        Fri, 02 Oct 2020 04:08:35 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id g9sm61954ejz.23.2020.10.02.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 04:08:34 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:08:31 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
Message-ID: <20201002110831.GD6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  49 ---------
>  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
>  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
>  4 files changed, 191 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> deleted file mode 100644
> index b64573680b42..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -SMI (Smart Multimedia Interface) Common
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Mediatek SMI have two generations of HW architecture, here is the list
> -which generation the SoCs use:
> -generation 1: mt2701 and mt7623.
> -generation 2: mt2712, mt6779, mt8173 and mt8183.
> -
> -There's slight differences between the two SMI, for generation 2, the
> -register which control the iommu port is at each larb's register base. But
> -for generation 1, the register is at smi ao base(smi always on register
> -base). Besides that, the smi async clock should be prepared and enabled for
> -SMI generation 1 to transform the smi clock into emi clock domain, but that is
> -not needed for SMI generation 2.
> -
> -Required properties:
> -- compatible : must be one of :
> -	"mediatek,mt2701-smi-common"
> -	"mediatek,mt2712-smi-common"
> -	"mediatek,mt6779-smi-common"
> -	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
> -	"mediatek,mt8173-smi-common"
> -	"mediatek,mt8183-smi-common"
> -- reg : the register and size of the SMI block.
> -- power-domains : a phandle to the power domain of this local arbiter.
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
> -  for generation 2 smi HW as follows:
> -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> -	    the register.
> -  - "smi" : It's the clock for transfer data and command.
> -	    They may be the same if both source clocks are the same.
> -  - "async" : asynchronous clock, it help transform the smi clock into the emi
> -	      clock domain, this clock is only needed by generation 1 smi HW.
> -  and these 2 option clocks for generation 2 smi HW:
> -  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> -  - "gals1": the path1 clock of GALS(Global Async Local Sync).
> -  Here is the list which has this GALS: mt6779 and mt8183.
> -
> -Example:
> -	smi_common: smi@14022000 {
> -		compatible = "mediatek,mt8173-smi-common";
> -		reg = <0 0x14022000 0 0x1000>;
> -		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> -		clocks = <&mmsys CLK_MM_SMI_COMMON>,
> -			 <&mmsys CLK_MM_SMI_COMMON>;
> -		clock-names = "apb", "smi";
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> new file mode 100644
> index 000000000000..76ecc7205438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SMI (Smart Multimedia Interface) Common
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +description: |+
> +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> +
> +  MediaTek SMI have two generations of HW architecture, here is the list
> +  which generation the SoCs use:
> +  generation 1: mt2701 and mt7623.
> +  generation 2: mt2712, mt6779, mt8173 and mt8183.
> +
> +  There's slight differences between the two SMI, for generation 2, the
> +  register which control the iommu port is at each larb's register base. But
> +  for generation 1, the register is at smi ao base(smi always on register
> +  base). Besides that, the smi async clock should be prepared and enabled for
> +  SMI generation 1 to transform the smi clock into emi clock domain, but that is
> +  not needed for SMI generation 2.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-smi-common
> +          - mediatek,mt2712-smi-common
> +          - mediatek,mt6779-smi-common
> +          - mediatek,mt8173-smi-common
> +          - mediatek,mt8183-smi-common
> +
> +      - description: for mt7623
> +        items:
> +          - const: mediatek,mt7623-smi-common
> +          - const: mediatek,mt2701-smi-common
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> +      gals(global async local sync) also is optional, here is the list which
> +      require gals: mt6779 and mt8183.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +          setting the register.
> +      - description: smi is the clock for transfer data and command.
> +      - description: async is asynchronous clock, it help transform the smi clock
> +          into the emi clock domain.
> +      - description: gals0 is the path0 clock of gals.
> +      - description: gals1 is the path1 clock of gals.
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: apb
> +          - const: smi
> +      - items:
> +          - const: apb
> +          - const: smi
> +          - const: async
> +      - items:
> +          - const: apb
> +          - const: smi
> +          - const: gals0
> +          - const: gals1

Similarly to my comment to other properties, this requirement per
compatible should be part of the schema within 'if-then'.

Best regards,
Krzysztof
