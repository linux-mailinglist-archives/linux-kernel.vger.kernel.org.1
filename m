Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14682B96D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgKSPsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:48:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38784 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgKSPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:48:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id 92so2632305otd.5;
        Thu, 19 Nov 2020 07:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIAE4uzT+8vC+EjZ/7M0VoomkRn2xJpo+773Y2o0nSA=;
        b=XdbZzp5yP9ndEb/PBG5cda94cS32of3hri2ct/8Qpss7AizlrnpnBztWhSJX3b0CvV
         hphahe3g6V6onME1yuUc3+NT21poLFvi9A+lAxB+9CWP1ywXCZe3r+AgbFXt1+IzZBCL
         oupq8z3fxM6I0f6e9WBK0aBtMtZHB5Am1JaE9ojeLKxn/tOI7zrcd1R4ABlrBDUlpoFi
         YA7IsXt54o785RiT7W2Jua3VTiVh2+tIFiuqbaLDLM9YCFyK7ITj7Eia3SknJO3MRGqT
         t2a9R9iQiiKTo1bzk4CaUtByMyxfGzSOvwm4CeK97GizLb4G0vP7NSCaMer85JpSdhVR
         Uw9g==
X-Gm-Message-State: AOAM531XDvLuv4328X9Pyw7W8Emdpxm9O8KBstn6Nt/NBQHjT5QCjum6
        oiIB1WC1S5RMHJsfDMpClw==
X-Google-Smtp-Source: ABdhPJzTxVOEW8YGQa60XmqmgMXCcZhJsnkbKKeiQk6v95zH5TTqI6+EhayfcsXXG4TUs/ahIGv2mw==
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr10744011otf.345.1605800920267;
        Thu, 19 Nov 2020 07:48:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u63sm106798oia.50.2020.11.19.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:48:39 -0800 (PST)
Received: (nullmailer pid 3309224 invoked by uid 1000);
        Thu, 19 Nov 2020 15:48:38 -0000
Date:   Thu, 19 Nov 2020 09:48:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, s.hauer@pengutronix.de, robh+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        tzimmermann@suse.de
Subject: Re: [PATCH 3/8] dt-bindings: display: imx: Add i.MX8qxp/qm DPR
 channel binding
Message-ID: <20201119154838.GA3308916@bogus>
References: <1605777745-23625-1-git-send-email-victor.liu@nxp.com>
 <1605777745-23625-4-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605777745-23625-4-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 17:22:20 +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Prefetch Resolve Channel.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.example.dts:26.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1402852

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

