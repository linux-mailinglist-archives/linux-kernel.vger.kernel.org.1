Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7117B2D6E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404976AbgLKDB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:01:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46884 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404814AbgLKDBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:01:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id w3so7003412otp.13;
        Thu, 10 Dec 2020 19:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bxEVmvuvgvxAxXjfH0UsYcMfJWZdt7Is0fsO8Ao9Gxk=;
        b=tFux/7eZACDdPpjAxlUD33cYTfKkUr7XMZgaa2wFmI23sRZquViZRwQjDahuZFMacQ
         cQEYDeM8cpfMT2A+LAol70Wwfeswd+2V2WFVhm1VcX7t183Vx0B4RH8aK7rcCXUY7lGl
         boxcIH1QdIWfKcPdQz8xyEcCkAmwDfyf/GvoAeYVJaCksF6DuK5D1nfYjF/Q7XUo0304
         ofhl5GKa67ZAoISq9sz7izrBhlBwuTQK6uSlbccCZD/mO/a2DcDJ6ccvN26G7pXsBxZ9
         zVzp6dGBRLG/ggnDqp6i/YeBRDx7ov5gaXr/JqU9mHHkVpwz6d77grH03UiLXlJDioJJ
         Z77w==
X-Gm-Message-State: AOAM532EkE3v3B7QOhE9HwY1QS7dami++vsR94xt7qCrCsRzTeM0Zc6b
        bWl2oLtPKC9gDRaMw8SGnVGa0b2cHQ==
X-Google-Smtp-Source: ABdhPJwNvin4qOwa9EmFH5TamvivmjDAGuGjlF4l85a7pdXJZuKtaj7NhbjkwP8YLrI2g+9wGQwr3A==
X-Received: by 2002:a9d:6642:: with SMTP id q2mr8244070otm.172.1607655663035;
        Thu, 10 Dec 2020 19:01:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm1501461oib.24.2020.12.10.19.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:01:02 -0800 (PST)
Received: (nullmailer pid 3535825 invoked by uid 1000);
        Fri, 11 Dec 2020 03:01:01 -0000
Date:   Thu, 10 Dec 2020 21:01:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v1 2/2] Staging: silabs si4455 serial driver: docs device
 tree binding
Message-ID: <20201211030101.GA3530369@robh.at.kernel.org>
References: <20201210122154.GA31799@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210122154.GA31799@dincontrollerdev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:21:56PM +0000, József Horváth wrote:
> add: device tree binding schema

For the subject, follow conventions of the directory. Something like:

dt-bindings: serial: Add SiLabs SI4455 schema

> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../bindings/serial/silabs,si4455.yaml        | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> new file mode 100644
> index 000000000000..80a73a61755b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Silicon Labs Si4455 device tree bindings

Add 'description' with some info on this h/w and possibly a link to 
datasheet if available.

> +
> +maintainers:
> +  - József Horváth <info@ministro.hu>
> +
> +allOf:
> +  - $ref: "/schemas/serial.yaml#"
> +
> +properties:
> +  compatible:
> +    const: silabs,si4455
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description: maximum clock frequency on SPI port
> +    maximum: 500000
> +
> +  shutdown-gpios:
> +    description: gpio pin for SDN
> +    maxItems: 1
> +
> +required:
> +  - reg
> +  - interrupts
> +  - spi-max-frequency
> +  - shutdown-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    &spi0 {
> +      serial0: si4455@0 {
> +        compatible = "silabs,si4455";
> +        reg = <0>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +        shutdown-gpios = <&gpio 26 1>;
> +        spi-max-frequency = <300000>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a29bc17d446d..16cc96971ac2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15937,7 +15937,7 @@ F:	drivers/platform/x86/touchscreen_dmi.c
>  SILICON LABS SI4455 SERIAL DRIVER
>  M:	József Horváth <info@ministro.hu>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/staging/serial/silabs,si4455.txt

This is a new file, right?

> +F:	Documentation/devicetree/bindings/serial/silabs,si4455.yaml
>  F:	drivers/tty/serial/si4455.c
>  F:	drivers/tty/serial/si4455_api.h
>  
> -- 
> 2.17.1
> 
