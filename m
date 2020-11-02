Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54302A315F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgKBRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:21:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42580 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:21:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id h62so13285212oth.9;
        Mon, 02 Nov 2020 09:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGgDvGSuDV9SLiPFgVzBkpII2wNb2Bp8F73VvTMHwow=;
        b=Csh4eZJaIHBpo4vGpT+rd5aQwXVOUC3VP+wqWtw8GEGrv1hXjVEVDK1MD+2UKHeW49
         Aj1u+oIMtW4EqyyyGkmrX5c+6cxZREV3lUc9O5vWkxSLQpnJjz5lM1G1xoKBJMokmGkb
         PvJQs77LarP0CMwWmIqQQDn/8TwJPb+T5977tveE8/zqzKInYz0oAMEKvydssbX0EK3G
         jiYKMqbtI+xDI0zOhFSxfqJCB+0b6XrGam/UZZAqC0jonDon91DwYedjttyi5JQolc+X
         u1s4vHMuiVUcn1Z8nrN8Paezsa5wQzmI0KNbYv5cW2A9JRn0J7Z7wg2NHYxAoJAgSlf2
         nJ5Q==
X-Gm-Message-State: AOAM53149Lo4+Bco+GyrfFh+OHzSI99941Xl5j5BjnC1k782QJlZOsJ2
        xRXeBhbPqzCXOJBz/lyi+8nvvaUAUA==
X-Google-Smtp-Source: ABdhPJzoAYU4fOEW+avlyMdmW8TBUsfjxgWK6zmtKxMiGlhhcoslLxfNnAj8xpkw1ky7MTWPKZFq6w==
X-Received: by 2002:a9d:7419:: with SMTP id n25mr12940588otk.183.1604337679233;
        Mon, 02 Nov 2020 09:21:19 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e8sm2580895oti.76.2020.11.02.09.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:21:18 -0800 (PST)
Received: (nullmailer pid 4072565 invoked by uid 1000);
        Mon, 02 Nov 2020 17:21:17 -0000
Date:   Mon, 2 Nov 2020 11:21:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org
Subject: Re: [PATCH v1 2/2] mfd: rt4505: Adds DT binding document for Richtek
 RT4831 MFD core
Message-ID: <20201102172117.GA4071346@bogus>
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
 <1604286803-20698-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604286803-20698-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020 11:13:23 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 MFD core.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 89 ++++++++++++++++++++++
>  include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
>  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/regulator/richtek,rt4831-regulator.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 124
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1391911

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

