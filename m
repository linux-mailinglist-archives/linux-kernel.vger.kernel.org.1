Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6782452DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHOVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:55:55 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:38898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729064AbgHOVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:55:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id EBF8C1801BE39
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:08:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BAB625853;
        Sat, 15 Aug 2020 03:08:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:7875:7903:9389:10004:10400:10450:10455:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:19904:19999:21080:21433:21627:21795:30051:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: linen97_5911ea827002
X-Filterd-Recvd-Size: 2879
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 03:08:03 +0000 (UTC)
Message-ID: <ccc21619fdee79985f619adeb49bd5713dc97d80.camel@perches.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 20:08:02 -0700
In-Reply-To: <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
         <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
         <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
         <20200813051853.GA510@jagdpanzerIV.localdomain>
         <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
         <20200813115435.GB483@jagdpanzerIV.localdomain>
         <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
         <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
         <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 19:33 -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 4:52 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> > > This is why I think any discussion that says "people should buffer
> > > their lines themselves and we should get rid if pr_cont()" is
> > > fundamentally broken.
> > > 
> > > Don't go down that hole. I won't take it. It's wrong.
> > 
> > I don't think it's wrong per se.
> 
> It's *absolutely* and 100% wrong.
> 
> Yes, any random *user* of pr_cont() can decide to buffer on it's own.

Which I believe is the point of the discussion,
not the complete removal of KERN_CONT.

> But when the discussion is about printk() - the implementation, not
> the users - then it's complete and utter BS to talk about trying to
> get rid of pr_cont().
> 
> See the difference?

Sure, but I fail to see where anyone said get rid of pr_cont
in this thread.  It seems all that was discussed was just
various schemes to improve coalescing output.


