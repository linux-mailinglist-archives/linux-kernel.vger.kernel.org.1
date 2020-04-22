Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485441B47C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgDVOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 10:54:52 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:57008 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgDVOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:54:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 31594181D3025;
        Wed, 22 Apr 2020 14:54:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2691:2828:2903:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13184:13229:13311:13357:13439:14096:14097:14659:14721:21080:21433:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: beast64_2a3913899b22e
X-Filterd-Recvd-Size: 2052
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Apr 2020 14:54:50 +0000 (UTC)
Message-ID: <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
Subject: Re: [PATCH v4 4/7] kernel.h: Split out min()/max() et al helpers
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Apr 2020 07:52:32 -0700
In-Reply-To: <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
         <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 15:51 +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out min()/max()
> et al helpers.

While adding organization into kernel.h by splitting
out various bits into separate files is a fine idea,
I believe removing the generic #include <linux/kernel.h>
from various files and substituting the sub-includes
is not a good idea.

> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

Yeah, that's the difficult bit and it could make
using precompiled headers very cumbersome.

I'd rather make #include <linux/kernel.h>" _more_
common or even used as the mandatory first #include
for all kernel .c files.

That would also ensure that common kernel facilities
are not duplicated or have naming conflicts with other
files.


