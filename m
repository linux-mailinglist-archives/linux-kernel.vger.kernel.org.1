Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8590621EB82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 10:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGNIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 04:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNIhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:37:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D61721835;
        Tue, 14 Jul 2020 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594715840;
        bh=sLsBHSZ4aocpjCsj6C5mM/qWcmp+IZ+iy3ml2lFuntM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DjAS5tgWevHzeuVCGsNREXLLFNJ0RV0cTtO4jdnVvJvYX0Xw+KU+eXymaiSB9W3Y
         mjeHQWmIz02zwPsoIYllvxUD3PRe8e7aRvFBylF1M45cCcK0ez4UTNlv3StOLyEw8A
         VjMCl5t1RoJKajxuRWH0yT/rxT7YlCpkdep5Y17Q=
Date:   Tue, 14 Jul 2020 09:37:15 +0100
From:   Will Deacon <will@kernel.org>
To:     guoren@kernel.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] arm64: Make TSK_STACK_CANARY more accurate defined
Message-ID: <20200714083715.GE4516@willie-the-truck>
References: <1594613013-13059-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594613013-13059-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:03:33AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> TSK_STACK_CANARY only used in arm64/Makefile with
> CONFIG_STACKPROTECTOR_PER_TASK wrap. So use the same policy in
> asm-offset.c.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/asm-offsets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 0577e21..37d5d3d 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -39,7 +39,7 @@ int main(void)
>    DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
>  #endif
>    DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
> -#ifdef CONFIG_STACKPROTECTOR
> +#ifdef CONFIG_STACKPROTECTOR_PER_TASK
>    DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
>  #endif

I don't think this really makese much sense. The 'stack_canary' field in
'struct task_struct' is defined as:

#ifdef CONFIG_STACKPROTECTOR
        /* Canary value for the -fstack-protector GCC feature: */
        unsigned long                   stack_canary;
#endif

so I think it makes sense to follow that in asm-offsets.c

Does the current code actually cause a problem?

Will
