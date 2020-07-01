Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9C210C60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgGANgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 09:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgGANgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:36:49 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BEC206BE;
        Wed,  1 Jul 2020 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593610609;
        bh=LVd6Z6sQeKlC+D0Iufc/3W5Wnj1f478ey4Lp50GY+OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1iUshb6zesMIcVTmT1hoq6eIIOzziS9R29NZUKcZ13b5F4/7G9sjwXl6nKX7equN
         KCUtn7c+q/xRBT+x787tDFuNm+ODwXQxA7PtdwTpBWn4l+3N6uYRyNm1V9dQoOnT/M
         6s4TTBAABfezdYTD2y3EmK9VUzd55r0tALj2StqI=
Date:   Wed, 1 Jul 2020 19:06:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Fix unused-function compiler warning
Message-ID: <20200701133643.GZ2599@vkoul-mobl>
References: <20200701090438.21224-1-tklauser@distanz.ch>
 <20200701131902.GC27013@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701131902.GC27013@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 16:19, Laurent Pinchart wrote:
> Hi Tobias,
> 
> Thank you for the patch.
> 
> On Wed, Jul 01, 2020 at 11:04:38AM +0200, Tobias Klauser wrote:
> > This fixes the following compiler warning when building with
> > CONFIG_PM && !CONFIG_PM_SLEEP:
> > 
> > drivers/phy/xilinx/phy-zynqmp.c:830:12: warning: ‘xpsgtr_resume’ defined but not used [-Wunused-function]
> >   830 | static int xpsgtr_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~
> > drivers/phy/xilinx/phy-zynqmp.c:819:12: warning: ‘xpsgtr_suspend’ defined but not used [-Wunused-function]
> >   819 | static int xpsgtr_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~
> 
> Oops :-S Sorry about that.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Vinod or Kishon, can you pick this patch up, or do I need to send a pull
> request ? (It's my first driver in the PHY subsystem so I don't know
> what the usual practices are there)

patches are welcome :-)

> 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  drivers/phy/xilinx/phy-zynqmp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> > index 8babee2ce9ec..22a0ae635797 100644
> > --- a/drivers/phy/xilinx/phy-zynqmp.c
> > +++ b/drivers/phy/xilinx/phy-zynqmp.c
> > @@ -815,7 +815,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
> >   * Power Management
> >   */
> >  
> > -#ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP

How about marking it as __maybe_unused instead?

-- 
~Vinod
