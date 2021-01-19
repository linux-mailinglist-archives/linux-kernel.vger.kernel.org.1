Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B342FC3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbhASWq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731200AbhASOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:34:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FA25206E5;
        Tue, 19 Jan 2021 14:34:16 +0000 (UTC)
Date:   Tue, 19 Jan 2021 14:34:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 4/5] arm64: mte: Enable async tag check fault
Message-ID: <20210119143412.GD17369@gaia>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118183033.41764-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 06:30:32PM +0000, Vincenzo Frascino wrote:
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> @@ -235,6 +273,15 @@ void mte_thread_switch(struct task_struct *next)
>  	/* avoid expensive SCTLR_EL1 accesses if no change */
>  	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
>  		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> +
> +	/*
> +	 * Check if an async tag exception occurred at EL1.
> +	 *
> +	 * Note: On the context switch path we rely on the dsb() present
> +	 * in __switch_to() to guarantee that the indirect writes to TFSR_EL1
> +	 * are synchronized before this point.
> +	 */
> +	mte_check_tfsr_el1();
>  }

We need an isb() before mte_check_tfsr_el1() here as well, we only have
a dsb() in __switch_to(). We do have an isb() in update_sctlr_el1_tcf0()
but only if the check passed. Now, it's worth benchmarking how expensive
update_sctlr_el1_tcf0() is (i.e. an SCTLR_EL1 access + isb with
something like hackbench) and we could probably remove the check
altogether. In the meantime, you can add an isb() on the "else" path of
the above check.

-- 
Catalin
