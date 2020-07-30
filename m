Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3749D2331FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgG3M12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgG3M11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:27:27 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDE42074B;
        Thu, 30 Jul 2020 12:27:25 +0000 (UTC)
Date:   Thu, 30 Jul 2020 13:27:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        james.morse@arm.com, peterx@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] arm64: mm: add message to die() in die_kernel_fault()
Message-ID: <20200730122723.GN25149@gaia>
References: <20200730114757.13592-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730114757.13592-1-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 07:47:57PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Just to identify the kernel fault more clearly.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  arch/arm64/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 8afb238..3a753c7 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -289,7 +289,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  	mem_abort_decode(esr);
>  
>  	show_pte(addr);
> -	die("Oops", regs, esr);
> +	die("Oops - Page fault", regs, esr);
>  	bust_spinlocks(0);
>  	do_exit(SIGKILL);
>  }

Don't we already print enough information prior to die()?

-- 
Catalin
