Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7591429DF75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbgJ2BB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731192AbgJ1WR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from localhost (i15-lef02-th2-89-83-213-3.ft.lns.abo.bbox.fr [89.83.213.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DBE2416E;
        Wed, 28 Oct 2020 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603892063;
        bh=DberZiErRVOoIhqno/qoc+dXE44GikMCW9mm2pyaM0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdJOXD2GirTHcSEv+h2FezILG4lelgQcsvMT01NY7rMhI4eBAPJufKv43GiXfe2sL
         YmqfoyOx8V2kggfcfGwugJyjFd2EmKXHgQwgWIwxC+ONrq8OXwiMePOfX2+3n0sWqF
         vsYpSBkjsJYUu5RTMRbnS7EGb+/EDu93mYxRNiMY=
Date:   Wed, 28 Oct 2020 14:34:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 4/6] irq_work: Unconditionally build on SMP
Message-ID: <20201028133420.GD229044@lothringen>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.464733855@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111221.464733855@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:07:11PM +0100, Peter Zijlstra wrote:

This may need a changelog :-)

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/Makefile   |    1 +
>  kernel/irq_work.c |    3 +++
>  2 files changed, 4 insertions(+)
> 
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_TRACE_CLOCK) += trace/
>  obj-$(CONFIG_RING_BUFFER) += trace/
>  obj-$(CONFIG_TRACEPOINTS) += trace/
>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
> +obj-$(CONFIG_SMP) += irq_work.o
>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>  obj-$(CONFIG_BPF) += bpf/
>  obj-$(CONFIG_KCSAN) += kcsan/
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -20,6 +20,7 @@
>  #include <linux/smp.h>
>  #include <asm/processor.h>
>  
> +#ifdef CONFIG_IRQ_WORK
>  
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> @@ -212,3 +213,5 @@ void irq_work_sync(struct irq_work *work
>  		cpu_relax();
>  }
>  EXPORT_SYMBOL_GPL(irq_work_sync);
> +
> +#endif /* CONFIG_IRQ_WORK */
> 
> 
