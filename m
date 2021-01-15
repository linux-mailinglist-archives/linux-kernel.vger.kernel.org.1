Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC62F702F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbhAOBsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:48:15 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34973 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbhAOBsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:48:14 -0500
Received: by mail-ot1-f49.google.com with SMTP id i6so7157017otr.2;
        Thu, 14 Jan 2021 17:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pw673ddKtkSPV+zrhOwh4NS44XUtYPevzD6JaghUBl0=;
        b=Qmx3OvCyrWN444GKnVseVdBxkcnV7FIRDohPVy7Hn+AsAlUfGcohTVqN32Edfhsz7Q
         7HXA10cFMmL3+Pr9xnaszAUfcNgBd7Hhi+kwcZVwv04OOM78gDMvBbNbx//tgHjJLUvy
         g5VoarjLP0VzjbE7qdDUG9RM2jhjNxb95kIrXecHt+/JjjHxOjm/F3SylMfgVOrs7Dfc
         lp/aM6u48mqrdMy0vva/Vqdqp1FGFgiAuafs8+EYh5zPyfy+iUdSXfsMoQ8cl5AQgzxw
         aLgErF804awuT5yDvKiSVewJqvgjCXV6DJBNlx+wrupqq59sFu40AwPRC+S4ayJQC647
         EYFQ==
X-Gm-Message-State: AOAM530iCzsAtlhik+VoR6n9vrEpzROL/97xwLQ56zJfib1+ZWOjJPfD
        DPUJtbkk3Yi+Y4PLgKa3kw==
X-Google-Smtp-Source: ABdhPJw9+YLvzDKXOKYwxSBhamfHNiJcw4vgO01dHrPFRc2bX3n8y87RGuUx51OSspW8DE2x5w0jLA==
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr6641002otm.305.1610675253544;
        Thu, 14 Jan 2021 17:47:33 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 109sm1459981otj.12.2021.01.14.17.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 17:47:32 -0800 (PST)
Received: (nullmailer pid 4084972 invoked by uid 1000);
        Fri, 15 Jan 2021 01:47:31 -0000
Date:   Thu, 14 Jan 2021 19:47:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210115014731.GA4077569@robh.at.kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
 <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 06:35:44PM +0100, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
>  MAINTAINERS                                   |   9 +-
>  drivers/phy/hisilicon/Kconfig                 |  10 +
>  drivers/phy/hisilicon/Makefile                |   1 +
>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   2 -
>  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
>  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
>  9 files changed, 759 insertions(+), 754 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
>  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
>  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
>  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> new file mode 100644
> index 000000000000..125a5d6546ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,hi3670-usb3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Kirin970 USB PHY
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Blank line.

> +description: |+
> +  Bindings for USB3 PHY on HiSilicon Kirin 970.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,hi3670-usb-phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  hisilicon,pericrg-syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: phandle of syscon used to control iso refclk.
> +
> +  hisilicon,pctrl-syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: phandle of syscon used to control usb tcxo.
> +
> +  hisilicon,sctrl-syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: phandle of syscon used to control phy deep sleep.
> +
> +  hisilicon,eye-diagram-param:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Eye diagram for phy.
> +
> +  hisilicon,tx-vboost-lvl:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TX level vboost for phy.
> +
> +required:
> +  - compatible
> +  - hisilicon,pericrg-syscon
> +  - hisilicon,pctrl-syscon
> +  - hisilicon,sctrl-syscon
> +  - hisilicon,eye-diagram-param
> +  - hisilicon,tx-vboost-lvl
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      usb3_otg_bc: usb3_otg_bc@ff200000 {
> +        compatible = "syscon", "simple-mfd";
> +        reg = <0x0 0xff200000 0x0 0x1000>;
> +
> +        usb_phy {

Is there a contiguous register region for this sub-block? If so, add 
'reg' even though Linux doesn't need it currently.

> +          compatible = "hisilicon,hi3670-usb-phy";
> +          #phy-cells = <0>;
> +          hisilicon,pericrg-syscon = <&crg_ctrl>;
> +          hisilicon,pctrl-syscon = <&pctrl>;
> +          hisilicon,sctrl-syscon = <&sctrl>;
> +          hisilicon,eye-diagram-param = <0xfdfee4>;
> +          hisilicon,tx-vboost-lvl = <0x5>;
> +        };
> +      };
> +    };
