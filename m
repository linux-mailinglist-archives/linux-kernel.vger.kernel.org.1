Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23DA2F6B03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbhANTbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:31:52 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36317 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhANTbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:31:51 -0500
Received: by mail-oi1-f179.google.com with SMTP id 9so7126806oiq.3;
        Thu, 14 Jan 2021 11:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jCW/74dk4/r2pTUeRiZ/lnXm69baMKCS/KFRrpnvniY=;
        b=q91N9MnWjUosYjc8G2O4ZDPBdOSWueuqySLX2MZQgmJpD/Nj4SzVVZiG5hL6XgsDBo
         quxQBMTwS7i/P1YG4yhQ5NT39hpS3lxb2dOHJE2xnaEwXD3xQl1ct6ERCBdUNWerlpHE
         JGyp3brubY23VQDNNuS9kSE4TfGsTcGDH6WVtxEx0vHkheTb/N5YqosG7mZoJsL7gWNu
         fEyFJ67tTi5or4Yv/wp1l2v0Qlx1jlMNGlrSlvPFh0xcgNH2rbZUTw3wSG0yhVZWB1nb
         /nGavetcWHhkisD80oNZFNnR20tcJvULEakZ6ylF8WTDjpt+GlGlGlrxk54ROdKE4Qzh
         +46Q==
X-Gm-Message-State: AOAM531T8hkMk64Dm02JZJq/PyzMe9qudf9mn6mWNxtVPxl2H8lx6Oc+
        QSqXkIjIme0GhrPv4S5kvsJJ3ojmYA==
X-Google-Smtp-Source: ABdhPJz81BTCFtHgx3zSCLgFeQQfXJoask7vf+brnMbnlpYkFgiiyvjdENxkrgkUXCeNWStSR65fkQ==
X-Received: by 2002:aca:b20a:: with SMTP id b10mr3512096oif.75.1610652670139;
        Thu, 14 Jan 2021 11:31:10 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 63sm1243184otx.2.2021.01.14.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:31:09 -0800 (PST)
Received: (nullmailer pid 3432430 invoked by uid 1000);
        Thu, 14 Jan 2021 19:31:08 -0000
Date:   Thu, 14 Jan 2021 13:31:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add TI TPS23861 bindings
Message-ID: <20210114193108.GA3430334@robh.at.kernel.org>
References: <20210111135708.3703175-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111135708.3703175-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:57:06PM +0100, Robert Marko wrote:
> Document bindings for the Texas Instruments TPS23861 driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes in v4:
> * Correct shunt binding
> 
>  .../bindings/hwmon/ti,tps23861.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> new file mode 100644
> index 000000000000..891eee9489aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/ti,tps23861.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS23861 PoE PSE
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  The TPS23861 is a IEEE 802.3at Quad Port Power-over-Ethernet PSE Controller.
> +
> +  Datasheets:
> +  https://www.ti.com/lit/gpn/tps23861
> +
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps23861
> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description: The value of curent sense resistor in microohms.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type $ref as that's already defined for anything with 
units.

> +    default: 255000
> +    minimum: 250000
> +    maximum: 255000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          tps23861@30 {
> +              compatible = "ti,tps23861";
> +              reg = <0x30>;
> +              shunt-resistor-micro-ohms = <255000>;
> +          };
> +    };
> -- 
> 2.29.2
> 
