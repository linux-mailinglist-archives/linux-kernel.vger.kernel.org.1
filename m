Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343732FFF7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbhAVJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAVJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:42:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5DC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:42:14 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2sxF-0004I2-N8; Fri, 22 Jan 2021 10:42:09 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1l2sxD-00030e-QC; Fri, 22 Jan 2021 10:42:07 +0100
Date:   Fri, 22 Jan 2021 10:42:07 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Robin van der Gracht <robin@protonic.nl>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 6/7] ARM: dts: imx6dl-prtvt7: fix PWM cell count for
 the backlight node.
Message-ID: <20210122094207.w2upvl5k5sad7u7p@pengutronix.de>
References: <20210121061141.23062-1-o.rempel@pengutronix.de>
 <20210121061141.23062-7-o.rempel@pengutronix.de>
 <CAOMZO5C6RM2vEMFJB-+Nen1Et8wn39JJVM1UcOcar0aMebKykQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C6RM2vEMFJB-+Nen1Et8wn39JJVM1UcOcar0aMebKykQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:40:47 up 50 days, 23:47, 29 users,  load average: 0.09, 0.07,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:17:42AM -0300, Fabio Estevam wrote:
> Hi Oleksij,
> 
> On Thu, Jan 21, 2021 at 3:12 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > At some point PWM cell count was changed, but it didn't triggered any
> 
> It changed in this commit:
> 
> commit fa28d8212ede9c533ae87a737571a9d3b3eebb29
> Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Date:   Fri Jul 10 07:19:37 2020 +0200
> 
>     ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files
> 
>     The imx-pwm driver supports 3 cells and this is the more flexible setting.
>     So use it by default and overwrite it back to two for the files that
>     reference the PWMs with just 2 cells to minimize changes.
> 
>     This allows to drop explicit setting to 3 cells for the boards that already
>     depend on this. The boards that are now using 2 cells explicitly can be
>     converted to 3 individually.
> 
>     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     Signed-off-by: Shawn Guo <shawnguo@kernel.org>

OK, nice. Thx!

Should I resend this series without this patch?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
