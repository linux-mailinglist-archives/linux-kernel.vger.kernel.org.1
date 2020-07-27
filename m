Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC86F22F3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgG0PYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgG0PYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:24:47 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC3CC061794;
        Mon, 27 Jul 2020 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9vIfOIhjeocObHiDXZCLuAgghjol6nwY5lbJNZUDwNs=; b=yRj+LeaSFDkx9M/0AwgXuDtpj
        T5mIneCQ+Kz2fI6q+xrI1xiG2gFiIlhJn4TsnFo3pl43IcA668M2w6DCDZ0adB5YbSguNwAtpBVVx
        IfX7FRl0ab4WCz4vl7zD3Z87iPhtR+iWTznoAcBK4lgK/W/r4cnO3Ouhpgma+1mq78RubSHz0Ehhh
        ewqZuHwYw4JKdQXvVoxcW+M6355G3QoNTW22mnVELnisjCHwOzfMbSoR+VBQ2vKLPKxh7WUWvs6P+
        FT0CTG3rbg+LSHKgbt0Bvri2CECLbC0NOnr3n7nfdgmvCaeRaZqYmhlLUsgW9akij+ETbiKN0qy0W
        9au3JzwCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44848)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k04zY-00030U-Gc; Mon, 27 Jul 2020 16:24:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k04zX-0003l8-DE; Mon, 27 Jul 2020 16:24:39 +0100
Date:   Mon, 27 Jul 2020 16:24:39 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, miguelborgesdefreitas@gmail.com,
        a.zummo@towertech.it, baruch@tkos.co.il, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727152439.GK1551@shell.armlinux.org.uk>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <20200727144938.GC239143@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727144938.GC239143@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:49:38PM +0200, Alexandre Belloni wrote:
> On 27/07/2020 10:45:53+0100, Russell King - ARM Linux admin wrote:
> > > This is but this shouldn't be a DT property as it has to be changed
> > > dynamically. I'm working on an ioctl interface to change this
> > > configuration.
> > 
> > Why does it need to be changed dynamically?  If the hardware components
> > are not fitted to allow the RTC to be safely used without DSM, then
> > why should userspace be able to disable DSM?
> 
> For RTCs with a standby mode, you want to be able to return to standby
> mode.
> 
> That would happen for example after factory flashing in that common use
> case:
>  - the board is manufactured
>  - Vbackup is installed, the RTC switches to standby mode
>  - the board is then booted to flash a system, Vprimary is now present,
>    the RTC switches to DSM.
> 
> At this point, if the board is simply shut down, the RTC will start
> draining Vbackup before leaving the factory. Instead, we want to be able
> to return to standby mode until the final user switches the product on
> for the first time.

I don't think you're understanding what's going on with this proposed
patch.  The cubox-i does work today, and the RTC does survive most
power-downs. There are situations where it doesn't.

So, let's take your process above.

- the board is manufactured
- Vbackup is installed, the RTC switches to standby mode
- the board is then booted to flash a system, Vprimary is now present
- the board is powered down.  the RTC _might_ switch over to battery
  if it notices the power failure in time, or it might not.  A random
  sample of units leaving the factory have the RTC in standby mode.
  Others are draining the battery.

I'm not saying what you propose isn't a good idea.  I'm questioning
why we should expose this in the generic kernel on platforms where
it's likely to end up with the RTC being corrupted.

Now, I question your idea that units should leave the factory without
the RTC being programmed.  We know that lovely systemd goes utterly
bonkers if the system time is beyond INT_MAX.  If the RTC leaves
standby mode containing a date which we translate beyond INT_MAX,
systemd will refuse to boot the system, and the user will have no
way to set the correct time.  The user returns the device to the
supplier as faulty...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
