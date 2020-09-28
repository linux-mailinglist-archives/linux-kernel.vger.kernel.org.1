Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171EB27A910
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgI1Hwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:52:51 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:46706 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbgI1Hwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:52:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 6F562800BE82
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:52:49 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5652A181D3030;
        Mon, 28 Sep 2020 07:52:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3770:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:7903:8527:9025:9121:10004:10400:11026:11232:11233:11257:11473:11658:11914:12043:12114:12262:12296:12297:12438:12555:12679:12740:12760:12895:12986:13439:14096:14097:14106:14181:14659:14721:14849:21080:21365:21433:21451:21627:21889:21939:30029:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: floor73_2d0ce722717f
X-Filterd-Recvd-Size: 3557
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Sep 2020 07:52:46 +0000 (UTC)
Message-ID: <0e8e87e25c90339fe790252626855cbb47bc2c08.camel@perches.com>
Subject: Re: [PATCH 2/2] sched: mark PRINTK_DEFERRED_CONTEXT_MASK in
 __schedule()
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com
Date:   Mon, 28 Sep 2020 00:52:44 -0700
In-Reply-To: <20200928073202.GA2611@hirez.programming.kicks-ass.net>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
         <20200927161130.33172-2-zhouchengming@bytedance.com>
         <20200928073202.GA2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-28 at 09:32 +0200, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 12:11:30AM +0800, Chengming Zhou wrote:
> > The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
> > deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
> > deadlock on rq lock in the printk path.
[]
> NAK printk_deferred is an abomination, kill that.

Didn't you introduce it?
Should you be complaining to yourself?

---

commit 3ccf3e8306156a28213adc720aba807e9a901ad5
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Mon Feb 27 10:47:00 2012 +0100

    printk/sched: Introduce special printk_sched() for those awkward moments
    
    There's a few awkward printk()s inside of scheduler guts that people
    prefer to keep but really are rather deadlock prone. Fudge around it
    by storing the text in a per-cpu buffer and poll it using the existing
    printk_tick() handler.
    
    This will drop output when its more frequent than once a tick, however
    only the affinity thing could possible go that fast and for that just
    one should suffice to notify the admin he's done something silly..
    
    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Link: http://lkml.kernel.org/n/tip-wua3lmkt3dg8nfts66o6brne@git.kernel.org
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

commit aac74dc495456412c4130a1167ce4beb6c1f0b38
Author: John Stultz <john.stultz@linaro.org>
Date:   Wed Jun 4 16:11:40 2014 -0700

    printk: rename printk_sched to printk_deferred
    
    After learning we'll need some sort of deferred printk functionality in
    the timekeeping core, Peter suggested we rename the printk_sched function
    so it can be reused by needed subsystems.
    
    This only changes the function name. No logic changes.
    
    Signed-off-by: John Stultz <john.stultz@linaro.org>
    Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
    Cc: Jan Kara <jack@suse.cz>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Jiri Bohac <jbohac@suse.cz>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar <mingo@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


