Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95C427F2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgI3UCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:02:50 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:53828 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgI3UCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:02:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 47DF34DB7;
        Wed, 30 Sep 2020 20:02:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:6609:9010:9040:10004:10400:10848:11232:11657:11658:11914:12297:12740:12760:12895:13018:13019:13069:13163:13229:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:30034:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: leaf49_111729727195
X-Filterd-Recvd-Size: 2499
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 20:02:48 +0000 (UTC)
Message-ID: <ec0ed7046e170f315a100fbf7c7c2dd9d6f92958.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <minyard@acm.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Sep 2020 13:02:46 -0700
In-Reply-To: <20200930162828.GA1672130@kroah.com>
References: <20200930121007.GA1615300@kroah.com>
         <20200930133656.GY3674@minyard.net> <20200930162828.GA1672130@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 18:28 +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 08:36:56AM -0500, Corey Minyard wrote:
> > On Wed, Sep 30, 2020 at 02:10:07PM +0200, Greg Kroah-Hartman wrote:
> > > There are a number of subdirectories and files in drivers/char/ that
> > > have their own maintainers and developers and ways of getting patches to
> > > Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> > > drivers, and agp drivers.  Instead of sending those patches to Arnd and
> > > myself, who can't do anything with them, send them to the proper
> > > developers instead.
> > > 
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Yes, please do.  No reason for you to get all the noise from these.
> > 
> > Acked-by: Corey Minyard <cminyard@mvista.com>
> 
> Thanks!
> 
> greg k-h

Your exclusion list is:

+X:	drivers/char/agp/
+X:	drivers/char/hw_random/
+X:	drivers/char/ipmi/
+X:	drivers/char/random.c
+X:	drivers/char/tpm/

But the current subdirectories of drivers/char are:

drivers/char/agp
drivers/char/hw_random
drivers/char/ipmi
drivers/char/mwave
drivers/char/pcmcia
drivers/char/tpm
drivers/char/tpm/eventlog
drivers/char/tpm/st33zp24
drivers/char/xilinx_hwicap
drivers/char/xillybus

do you want to specifically maintain any of them?

Wouldn't it be easier to add a single subdirectory exclusion
and add specific inclusions for subdirectories you actually
do want to maintain>


X:	drivers/char/*/
F:	drivers/char/<whatever>




