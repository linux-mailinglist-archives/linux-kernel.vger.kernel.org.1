Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD282B8E67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKSJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 04:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgKSJHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 04:07:13 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6BD221F1;
        Thu, 19 Nov 2020 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605776832;
        bh=PCe/AdYOz9O2LA4LpB6Us7fdfDL4tIWmb1FN7t4fCT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2DPRHQIuH3DBHoqIlpQ/Dk0dD6tgZ3bRmXEXr6EbE1H4tcibWcbf94EV3yqZglOm
         f05t38/H4YtsmptDDE6maEWRMFyrSwQkIFIPKEqUIcI8poeIoDUOBd+n5IfyoHSM0x
         1JvndqXAD63YWHnu//aPKZIbsoaWF7M2SpXVk1bM=
Date:   Thu, 19 Nov 2020 09:07:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*
Message-ID: <20201119090706.GE3599@willie-the-truck>
References: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:45:40AM +0800, Youling Tang wrote:
> We currently try to emit *.init.rodata.* twice, once in INIT_DATA, and once
> in the line immediately following it. As the two section definitions are
> identical, the latter is redundant and can be dropped.
> 
> This patch drops the redundant *.init.rodata.* section definition.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 1bda604..7dba3c4 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -201,7 +201,7 @@ SECTIONS
>  		INIT_CALLS
>  		CON_INITCALL
>  		INIT_RAM_FS
> -		*(.init.rodata.* .init.bss)	/* from the EFI stub */
> +		*(.init.bss)	/* from the EFI stub */

Acked-by: Will Deacon <will@kernel.org>

Will
