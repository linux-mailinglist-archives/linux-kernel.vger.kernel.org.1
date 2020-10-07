Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4D285E60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgJGLnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJGLnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:43:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47602064E;
        Wed,  7 Oct 2020 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602070996;
        bh=m8SUvO9GwZX6+CTyPm+avNZgWgQ0DO1YZGU0aJ4tmuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sazBwxxbmuBpirPv5pKd8t41qbYDFqIQ6MCxAY22Qank9/nrZiWAXJcLKhdv/gPAP
         w/tuQDd71H2jE/0VmCPDf9zru0S3z4wGpV+h6DmzwzUGOmMGKKLVrPzZGV4T2px9a8
         EKikGCUTH5TEK8ggLE/LJEOmv3oli1b7aLJ4udAQ=
Date:   Wed, 7 Oct 2020 13:43:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>
Subject: Re: [PATCH 2/2] w1: w1_therm: Add support for GXCAS GX20MH01 device.
Message-ID: <20201007114359.GA2167293@kroah.com>
References: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
 <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru>
 <20201006151915.77d044a4@coco.lan>
 <1561045277.20201007103227@wirenboard.ru>
 <20201007105702.67988846@coco.lan>
 <20201007090619.GA613204@kroah.com>
 <20201007130549.6ca57af0@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007130549.6ca57af0@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 01:05:49PM +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 7 Oct 2020 11:06:19 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Wed, Oct 07, 2020 at 10:57:02AM +0200, Mauro Carvalho Chehab wrote:
> > > Em Wed, 7 Oct 2020 10:32:27 +0300
> > > Ivan Zaentsev <ivan.zaentsev@wirenboard.ru> escreveu:
> > >   
> > > > Tuesday, October 6, 2020, 4:19:15 PM, Mauro Carvalho Chehab wrote:
> > > >   
> > > > >> diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
> > > > >> index f1148181f53e..00376501a5ef 100644
> > > > >> --- a/Documentation/w1/slaves/w1_therm.rst
> > > > >> +++ b/Documentation/w1/slaves/w1_therm.rst    
> > > >   
> > > > >>  
> > > > >> @@ -130,4 +131,12 @@ conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
> > > > >>  power), the driver returns a conversion error. Bit mask ``2`` enables poll for
> > > > >>  conversion completion (normal power only) by generating read cycles on the bus
> > > > >>  after conversion starts. In parasite power mode this feature is not available.
> > > > >> -Feature bit masks may be combined (OR).
> > > > >> +Feature bit masks may be combined (OR). See accompanying sysfs documentation:
> > > > >> +:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
> > > > >> +    
> > > >   
> > > > > As warned by Sphinx, this cross-reference is broken:    
> > > >   
> > > > >         .../Documentation/w1/slaves/w1_therm.rst:125: WARNING:
> > > > > undefined label: w1_therm (if the link has no caption the label must precede a section header)    
> > > > 
> > > > Would this be ok?  
> > > 
> > > Yeah, sure!
> > >   
> > > > 
> > > > "More details in Documentation/ABI/testing/sysfs-driver-w1_therm"
> > > >   
> > > > > Not sure what you wanted to point here.    
> > > > 
> > > > A link to a driver's sysfs interface, but sysfs docs are text
> > > > files and seem to not be included in Sphynx Docs.  
> > > 
> > > I sent upstream sometime ago a patch series adding ABI to Sphinx, but I 
> > > was not merged, not sure why:
> > > 
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v5.6  
> > 
> > I think the raft of different patches floating around at the time made
> > me totally confused as to what was, and was not, the latest versions.
> 
> Yeah, there were lots of patches floating around that time.
> 
> I also recall that someone (Jeni?) asked if the best wouldn't be to
> just convert the ABI files to ReST directly.
> 
> > I'll be glad to look at them again, if you want to rebase after 5.10-rc1
> > is out and resend them, as I think this should be showing up in the
> > documentation.
> 
> Surely. I'll rebase them after 5.10-rc1 and re-submit. 
> 
> What strategy do you prefer? Keep the files with the same format as
> today (allowing them to optionally have ReST markups) or to convert
> them to .rst directly?
> 
> In the latter case, the best would be to apply it as early as possible
> after 5.10-rc1, as it may cause conflicts with other patches being
> submitted for 5.11.

The existing format if at all possible, doing wholesale changes is a
mess and wouldn't be recommended.

I think you already fixed up the entries that had problems being parsed
in the past, if not, we can resolve those as well.

thanks,

greg k-h
