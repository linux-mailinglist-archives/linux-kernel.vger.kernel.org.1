Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3341E2A7C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgKEKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:52:49 -0500
Received: from foss.arm.com ([217.140.110.172]:57294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbgKEKwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:52:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BAE142F;
        Thu,  5 Nov 2020 02:52:46 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 848743F66E;
        Thu,  5 Nov 2020 02:52:44 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:52:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kfence: Use pt_regs to generate stack trace on faults
Message-ID: <20201105105241.GC82102@C02TD0UTHF1T.local>
References: <20201105092133.2075331-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105092133.2075331-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:21:33AM +0100, Marco Elver wrote:
> Instead of removing the fault handling portion of the stack trace based
> on the fault handler's name, just use struct pt_regs directly.
> 
> Change kfence_handle_page_fault() to take a struct pt_regs, and plumb it
> through to kfence_report_error() for out-of-bounds, use-after-free, or
> invalid access errors, where pt_regs is used to generate the stack
> trace.
> 
> If the kernel is a DEBUG_KERNEL, also show registers for more
> information.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marco Elver <elver@google.com>

Wow; I wasn't expecting this to be put together so quickly, thanks for
doing this!

From a scan, this looks good to me -- just one question below.

> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index ed2d48acdafe..98a97f9d43cd 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -171,6 +171,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
>  /**
>   * kfence_handle_page_fault() - perform page fault handling for KFENCE pages
>   * @addr: faulting address
> + * @regs: current struct pt_regs (can be NULL, but shows full stack trace)
>   *
>   * Return:
>   * * false - address outside KFENCE pool,

> @@ -44,8 +44,12 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
>  		case KFENCE_ERROR_UAF:
>  		case KFENCE_ERROR_OOB:
>  		case KFENCE_ERROR_INVALID:
> -			is_access_fault = true;
> -			break;
> +			/*
> +			 * kfence_handle_page_fault() may be called with pt_regs
> +			 * set to NULL; in that case we'll simply show the full
> +			 * stack trace.
> +			 */
> +			return 0;

For both the above comments, when/where is kfence_handle_page_fault()
called with regs set to NULL? I couldn't spot that in this patch, so
unless I mised it I'm guessing that's somewhere outside of the patch
context?

If this is a case we don't expect to happen, maybe add a WARN_ON_ONCE()?

Thanks,
Mark.
