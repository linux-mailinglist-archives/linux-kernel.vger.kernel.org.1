Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0732D0EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgLGLIo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLGLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:08:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71919C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:08:03 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kmEMz-0006zp-F7; Mon, 07 Dec 2020 12:07:53 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kmEMx-0003Om-SK; Mon, 07 Dec 2020 12:07:51 +0100
Date:   Mon, 7 Dec 2020 12:07:51 +0100
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
Subject: Re: [PATCH v6 2/8] dt-bindings: display: simple: add EDT compatibles
 already supported by the driver
Message-ID: <20201207110751.n5agiqjbdfuraslj@pengutronix.de>
References: <20201202081826.29512-1-o.rempel@pengutronix.de>
 <20201202081826.29512-3-o.rempel@pengutronix.de>
 <20201205193538.GG332836@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201205193538.GG332836@ravnborg.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:06:49 up 5 days,  1:13, 24 users,  load average: 0.04, 0.04, 0.05
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 08:35:38PM +0100, Sam Ravnborg wrote:
> Hi Oleksij,
> 
> On Wed, Dec 02, 2020 at 09:18:20AM +0100, Oleksij Rempel wrote:
> > Some EDT compatibles are already supported by the driver but will fail
> > on checkpatch script. Fix it by syncing dt-bindings documentation with the
> > driver.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/display/panel/panel-simple.yaml        | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > index 428b03342fea..0bb3e67fb58c 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > @@ -108,10 +108,12 @@ properties:
> >          # Emerging Display Technology Corp. 480x272 TFT Display with capacitive touch
> >        - edt,et057090dhu
> >          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> > +      - edt,et070080dh6
> >        - edt,etm043080dh6gp
> >          # Emerging Display Technology Corp. 480x272 TFT Display
> >        - edt,etm0430g0dh6
> >          # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
> > +      - edt,etm0700g0bdh6
> >        - edt,etm070080bdh6
> The order is wrong here. edt,etm070080bdh6 comes before edt,etm0700g0bdh6.
> I checked with "sort" in my editor just to make sure.

I would really like to remove this useless comments. It make sorting so
mach easier.

> >          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >          # Same display as the ETM0700G0BDH6, but with changed hardware for the
> > @@ -124,6 +126,7 @@ properties:
> >        - edt,etm0700g0dh6
> >          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >          # Same as ETM0700G0DH6 but with inverted pixel clock.
> > +      - edt,etm0700g0edh6
> >        - evervision,vgg804821
> >          # Foxlink Group 5" WVGA TFT LCD panel
> >        - foxlink,fl500wvr00-a0t
> 
> 	Sam
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
