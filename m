Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D242B7B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKRKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:42:31 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:45772 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:42:30 -0500
Received: by mail-ej1-f65.google.com with SMTP id dk16so2012564ejb.12;
        Wed, 18 Nov 2020 02:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSpyNr9ImM7m91CBLdyW5FUGxR8gG95LO/PYe+GLcPM=;
        b=rDkONH0ooGN6zPjwQT/PAJ+R1//Dlt+Ps0mBcq6GY522GsSLeaBTktGzulLuJ3eymO
         ZZSpk1cnb5kBLhUzTulVSCZAo041hnsFvQUZ1asVr2bKTEW0P6PP+bbqZqf0zqNytHsy
         ABF8Y30p/VTTbzl8KcQZiOxBV+T5nL2GFsDW9kT1ZIFLPThn3CIHdmqea56DM+t2B9es
         tURslJX0FtONvQ3nRAnGo3DKY5wLvTyHh+aiXpZrjerA/aAR7BnNv2tbk20FDGzBr4dm
         veVM7EA//tckyX1rlMwd9SdKkpHqvK9thsYp5kLGlaPy9N9gLuXGz77ze1E20omfpnv2
         Ik6g==
X-Gm-Message-State: AOAM531MOrtIEVx6dfrPpLBUNYJSjZoTdMd18Ak4IQpY1PVW016TtzX5
        lp7QjBUq61+YKTONgEgsDSk=
X-Google-Smtp-Source: ABdhPJx7/ODY/gVEoRqL5kGJlrG8wd017WuRtscj4IzeoSwSxUVO6td2HgkiLYpTN9rcgeuRjg3bBw==
X-Received: by 2002:a17:906:1408:: with SMTP id p8mr22992702ejc.548.1605696148906;
        Wed, 18 Nov 2020 02:42:28 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f13sm12601074ejf.42.2020.11.18.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 02:42:28 -0800 (PST)
Date:   Wed, 18 Nov 2020 11:42:26 +0100
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
Message-ID: <20201118104226.GA23766@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com>
 <20201114164128.GD14989@kozik-lap>
 <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201116161338.GB25108@kozik-lap>
 <AM6PR04MB60534E7BD063455FDA2649C3E2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB60534E7BD063455FDA2649C3E2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:28:47AM +0000, Alice Guo wrote:
 > 
> > If it is properly explained and there is no other way then yes, you could. Here, for
> > old DTBs, I would prefer to use
> > of_platform_device_create() and bind to "soc" node (child of root).
> > This way you would always have device and exactly one entry point for the
> > probe.
> > 
> 
> static struct platform_driver imx8_soc_init_driver = {
> 	.probe = imx8_soc_init_probe,
> 	.driver = {
> 		.name = "soc@0",
> 	},
> };
> Can I use "soc@0" to match this driver? It will not use of_platform_device_create(). It will use of_find_property() to determine whether
> and nvmem-cells can be used. If there is no nvmem-cells, it will use the old way, which supports old DTBS. There is no need to add new
> compatible.

No, the soc@0 is not a proper name for the driver.

Best regards,
Krzysztof
