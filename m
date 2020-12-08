Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1C2D3522
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgLHVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgLHVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:21:39 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77455C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:20:59 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so13377850pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RDWW5hZB1VaGavC7326+UBXGxqMf/k+gnSVXcAhVGwQ=;
        b=AzGHJdjfU/mONr1fn3P2XppbsELqU+Ks1DxhOIyrwAIThIouZPSCNVvGGdOcjTNQrQ
         udNZV9WyRf4see5Jei7FuuQOZ9xEDhVqn9clbZl7Wj0EK3VzrHStV5kxkVQpgIxdXVsk
         PjL1jmBuaJjpJCPN3QLjDgqjJ1lWVEgGRWud4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDWW5hZB1VaGavC7326+UBXGxqMf/k+gnSVXcAhVGwQ=;
        b=NbA8BCzORXy2Sb01Cjv13kLjQ2zltDo5XDOZtJ8OMa1j8spoxEUZsry8lERYmZCn2C
         ygP52j6d6MxyqPdu9wI/bgPP/z7JliGnGBk6tX7pnlijyayof1b1B8rr2YQEmUdLIGRi
         gsYLepDVnoYfCMPIaPPzk59MYT4EI6K1Reek582B40GhytFRcM9JjOe+7PyNTK40MKq4
         GoJboks6p5k9AN1Y+ryJHpUVDSVVpzarI/dYk/E7TkKTcUWhdb8VT55IlR7zgQtZJlBE
         uCyUCvUmBQCLZaAeXxYw9DmH68XsC6cV1+ZKkfevIf9VwfRkbAvWoVV7Fk5KnIsvb8I9
         Fdqw==
X-Gm-Message-State: AOAM53029vwJO/SfjLHuMcv5iCNDLa6g3ToKcZniDPuTL4xa+AGfHDVH
        ZazxABZsEnu66EYIvXNSlQ9jIg==
X-Google-Smtp-Source: ABdhPJzXe+P48JeIrEK52QtqLMEukiieA6pN0QbzAkcKvHTd7HBnmtnnpXFAqO+nBIQPJ9ZDbwfdTA==
X-Received: by 2002:a62:e901:0:b029:197:ca81:4bb9 with SMTP id j1-20020a62e9010000b0290197ca814bb9mr2664207pfh.26.1607462459031;
        Tue, 08 Dec 2020 13:20:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17sm16772192pge.37.2020.12.08.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:20:57 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:20:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lkdtm: don't move ctors to .rodata
Message-ID: <202012081319.D5827CF@keescook>
References: <20201207170533.10738-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207170533.10738-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 05:05:33PM +0000, Mark Rutland wrote:
> When building with KASAN and LKDTM, clang may implictly generate an
> asan.module_ctor function in the LKDTM rodata object. The Makefile moves
> the lkdtm_rodata_do_nothing() function into .rodata by renaming the
> file's .text section to .rodata, and consequently also moves the ctor
> function into .rodata, leading to a boot time crash (splat below) when
> the ctor is invoked by do_ctors().
> 
> Let's prevent this by marking the function as noinstr rather than
> notrace, and renaming the file's .noinstr.text to .rodata. Marking the
> function as noinstr will prevent tracing and kprobes, and will inhibit
> any undesireable compiler instrumentation.
> 
> The ctor function (if any) will be placed in .text and will work
> correctly.
> 
> Example splat before this patch is applied:
> 
> [    0.916359] Unable to handle kernel execute from non-executable memory at virtual address ffffa0006b60f5ac
> [    0.922088] Mem abort info:
> [    0.922828]   ESR = 0x8600000e
> [    0.923635]   EC = 0x21: IABT (current EL), IL = 32 bits
> [    0.925036]   SET = 0, FnV = 0
> [    0.925838]   EA = 0, S1PTW = 0
> [    0.926714] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000427b3000
> [    0.928489] [ffffa0006b60f5ac] pgd=000000023ffff003, p4d=000000023ffff003, pud=000000023fffe003, pmd=0068000042000f01
> [    0.931330] Internal error: Oops: 8600000e [#1] PREEMPT SMP
> [    0.932806] Modules linked in:
> [    0.933617] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc7 #2
> [    0.935620] Hardware name: linux,dummy-virt (DT)
> [    0.936924] pstate: 40400005 (nZcv daif +PAN -UAO -TCO BTYPE=--)
> [    0.938609] pc : asan.module_ctor+0x0/0x14
> [    0.939759] lr : do_basic_setup+0x4c/0x70
> [    0.940889] sp : ffff27b600177e30
> [    0.941815] x29: ffff27b600177e30 x28: 0000000000000000
> [    0.943306] x27: 0000000000000000 x26: 0000000000000000
> [    0.944803] x25: 0000000000000000 x24: 0000000000000000
> [    0.946289] x23: 0000000000000001 x22: 0000000000000000
> [    0.947777] x21: ffffa0006bf4a890 x20: ffffa0006befb6c0
> [    0.949271] x19: ffffa0006bef9358 x18: 0000000000000068
> [    0.950756] x17: fffffffffffffff8 x16: 0000000000000000
> [    0.952246] x15: 0000000000000000 x14: 0000000000000000
> [    0.953734] x13: 00000000838a16d5 x12: 0000000000000001
> [    0.955223] x11: ffff94000da74041 x10: dfffa00000000000
> [    0.956715] x9 : 0000000000000000 x8 : ffffa0006b60f5ac
> [    0.958199] x7 : f9f9f9f9f9f9f9f9 x6 : 000000000000003f
> [    0.959683] x5 : 0000000000000040 x4 : 0000000000000000
> [    0.961178] x3 : ffffa0006bdc15a0 x2 : 0000000000000005
> [    0.962662] x1 : 00000000000000f9 x0 : ffffa0006bef9350
> [    0.964155] Call trace:
> [    0.964844]  asan.module_ctor+0x0/0x14
> [    0.965895]  kernel_init_freeable+0x158/0x198
> [    0.967115]  kernel_init+0x14/0x19c
> [    0.968104]  ret_from_fork+0x10/0x30
> [    0.969110] Code: 00000003 00000000 00000000 00000000 (00000000)
> [    0.970815] ---[ end trace b5339784e20d015c ]---
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Oh, eek. Why was a ctor generated at all? But yes, this looks good.
Greg, can you pick this up please?

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
