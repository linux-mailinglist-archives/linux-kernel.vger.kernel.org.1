Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDDC28F086
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgJOLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgJOLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:00:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889ACC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:00:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kT0zb-0005EJ-GU; Thu, 15 Oct 2020 13:00:19 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kT0za-0005Vw-FH; Thu, 15 Oct 2020 13:00:18 +0200
Date:   Thu, 15 Oct 2020 13:00:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/3] ARM: dts: add Van der Laan LANMCU board
Message-ID: <20201015110018.7u3v7kdsi5osmxs7@pengutronix.de>
References: <20201014085316.11916-1-o.rempel@pengutronix.de>
 <20201014085316.11916-3-o.rempel@pengutronix.de>
 <20201014100501.djbfqzdeodowm4ov@pengutronix.de>
 <20201015090245.ogtzxflo4icxbakv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090245.ogtzxflo4icxbakv@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:59:39 up 335 days,  2:18, 375 users,  load average: 0.11, 0.11,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-15 11:02, Oleksij Rempel wrote:
> Hi Marco,
> 
> thank you for review!
> 
> On Wed, Oct 14, 2020 at 12:05:01PM +0200, Marco Felsch wrote:
> > Hi Oleksij,
> > 
> > pls can you send a patch adding this board to:
> > Documentation/devicetree/bindings/arm/fsl.yaml
> > 
> > infront of this patch?
> 
> This is patch 3/3 and fsl.yaml 2/3. Do I'm missing some thing?

Argh.. didn't saw this patch 2/3..

Regards,
  Marco
