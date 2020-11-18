Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03AD2B7F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgKROKs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Nov 2020 09:10:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47025 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgKROKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:10:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id t11so2096960edj.13;
        Wed, 18 Nov 2020 06:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dCaejjvBRfN9D5+bG0Al83hd61GejEfm84KJfE/0UCg=;
        b=Mw3hX1vlT6r5adqhgBM4Xv98OiHIY8Wsb+mr4I3UBPNM5eOfw2Uv0+VowR1u9Dzm0V
         VC7GPf9DVa5bcPLKJiy3KgdLMz7mhi9/QT611wou7zU66FgwC2NGiotSdCc8Kfj8Ifyd
         MIycLCHWvrJ+0HZwXlWNU/rASITXI9PschqOSUQRcqX6EplSgD1YGUJcD7POPSBNJiHY
         2t4XlITpppVySZegSrl7wt8uVfBOSnQm4BtQ1GKQX77seUntXUjmlx4QqMSBi7hsaTlP
         9T4BlBv7rEPvOL0uOfbgkwgujixV0fFowMQEq7Y569MJFv85x4D4HYvpjegm2ZThn7gn
         cT+w==
X-Gm-Message-State: AOAM530JqV5/8K1u5IoKzpX8USZOJm5QHD1xCdw4Su9q6VaWmDKcqOQX
        PidpuovqApUVKG6d/d4LYLA=
X-Google-Smtp-Source: ABdhPJy++65D5QzRsXuY80U6RF8EXBj+9O/hM9l5oSx51AwG4Ga8m9PRsg3wegP1c0kwUiNX9HTgJw==
X-Received: by 2002:aa7:cc0e:: with SMTP id q14mr26071520edt.181.1605708645493;
        Wed, 18 Nov 2020 06:10:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i3sm1047604ejh.80.2020.11.18.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:10:44 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:10:42 +0100
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
Message-ID: <20201118141042.GA34654@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com>
 <20201114164128.GD14989@kozik-lap>
 <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201116161338.GB25108@kozik-lap>
 <AM6PR04MB60534E7BD063455FDA2649C3E2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201118104226.GA23766@kozik-lap>
 <AM6PR04MB6053817F03F3857C68CA833CE2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB6053817F03F3857C68CA833CE2E10@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:07:41PM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月18日 18:42
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform
> > driver
> > 
> > Caution: EXT Email
> > 
> > On Wed, Nov 18, 2020 at 10:28:47AM +0000, Alice Guo wrote:
> >  >
> > > > If it is properly explained and there is no other way then yes, you
> > > > could. Here, for old DTBs, I would prefer to use
> > > > of_platform_device_create() and bind to "soc" node (child of root).
> > > > This way you would always have device and exactly one entry point
> > > > for the probe.
> > > >
> > >
> > > static struct platform_driver imx8_soc_init_driver = {
> > >       .probe = imx8_soc_init_probe,
> > >       .driver = {
> > >               .name = "soc@0",
> > >       },
> > > };
> > > Can I use "soc@0" to match this driver? It will not use
> > > of_platform_device_create(). It will use of_find_property() to
> > > determine whether and nvmem-cells can be used. If there is no nvmem-cells,
> > it will use the old way, which supports old DTBS. There is no need to add new
> > compatible.
> > 
> > No, the soc@0 is not a proper name for the driver.
> 
> I have no good idea, please give suggestion. Should I still add new compatible?
> Should I still keep device_initcall? If use of_platform_device_create(), which
> node should I use?

I mentioned my idea in the email before - of_platform_device_create() to
bind to the soc node. This will have to be in the initcall, you don't
have a choice to avoid it, since there was no compatible before.

Best regards,
Krzysztof

