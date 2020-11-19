Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15532B96D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgKSPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:48:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34089 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbgKSPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:48:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id j14so5715556ots.1;
        Thu, 19 Nov 2020 07:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNIhPxmg0BaACTrqzvaGUD3Lem9SsDuuD5upZKtAA4E=;
        b=gal6mZGsPZI7ktfSZmdFqEf6KA0d2E5jbpQSkhIl63D4GUtTeSgoF9gacYS+CTSO3e
         zeq5hbI4hhcFTmxyg9ePIQGFN1W/aGwqx/q60ze8VJXRKXskivczUFkz/UPTIJ6hNvkw
         zv9BfCL235xCJOR+C2q+upcmdHLuN9TjM31Gbx9kzA1dpu5V3Gh3SnafC6hPu8SjgsoN
         URk1p8Vl9s2spsAPXO2cteUoXQIXgJgqBXW5517LSGOwa4r+ihM5dQL2klH3JTrCPVR1
         Oxlqtb4RUceJtd84kTQobqaVLOJg4dvRDP2tX4CHlxbuc9CgHwYejcaJieicxwupdvXT
         AIRw==
X-Gm-Message-State: AOAM531i2x1iGsJs4CQpnvUdP5dbTDdoMKhjyjwvAQYDism4eFhGlS5T
        xXIJnakvzgIlm8ChzZaobLg7WVWfHg==
X-Google-Smtp-Source: ABdhPJzsfxth9Ic2aCa7zH6IVqqbDHRcU4XR7Phf3pasfHNI1BZH8DOoXQawnG5okLRXsgiGsFi66Q==
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr10641245otq.162.1605800895148;
        Thu, 19 Nov 2020 07:48:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t19sm22850otp.51.2020.11.19.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:48:14 -0800 (PST)
Received: (nullmailer pid 3308585 invoked by uid 1000);
        Thu, 19 Nov 2020 15:48:13 -0000
Date:   Thu, 19 Nov 2020 09:48:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        devicetree@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH 2/8] dt-bindings: display: imx: Add i.MX8qxp/qm PRG
 binding
Message-ID: <20201119154813.GA3308033@bogus>
References: <1605777745-23625-1-git-send-email-victor.liu@nxp.com>
 <1605777745-23625-3-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605777745-23625-3-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 17:22:19 +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Prefetch Resolve Gasket.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bindings/display/imx/fsl,imx8qxp-prg.yaml      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.example.dts:24.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1402851

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

