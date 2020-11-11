Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF32AE530
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbgKKA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKKA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:58:38 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:58:37 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kceSw-003Awl-Lq; Wed, 11 Nov 2020 00:58:26 +0000
Date:   Wed, 11 Nov 2020 00:58:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix missing include in asm uaccess.h
Message-ID: <20201111005826.GY3576660@ZenIV.linux.org.uk>
References: <20201111004440.8783-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111004440.8783-1-ansuelsmth@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 01:44:38AM +0100, Ansuel Smith wrote:
> Fix a compilation error as PF_KTHREAD is defined in linux/sched.h and
> this is missing.
> 
> Fixes: df325e05a682 ("arm64: Validate tagged addresses in access_ok()
> called from kernel threads")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 991dd5f031e4..51a4f63f464a 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -7,6 +7,8 @@
>  #ifndef __ASM_UACCESS_H
>  #define __ASM_UACCESS_H
>  
> +#include <linux/sched.h>
> +
>  #include <asm/alternative.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/sysreg.h>

NAK.  The real bug is in arch/arm64/include/asm/asm-prototypes.h -
it has no business pulling asm/uaccess.h

Just include linux/uaccess.h instead.
