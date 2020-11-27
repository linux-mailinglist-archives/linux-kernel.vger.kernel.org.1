Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18D2C65A1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgK0MPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgK0MPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:15:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A020C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:15:34 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ffb00d5ac34a4508c2f14.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:fb00:d5ac:34a4:508c:2f14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48B031EC043F;
        Fri, 27 Nov 2020 13:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606479332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P53cfVOos+Pvx8rAvIlaZ0UVw4A0lfL3WA+ZSjb2kSA=;
        b=NRwy04c+aeQgdL2ZrSw+nMWWvyRwwcAcPPa6Yu6KDI9uyEaWfqrSuxZKbXiF8oi0eME2Xz
        h0NbcAjE72RPFhdmmkOkDEFt1XeL3lnT9zcsiHyfmjj4F0whfwIMYhEPBk7KdI7URFQ7QX
        abpN/1rByfYi+bGR6hd0eUIPXpnSt8U=
Date:   Fri, 27 Nov 2020 13:15:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] x86/e820: fix the function type for e820__mapped_all
Message-ID: <20201127121526.GC13163@zn.tnic>
References: <20201113182654.967462-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113182654.967462-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:26:54AM -0800, Sami Tolvanen wrote:
> e820__mapped_all is passed as a callback to is_mmconf_reserved, which
> expects a function of type:
> 
>   typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
> 
> This trips indirect call checking with Clang's Control-Flow Integrity
> (CFI). Change the last argument from enum e820_type to unsigned to fix
> the type mismatch.
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/include/asm/e820/api.h | 2 +-
>  arch/x86/kernel/e820.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index e8f58ddd06d9..e872a796619d 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -12,7 +12,7 @@ extern unsigned long pci_mem_start;
>  
>  extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
>  extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
> -extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
> +extern bool e820__mapped_all(u64 start, u64 end, unsigned type);

I think the proper fix is to fix the typedef to:

	typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);

because

* is_mmconf_reserved() is passing in E820_TYPE_RESERVED which is enum e820_type

* is_acpi_reserved() is the other check_reserved_t function ptr and the last arg
type there is unused so it can just as well be enum e820_type.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
