Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A43009CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbhAVR3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:29:38 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54862 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbhAVQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:47:26 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 79D053B6F60
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:36:42 +0000 (UTC)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5E39340013;
        Fri, 22 Jan 2021 16:35:20 +0000 (UTC)
Date:   Fri, 22 Jan 2021 17:35:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [GIT PULL] ARM: at91: soc for 5.12
Message-ID: <20210122163520.GG1196852@piout.net>
References: <20210122143536.168833-1-nicolas.ferre@microchip.com>
 <CAK8P3a0s5UPvCzQrcYmPPDYgT+YyZ3vc=fF0GEwpqROR+Zio-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0s5UPvCzQrcYmPPDYgT+YyZ3vc=fF0GEwpqROR+Zio-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2021 16:25:47+0100, Arnd Bergmann wrote:
> On Fri, Jan 22, 2021 at 3:35 PM <nicolas.ferre@microchip.com> wrote:
> >
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> >
> > Arnd, Olof,
> >
> > I'm taking back the lead on sending the pull-requests for AT91 and hope that I
> > didn't loose the knowledge in the meantime. Tell me if there's something I'm
> > missing. Thanks a lot to Alexandre who kept our flow steady and very
> > predictable during all those years!
> >
> > Here are the first SoC changes for 5.12 which contain a single patch for multi
> > platform kernels.
> >
> > I plan to send another pull-request for the SoC changes related to new sama7g5
> > that Claudiu sent to the mainling-list recently. I'll let it mature in
> > linux-next by the beginning of next week and will send another pull-request by
> > mid-next-week.
> > Tell me if you see a problem with this approach.
> 
> This all looks good to me, but I think I'd rather take the 'soc' pull request
> into the v5.11 bugfixes, as this may already affect users on other machines.
> 
> I would also suggest adding a 'Cc: stable@vger.kernel.org' tag. If you like,
> I can just cherry-pick that patch into the fixes branch and add it there.
> 

I wouldn't backport it as a fix, this is just a warning, in a
configuration that is very unlikely to be used (and honestly, I
wouldn't enable this driver on any platform).

If you take it as a fix, you'll have to also get
https://lore.kernel.org/linux-arm-kernel/1611318097-8970-5-git-send-email-claudiu.beznea@microchip.com/


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
