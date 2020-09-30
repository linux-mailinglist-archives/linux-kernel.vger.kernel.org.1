Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7963F27F164
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgI3SgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:36:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F7EC061755;
        Wed, 30 Sep 2020 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u8cc2kComrEkpimrNXVdUMg+LW293Fw3FtvuzMDNHPI=; b=RGcasAAliX1Wt4AOQfJtYZto1N
        HBRlXSkKM76ZvUmu7s5c5JIozt6rgUuv/8lzDxAp3ZU84i+Hyx53SdKZk7h0IUPMBx2re9DV14OAa
        COtHRH4n1YdYFP3dza/XPZ641w4BaUNK/DdRq2z09unSl+6r9pLm9NdnAvaS8nNvumWKemCFmiW/m
        /pMyjviyYKaP/yN22/OXo9DG5EWRlnMGAzvUFGhhEaSTwSARINIThpw53jBvPPKJeXWL7SBOt1Rpw
        9Q/TAvzn9mdyNxKn2nLYRGeEKs9+bwetlH2k1bHDIpq4+2QUlfoDjzT6pdu7rDNM22Tpfs4KmGh8A
        oDEa3apA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNgxI-0003Vp-Am; Wed, 30 Sep 2020 18:35:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B5AC301179;
        Wed, 30 Sep 2020 20:35:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DC5920244EC3; Wed, 30 Sep 2020 20:35:52 +0200 (CEST)
Date:   Wed, 30 Sep 2020 20:35:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <sblbir@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars
 in enable_l1d_flush_for_task()
Message-ID: <20200930183552.GG2628@hirez.programming.kicks-ass.net>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com>
 <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
 <20200929083709.GC2651@hirez.programming.kicks-ass.net>
 <87eemji887.fsf@nanos.tec.linutronix.de>
 <20200930170316.GB2628@hirez.programming.kicks-ass.net>
 <87blhni1pg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blhni1pg.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:00:59PM +0200, Thomas Gleixner wrote:
> On Wed, Sep 30 2020 at 19:03, Peter Zijlstra wrote:
> > On Wed, Sep 30, 2020 at 05:40:08PM +0200, Thomas Gleixner wrote:
> > Also, that preempt_disable() in there doesn't actually do anything.
> > Worse, preempt_disable(); for_each_cpu(); is an anti-pattern. It mixes
> > static_cpu_has() and boot_cpu_has() in the same bloody condition and has
> > a pointless ret variable.

Also, I forgot to add, it accesses ->cpus_mask without the proper
locking, so it could be reading intermediate state from whatever cpumask
operation that's in progress.

> I absolutely agree and I really missed it when looking at it before
> merging. cpus_read_lock()/unlock() is the right thing to do if at all.
> 
> > It's shoddy code, that only works if you align the planets right. We
> > really shouldn't provide interfaces that are this bad.
> >
> > It's correct operation is only by accident.
> 
> True :(
> 
> I understand Balbirs problem and it makes some sense to provide a
> solution. We can:
> 
>     1) reject set_affinity() if the task has that flush muck enabled
>        and user space tries to move it to a SMT enabled core
> 
>     2) disable the muck if if detects that it is runs on a SMT enabled
>        core suddenly (hotplug says hello)
> 
>        This one is nasty because there is no feedback to user space
>        about the wreckage.

That's and, right, not or. because 1) deals with sched_setffinity()
and 2) deals wit hotplug.

Now 1) requires an arch hook in sched_setaffinity(), something I'm not
keen on providing, once we provide it, who knows what strange and
wonderful things archs will dream up.

And 2) also happens on hot-un-plug, when the task's affinity gets
forced because it became empty. No user feedback there either, and
information is lost.


I suppose we can do 2) but send a signal. That would cover all cases and
keep it in arch code. But yes, that's pretty terrible too.
