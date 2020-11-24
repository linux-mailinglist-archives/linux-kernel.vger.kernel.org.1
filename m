Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AFC2C1F60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgKXIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgKXIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:04:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0077CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J+sC5nVA+jJp0DHC6JUPfNSylCuApF1MQxVFZNf6fgA=; b=tYI2jGIJC1XEfzxq7s+3I5Itgw
        MBUyyGGzn769CRIBgHO1Z29XlmmP34W+9hdXmefzGKtauqOFm7HLI8knm2cu5fZ5O5K5tqEK39VVc
        O4QxH2ylRauzyoo6dxQovCVMLZonoWbsQiPBGY0hE/dkfNh4LxTwy8AJ5ZcOboVJTJsMsdRbW8bo8
        CQysXpRqHjx4+fz3bJL/JUCgqbDjCApFRpKPc/oUcSOtVgSg6u4r4COT9L920Zq9IlMvVG4Htr5zW
        2CpO8P3wpPhYVBuCqpjgau1+XyXnundzyktqvjhYD6uzKBzeF3gRGlk4yw5lWDYWoFDdRGDqAu/Zz
        jwycGgJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khTIx-0002Fq-Ec; Tue, 24 Nov 2020 08:04:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8F2D304D28;
        Tue, 24 Nov 2020 09:03:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3C0C2C603632; Tue, 24 Nov 2020 09:03:59 +0100 (CET)
Date:   Tue, 24 Nov 2020 09:03:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 0/8] mm/highmem: Preemptible variant of kmap_atomic &
 friends
Message-ID: <20201124080359.GD2414@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118194838.753436396@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:48:38PM +0100, Thomas Gleixner wrote:
>  Documentation/driver-api/io-mapping.rst |   74 +++++++++++--------
>  arch/x86/Kconfig                        |    1 
>  arch/x86/include/asm/fixmap.h           |   12 ++-
>  arch/x86/include/asm/pgtable_64_types.h |    6 +
>  arch/x86/kernel/crash_dump_32.c         |   48 ++----------
>  include/asm-generic/kmap_size.h         |    2 
>  include/linux/highmem-internal.h        |   58 +++++++++++++++
>  include/linux/highmem.h                 |   43 +++++++----
>  include/linux/io-mapping.h              |   30 +++++++
>  include/linux/kernel.h                  |   21 +++--
>  include/linux/preempt.h                 |   38 ----------
>  include/linux/sched.h                   |   11 ++
>  kernel/entry/common.c                   |    2 
>  kernel/fork.c                           |    1 
>  kernel/sched/core.c                     |   63 ++++++++++++++--
>  kernel/sched/sched.h                    |    4 -
>  lib/Kconfig.debug                       |   22 +++++
>  lib/smp_processor_id.c                  |    2 
>  mm/highmem.c                            |  121 ++++++++++++++++++++++++++++----
>  19 files changed, 400 insertions(+), 159 deletions(-)

Grudgingly-Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
