Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4B29F026
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgJ2Pf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:35:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45483 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgJ2Pdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:33:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so3557758oie.12;
        Thu, 29 Oct 2020 08:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ocWwIL/dDwTLIUoq7+Qhh4BePPKhfoRf+gfkTAlnfE=;
        b=Rn1baYeWzNfftye3sWZFii0V+jqMraflrmIN3gN7Ev+Lc1S0ExqF3BFK0dGkdmfjIm
         Vl06hTPoqwPlvZfoOzvskskn6s0VZBe7oTuBwz14jfFbbSWDpzSQAzjUpMeZ00T4/0hf
         Fgh5IVu3y8XKgIhYPsP1/0y2Q4c6vjqk+6E46FnhH51wAKPw/otsoYeHduo6ZKTDwDln
         wFYNKXpHaSKdeFE5StB+dyoy5CKM/G/3Ar5vEyh74wMHqL7EfEGevVofrie4n+MSTYhs
         Hxz5RjuQxSi1YLH6YHCeS3aGS5iiL0wYjLqpM+jz10xxVk9wNzuaRd2LMb1IS4PI5dze
         Uqzg==
X-Gm-Message-State: AOAM532t+IwFf471bE/F4QZfQUskpV3tBXnlvkyGNa9HdVOGdMEzAZgG
        6rG6BKcjfJhJO9s4bKHhFQ==
X-Google-Smtp-Source: ABdhPJxx6ksmqAcP54I2X1X7c9qFS8b+Y2kGlos0R+7+8Mquqh1BvZAp60KWBzgBzsYck73exERUTg==
X-Received: by 2002:aca:4ed4:: with SMTP id c203mr293678oib.120.1603985632692;
        Thu, 29 Oct 2020 08:33:52 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 9sm657867otp.72.2020.10.29.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:33:52 -0700 (PDT)
Received: (nullmailer pid 1911924 invoked by uid 1000);
        Thu, 29 Oct 2020 15:33:51 -0000
Date:   Thu, 29 Oct 2020 10:33:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, linux-usb@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 01/10] dt-bindings: usb: Maxim type-c controller
 device tree binding document
Message-ID: <20201029153351.GA1911637@bogus>
References: <20201029063138.1429760-1-badhri@google.com>
 <20201029063138.1429760-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029063138.1429760-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 23:31:29 -0700, Badhri Jagan Sridharan wrote:
> Add device tree binding document for Maxim 33359 Type-C chip driver
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Migrated to yaml format.
> 
> Changes since v7:
> - Rebase on usb-next
> 
> Changes since v8:
> - Fix errors from make dt_binding_check as suggested by
>   Rob Herring.
> 
> Changes since v9:
> - additionalProperties: false as suggested by Rob Herring.
> 
> Changes since v10:
> - Added the chip number to the binding as suggested by Rob Herring.
> - Renamed the filename as well.
> 
> Changes since v11:
> Addressed comments from Rob Herring to rename from maxim,33359
> to maxim,max33359
> ---
>  .../bindings/usb/maxim,max33359.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/usb/maxim,max33359.example.dts:39.53-54 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/usb/maxim,max33359.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1389879

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

