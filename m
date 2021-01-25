Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A49301FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 01:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbhAYAtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 19:49:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33267 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbhAYAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 19:48:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F34335C00D4;
        Sun, 24 Jan 2021 19:47:46 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 24 Jan 2021 19:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=y1nWTSF553upeE1Epom1RrsssjZa5L2
        ibP59KtZo8T0=; b=Ut+P9DcY3DtzVn969+U0jXWzJI6fZA59WXlEgDuJU28e4Uf
        lJjp8TL2HPGfoZ1dZEp/OEFIEbxhqGu/TnuiRSTK7zpbZBWFQyQYofoKfh9obmzI
        /6WKAMt/fa04djYgu3ZSNitMsG9LUHlSFRzoHzJM8dXJRXspR5E8AyYgZOvX9xZd
        pKvtIq0x5+0esqZTlfg9CU8Kd+v0gtGqNI6KOEKOIpf2WtNcvJlC2YaxCiDElsT9
        pSZNqU1Ch1m+Hr5HbB8LbDRw80rqePiHBtIIBUvcqV8tV3MO6DDiqGVDDmfXhi7c
        Zf4vQJl9zjwXixTmDvJL9fLN5J+axH5hj1DYcpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y1nWTS
        F553upeE1Epom1RrsssjZa5L2ibP59KtZo8T0=; b=RyGecOrdRR+ctcQgEt4SCe
        8lzzc2w8yX7ZaqRxKd7dVKN1EyuI+B4qVGgWsE5/0BmzLzVpEWsXK9DlnNsr+XGk
        JXq1CJXu2SS7Hp+6aEVBicd9rvvbFchUriCKTeJNsGv5JzZ1CI6p/Q7O+GgLD/Ef
        +O4NlS7lBqG08OwZFZbc09C3gH6u2rIY4oasJU45MDduLM4pRMXdfFfVnXg9wXym
        2nO2e+EvLz4m4csPvEgFqLgd3xH6E2Fm+MJ2PEqDrNdtzsELtheg6TMHe2CT/y0Y
        wlwf89A4j79SdXxQs39pxeiBIZSfmMpGQHh4+8/ka4ew5sRPPO4UhxI3cFX8Rh6g
        ==
X-ME-Sender: <xms:MBUOYFTVp_xSYzvzRfF715cQWdEtOFuHDeWNtvgndimMic7Koq6K2Q>
    <xme:MBUOYOxohSYaNXqa3Nwy0eb6T8Rl8u0o73iWyT3JLJao1oQ9-581Pm7OJfHw_oHYc
    qOi1N1NnZXAXp6Q8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeffgeffveduueeljefgfeevhfegtefguefgkeefhfekjeeivdekiedttddv
    ledvvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghn
    ughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:MBUOYK0MApys27sTXlXIbSJRL1aNvmSw4oKrc2gkzF-UIqdEaek38g>
    <xmx:MBUOYNA_oj536NgOLrRnvmpztxsLfdJktPbXyQE3eGLdqWlX8WMIHw>
    <xmx:MBUOYOjPbeDqgIzGSLMDBJUNVN9M6zc9u9o7bfveTZ4MM2aczlbn4g>
    <xmx:MhUOYCgGC9ByEf0gaBOXVlg1Es9FACVq8nPimVyaq-3XXg4SxOSoMg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A76A2A0005D; Sun, 24 Jan 2021 19:47:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-78-g36b56e88ef-fm-20210120.001-g36b56e88
Mime-Version: 1.0
Message-Id: <57a20436-5d12-4f7c-b413-0cd1908acf02@www.fastmail.com>
In-Reply-To: <HK0PR06MB338049BAE1D1DAE7567F620DF2A00@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
 <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
 <adadc9ef-32ab-0a79-327c-c499c1c04093@sholland.org>
 <HK0PR06MB338049BAE1D1DAE7567F620DF2A00@HK0PR06MB3380.apcprd06.prod.outlook.com>
Date:   Mon, 25 Jan 2021 11:17:24 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Stephen Boyd" <sboyd@kernel.org>, "Joel Stanley" <joel@jms.id.au>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jan 2021, at 18:45, Ryan Chen wrote:
> Hello,
> 	How about this patch progress?
> 	It does impact a lot of machine that when BMC boot at u-boot. 
> 	SUART is work for Host. But after boot into kernel, due to the clk disabled. 
> 	The SUART is not work for Host anymore. 

Maybe it's worth taking Ryan's patch for now, and when the protected-clocks 
binding gets merged we can rip out the CLK_IS_CRITICAL flags and convert the 
Aspeed devicetrees to use protected-clocks instead?

The only issue I see with that plan is it becomes ambiguous as to which clock 
each platform considers crititical/in-need-of-protection.

Andrew

> 
> Regards,
> Ryan
> > -----Original Message-----
> > From: Samuel Holland <samuel@sholland.org>
> > Sent: Thursday, October 29, 2020 10:25 AM
> > To: Stephen Boyd <sboyd@kernel.org>; Joel Stanley <joel@jms.id.au>
> > Cc: Andrew Jeffery <andrew@aj.id.au>; Michael Turquette
> > <mturquette@baylibre.com>; Ryan Chen <ryan_chen@aspeedtech.com>;
> > BMC-SW <BMC-SW@aspeedtech.com>; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > <linux-aspeed@lists.ozlabs.org>; linux-clk@vger.kernel.org; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
> > 
> > Stephen,
> > 
> > On 10/14/20 12:16 PM, Stephen Boyd wrote:
> > > Quoting Joel Stanley (2020-10-13 22:28:00)
> > >> On Wed, 14 Oct 2020 at 02:50, Stephen Boyd <sboyd@kernel.org> wrote:
> > >>>
> > >>> Quoting Ryan Chen (2020-09-28 00:01:08)
> > >>>> In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2
> > >>>> are default for Host SuperIO UART device, eSPI clk for Host eSPI
> > >>>> bus access eSPI slave channel, those clks can't be disable should
> > >>>> keep default, otherwise will affect Host side access SuperIO and SPI slave
> > device.
> > >>>>
> > >>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > >>>> ---
> > >>>
> > >>> Is there resolution on this thread?
> > >>
> > >> Not yet.
> > >>
> > >> We have a system where the BMC (management controller) controls some
> > >> clocks, but the peripherals that it's clocking are outside the BMC's
> > >> control. In this case, the host processor us using some UARTs and
> > >> what not independent of any code running on the BMC.
> > >>
> > >> Ryan wants to have them marked as critical so the BMC never powers them
> > down.
> > >>
> > >> However, there are systems that don't use this part of the soc, so
> > >> for those implementations they are not critical and Linux on the BMC
> > >> can turn them off.
> > >>
> > >> Do you have any thoughts? Has anyone solved a similar problem already?
> > >>
> > >
> > > Is this critical clocks in DT? Where we want to have different DT for
> > > different device configurations to indicate that some clks should be
> > > marked critical so they're never turned off and other times they
> > > aren't so they're turned off?
> > >
> > > It also sounds sort of like the protected-clocks binding. Where you
> > > don't want to touch certain clks depending on the usage configuration
> > > of the SoC. There is a patch to make that generic that I haven't
> > > applied because it looks wrong at first glance[1]. Maybe not
> > > registering those clks to the framework on the configuration that Ryan has is
> > good enough?
> > 
> > Could you please be more specific than the patch "looks wrong"? I'm more
> > than happy to update the patch to address your concerns, but I cannot do that
> > unless I know what your concerns are.
> > 
> > Regards,
> > Samuel
> > 
> > > [1]
> > > https://lore.kernel.org/r/20200903040015.5627-2-samuel@sholland.org
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
