Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7A2EED32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 06:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbhAHFiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 00:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbhAHFiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 00:38:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C5C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 21:37:37 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxkSk-0001Q5-Ar; Fri, 08 Jan 2021 06:37:26 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kxkSj-0001rO-4Q; Fri, 08 Jan 2021 06:37:25 +0100
Date:   Fri, 8 Jan 2021 06:37:25 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        David Jander <david@protonic.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add an entry for
 Kverneland Group
Message-ID: <20210108053725.wsxh7wjpm6dmnniw@pengutronix.de>
References: <20210107100831.30389-1-o.rempel@pengutronix.de>
 <20210107100831.30389-2-o.rempel@pengutronix.de>
 <20210108022323.GA1742887@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108022323.GA1742887@robh.at.kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:36:13 up 36 days, 19:42, 16 users,  load average: 0.07, 0.07,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 07:23:23PM -0700, Rob Herring wrote:
> On Thu, 07 Jan 2021 11:08:27 +0100, Oleksij Rempel wrote:
> > Add "kvg" entry for Kverneland Group: https://ien.kvernelandgroup.com/
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Sorry, nothing is changed.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
