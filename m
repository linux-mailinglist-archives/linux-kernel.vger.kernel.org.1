Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239D72AB753
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgKILk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgKILk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:40:27 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB35206B6;
        Mon,  9 Nov 2020 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922026;
        bh=ZH2CxmFqi2H7DhI5aondhhSGXd5KskCQ2BDSLlT/ciM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2L7Q6hr5R4N68mnap64H4bxsT4L7HmXJmmLL/v0olIfjECOoO8rU5N2J6KS5A4Fck
         I2f5eZ5LL3WY1Qb1/lKXOPOdae03U2eHNaCDkVW/1iGrpeLq9znPBDe5nY479LsmGL
         XXm+cu5hoC8dtNNQVhGXVzroMSEUgIbhyWJ4WMGg=
Date:   Mon, 9 Nov 2020 12:41:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Message-ID: <20201109114125.GC1769924@kroah.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:57:05AM +0000, Aisheng Dong wrote:
> Hi Greg,
> 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, November 9, 2020 6:37 PM
> > Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix build
> > failure
> > 
> > On Mon, Nov 09, 2020 at 10:14:46AM +0000, Sudip Mukherjee wrote:
> > > Hi Greg,
> > >
> > > On Sun, Nov 8, 2020 at 8:23 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip Mukherjee wrote:
> > > > > When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> > > > > is unable to find device_is_bound(). The error being:
> > > > > ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> > > > >       undefined!
> > > > >
> > > > > Export the symbol so that the module finds it.
> > > > >
> > > > > Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding
> > > > > support")
> > > > > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > > > > ---
> > > > >
> > > > > resending with the Fixes: tag.
> > > > >
> > > > >  drivers/base/dd.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c index
> > > > > 148e81969e04..a796a57e5efb 100644
> > > > > --- a/drivers/base/dd.c
> > > > > +++ b/drivers/base/dd.c
> > > > > @@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)  {
> > > > >       return dev->p && klist_node_attached(&dev->p->knode_driver);
> > > > >  }
> > > > > +EXPORT_SYMBOL(device_is_bound);
> > > >
> > > > EXPORT_SYMBOL_GPL() please, like all the other exports in this file.
> > > >
> > > > Also, wait, no, don't call this, are you sure you are calling it in
> > > > a race-free way?  And what branch/tree is the above commit in?
> > >
> > > I have not checked fully but since it is being called from probe() I
> > > assume the lock will be held at that time.
> > 
> > probe() should never call this function as it makes no sense at all at that point in
> > time.  The driver should be fixed.
> 
> Would you suggest if any other API we can use to allow the driver to know whether
> another device has been probed?

There is none, sorry, as that just opens up way too many problems.

> For imx scu driver in question, it has a special requirement that it depends on scu power domain
> driver. However, there're a huge number (200+) of power domains for each device clock, we can't define
> them all in DT for a single clock controller node.
> 
> That's why we wanted to use device_is_bound() before to check if scu power domain is ready or not to
> support defer probe.

Use the device link functionality for this type of thing, that is what
it was created for.

thanks,

greg k-h
