Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45DC27EFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgI3RDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3RDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:03:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B6C061755;
        Wed, 30 Sep 2020 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MMthncIuRiOfaiEZfDxlAanpq7cwXkc95Eu54otq0Iw=; b=1KmfELOdqa9i5Kk2StW7u12SMi
        Srz+ADPn4f4mwy305WvjdGzCq8zlMCdiX2rK3A4jsdgkQyCBjzYQcXOvwJnUj3IOTcH54d3/eUQvq
        uHjAmTGIDOfWUaCbmyMPtaCGVXHx9f40VTg9K0w1PW5Si2FuvmkUF4q4AJgvnvUcBGDCImLLvkWiF
        oYOwbH2hgYqOLJb6AOS0Xr+8hpi3lB8XUt1uxQAPXiYaNmPjGrucr//h00SfMPBp+Qw1MhwTNw4Ov
        xklsX86qlNMyt1G1R1hcE0DIYXUph0Gnj3KBOHbhIvyAjr+p4ZJsYyfDXl11LoPp2vHMyOtbiwnYF
        9dBMsK0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNfVf-0004BU-Rq; Wed, 30 Sep 2020 17:03:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17B9B301179;
        Wed, 30 Sep 2020 19:03:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02B4A20115B0E; Wed, 30 Sep 2020 19:03:16 +0200 (CEST)
Date:   Wed, 30 Sep 2020 19:03:16 +0200
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
Message-ID: <20200930170316.GB2628@hirez.programming.kicks-ass.net>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com>
 <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
 <20200929083709.GC2651@hirez.programming.kicks-ass.net>
 <87eemji887.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eemji887.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:40:08PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 29 2020 at 10:37, Peter Zijlstra wrote:
> > Here, I fixed it..
> 
> Well, no. What Balbir is trying to do here is to establish whether a
> task runs on a !SMT core. sched_smt_active() is system wide, but their
> setup is to have a bunch of SMT enabled cores and cores where SMT is off
> because the sibling is offlined. They affine these processes to non SMT
> cores and the check there validates that before it enabled that flush
> thingy.

Yes, I see that it does that. But it's still complete shit.

> Of course this is best effort voodoo because if all CPUs in the mask are
> offlined then the task is moved to a SMT enabled one where L1D flush is
> useless. Though offlining their workhorse CPUs is probably not the daily
> business for obvious raisins.

Not only hotplug, you can trivially change the affinity after this
check.

Also, that preempt_disable() in there doesn't actually do anything.
Worse, preempt_disable(); for_each_cpu(); is an anti-pattern. It mixes
static_cpu_has() and boot_cpu_has() in the same bloody condition and has
a pointless ret variable.

It's shoddy code, that only works if you align the planets right. We
really shouldn't provide interfaces that are this bad.

It's correct operation is only by accident.
