Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0266122074D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgGOIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 04:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgGOIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:31:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBF620657;
        Wed, 15 Jul 2020 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594801908;
        bh=yiJirQWg9zviSkJbXACuIur4MPrAwCoUUHNi4tNnYFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDgFNGtzY6hhT0au1lwQAZoZYeOutZO1dNWi+TzklJXkHm0K8yoe8CgBFrF6bZjrt
         x4icQi7Qn1aOHEg5jsxqTU0ws/FI8X7zj/XgTzdFzIGkhpp4tixfQ0opMzxHQVz4kt
         kzzAIXM/piLhm7hOZS1O6DVm3C8g4z6KyBpGxvTQ=
Date:   Wed, 15 Jul 2020 10:31:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: comedi_fops.c: changed type in
 assignment to unsigned int *
Message-ID: <20200715083144.GA2716443@kroah.com>
References: <20200715044813.fww3regsgsbgyp7b@pesu-pes-edu>
 <20200715070842.GA2303720@kroah.com>
 <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhDqq3u_0wCRGDaWRGgtC6bkx6t+AubAXfnX_f7V0t10BRuuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:56:45PM +0530, B K Karthik wrote:
> On Wed, Jul 15, 2020, 12:38 PM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Jul 15, 2020 at 12:48:13AM -0400, B K Karthik wrote:
> > > fixed a sparse warning by changing the type in
> > > assignment from void [noderef] __user * to unsigned int *
> > > (different address space)
> > >
> > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > ---
> > >  drivers/staging/comedi/comedi_fops.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/comedi/comedi_fops.c
> > b/drivers/staging/comedi/comedi_fops.c
> > > index 3f70e5dfac39..4cc012e231b7 100644
> > > --- a/drivers/staging/comedi/comedi_fops.c
> > > +++ b/drivers/staging/comedi/comedi_fops.c
> > > @@ -2956,7 +2956,7 @@ static int get_compat_cmd(struct comedi_cmd *cmd,
> > >       cmd->scan_end_arg = v32.scan_end_arg;
> > >       cmd->stop_src = v32.stop_src;
> > >       cmd->stop_arg = v32.stop_arg;
> > > -     cmd->chanlist = compat_ptr(v32.chanlist);
> > > +     cmd->chanlist = (unsigned int *) compat_ptr(v32.chanlist);
> > >       cmd->chanlist_len = v32.chanlist_len;
> > >       cmd->data = compat_ptr(v32.data);
> > >       cmd->data_len = v32.data_len;
> >
> > Always run your patches through checkpatch before sending them, so you
> > do not have a grumpy maintainer telling you that you have to run
> > checkpatch on your patch before sending them.
> >
> 
> I will. Sorry for that.
> 
> But the error that's being shown in this patch is something that comes up
> on its own.

No it is not.

> git format-patch leaves trailing whitespace in blank lines.

It does?  Where is any trailing whitespace here?  That's not the issue.

> It has been reported to the maintainers.

It was?  Where?

thanks,

greg k-h
