Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924792B96CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgKSPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:47:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44499 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgKSPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:47:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id t16so6747229oie.11;
        Thu, 19 Nov 2020 07:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i1tNp2KgBd14FkkpCIHyiNr1qV+4/KrTXMEh9UM4OyA=;
        b=qWJdHpJvbx0G0+Vup1XZBMBUwnC0CXaKw44s66pMJWN5NccbNjaGObiE5W6gVLT9iA
         0YT7qEbzJksI2Mtywx8OI7VuVVAuWDPaIn+lr2var911DzIkj+6spz4mTQRxe1t7kbU9
         gvjkVRMTG0TX96AS02CYDD6kPN5Xxd3rLgJfXASSYbR8KobVE8drkEpnkb42Ml2Gxczf
         j21KceX9eBDExinTbLGB4m8ZGV6kqMEmQlSxnC3T0aOCBR9I7sp2dc86TQjmaKKJLoln
         FocrEUXyDoxapAA0l9LzXSfGAiKGGljsQVzlT6njx53B4H/eMMuhxwTij8/LdVeI5JC8
         jhWw==
X-Gm-Message-State: AOAM532K6H8U1Kpmlt7Inx7/PWKy420sWm7EgKTLKHXzWCBVda1UTXel
        iyLlJFIegHBg51xB64xFgw==
X-Google-Smtp-Source: ABdhPJwkrz3+GCohSQnDOih8nPEsaXejgRb4izFB+vIbBFRIMNrgLzBmWvAhWHS986gyCl3cLw7szQ==
X-Received: by 2002:a54:480b:: with SMTP id j11mr3182548oij.31.1605800820893;
        Thu, 19 Nov 2020 07:47:00 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x7sm29561otb.19.2020.11.19.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:46:59 -0800 (PST)
Received: (nullmailer pid 3306861 invoked by uid 1000);
        Thu, 19 Nov 2020 15:46:59 -0000
Date:   Thu, 19 Nov 2020 09:46:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     s.hauer@pengutronix.de, linux-imx@nxp.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH 1/8] dt-bindings: display: imx: Add i.MX8qxp/qm DPU
 binding
Message-ID: <20201119154659.GA3306242@bogus>
References: <1605777745-23625-1-git-send-email-victor.liu@nxp.com>
 <1605777745-23625-2-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605777745-23625-2-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 17:22:18 +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Processing Unit.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bindings/display/imx/fsl,imx8qxp-dpu.yaml      | 358 +++++++++++++++++++++
>  1 file changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:29:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:69:111: [warning] line too long (111 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:70:111: [warning] line too long (111 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:71:111: [warning] line too long (112 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:72:111: [warning] line too long (112 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:73:111: [warning] line too long (111 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:74:111: [warning] line too long (111 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:75:111: [warning] line too long (112 > 110 characters) (line-length)
./Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml:76:111: [warning] line too long (112 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.example.dts:85.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1402850

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

