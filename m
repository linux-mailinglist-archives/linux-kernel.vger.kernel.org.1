Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB162B90C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKSLOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgKSLOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:14:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cCH4QrDRb87dwiJfE1X+FleodlPrwqMdYQt5/vtzv2I=; b=zpHguXsNy8N3aF6ECzmq4pB6IV
        eoA3aOyEaivB67/n0lW35/CZmYNEXuKPmcajBDpkTSndWW2dZnoeIN6iDooFrtecNUXrIS41GS+lo
        k0Cglho2Qg2Su4TAnwf21BbrnI820lKCmL0pLAp3e+Qku3ZB2/ckm74gSKa+t94bveacp+5i7mlY8
        e2d3UcECue8gf6Ll9be0MKcA+Ga/JmMD/nGng+ejuVTJeVBhyz4vPkIiX2AWXf97R+wFYLKDM5Nvh
        Y7rpFQvRlSaDEsSHLbz2L898j36ef1VARn3DSIL0JGhLzbfeLkeNL2xMtbaAwNuUxv/GH2CfSCwdg
        eHI/XzKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfhtG-0004wR-5M; Thu, 19 Nov 2020 11:14:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76BFD301E02;
        Thu, 19 Nov 2020 12:14:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 622A1200DA727; Thu, 19 Nov 2020 12:14:11 +0100 (CET)
Date:   Thu, 19 Nov 2020 12:14:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
Message-ID: <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.269943012@linutronix.de>
 <20201119093834.GH3306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119093834.GH3306@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:38:34AM +0000, Mel Gorman wrote:
> On Wed, Nov 18, 2020 at 08:48:42PM +0100, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Now that the scheduler can deal with migrate disable properly, there is no
> > real compelling reason to make it only available for RT.
> > 
> > There are quite some code pathes which needlessly disable preemption in
> > order to prevent migration and some constructs like kmap_atomic() enforce
> > it implicitly.
> > 
> > Making it available independent of RT allows to provide a preemptible
> > variant of kmap_atomic() and makes the code more consistent in general.
> > 
> > FIXME: Rework the comment in preempt.h - Peter?
> > 
> 
> I didn't keep up to date and there is clearly a dependency on patches in
> tip for migrate_enable/migrate_disable . It's not 100% clear to me what
> reworking you're asking for but then again, I'm not Peter!

He's talking about the big one: "Migrate-Disable and why it is
undesired.".

I still hate all of this, and I really fear that with migrate_disable()
available, people will be lazy and usage will increase :/

Case at hand is this series, the only reason we need it here is because
per-cpu page-tables are expensive...

I really do think we want to limit the usage and get rid of the implicit
migrate_disable() in spinlock_t/rwlock_t for example.


AFAICT the scenario described there is entirely possible; and it has to
show up for workloads that rely on multi-cpu bandwidth for correctness.

Switching from preempt_disable() to migrate_disable() hides the
immediate / easily visible high priority latency, but you move the
interference term into a place where it is much harder to detect, you
don't lose the term, it stays in the system.


So no, I don't want to make the comment less scary. Usage is
discouraged.
