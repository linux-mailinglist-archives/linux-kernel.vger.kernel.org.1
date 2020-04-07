Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595DC1A128A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDGRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 13:20:42 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:34162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDGRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:20:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 62F4D18033F62;
        Tue,  7 Apr 2020 17:20:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2828:2899:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:7514:7903:9010:10004:10400:10848:11232:11658:11914:12043:12296:12297:12660:12663:12740:12760:12895:13069:13072:13311:13357:13439:13891:14096:14097:14181:14659:14721:14777:21080:21433:21451:21611:21627:21660:21819:30003:30022:30026:30054:30079:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: army88_5e3ac7fd8b42
X-Filterd-Recvd-Size: 2612
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 17:20:40 +0000 (UTC)
Message-ID: <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
From:   Joe Perches <joe@perches.com>
To:     Jeff King <peff@peff.net>, Olaf Hering <olaf@aepfle.de>
Cc:     linux-kernel@vger.kernel.org, git@vger.kernel.org
Date:   Tue, 07 Apr 2020 10:18:41 -0700
In-Reply-To: <20200407170257.GA1844923@coredump.intra.peff.net>
References: <20200407154046.GA15368@aepfle.de>
         <20200407170257.GA1844923@coredump.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 13:02 -0400, Jeff King wrote:
> On Tue, Apr 07, 2020 at 05:40:46PM +0200, Olaf Hering wrote:
> 
> > For me sending patches via git send-email fails because email address
> > conversion is failing. Something appends a ')' to x86/lkml@kernel.org.
> > I suspect the double '))' in MAINTAINERS is confusing the command.
> > I tried to send the trivial patch from v5.0 and v5.6 tag.
> > 
> > Is this a failure in ./scripts/get_maintainer.pl,
> > or is this something git does internally?
> > I'm sure others use such command on a daily basis, so likely something on
> > my end became broken at some point in the past.
> 
> It's a bug in send-email's hand-rolled address parser, which was fixed
> in bd869f67b9 (send-email: add and use a local copy of Mail::Address,
> 2018-01-05). Upgrade to Git v2.17.0 or newer.

Not really.
You need to add --norolestats on the get_maintainer command line

git send-email expects bare email addresses, not ones annotated
with additional content.


For instance:

$ ./scripts/get_maintainer.pl -f lib/vsprintf.c
Petr Mladek <pmladek@suse.com> (maintainer:VSPRINTF)
Steven Rostedt <rostedt@goodmis.org> (maintainer:VSPRINTF)
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> (maintainer:VSPRINTF)
Andy Shevchenko <andriy.shevchenko@linux.intel.com> (reviewer:VSPRINTF)
Rasmus Villemoes <linux@rasmusvillemoes.dk> (reviewer:VSPRINTF)
linux-kernel@vger.kernel.org (open list)

vs:

$ ./scripts/get_maintainer.pl -f --norolestats lib/vsprintf.c
Petr Mladek <pmladek@suse.com>
Steven Rostedt <rostedt@goodmis.org>
Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Rasmus Villemoes <linux@rasmusvillemoes.dk>
linux-kernel@vger.kernel.org


