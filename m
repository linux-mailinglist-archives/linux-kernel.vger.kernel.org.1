Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D092D1583
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgLGQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:04:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39819 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:04:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id v85so5335093oia.6;
        Mon, 07 Dec 2020 08:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZmZoFkAfZf3KY5TWqHDY4LCl+TVFFSeX7ZglQlEtdU=;
        b=DrCw5PUoyXGY5SqlpgXxiNAR0J+F21Hb+QrHsQQjeuP5sWVm62kvWsLV8AWLmy72hf
         WxCxu2AqrxhUZu2lYq1gdGXCQ0EGY1Du3duwfkfPnVDCes8egvH/0aP8qUJUHpro7dU4
         94LOYjUxg/FHkSvutD0+Q7OdynXt9Nhqi4xoPm6w82lVMXtlCIRhJs69zR28dvZ+Zq6q
         OCRFZJXW9wMq6/pJy+glpEx2Bit/UVT3jfYfSqhoforCd1xIQp01s6G06Qfqr55G+CqQ
         zBVRyIoroTPUuLu9+fTL8/5eQJdrPQko9k7VDiGNXGI6JePrdju+jONjH9mVdPmA/SMs
         EUXA==
X-Gm-Message-State: AOAM530VVsOgpj0DI3DNOTyVSbVyXiRbbkZ+h38lMIhwrYwgDyxXUkW2
        ApG7EO2Xtj69rX8vEiu8qg==
X-Google-Smtp-Source: ABdhPJy40Pfu17wwKQOmtAzROlJeDuPwjzee6mv+7UV9tOWgfzkd1fdia3mhHPSAx+ucB5koirIviQ==
X-Received: by 2002:aca:d955:: with SMTP id q82mr12823202oig.116.1607357056416;
        Mon, 07 Dec 2020 08:04:16 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm1009209otk.58.2020.12.07.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:04:15 -0800 (PST)
Received: (nullmailer pid 360356 invoked by uid 1000);
        Mon, 07 Dec 2020 16:04:13 -0000
Date:   Mon, 7 Dec 2020 10:04:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, cy_huang@richtek.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201207160413.GA359560@robh.at.kernel.org>
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
 <1607011595-13603-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607011595-13603-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020 00:06:33 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../leds/backlight/richtek,rt4831-backlight.yaml   | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.example.dts:19:18: fatal error: dt-bindings/leds/rt4831-backlight.h: No such file or directory
   19 |         #include <dt-bindings/leds/rt4831-backlight.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1410481

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

