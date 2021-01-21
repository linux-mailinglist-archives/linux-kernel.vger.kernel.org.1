Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D62FE91B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbhAULoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:44:03 -0500
Received: from foss.arm.com ([217.140.110.172]:33120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730606AbhAULnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:43:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CBBD11B3;
        Thu, 21 Jan 2021 03:42:36 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.35.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 889553F719;
        Thu, 21 Jan 2021 03:42:35 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:42:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 19/29] csky: mm: abort uaccess retries upon fatal signal
Message-ID: <20210121114233.GC48431@C02TD0UTHF1T.local>
References: <20210121065349.3188251-1-guoren@kernel.org>
 <20210121065349.3188251-19-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121065349.3188251-19-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:53:39PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Pick up the patch from the 'Link' made by Mark Rutland. Keep the
> same with x86, arm, arm64, arc, sh, power.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/1499782763-31418-1-git-send-email-mark.rutland@arm.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/csky/mm/fault.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index c7b67976bac4..1482de56f4f7 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -279,8 +279,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	 * signal first. We do not need to release the mmap_lock because it
>  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
>  	 */
> -	if (fault_signal_pending(fault, regs))
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			no_context(regs, addr);
>  		return;
> +	}

FWIW, this looks right to me -- I assumed you've tested with the
test-case in the linked email?

It looks like a number of other architectures are still broken here. :/

I'll go and poke them...

Thanks,
Mark.
  
>  	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
>  		flags |= FAULT_FLAG_TRIED;
> -- 
> 2.17.1
> 
