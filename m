Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A62AB758
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgKILlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgKILlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:41:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A1F206ED;
        Mon,  9 Nov 2020 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604922071;
        bh=DdnMt4dQZoBazp+CcQ4voHqmXOu6LUFvv01/xOPmr+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuFpOwJ3KiWu5V1sgJj/SVUK/BrOrRC1WZYcczQTEWqTTDT/EWgQ5lq73kVcI7Vid
         SMjjpP2945dgFy2GtvCM6LwPij2STkSf3vpKV4myivDKWiPrhJNtYrvjLXL1cEbEt9
         EjeDNTJt9lJMvYdzjdccshE38LrC+uDoAvlfnX0Q=
Date:   Mon, 9 Nov 2020 12:42:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Message-ID: <20201109114211.GD1769924@kroah.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CADVatmNmoBFipoELoyuJ4EUB=KjjO+_9ahm830+04Xi3T77jqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNmoBFipoELoyuJ4EUB=KjjO+_9ahm830+04Xi3T77jqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 11:18:56AM +0000, Sudip Mukherjee wrote:
> Hi Aisheng,
> 
> On Mon, Nov 9, 2020 at 10:57 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
> >
> > Hi Greg,
> >
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Monday, November 9, 2020 6:37 PM
> > > Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix build
> > > failure
> > >
> > > On Mon, Nov 09, 2020 at 10:14:46AM +0000, Sudip Mukherjee wrote:
> > > > Hi Greg,
> > > >
> > > > On Sun, Nov 8, 2020 at 8:23 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip Mukherjee wrote:
> > > > > > When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> > > > > > is unable to find device_is_bound(). The error being:
> > > > > > ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> > > > > >       undefined!
> > > > > >
> > > > > > Export the symbol so that the module finds it.
> > > > > >
> 
> <snip>
> 
> > >
> > > probe() should never call this function as it makes no sense at all at that point in
> > > time.  The driver should be fixed.
> >
> > Would you suggest if any other API we can use to allow the driver to know whether
> > another device has been probed?
> >
> > For imx scu driver in question, it has a special requirement that it depends on scu power domain
> > driver. However, there're a huge number (200+) of power domains for each device clock, we can't define
> > them all in DT for a single clock controller node.
> >
> > That's why we wanted to use device_is_bound() before to check if scu power domain is ready or not to
> > support defer probe.
> 
> iiuc, you are waiting for "fsl,scu-pd" to be registered.
> I think you might be able to use bus_for_each_dev() to check if the
> device has registered with the bus or not. It will be on the bus only
> after bind was successful. The bus will be "platform_bus_type".

No, do not do that, again, no individual driver should ever have to do
that.  Think about what would be involved if _every_ driver started
doing this.

> But I am sure Greg can give you better suggestion than this. :)

device link :)

thanks,

greg k-h
