Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C7D2B8F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgKSJmH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 04:42:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32791 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgKSJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:42:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id k4so5164658edl.0;
        Thu, 19 Nov 2020 01:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3auPEnlipqCorigcU4BHjBL1ODSkT0upvIcBnwf2V8I=;
        b=Ltaa/tHJGpYIAD9TUO6XSrAhfNOlE1XcECAl/PBwFC3PM3GGfoYwMW3t3poQvAqpxC
         8CSRVd0DhSixNun5AD7AyRuL1ednH8go/Ofwik+IpeD4KPYJ+mlC9xjeY41/CGBLgOwP
         gSWLfzWKh+sqiE/lRch2+vpO22dyNFk7HcUKL9r/Odt+qNvwc+2kqcWCKYwxNMQMTaXw
         h6hIYwbDy/NTnNGrwxP6KX3UZwNEL22KYEgilkfMt0sWnJbLdeY23/M9jV8xKknIwMd3
         9aR1YMaiJDD/+VKf57OaqI5J+O3nH+OdzgMbd7ZtxlNM5001EiF4MotBZYfiRZCGqeKg
         AYaA==
X-Gm-Message-State: AOAM532ir+7lywH5G7eXgM2wPtzS6lxmOOwElWrYqiuxvssNPXYjTeZ/
        pVyb+Sv1w5MfXGgjIBSnOgY=
X-Google-Smtp-Source: ABdhPJy9aK/v8lgD//8i81Okyz9z/08o/+z/Z/jVtCQN8EkcFIdhDPo/tTgCG6Gz3Q6sry9vOEiW2A==
X-Received: by 2002:a05:6402:370:: with SMTP id s16mr28723329edw.50.1605778924729;
        Thu, 19 Nov 2020 01:42:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s20sm14458997edw.26.2020.11.19.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 01:42:03 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:42:01 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform
 driver
Message-ID: <20201119094201.GA3841@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com>
 <20201114164128.GD14989@kozik-lap>
 <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201116161338.GB25108@kozik-lap>
 <AM6PR04MB60534E7BD063455FDA2649C3E2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201118104226.GA23766@kozik-lap>
 <AM6PR04MB6053817F03F3857C68CA833CE2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201118141042.GA34654@kozik-lap>
 <AM6PR04MB6053E8B7B16148887482F7A4E2E00@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB6053E8B7B16148887482F7A4E2E00@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 07:32:17AM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月18日 22:11
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform driver
> > 
> > Caution: EXT Email
> > 
> > On Wed, Nov 18, 2020 at 02:07:41PM +0000, Alice Guo wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Sent: 2020年11月18日 18:42
> > > > To: Alice Guo <alice.guo@nxp.com>
> > > > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use
> > > > platform driver
> > > >
> > > > Caution: EXT Email
> > > >
> > > > On Wed, Nov 18, 2020 at 10:28:47AM +0000, Alice Guo wrote:
> > > >  >
> > > > > > If it is properly explained and there is no other way then yes,
> > > > > > you could. Here, for old DTBs, I would prefer to use
> > > > > > of_platform_device_create() and bind to "soc" node (child of root).
> > > > > > This way you would always have device and exactly one entry
> > > > > > point for the probe.
> > > > > >
> > > > >
> > > > > static struct platform_driver imx8_soc_init_driver = {
> > > > >       .probe = imx8_soc_init_probe,
> > > > >       .driver = {
> > > > >               .name = "soc@0",
> > > > >       },
> > > > > };
> > > > > Can I use "soc@0" to match this driver? It will not use
> > > > > of_platform_device_create(). It will use of_find_property() to
> > > > > determine whether and nvmem-cells can be used. If there is no
> > > > > nvmem-cells,
> > > > it will use the old way, which supports old DTBS. There is no need
> > > > to add new compatible.
> > > >
> > > > No, the soc@0 is not a proper name for the driver.
> > >
> > > I have no good idea, please give suggestion. Should I still add new compatible?
> > > Should I still keep device_initcall? If use
> > > of_platform_device_create(), which node should I use?
> > 
> > I mentioned my idea in the email before - of_platform_device_create() to bind
> > to the soc node. This will have to be in the initcall, you don't have a choice to
> > avoid it, since there was no compatible before.
> >
> 
> 	node = of_find_node_by_path("/soc@0");
> 	if (!node)
> 		return -ENODEV;
> 
> 	pdev = of_platform_device_create(node, "XXX", NULL);
> 	if (!pdev)
> 		return -ENODEV;
> 
> Cannot use of_platform_device_create because "of_node_test_and_set_flag(np, OF_POPULATED)" returns true.
> of_platform_device_create is used to create platform device, but soc@0 is created by common code. I don't know how
> to bind to the soc node. The way I did in v3 seems not bad, it can work correctly and support old DTBs. Can I keep this way?

Indeed, it would require some more hacks and actually might not work at
all since bus device is already created. Keep the old way and fix other
pointed out issues.

Best regards,
Krzysztof

