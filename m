Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF5233340
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgG3NlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 09:41:17 -0400
Received: from vps.xff.cz ([195.181.215.36]:55364 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgG3NlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1596116471; bh=GofhiWtZo83ZcSwGRix98z4zveLZhyL8LDQJeSZFE5I=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=iZkcEonxCQQzyGK1LZyT3oh0DfrUWc6bPMjsFRVLCIiNAsKJ8tKncEPFNJv9Nl/pc
         1c3mp/qj79uELGYcZXENPLcN1S5z4QVZmrPBhOmpT8/3WF0mB9ozYWBCyKyv89+6pE
         dAaRRkoiFvtzkBHs0FQXQ8QZIfut82ivnSo3/7cY=
Date:   Thu, 30 Jul 2020 15:41:11 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix st7703 panel initialization failures
Message-ID: <20200730134111.nayvgw4kcxeg6kft@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Fabio Estevam <festevam@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200716123753.3552425-1-megous@megous.com>
 <20200716140843.GA359122@bogon.m.sigxcpu.org>
 <20200716143209.ud6ote4q545bo2c7@core.my.home>
 <20200718173124.GA88021@bogon.m.sigxcpu.org>
 <20200718174215.mgjl3klytfa3nf3t@core.my.home>
 <20200729154809.GA435075@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729154809.GA435075@bogon.m.sigxcpu.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 29, 2020 at 05:48:09PM +0200, Guido Günther wrote:
> Hi,
> On Sat, Jul 18, 2020 at 07:42:15PM +0200, Ondřej Jirman wrote:
> > Hello,
> > 
> > On Sat, Jul 18, 2020 at 07:31:24PM +0200, Guido Günther wrote:
> > > Hi,
> > > On Thu, Jul 16, 2020 at 04:32:09PM +0200, Ondřej Jirman wrote:
> > > > Hi Guido,
> > > > 
> > > > On Thu, Jul 16, 2020 at 04:08:43PM +0200, Guido Günther wrote:
> > > > > Hi Ondrej,
> > > > > On Thu, Jul 16, 2020 at 02:37:51PM +0200, Ondrej Jirman wrote:
> > > > > > When extending the driver for xbd599 panel support I tried to do minimal
> > > > > > changes and keep the existing initialization timing.
> > > > > > 
> > > > > > It turned out that it's not good enough and the existing init sequence
> > > > > > is too aggressive and doesn't follow the specification. On PinePhone
> > > > > > panel is being powered down/up during suspend/resume and with current
> > > > > > timings this frequently leads to corrupted display.
> > > > > 
> > > > > Given the amount of ST7703 look alikes i don't think you can go by the
> > > > > datasheet and hope not to break other panels. The current sleeps cater
> > > > > for the rocktech panel (which suffered from similar issues you describe
> > > > > when we took other parameters) so you need to make those panel specific.
> > > > 
> > > > It should work on rocktech too. The patch mostly increases/reorders the delays
> > > > slightly, to match the controller documentation. I don't see a reason to
> > > > complicate the driver with per panel special delays, unless these patches don't
> > > > work on your panel.
> > > 
> > > That's why i brought it up. It breaks the rocktech panel on
> > > blank/unblank loops where it just stays blank and then starts hitting
> > > DSI command timeouts.
> > 
> > Good to know. Does keeping the msleep(20); after init sequence and before sleep
> > exit make it work?
> 
> We need both sleeps to make this work reliably so basically
> reverting your 'drm/panel: st7703: Make the sleep exit timing match the
> spec' makes things stable again.
> 
> We don't need to sleep 120ms after sleep out though since our panel only
> requires 15ms as per data sheet there so it really makes sense to make
> these configurable.

Thank you for checking it.

I'd be happy with just the other patch being applied. That would be enough
to fix issues with xingbangda panel too.

In my tests xbd panel doesn't need 120ms either, despite the datasheet.
What breaks xbd panel is the lack of post-powerup delay before deasserting
reset line.

regards,
	o.

> Cheers,
>  -- Guido
> 
> > 
> > thank you and regards,
> > 	o.
> > 
> > > Cheers,
> > >  -- Guido
> > > 
> > > > 
> > > > The init sequence is still suboptimal, and doesn't follow the kernel docs
> > > > completely, even after these patches. Controller spec also talks about adding
> > > > some delay before enabling the backlight to avoid visual glitches.
> > > > 
> > > > Which is what enable callback is documented to be for. Currently part of the
> > > > initialization that belongs to prepare callback is also done in enable callback.
> > > > 
> > > > I see the glitch (small vertical shift of the image on powerup), but personally
> > > > don't care much to introduce even more delays to the driver, just for the
> > > > cosmetic issue.
> > > > 
> > > > regards,
> > > > 	o.
> > > > 
> > > > > Cheers,
> > > > >  -- Guido
> > > > > 
> > > > > > 
> > > > > > This patch series fixes the problems.
> > > > > > 
> > > > > > The issue was reported by Samuel Holland.
> > > > > > 
> > > > > > Relevant screenshots from the datasheet:
> > > > > > 
> > > > > >   Power on timing: https://megous.com/dl/tmp/35b72e674ce0ca27.png
> > > > > >   Power off timing: https://megous.com/dl/tmp/dea195517106ff17.png
> > > > > >   More optimal reset on poweron: https://megous.com/dl/tmp/a9e5caf14e1b0dc6.png
> > > > > >   Less optimal reset on poweron: https://megous.com/dl/tmp/246761039283c4cf.png
> > > > > >   Datasheet: https://megous.com/dl/tmp/ST7703_DS_v01_20160128.pdf
> > > > > > 
> > > > > > Please take a look.
> > > > > > 
> > > > > > thank you and regards,
> > > > > >   Ondrej Jirman
> > > > > > 
> > > > > > Ondrej Jirman (2):
> > > > > >   drm/panel: st7703: Make the sleep exit timing match the spec
> > > > > >   drm/panel: st7703: Fix the power up sequence of the panel
> > > > > > 
> > > > > >  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 29 ++++++++++---------
> > > > > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > -- 
> > > > > > 2.27.0
> > > > > > 
> > > > 
> > 
