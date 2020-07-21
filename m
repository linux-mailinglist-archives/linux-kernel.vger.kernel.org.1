Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB7227742
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 05:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgGUDx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 23:53:57 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:46894 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgGUDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:53:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BB25F18014A0A;
        Tue, 21 Jul 2020 03:53:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:6691:7514:7875:10004:10400:10848:11232:11658:11914:12043:12296:12297:12663:12679:12740:12760:12895:13069:13095:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:30012:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: clock38_5a1340526f2a
X-Filterd-Recvd-Size: 2274
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Jul 2020 03:53:53 +0000 (UTC)
Message-ID: <b44b9b7c0f0d5ace01e56d2bac0251573ea7df17.camel@perches.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Jul 2020 20:53:52 -0700
In-Reply-To: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <20200717234818.8622-3-john.ogness@linutronix.de>
         <20200719143527.GA566@jagdpanzerIV.localdomain>
         <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
         <20200720015057.GA463@jagdpanzerIV.localdomain>
         <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-20 at 11:30 -0700, Linus Torvalds wrote:
> On Sun, Jul 19, 2020 at 6:51 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > Do I get it right, what you are saying is - when we process a PR_CONT
> > message the cont buffer should already contain previous non-LOG_NEWLINE
> > and non-PR_CONT message, otherwise it's a bug?
> 
> No.
> 
> I'm saying that the code that does PR_CONT should have done *some*
> printing before, otherwise it's at the very least questionable.
> 
> IOW, you can't just randomly start printing with PR_CONT, without
> having established _some_ context for it.

I believe there are at least a few cases that
_only_ use pr_cont to emit
complete lines.

For example: SEQ_printf in kernel/sched/debug.c


