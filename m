Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85816243C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHMPHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 11:07:35 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:33688 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726727AbgHMPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:07:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 34F25180A9F42;
        Thu, 13 Aug 2020 15:07:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:10004:10400:10967:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12697:12737:12740:12760:12895:12986:13095:13181:13229:13255:13439:13870:14181:14659:14721:21080:21365:21433:21451:21627:21990:30029:30034:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: chin73_140509f26ff5
X-Filterd-Recvd-Size: 3240
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Aug 2020 15:07:19 +0000 (UTC)
Message-ID: <6c0b063837a3a549389275c44e9512a1ffc36717.camel@perches.com>
Subject: Re: [PATCH 35/44] staging: regulator: hi6421v600-regulator: add a
 driver-specific debug macro
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Thu, 13 Aug 2020 08:07:17 -0700
In-Reply-To: <20200813121036.126c4797@coco.lan>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <7cb10b3910e9fa3e52d36e4e416030175cc761ab.1597247164.git.mchehab+huawei@kernel.org>
         <6a424468eb61e2eb9b014817819dd4da61f2ada1.camel@perches.com>
         <20200813121036.126c4797@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-13 at 12:10 +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 12 Aug 2020 09:10:29 -0700
> Joe Perches <joe@perches.com> escreveu:
> 
> > On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> > > Using dev_dbg() is not too nice, as, instead of printing the
> > > name of the regulator, it prints "regulator.<number>", making
> > > harder to associate what is happening with each ldo line.
> > > 
> > > So, add a debug-specific macro, which will print the rdev's
> > > name, just like the regulator core.  
> > 
> > Seems sensible, but trivially:
> > 
> > > diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c  
> > []
> > > @@ -209,10 +212,10 @@ static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev
> > >  	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
> > >  
> > >  	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA)) {
> > > -		dev_dbg(&rdev->dev, "%s: normal mode", __func__);
> > > +		rdev_dbg(rdev, "normal mode");
> > >  		return REGULATOR_MODE_NORMAL;
> > >  	} else {
> > > -		dev_dbg(&rdev->dev, "%s: idle mode", __func__);
> > > +		rdev_dbg(rdev, "idle mode");  
> > 
> > missing terminating newlines
> 
> As per request from Jonathan, I ended dropping those rdev_dbg()
> on a followup patch.
> 
> Btw, after this changeset:
> 
> 	commit 563873318d328d9bbab4b00dfd835ac7c7e28697
> 	Merge: 24532f768121 bfd8d3f23b51
> 	Author: Linus Torvalds <torvalds@linux-foundation.org>
> 	Date:   Mon Oct 10 09:29:50 2016 -0700
> 
> 	    Merge branch 'printk-cleanups'
>     
> 	    Merge my system logging cleanups, triggered by the broken '\n' patches.
> 
> the printk lib will add a line feed if a "\n" is missing. I had
> to get rid of pr_cont() & friends on that time on media, due to that. 

I know.

Message formats should still end in a newline.

Any other subsystem could use a pr_cont and that
could be added to any line without a terminating
newline.

Also any line without a newline will not be emitted
until another message is emitted.


