Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C5245034
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 01:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHNXw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 19:52:29 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:59826 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgHNXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 19:52:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DB3FC18027C9B;
        Fri, 14 Aug 2020 23:52:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2898:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:6119:6691:7514:7903:8985:9025:9389:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13095:13255:13439:14093:14096:14097:14181:14659:14721:19904:19999:21080:21324:21433:21451:21627:21740:21811:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bike41_3c12a7d27000
X-Filterd-Recvd-Size: 3702
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Aug 2020 23:52:25 +0000 (UTC)
Message-ID: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 16:52:24 -0700
In-Reply-To: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
         <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
         <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
         <20200813051853.GA510@jagdpanzerIV.localdomain>
         <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
         <20200813115435.GB483@jagdpanzerIV.localdomain>
         <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > I think what Linus said a long time ago was that the initial purpose of
> > pr_cont was
> > 
> >         pr_info("Initialize feature foo...");
> >         if (init_feature_foo() == 0)
> >                 pr_cont("ok\n");
> >         else
> >                 pr_cont("not ok\n");
> > 
> >         And if init_feature_foo() crashes the kernel then the first printk()
> >         form panic() will flush the cont buffer.
> 
> Right.
> 
> This is why I think any discussion that says "people should buffer
> their lines themselves and we should get rid if pr_cont()" is
> fundamentally broken.
> 
> Don't go down that hole. I won't take it. It's wrong.

I don't think it's wrong per se.

It's reasonable to avoid pr_cont when appropriate.

Trivial buffering, or adding and using YA vsprintf 
extension can avoid unnecessary message interleaving.

For instance, I just sent this patch to allow removal
of print_vma_addr and its use of pr_cont.

https://lore.kernel.org/lkml/09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com/

This is similar to the dump_flags_names removal back
in commit edf14cdbf9a0 ("mm, printk: introduce new format
string for flags")

> The fact is, pr_cont() goes back to the original kernel. No, it wasn't
> pr_cont() back then, and no, there were no actual explicit markers for
> "this is a continuation" at all, it was all just "the last printk
> didn't have a newline, so we continue where we left off".
> 
> We've added pr_cont (and KERN_CONT) since then, and I realize that a
> lot of people hate the complexity it introduces, but it's a
> fundamental complexity that you have to live with.
> 
> If you can't live with pr_cont(), you shouldn't be working on
> printk(), and find some other area of the kernel that you _can_ live
> with.
> 
> It really is that simple.
> 

