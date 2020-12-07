Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2952D1226
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgLGNdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:33:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33089 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgLGNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:33:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id w206so9571908wma.0;
        Mon, 07 Dec 2020 05:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RembZIikAsE5OexlUCmMaxB8Hxwcn1zAj8r/g95Ples=;
        b=feC85Ph5EwED2vdZ/G39ezyxe09DIe4/4fCc5ft7vX0Htz3WajTiMTV9fZVtZrmh6o
         d9YoSRnR9cdlIWMI8m3Rszddwz8c9jq8wq/o5iwsgTJ+71v6qMUF0YueYKqZSaCg10Hv
         E9c2n1SWJ1E8bvSyq/Z9LNr6xI553y5Wh1x3neRLVMjgDTtKYlwUZOrK8PhI6HviG34p
         hQbUdPb45hHu8zaciEbVlrqzVRFRwkIkggOlyQRtebETTBMo8V5iUDMsFC38FlZHl4zV
         3Tu9EJF8NEMG0tSH4Jxb0scSnhPbCM0bqKHdxVNyYhhfYdhQeICWOj2KUCCMXnDnKIfx
         teCg==
X-Gm-Message-State: AOAM533Tr7PdHyxuj2qgthjpLLbXn3DS66/EVeNWCxJf/UdFFuZsrd7G
        D6GjgIwQmziF7QENqIzo5hU=
X-Google-Smtp-Source: ABdhPJyuL/ez8mJ0q23T4aZfgVuL6x9VKr+VNNaVPLFEKOwvqeI1hYphd1rV0mYYmwzWeC3qZmjs7A==
X-Received: by 2002:a1c:b402:: with SMTP id d2mr18163671wmf.38.1607347943775;
        Mon, 07 Dec 2020 05:32:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t1sm2283843wro.27.2020.12.07.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:32:22 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:32:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Message-ID: <20201207133221.GA32877@kozik-lap>
References: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
 <20201207132140.GA31982@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207132140.GA31982@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:21:40PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> > Error log:
> > sysfs: cannot create duplicate filename '/bus/platform/devices/30000000.bus'
> > 
> > The spba bus name is duplicate with aips bus name.
> > Refine spba bus name to fix this issue.
> > 
> > Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index fd669c0f3fe5..30762eb4f0a7 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -246,7 +246,7 @@ aips1: bus@30000000 {
> >  			#size-cells = <1>;
> >  			ranges;
> >  
> > -			spba: bus@30000000 {
> > +			spba: spba-bus@30000000 {
> 
> The proper node name is "bus" so basically you introduce wrong name to
> other problem.  Introducing wrong names at least requires a comment.

I just noticed that my message was barely understandable... so let me
fix it:

The proper node name is "bus" so basically you introduce wrong name to
_fix_ other problem.  Introducing wrong names at least requires a comment.

> However the actual problem here is not in node names but in addresses:
> 
> 	aips1: bus@30000000 {
> 		spba: bus@30000000 {
> 
> You have to devices with the same unit address. How do you share the
> address space?
> 
> I think this should be rather fixed.

And again, hungry keyboard ate a letter, so:

You have _two_ devices with the same unit address. How do you share the
address space?
I think this should be rather fixed.

Best regards,
Krzysztof
