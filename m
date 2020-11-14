Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA92B2A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 02:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKNBTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 20:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKNBTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 20:19:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951FDC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 17:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Cjg03gP8/jRknfS65AD/9a+9L27EhRjv5GIR2T2lnWo=; b=L7wgoNZYJ2CWIBsd0u7YjBjAKM
        t/U2x45MmC9wNr31WpXX52lozTZLiP6KaHVJaC92JRg9PKR3P9W7liWGZIB9C5j0Gc/vcG5cS1P/R
        RkDT3tiaSg3Gqiye4V4o8kWgrHtTHZQX5kLx9FCzye7yT4cIldIvwhV72ZcU8XR2ucuAxaF8UCQ7C
        zj44pUHRyw+j2pAHTGqvbnABQbZaIUbNhHsm4gd8rllDGaT355PINiO+AJPxWRUjf8ru9DLBryH1X
        aWjS3QTHGa7OPuQgzrGWjpIosbdDszOMkpCO34c3ltb20IFbgNNsiyOGdanxeKLkg/aJMG2OSTrn0
        sEWe2JfA==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdkEA-0002In-54; Sat, 14 Nov 2020 01:19:42 +0000
Subject: Re: [PATCH v2 2/2] x86/e820: fix the function type for
 e820__mapped_all
To:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
References: <20201114002306.4166604-1-samitolvanen@google.com>
 <20201114002306.4166604-2-samitolvanen@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <15282e4d-5535-825c-b5be-8a0114b3e356@infradead.org>
Date:   Fri, 13 Nov 2020 17:19:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201114002306.4166604-2-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 4:23 PM, Sami Tolvanen wrote:
> e820__mapped_all is passed as a callback to is_mmconf_reserved, which
> expects a function of type:
> 
> typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned int type);
> 
> This trips indirect call checking with Clang's Control-Flow Integrity
> (CFI). Change the last argument from enum e820_type to unsigned to fix
> the type mismatch.
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/x86/include/asm/e820/api.h | 2 +-
>  arch/x86/kernel/e820.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index e8f58ddd06d9..a122ca2784b2 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -12,7 +12,7 @@ extern unsigned long pci_mem_start;
>  
>  extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
>  extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
> -extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
> +extern bool e820__mapped_all(u64 start, u64 end, unsigned int type);
>  
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 22aad412f965..24b82ff53513 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -145,7 +145,7 @@ static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
>  /*
>   * This function checks if the entire range <start,end> is mapped with type.
>   */
> -bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
> +bool __init e820__mapped_all(u64 start, u64 end, unsigned int type)
>  {
>  	return __e820__mapped_all(start, end, type);
>  }
> 


-- 
~Randy

