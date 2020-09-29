Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1727D6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgI2TQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:16:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38166 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:16:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id y5so5572374otg.5;
        Tue, 29 Sep 2020 12:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QauaYLRMz+oe1o0xyF9Nqy9xr7O4zWOBwtcjI4EBzEs=;
        b=mppZb6KnSvTZD4uKgzTQrCHOfJbyInIB9bquT3mKHzw7AZJOgNb4UJf1nqRfxosshV
         QGGVOVnnm4KAuWrefXGMH8tBMINvoGmE93UwpEvlzi6UytKs6PKFCo17TFShwmYoI104
         Sjtbt22KNLRcUBeyuYV2qQxqDM2nkCw6BRZxPTjgzS/e0qekrCj5+RFUisFA8Kp4/IzM
         LmacmlCfMzhha3CnQS7BKeLROP2scIYQgkzaeVk2TZ0a/c3WijlWXh8qy1BYNADjDIKq
         pgwa9cPUawWW8SEewn/A4mUhtZ0I9gr3Y+trz/aXbPfNoc5SSghupjj0KDJzt+xF8QhT
         oSCA==
X-Gm-Message-State: AOAM530CnvFFOMyz7ynqbN1xVWyD7ziH1O7kcbuxs7Zd7iDtbbuNPoam
        vv8r6WwiIzgOEXPjkNkwVQ==
X-Google-Smtp-Source: ABdhPJwTwiX45xB3goAL8/bXjW603jv5MrJWRFtRseQpWe5MbJNranbGGR0ZqSsvxDRhUt3XqHZg5A==
X-Received: by 2002:a05:6830:1286:: with SMTP id z6mr3651960otp.291.1601407011974;
        Tue, 29 Sep 2020 12:16:51 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm1207703otp.14.2020.09.29.12.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:16:51 -0700 (PDT)
Received: (nullmailer pid 995045 invoked by uid 1000);
        Tue, 29 Sep 2020 19:16:50 -0000
Date:   Tue, 29 Sep 2020 14:16:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: arm: fsl: document i.MX25 and i.MX27
 boards
Message-ID: <20200929191650.GA994990@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-6-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:03 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX25 and i.MX27 based boards
> to fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/imx27-apf27dev.dt.yaml: /: compatible:
>     ['armadeus,imx27-apf27dev', 'armadeus,imx27-apf27', 'fsl,imx27'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 45 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
