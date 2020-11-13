Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD72B23DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgKMSfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:35:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D139C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=94mpeEQ5347vYMWO2O5kVIMAmiKW0s2hsuuld99rPQE=; b=UUF/eMg7P5n0iBD1VCCYL5Zq2M
        tj+1mIBSUKhSenAaGXCR+si9J54UDbmRgvSFLLlBDz9d0R3rk/YXrgTb57PDnmoGMCmvbf4LqAEtj
        TdiTDjfNxP81mv5HU3cKQK6j5Az7vilT5rTnC6vxgRL5SAt0Su7eg/tjWXp0+wUlupLTszGGMZDlB
        gT2NlzWfsBJD+J2LHAJta6XjN5KE2zWVsOZWhSTSXLvmSiLieDENMtym2iD6EKyBRAJ8C14Q3tq+N
        VggEcvuh3yaW5M1e0Eo0T3dWZyFgazqklwerOvxbeYEDqkFXrdWCH49BvVLsMA1MdUcqpMxwpt/eS
        lJi1Lubg==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kddub-0003b0-Et; Fri, 13 Nov 2020 18:35:05 +0000
Subject: Re: [PATCH] x86/e820: fix the function type for e820__mapped_all
To:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
References: <20201113182654.967462-1-samitolvanen@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <95513107-5aa4-5e42-467f-f9a415eb9f3f@infradead.org>
Date:   Fri, 13 Nov 2020 10:34:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201113182654.967462-1-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 10:26 AM, Sami Tolvanen wrote:
> e820__mapped_all is passed as a callback to is_mmconf_reserved, which
> expects a function of type:
> 
>   typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
> 
> This trips indirect call checking with Clang's Control-Flow Integrity
> (CFI). Change the last argument from enum e820_type to unsigned to fix
> the type mismatch.

Hi,

Kernel style is no raw unsigned -- use unsigned int or unsigned long, please.

checkpatch should or could have found that issue.

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
>  
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 22aad412f965..9f6a4e9bca4c 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -145,7 +145,7 @@ static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
>  /*
>   * This function checks if the entire range <start,end> is mapped with type.
>   */
> -bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
> +bool __init e820__mapped_all(u64 start, u64 end, unsigned type)
>  {
>  	return __e820__mapped_all(start, end, type);
>  }
> 
> base-commit: 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> 


-- 
~Randy

