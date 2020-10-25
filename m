Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61D297FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 03:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766690AbgJYCUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 22:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766683AbgJYCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 22:20:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6AC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 19:20:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r7so5347740qkf.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jyb14OtReYweMvVoCijrCzRYw8bKyGrGIBysmq4Dh4Y=;
        b=hhHs+YTp8W8WUcVs3MdoVQ2Ymz+6E7/Xs4CAkWNHVBZ64V9CuMBGXR0cNE/1HWtfbF
         YGubjua5GSq5gqyR5LRAPKe4+eE7N9cMt2t2zrSzfhCgXsp7mRbWm2Apf4mWbSyV4kET
         NbNQJLqaQMQdt0D2YaaqoNIVrXvHm5CI+XZBv1BDsj3O2beJyWSFEFUROa06Zktai2VB
         u3mDiheXJ2rrhigVLfxXQipbX/XVnYGg+Tlhf8M3qG+UAbM2fgXGaJdaBhr3pA4PUktt
         vNawcs5EWqTi5eQmdbHawxRMqvO+FPQDNgzPgtG4LJS37P1eXYf9m1m67EDr2mI1d7rM
         SV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Jyb14OtReYweMvVoCijrCzRYw8bKyGrGIBysmq4Dh4Y=;
        b=XiuMMFn6OmbuTDhHMufEWNmtci11zbo70z18aeZ4Lw+KTmZx9MChNuqFbId5sIm/hr
         9l3v4njvJAiqaxKMFo4oGPtcTxYaajLrK9JYX1vbJRQYuoWAp6MmckEBGQpMFAOIXUWs
         cKXdUB8VMophhap3nwmtI23hWuWHxDcYA3k0oul7RzK5eYBAGk2/tk0QbMeRtf6KOcXT
         UcNOWlB5fcVq6pTg6kYy0y0UHtFM1oTJN4TjmcMSbLm3Lu41aa8KOTDvTo5DWKfebCcC
         VsfXjjQYx7z8ifN4iEfwzFCrhjV0HWB48Jj2oAPCVIGccvdVV1YetAGCM8iYuMSoWR9/
         nd7Q==
X-Gm-Message-State: AOAM5339rxoZ00dcAiBGlpOks8B4+mZ8fsBCDhm5HRK7PtyyAjkl8x1A
        vO2hlhEyu2dcDVya0aXLju0=
X-Google-Smtp-Source: ABdhPJzZ72uflWIVu2JdQvt4KM+4AiN5hF/KFrpmJpPa+dtRn5gdx0wmiduCb+iQjvD7Q6Sy8glYQg==
X-Received: by 2002:a37:6688:: with SMTP id a130mr9984602qkc.219.1603592405469;
        Sat, 24 Oct 2020 19:20:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l14sm4305235qti.34.2020.10.24.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 19:20:04 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 24 Oct 2020 22:20:03 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: RFC x86/boot/64: BOOT_PGT_SIZE definition for compressed kernel
Message-ID: <20201025022003.GA971914@rani.riverdale.lan>
References: <20201025004158.GA767345@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025004158.GA767345@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 08:41:58PM -0400, Arvind Sankar wrote:
> Hi, I think the definition of BOOT_PGT_SIZE in
> arch/x86/include/asm/boot.h is insufficient, especially after
>   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> 
> Currently, it allocates 6 pages if KASLR is disabled, and either 17 or
> 19 pages depending on X86_VERBOSE_BOOTUP if KASLR is enabled.
> 
> - The X86_VERBOSE_BOOTUP test shouldn't be done: that only disables
>   debug messages, but warnings/errors are always output to VGA memory,
>   so the two extra pages for mapping video RAM are always needed.
> 
> - The calculation wasn't updated for X86_5LEVEL, which requires at least
>   one more page for the P4D level, and in theory could require two extra
>   pages for each of the 4 mappings (compressed kernel, output kernel,
>   boot_params and command line), though that would require a system with
>   truly ginormous amounts of RAM.
> 
> - If KASLR is disabled, there are only 6 pages, but now that we're
>   always setting up our own page table, we need 1+(2+2)*3 (one PGD, and
>   two PUD and two PMD pages for kernel, boot_params and command line),
>   and 2 more pages for the video RAM, and more for 5-level. Even for
>   !RELOCATABLE, 13 pages might be needed.
> 
> - SEV-ES needs one more page because it needs to do a PTE-level mapping
>   for the GHCB page.
> 
> - The static calculation is also busted because
>   boot/compressed/{kaslr.c,acpi.c} can scan the setup data, EFI
>   configuration tables and the EFI memmap, and none of these are
>   accounted for. They used to be scanned while still on the
>   firmware/bootloader page tables, but now our page tables have to cover
>   them as well. Trying to add up the worst case for all of these, and
>   anything else the compressed kernel might potentially access seems
>   like a lost cause.
> 
> We could do something similar to what the main kernel does with
> early_dynamic_pgts: map the compressed kernel at a fixed virtual
> address (in negative address space, say); recycle all the other mappings
> until we're done with decompression, and then map the output,
> boot_params and command line. The number of pages needed for this can be
> statically calculated, for 4-level paging we'd need 2 pages for the
> fixed mapping, 12 pages for the other three, and one PGD page.
> 
> Thoughts?

Or just bump BOOT_PGT_SIZE to some largeish number?
