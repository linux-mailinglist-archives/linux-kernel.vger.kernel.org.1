Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3B2A456E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgKCMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:46:27 -0500
Received: from foss.arm.com ([217.140.110.172]:48334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgKCMq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:46:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81536106F;
        Tue,  3 Nov 2020 04:46:26 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD1583F718;
        Tue,  3 Nov 2020 04:46:24 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:46:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arm64: alternatives: Remove READ_ONCE() usage
 during patch operation
Message-ID: <20201103124622.GC40454@C02TD0UTHF1T.local>
References: <20201103121721.5166-1-will@kernel.org>
 <20201103121721.5166-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103121721.5166-4-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:17:20PM +0000, Will Deacon wrote:
> In preparation for patching the internals of READ_ONCE() itself, replace
> its usage on the alternatives patching patch with a volatile variable
> instead.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/alternative.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 73039949b5ce..a57cffb752e8 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -21,7 +21,8 @@
>  #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
>  #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
>  
> -static int all_alternatives_applied;
> +/* Volatile, as we may be patching the guts of READ_ONCE() */
> +static volatile int all_alternatives_applied;
>  
>  static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
>  
> @@ -205,7 +206,7 @@ static int __apply_alternatives_multi_stop(void *unused)
>  
>  	/* We always have a CPU 0 at this point (__init) */
>  	if (smp_processor_id()) {
> -		while (!READ_ONCE(all_alternatives_applied))
> +		while (!all_alternatives_applied)
>  			cpu_relax();
>  		isb();
>  	} else {
> @@ -217,7 +218,7 @@ static int __apply_alternatives_multi_stop(void *unused)
>  		BUG_ON(all_alternatives_applied);
>  		__apply_alternatives(&region, false, remaining_capabilities);
>  		/* Barriers provided by the cache flushing */
> -		WRITE_ONCE(all_alternatives_applied, 1);
> +		all_alternatives_applied = 1;
>  	}
>  
>  	return 0;
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
