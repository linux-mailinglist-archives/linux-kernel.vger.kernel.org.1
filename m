Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C11F278ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgIYOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgIYOV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:21:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1F4208A9;
        Fri, 25 Sep 2020 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601043716;
        bh=S03ouvc4Wtwn2XnHrltiJObGWm6huyZQX8jzvKd1Aok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eu/Xch7YM2T/Mun7Cgb6UW6fjul9MEfEY9sEctwa4lA4huUje85m5yjtpXGWufPxR
         /LzlwIMm5RQ55U8/iutlWpEAy409dqrBldGDGn8s9D/IVjinC+kgHTPJM9Ur3hLqGc
         cfIYS6UTURCmXv84g0jlnJWr71Z8NUHn7plSg2NE=
Received: by pali.im (Postfix)
        id A295468A; Fri, 25 Sep 2020 16:21:53 +0200 (CEST)
Date:   Fri, 25 Sep 2020 16:21:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Update link to V7
 schematic
Message-ID: <20200925142153.el56h5ttxbcdmxcm@pali>
References: <20200925084306.16309-1-pali@kernel.org>
 <87wo0iezsr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wo0iezsr.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Friday 25 September 2020 15:44:36 Gregory CLEMENT wrote:
> Hello Pali,
> 
> could you add a commit log besides the topic ?

I can add, but I do not know what to write for such simple update.

> Also note that I've just sent the pull requests for 5.10 and I was
> already a little late for that, so I fear this patch will be for 5.11.

I think it is fine.

> Unless the former url was broken it this case it could be considered as
> a fixe and could be applied for 5.9. If you think it, you should also
> add a "Fixes:" tag.

Both URLs are still working. Previous URL just contains older version.
New URL is available in the main / official web page [1] for technical
documentation and also is more descriptive.

[1] - http://espressobin.net/tech-spec/

> Thank,
> 
> Gregory
> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > index 61d49d6a2a2a..6062a7df7342 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > @@ -8,7 +8,7 @@
> >   *
> >   */
> >  /*
> > - * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> > + * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
> >   */
> >  
> >  /dts-v1/;
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > index 44dbe9a21cc7..c47a93978386 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > @@ -8,7 +8,7 @@
> >   *
> >   */
> >  /*
> > - * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
> > + * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
> >   */
> >  
> >  /dts-v1/;
> > -- 
> > 2.20.1
> >
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
