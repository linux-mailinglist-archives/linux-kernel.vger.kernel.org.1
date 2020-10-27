Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417E429AC49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900101AbgJ0MkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:40:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39789 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900084AbgJ0MkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:40:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id m16so1581504ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f2bgYQSP0h9bji4PNEkOJ45g7PxITqxKPHnafoL5ywo=;
        b=f7AWN2jEqEGXBj2WyOOD1p5VjNl+OLEhLNMT0RMsgOEECijRHc8twosQU8MiOUaHAo
         EZlCTnZXAbm2fYsirr8zPn3hE3wpNcZ2y3Mnrr53KV25oM/g2xIERx+01pKjWGo9KEll
         GWfTzLr7hdFTk2sJnZg/gBBwOO4KihW8gG61AGrfcJ7rCbXl3tk76MYetrTl2rtjJMV1
         klWxXVHpEwRjrVZHwcvTCSm+ZN8tQVQoDU+6HTmZxxxaOdV/vPcn9l5d5JuXRmJyaRS2
         T5ypMTKgawgklbMKQ5d7YvP0/BTMGQK33NvzHmGZZlH+mwNS8O9ZNI3J7b8mLMWnT72D
         zz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2bgYQSP0h9bji4PNEkOJ45g7PxITqxKPHnafoL5ywo=;
        b=nXa7SdvFGtajDg9zcMGMNgXyUipiQfb9dzAFNtUgIa8gZSZ4G/JrtTmtUXtv/PLji5
         Pi66QhH0MoGtp5V4Fr4K4HWJEbGEEDkqYLRaRid350HLNMI7z+bNJRYE8FUyFAhu1PqQ
         3Vgs7niDKLPBBxpjobf2cO6mjYMgBaDWBhfNDF9dHRiVb9QlE1zqFB+VAzPKToC0pfxu
         43T0+NnV6KY3Isj7rQYnYvr6IryWiZ3vFtCqCtjvtCpYW3tC5lRkh5Ziy0biymohsrmN
         vR/H05UxvLyrtHm7SvtY/bALLlJsXVPVNuzbMyRZ1gEP3htVSUrkzLTL230CaKXVbPWz
         EVvA==
X-Gm-Message-State: AOAM532zwPBspGTB1wt7EmyYdWkEyWd+PMK6OBhYcfNZ5pe/mXFVg+hh
        8FLAKEFyQCLAkH6DgGhc9XOYPQ==
X-Google-Smtp-Source: ABdhPJxMw+7iRjiLHJuNyLgA5g31a+DxVqBWzGSBF7NnLksG8zb7zF83sk6KOhZOEe6xMRgw8f2S6w==
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr951090ljj.271.1603802406590;
        Tue, 27 Oct 2020 05:40:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u1sm162206lfm.121.2020.10.27.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:40:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 70500103677; Tue, 27 Oct 2020 15:40:07 +0300 (+03)
Date:   Tue, 27 Oct 2020 15:40:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: RFC x86/boot/64: BOOT_PGT_SIZE definition for compressed kernel
Message-ID: <20201027124007.xkkseswwgerlzlsl@box>
References: <20201025004158.GA767345@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Or sparse physical memory map. I hacked QEMU before for testing 5-level
paging:

https://gist.github.com/kiryl/d45eb54110944ff95e544972d8bdac1d

> - If KASLR is disabled, there are only 6 pages, but now that we're
>   always setting up our own page table, we need 1+(2+2)*3 (one PGD, and
>   two PUD and two PMD pages for kernel, boot_params and command line),
>   and 2 more pages for the video RAM, and more for 5-level. Even for
>   !RELOCATABLE, 13 pages might be needed.

The comment for BOOT_PGT_SIZE has to be updated.

BTW, what happens if we underestimate BOOT_PGT_SIZE? Do we overwrite
something?

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

Recycling idea look promising to me, but it would require handling #PF in
decompression code, right? It is considerable complication of the code.

-- 
 Kirill A. Shutemov
