Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297182C78FB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgK2Lqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 06:46:54 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:36918 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387474AbgK2Lqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 06:46:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8D976FB03;
        Sun, 29 Nov 2020 12:46:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uofVr3cjS6wZ; Sun, 29 Nov 2020 12:46:10 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CC0A44068E; Sun, 29 Nov 2020 12:46:09 +0100 (CET)
Date:   Sun, 29 Nov 2020 12:46:09 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] arm64: defconfig: Enable Librem 5 hardware
Message-ID: <20201129114609.GA3242@bogon.m.sigxcpu.org>
References: <cover.1606495281.git.agx@sigxcpu.org>
 <20201127200908.GA1162@amd>
 <20201128191019.GB6719@bogon.m.sigxcpu.org>
 <20201128205848.GA20920@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128205848.GA20920@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Sat, Nov 28, 2020 at 09:58:48PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This series enables components found on Purism's Librem 5
> > > > that are available in mainline.
> > > > 
> > > > - changes from v1
> > > >   - As per review comments from Krzysztof Kozlowski
> > > >     https://lore.kernel.org/linux-arm-kernel/CAJKOXPdEwiSTg+cMes_wes5oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com/
> > > >     - Squash config changes into a single commit
> > > >   - Add touch controller
> > > > 
> > > > Patches are on top of Shawn's imx/defconfig
> > > 
> > > Thanks for bringing support for your hardware to the mainline.
> > > 
> > > Can I ask phone-devel@vger.kernel.org to be cc-ed for phone-related
> > > changes?
> > 
> > Good point. Done with v3.
> > 
> > > How complete is the support?
> > 
> > The components enabled should work in 5.11 (there's some LCD/DSI patches
> > in flight (that's why i did not send the corresponding DT addition yet)
> > and we need to submit a DT for Evergreen (imx8mq-librem5r4).
> > 
> > https://git.sigxcpu.org/cgit/talks/2020-debconf-mobile/plain/talk.pdf
> > 
> > is a bit outdated but has some numbers starting on page 24.
> 
> Thanks for pointer :-).
> 
> > > In particular, what interface do you use to configure audio routing
> > > for the modem?
> > 
> > https://salsa.debian.org/DebianOnMobile-team/callaudiod manages
> > > that.
> 
> Does kernel provide mixer interface for callaudiod to do its job?

callaudiod handles selecting e.g. earpiece vs. speaker by selecting the
right pulseaudio ports (it's invoked by calls (the phone call handling
application via DBus) and only relies on the codec being an alsa
device and hence handled by pulseaudio/alsa-ucm.

Wys (https://source.puri.sm/Librem5/wys) manages the routing between the
modem and codec by listening to ModemManager's state and connecting audio
source and sink (again solely via pulsaudio so again just relying on
modem and codec being alsa devices). Since the modem is not part of the
SoC on the Librem 5 it's a completely separate device.

Cheers,
 -- Guido


> 
> Best regards,
> 
> 								Pavel
> -- 
> http://www.livejournal.com/~pavelmachek


