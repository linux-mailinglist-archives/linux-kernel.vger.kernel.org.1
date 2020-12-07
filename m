Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DCF2D0EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgLGLHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgLGLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:07:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A1C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:06:29 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kmELT-0006rA-MA; Mon, 07 Dec 2020 12:06:19 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kmELQ-0003OA-J2; Mon, 07 Dec 2020 12:06:16 +0100
Date:   Mon, 7 Dec 2020 12:06:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/8] dt-bindings: display: simple: fix alphabetical
 order for EDT compatibles
Message-ID: <20201207110616.r47utgzdkw3wrply@pengutronix.de>
References: <20201202081826.29512-1-o.rempel@pengutronix.de>
 <20201202081826.29512-2-o.rempel@pengutronix.de>
 <20201205193229.GF332836@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201205193229.GF332836@ravnborg.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:59:39 up 5 days,  1:06, 24 users,  load average: 0.11, 0.08, 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 08:32:29PM +0100, Sam Ravnborg wrote:
> Hi Oleksij

> Thanks for fixing this, but something is not correct.
> I think you switched around the order of comment and compatible.

Ack, i confused my self with comments like:
> > -      - edt,etm0700g0dh6
> > -        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> > -        # Same as ETM0700G0DH6 but with inverted pixel clock.
> >        - edt,etm070080bdh6

Do this comments actually make any sense? All of this devices are kind
of similar to each other.

> On Wed, Dec 02, 2020 at 09:18:19AM +0100, Oleksij Rempel wrote:
> > Reorder it alphabetically and remove one double entry.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../bindings/display/panel/panel-simple.yaml     | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > index edb53ab0d9eb..428b03342fea 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > @@ -106,26 +106,24 @@ properties:
> >          # Emerging Display Technology Corp. 3.5" QVGA TFT LCD panel
> >        - edt,et035012dm6
> >          # Emerging Display Technology Corp. 480x272 TFT Display with capacitive touch
> > +      - edt,et057090dhu
> > +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >        - edt,etm043080dh6gp
> >          # Emerging Display Technology Corp. 480x272 TFT Display
> >        - edt,etm0430g0dh6
> >          # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
> > -      - edt,et057090dhu
> > -        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> > -      - edt,etm070080dh6
> > -        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch


> >          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >          # Same display as the ETM0700G0BDH6, but with changed hardware for the
> >          # backlight and the touch interface.
> > +      - edt,etm070080dh6
> > +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >        - edt,etm070080edh6
> >          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >          # Same timings as the ETM0700G0DH6, but with resistive touch.
> > -      - edt,etm070080dh6
> > -        # Evervision Electronics Co. Ltd. VGG804821 5.0" WVGA TFT LCD Panel
> > +      - edt,etm0700g0dh6
> > +        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> > +        # Same as ETM0700G0DH6 but with inverted pixel clock.
> >        - evervision,vgg804821
> >          # Foxlink Group 5" WVGA TFT LCD panel
> >        - foxlink,fl500wvr00-a0t
> 
> It goes like this
> 
> 	  # This is the comment
> 	- compatible,for-the-comment
> 
> I always look at the first entry when I need to check the order.
> Also the comment for evervision,vgg804821 seems to be lost in the above.

ack.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
