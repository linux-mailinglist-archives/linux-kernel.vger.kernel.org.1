Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B430027F996
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgJAGlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:41:14 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:45370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgJAGlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:41:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DABB918037BD1;
        Thu,  1 Oct 2020 06:41:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2110:2393:2540:2553:2559:2562:2693:2828:2911:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4425:5007:6119:7514:8531:9010:10004:10400:10848:11232:11657:11658:11914:12297:12679:12740:12760:12895:13255:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:30034:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: night67_22105e927199
X-Filterd-Recvd-Size: 3190
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 06:41:11 +0000 (UTC)
Message-ID: <8482fdeb2c8e8748914047b8b99be760f00e2d68.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Sep 2020 23:41:10 -0700
In-Reply-To: <20201001062911.GB27677@kroah.com>
References: <20200930121007.GA1615300@kroah.com>
         <20200930133656.GY3674@minyard.net> <20200930162828.GA1672130@kroah.com>
         <ec0ed7046e170f315a100fbf7c7c2dd9d6f92958.camel@perches.com>
         <20201001062911.GB27677@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-01 at 08:29 +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 01:02:46PM -0700, Joe Perches wrote:
> > On Wed, 2020-09-30 at 18:28 +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 30, 2020 at 08:36:56AM -0500, Corey Minyard wrote:
> > > > On Wed, Sep 30, 2020 at 02:10:07PM +0200, Greg Kroah-Hartman wrote:
> > > > > There are a number of subdirectories and files in drivers/char/ that
> > > > > have their own maintainers and developers and ways of getting patches to
> > > > > Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> > > > > drivers, and agp drivers.  Instead of sending those patches to Arnd and
> > > > > myself, who can't do anything with them, send them to the proper
> > > > > developers instead.
[]
> > Your exclusion list is:
> > 
> > +X:	drivers/char/agp/
> > +X:	drivers/char/hw_random/
> > +X:	drivers/char/ipmi/
> > +X:	drivers/char/random.c
> > +X:	drivers/char/tpm/
> > 
> > But the current subdirectories of drivers/char are:
> > 
> > drivers/char/agp
> > drivers/char/hw_random
> > drivers/char/ipmi
> > drivers/char/mwave
> > drivers/char/pcmcia
> > drivers/char/tpm
> > drivers/char/tpm/eventlog
> > drivers/char/tpm/st33zp24
> > drivers/char/xilinx_hwicap
> > drivers/char/xillybus
> > 
> > do you want to specifically maintain any of them?
> 
> Yes, the other ones we do maintain.
> 
> > Wouldn't it be easier to add a single subdirectory exclusion
> > and add specific inclusions for subdirectories you actually
> > do want to maintain>
> > 
> > 
> > X:	drivers/char/*/
> > F:	drivers/char/<whatever>
> 
> If we do that, it will be one extra line in the MAINTAINERS file, as we
> are dealing with 4 we want, and 4 we don't :)
> 
> I like being explicit as to what we do NOT want to review, it's easier
> to see when glancing at the file.

No worries, it just wasn't obvious that all the other
directories were ones you actually want to maintain.

btw: xillybus nominally has its own maintainer too.

XILLYBUS DRIVER
M:	Eli Billauer <eli.billauer@gmail.com>
L:	linux-kernel@vger.kernel.org
S:	Supported
F:	drivers/char/xillybus/

cheers, Joe

