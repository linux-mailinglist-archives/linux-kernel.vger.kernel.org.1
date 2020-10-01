Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D127FE8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgJALiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbgJALiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:38:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 250AB20B1F;
        Thu,  1 Oct 2020 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601552333;
        bh=NT5Rl7p8mHUmryuih5nEcvIk301LoUAVK1f+RdBcxjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHu0GsqNlf1lU/OXrrBK8DCv/zEYoLpyE/edXJioauVBfvDi7gufsK1y0SvNsoy7f
         WyfvB+WBDKESXDi9Dod6Zslhyi13zR2o613PG7u6usKWbvxGko7fYSvhn5Tvi1rwpV
         i0gVxcqsAbLnBy87vbqS8ozXePjQ15/J/2DksRrQ=
Date:   Thu, 1 Oct 2020 13:38:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
Message-ID: <20201001113854.GA2368232@kroah.com>
References: <20200930121007.GA1615300@kroah.com>
 <20200930133656.GY3674@minyard.net>
 <20200930162828.GA1672130@kroah.com>
 <ec0ed7046e170f315a100fbf7c7c2dd9d6f92958.camel@perches.com>
 <20201001062911.GB27677@kroah.com>
 <8482fdeb2c8e8748914047b8b99be760f00e2d68.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8482fdeb2c8e8748914047b8b99be760f00e2d68.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:41:10PM -0700, Joe Perches wrote:
> On Thu, 2020-10-01 at 08:29 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 30, 2020 at 01:02:46PM -0700, Joe Perches wrote:
> > > On Wed, 2020-09-30 at 18:28 +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 30, 2020 at 08:36:56AM -0500, Corey Minyard wrote:
> > > > > On Wed, Sep 30, 2020 at 02:10:07PM +0200, Greg Kroah-Hartman wrote:
> > > > > > There are a number of subdirectories and files in drivers/char/ that
> > > > > > have their own maintainers and developers and ways of getting patches to
> > > > > > Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> > > > > > drivers, and agp drivers.  Instead of sending those patches to Arnd and
> > > > > > myself, who can't do anything with them, send them to the proper
> > > > > > developers instead.
> []
> > > Your exclusion list is:
> > > 
> > > +X:	drivers/char/agp/
> > > +X:	drivers/char/hw_random/
> > > +X:	drivers/char/ipmi/
> > > +X:	drivers/char/random.c
> > > +X:	drivers/char/tpm/
> > > 
> > > But the current subdirectories of drivers/char are:
> > > 
> > > drivers/char/agp
> > > drivers/char/hw_random
> > > drivers/char/ipmi
> > > drivers/char/mwave
> > > drivers/char/pcmcia
> > > drivers/char/tpm
> > > drivers/char/tpm/eventlog
> > > drivers/char/tpm/st33zp24
> > > drivers/char/xilinx_hwicap
> > > drivers/char/xillybus
> > > 
> > > do you want to specifically maintain any of them?
> > 
> > Yes, the other ones we do maintain.
> > 
> > > Wouldn't it be easier to add a single subdirectory exclusion
> > > and add specific inclusions for subdirectories you actually
> > > do want to maintain>
> > > 
> > > 
> > > X:	drivers/char/*/
> > > F:	drivers/char/<whatever>
> > 
> > If we do that, it will be one extra line in the MAINTAINERS file, as we
> > are dealing with 4 we want, and 4 we don't :)
> > 
> > I like being explicit as to what we do NOT want to review, it's easier
> > to see when glancing at the file.
> 
> No worries, it just wasn't obvious that all the other
> directories were ones you actually want to maintain.

Someone has to :)

> btw: xillybus nominally has its own maintainer too.
> 
> XILLYBUS DRIVER
> M:	Eli Billauer <eli.billauer@gmail.com>
> L:	linux-kernel@vger.kernel.org
> S:	Supported
> F:	drivers/char/xillybus/

I end up usually taking the patches from here so leaving it as part of
the "umbrella" for char/misc patches is fine.

thanks,

greg k-h
