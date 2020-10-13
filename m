Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E434B28CDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgJMMOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:14:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39214 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgJMMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id c13so22233423oiy.6;
        Tue, 13 Oct 2020 05:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNZrkqo2bIR8rioX8LTdMOLgxj/aN1GPWKl/35Vks+E=;
        b=hrtf0H94NLkdRz5l1zTdLIUvIIj+ZSMTJSFrpVV2OWolP1FkMhD/9NBMJ2Z5izWDLW
         Mpgdn7/kOk4AUhPFevN6EsrozBK6sm5zUMigS+uX6md11BrHsceATUrS5AJDE0E6WqgK
         6lRvcrjXg103Y7CImUlizbXvnagYWaT0El9kU66WIsS/ejKRuk6XUsvnU0ytOtKupm6B
         lOmYMPyQssIGmt2gXs+A5nkYhzxDVuSmEWmYrppS2eLBEm6kbNwgjlOVYFLn1Rw0XXwG
         e8GvApYS22FZSdxoXdzoMvvBjIvPjfpVPiP1b791jmTYo4c6tFxz7atlyCRG/ITf2qq9
         hS8Q==
X-Gm-Message-State: AOAM53154BoGkrp3kZq1+KrM33tMa4QFMkg9/A36kJGtwhGfAOavitUE
        eFcvapkrJFjxvne33O/NDcl0M/2EEBb7
X-Google-Smtp-Source: ABdhPJxc11DpAC5kq8/69t9HYzgMkF+fcfIUO/dYdLcZ3YTHq1DMn2LZXcmOdTlj7pxGSrK//aXIAg==
X-Received: by 2002:aca:ed06:: with SMTP id l6mr12882931oih.141.1602591283659;
        Tue, 13 Oct 2020 05:14:43 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v17sm2657704otn.81.2020.10.13.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:14:42 -0700 (PDT)
Received: (nullmailer pid 3275784 invoked by uid 1000);
        Tue, 13 Oct 2020 12:14:41 -0000
Date:   Tue, 13 Oct 2020 07:14:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] dt-bindings: usb: usb-hcd: Convert generic USB
 properties to DT schema
Message-ID: <20201013121441.GA3269269@bogus>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010224121.12672-2-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:41:04AM +0300, Serge Semin wrote:
> The generic USB HCD properties have been described in the legacy bindings
> text file: Documentation/devicetree/bindings/usb/generic.txt . Let's
> convert it' content into the USB HCD DT schema properties so all USB DT
> nodes would be validated to have them properly utilized.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../devicetree/bindings/usb/generic.txt       | 57 -------------
>  .../devicetree/bindings/usb/usb-hcd.yaml      | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/generic.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> deleted file mode 100644
> index ba472e7aefc9..000000000000
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -Generic USB Properties
> -
> -Optional properties:
> - - maximum-speed: tells USB controllers we want to work up to a certain
> -			speed. Valid arguments are "super-speed-plus",
> -			"super-speed", "high-speed", "full-speed" and
> -			"low-speed". In case this isn't passed via DT, USB
> -			controllers should default to their maximum HW
> -			capability.
> - - dr_mode: tells Dual-Role USB controllers that we want to work on a
> -			particular mode. Valid arguments are "host",
> -			"peripheral" and "otg". In case this attribute isn't
> -			passed via DT, USB DRD controllers should default to
> -			OTG.
> - - phy_type: tells USB controllers that we want to configure the core to support
> -			a UTMI+ PHY with an 8- or 16-bit interface if UTMI+ is
> -			selected. Valid arguments are "utmi" and "utmi_wide".
> -			In case this isn't passed via DT, USB controllers should
> -			default to HW capability.
> - - otg-rev: tells usb driver the release number of the OTG and EH supplement
> -			with which the device and its descriptors are compliant,
> -			in binary-coded decimal (i.e. 2.0 is 0200H). This
> -			property is used if any real OTG features(HNP/SRP/ADP)
> -			is enabled, if ADP is required, otg-rev should be
> -			0x0200 or above.
> - - companion: phandle of a companion
> - - hnp-disable: tells OTG controllers we want to disable OTG HNP, normally HNP
> -			is the basic function of real OTG except you want it
> -			to be a srp-capable only B device.
> - - srp-disable: tells OTG controllers we want to disable OTG SRP, SRP is
> -			optional for OTG device.
> - - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
> -			optional for OTG device.
> - - usb-role-switch: boolean, indicates that the device is capable of assigning
> -			the USB data role (USB host or USB device) for a given
> -			USB connector, such as Type-C, Type-B(micro).
> -			see connector/usb-connector.yaml.
> - - role-switch-default-mode: indicating if usb-role-switch is enabled, the
> -			device default operation mode of controller while usb
> -			role is USB_ROLE_NONE. Valid arguments are "host" and
> -			"peripheral". Defaults to "peripheral" if not
> -			specified.
> -
> -
> -This is an attribute to a USB controller such as:
> -
> -dwc3@4a030000 {
> -	compatible = "synopsys,dwc3";
> -	reg = <0x4a030000 0xcfff>;
> -	interrupts = <0 92 4>
> -	usb-phy = <&usb2_phy>, <&usb3,phy>;
> -	maximum-speed = "super-speed";
> -	dr_mode = "otg";
> -	phy_type = "utmi_wide";
> -	otg-rev = <0x0200>;
> -	adp-disable;
> -};
> diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> index 7263b7f2b510..815de24127db 100644
> --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> @@ -22,9 +22,93 @@ properties:
>      description:
>        Name specifier for the USB PHY
>  
> +  maximum-speed:
> +   description: |

Drop the '|' if there's no formatting to preserve.

> +     Tells USB controllers we want to work up to a certain speed. In case this
> +     isn't passed via DT, USB controllers should default to their maximum HW
> +     capability.
> +   $ref: /schemas/types.yaml#/definitions/string
> +   enum: ["low-speed", "full-speed", "high-speed", "super-speed",
> +          "super-speed-plus"]

One per line and drop the quotes.

> +
> +  dr_mode:
> +    description: |
> +      Tells Dual-Role USB controllers that we want to work on a particular
> +      mode. In case this attribute isn't passed via DT, USB DRD controllers
> +      should default to OTG.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["host", "peripheral", "otg"]
> +
> +  phy_type:
> +    description: |
> +      Tells USB controllers that we want to configure the core to support a
> +      UTMI+ PHY with an 8- or 16-bit interface if UTMI+ is selected. In case
> +      this isn't passed via DT, USB controllers should default to HW
> +      capability.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["utmi", "utmi_wide"]
> +
> +  otg-rev:
> +    description: |
> +      Tells usb driver the release number of the OTG and EH supplement with
> +      which the device and its descriptors are compliant, in binary-coded
> +      decimal (i.e. 2.0 is 0200H). This property is used if any real OTG
> +      features (HNP/SRP/ADP) is enabled. If ADP is required, otg-rev should be
> +      0x0200 or above.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  companion:
> +    description: Phandle of a companion device
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  hnp-disable:
> +    description: |
> +      Tells OTG controllers we want to disable OTG HNP. Normally HNP is the
> +      basic function of real OTG except you want it to be a srp-capable only B
> +      device.
> +    type: boolean
> +
> +  srp-disable:
> +    description: |
> +      Tells OTG controllers we want to disable OTG SRP. SRP is optional for OTG
> +      device.
> +    type: boolean
> +
> +  adp-disable:
> +    description: |
> +      Tells OTG controllers we want to disable OTG ADP. ADP is optional for OTG
> +      device.
> +    type: boolean
> +
> +  usb-role-switch:
> +    description: |
> +      Indicates that the device is capable of assigning the USB data role
> +      (USB host or USB device) for a given USB connector, such as Type-C,
> +      Type-B(micro). See connector/usb-connector.yaml.
> +
> +  role-switch-default-mode:
> +    description: |
> +      Indicates if usb-role-switch is enabled, the device default operation
> +      mode of controller while usb role is USB_ROLE_NONE.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["host", "peripheral"]
> +    default: "peripheral"
> +
>  examples:
>    - |
>      usb {
>          phys = <&usb2_phy1>, <&usb3_phy1>;
>          phy-names = "usb";
>      };
> +  - |
> +    usb@4a030000 {
> +        compatible = "snps,dwc3";
> +        reg = <0x4a030000 0xcfff>;
> +        interrupts = <0 92 4>;
> +        usb-phy = <&usb2_phy>, <&usb3_phy>;
> +        maximum-speed = "super-speed";
> +        dr_mode = "otg";
> +        phy_type = "utmi_wide";
> +        otg-rev = <0x0200>;
> +        adp-disable;
> +    };
> -- 
> 2.27.0
> 
