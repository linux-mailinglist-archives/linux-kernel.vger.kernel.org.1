Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CECB2B7B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKRKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgKRKov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:44:51 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DED7206A5;
        Wed, 18 Nov 2020 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605696289;
        bh=gTI+Tk0xN6ZXh54yy91oECXFwZUA9qhLXwJEsFPlDCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUr+LKlDil0FVn+Ut1kK2ECrSQzEWBgnnoEduRezMbB4QWt7lUASxRSJoj1g2Tsii
         xF6zKZmwc4Fd2DMherCpe4kiCAElyTPDVQtY9inYnMHqdiXk4kQTCN6LfoJAExrd0r
         sN+pJxnWH344VhBTWYZwrsa+u9QcWrI2ULvgHQlg=
Date:   Wed, 18 Nov 2020 11:45:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Message-ID: <X7T7TgGGgxx9j2Rl@kroah.com>
References: <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109114125.GC1769924@kroah.com>
 <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109120512.GB1832201@kroah.com>
 <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com>
 <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:23:42AM +0000, Aisheng Dong wrote:
> Hi Greg,
> 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, November 9, 2020 8:48 PM
> > 
> > On Mon, Nov 09, 2020 at 12:26:55PM +0000, Aisheng Dong wrote:
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Monday, November 9, 2020 8:05 PM
> > > >
> > > > On Mon, Nov 09, 2020 at 11:55:46AM +0000, Aisheng Dong wrote:
> > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Sent: Monday, November 9, 2020 7:41 PM
> > > > > >
> > > > > > On Mon, Nov 09, 2020 at 10:57:05AM +0000, Aisheng Dong wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Sent: Monday, November 9, 2020 6:37 PM
> > > > > > > > Subject: Re: [PATCH RESEND] driver core: export
> > > > > > > > device_is_bound() to fix build failure
> > > > > > > >
> > > > > > > > On Mon, Nov 09, 2020 at 10:14:46AM +0000, Sudip Mukherjee
> > wrote:
> > > > > > > > > Hi Greg,
> > > > > > > > >
> > > > > > > > > On Sun, Nov 8, 2020 at 8:23 AM Greg Kroah-Hartman
> > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip Mukherjee
> > wrote:
> > > > > > > > > > > When CONFIG_MXC_CLK_SCU is configured as 'm' the build
> > > > > > > > > > > fails as it is unable to find device_is_bound(). The error being:
> > > > > > > > > > > ERROR: modpost: "device_is_bound"
> > > > [drivers/clk/imx/clk-imx-scu.ko]
> > > > > > > > > > >       undefined!
> > > > > > > > > > >
> > > > > > > > > > > Export the symbol so that the module finds it.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells
> > > > > > > > > > > binding
> > > > > > > > > > > support")
> > > > > > > > > > > Signed-off-by: Sudip Mukherjee
> > > > > > > > > > > <sudipm.mukherjee@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > resending with the Fixes: tag.
> > > > > > > > > > >
> > > > > > > > > > >  drivers/base/dd.c | 1 +
> > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > > > > > > > > index 148e81969e04..a796a57e5efb 100644
> > > > > > > > > > > --- a/drivers/base/dd.c
> > > > > > > > > > > +++ b/drivers/base/dd.c
> > > > > > > > > > > @@ -353,6 +353,7 @@ bool device_is_bound(struct device
> > > > > > > > > > > *dev)
> > > > {
> > > > > > > > > > >       return dev->p &&
> > > > > > > > > > > klist_node_attached(&dev->p->knode_driver);
> > > > > > > > > > >  }
> > > > > > > > > > > +EXPORT_SYMBOL(device_is_bound);
> > > > > > > > > >
> > > > > > > > > > EXPORT_SYMBOL_GPL() please, like all the other exports in this
> > file.
> > > > > > > > > >
> > > > > > > > > > Also, wait, no, don't call this, are you sure you are
> > > > > > > > > > calling it in a race-free way?  And what branch/tree is
> > > > > > > > > > the above
> > > > commit in?
> > > > > > > > >
> > > > > > > > > I have not checked fully but since it is being called from
> > > > > > > > > probe() I assume the lock will be held at that time.
> > > > > > > >
> > > > > > > > probe() should never call this function as it makes no sense
> > > > > > > > at all at that point in time.  The driver should be fixed.
> > > > > > >
> > > > > > > Would you suggest if any other API we can use to allow the
> > > > > > > driver to know whether another device has been probed?
> > > > > >
> > > > > > There is none, sorry, as that just opens up way too many problems.
> > > > > >
> > > > > > > For imx scu driver in question, it has a special requirement
> > > > > > > that it depends on scu power domain driver. However, there're
> > > > > > > a huge number
> > > > > > > (200+) of power domains for each device clock, we can't define
> > > > > > > them all in DT
> > > > > > for a single clock controller node.
> > > > > > >
> > > > > > > That's why we wanted to use device_is_bound() before to check
> > > > > > > if scu power domain is ready or not to support defer probe.
> > > > > >
> > > > > > Use the device link functionality for this type of thing, that
> > > > > > is what it was created for.
> > > > > >
> > > > >
> > > > > Thanks for the suggestion. I will check it how to use.
> > > > > BTW, I wonder if dev_driver_string() could be an optional solution
> > > > > which seems a more simple way?
> > > >
> > > > Also, how do you really know you even have a valid pointer to that
> > > > other device structure?  How are you getting access to that?
> > > >
> > >
> > > The rough idea is as follows. Not sure if those APIs are safe enough
> > > as there're many users In kernel.
> > >
> > > pd_np = of_find_compatible_node(NULL, NULL, "fsl,scu-pd"); pd_dev =
> > > of_find_device_by_node(pd_np); if (!pd_dev ||
> > > !dev_driver_string(&pd_dev->dev) ||
> > >    strcmp(dev_driver_string(&pd_dev->dev), "imx-scu-pd")) {
> > >         of_node_put(pd_np);
> > >         return -EPROBE_DEFER;
> > > }
> > 
> > Ick, again, no, don't do that, you can not guarantee "names" of devices
> > anywhere in the system, sorry.
> 
> I tried to understand how to use devlink for this case by diving deep into the devlink code,
> however, it looked to me there're a few limitations on the current devlink usage.

Adding Saravana, who wrote that code to help explain it.

> We can't create driver presence dependency link in consumer's probe function
> while the supplier driver is still not probed or even not created yet.
> (we're the later case that supplier device scu-pd may be created after scu-clk device).

Sounds like your DT is set up backwards?

> The kernel doc Documentation/driver-api/device_link.rst also mentioned this limitation and
> the suggested solution is:
> "The onus is thus on the consumer to check presence of the supplier after adding the link,
> and defer probing on non-presence."
> 
> Then the question is , back again, , how to check the presense of other device driver if we can't
> use device_is_bound() API in module?

Your driver should not care, as you can't get direct access to it, so
don't try to ask the driver core about it as that is racy and not
viable.

If your driver needs resources that it can not get at this point in
time, just return from probe with a defer error.  That way it will be
called again after other drivers load.

> The dev_driver_string() seems be a quick and dirty solution for the this build break issue as
> the driver name is less possible to be changed and under control.

No, driver names are not ever guaranteed to stay the same and are not to
be used for this at all, sorry.

> How would you suggest for current situation?

defer your probe like all other drivers in this situation do it?  What
makes this one driver so much different than the thousands of other ones
we currently have?

thanks,

greg k-h
