Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5829ACF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbgJ0NQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:16:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37766 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbgJ0NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:16:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id h19so882397qtq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=htuQpcVyaYACrT+nsrI4stqSgrJzxSmMvkzSIVftwUU=;
        b=VhHdHuK7W+NZ4VnoClCKW1tJBdCkfHdU2mtB6LFUI/tyWI86pp2z9Yv0dPTm27rE/a
         YC5POqDbDTNrWZTrsYkBQURNWCQyL5g1Y0pGcquvuPSsYdm5IQ4MedjnaGThFDco+J4e
         HHRjfaBuUnQ300D9l0yLN+tiXZ3z6QLAN211Mj6yUrdCB/RVIEqmUp1/rxDRS6MZQfHs
         KWh3XfV1UnkKNVQ09txutEuaYpyY/8/a9IOB6hqa7OGrVQBKiqNlz9P7Uzm21lb5OuJ1
         90StBX6yrTD/5zlj7GEPfpSSwLUpsiQAUCchEIVirYyrk1oHeb/iz6Oqv7wh5MRxSOhY
         VLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=htuQpcVyaYACrT+nsrI4stqSgrJzxSmMvkzSIVftwUU=;
        b=HUWN+h+xyQnnq+SRLJFqd5+fOO5w0MXril+ckGCdQCZefkQiIKIZHmQt2vFJ11f7Mq
         h8DR5VrcpA/2BKaxgcn8e/51j0+MHrLjzA1wEcvrwP/6P7E5uAX6Mtuna1f7pV024CIY
         zgcNEzx/6vjXpviXyfsVfbtX/9iMPZEkCQW6Mop7Thg2LPFnmzeG7SUfI2jG/MXClgQi
         8kq5hSK6HKUw+ev7GvMwhujuyo05+xkdxEllh8cIv5Arot6/J//Gz35Zft70+720PhoE
         TIVP+f/hzjtnKG+oE1o7zzE/ecGvGvIQBIav74NG3xIjK2AVsC73YKtzfhMIqast0XW9
         l/pQ==
X-Gm-Message-State: AOAM533O3RLTLnChws+07R7tslM2If3HdJ/Wgi3TzCfefCiQ0wqfwNRi
        0rJCt1zYmxNFQt57op0D+CU=
X-Google-Smtp-Source: ABdhPJwiKQaOiwv0RtDsh2jZMOmkS9bMLnGgzqrc4bwQBIN/YYd3edFSav+9L/3P/Z7VUYDdqqzdyg==
X-Received: by 2002:ac8:7b2a:: with SMTP id l10mr2021617qtu.222.1603804579972;
        Tue, 27 Oct 2020 06:16:19 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j8sm623679qke.38.2020.10.27.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:16:19 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 27 Oct 2020 09:16:17 -0400
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: RFC x86/boot/64: BOOT_PGT_SIZE definition for compressed kernel
Message-ID: <20201027131617.GA1743199@rani.riverdale.lan>
References: <20201025004158.GA767345@rani.riverdale.lan>
 <20201027124007.xkkseswwgerlzlsl@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027124007.xkkseswwgerlzlsl@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:40:07PM +0300, Kirill A. Shutemov wrote:
> On Sat, Oct 24, 2020 at 08:41:58PM -0400, Arvind Sankar wrote:
> > Hi, I think the definition of BOOT_PGT_SIZE in
> > arch/x86/include/asm/boot.h is insufficient, especially after
> >   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> > 
> > Currently, it allocates 6 pages if KASLR is disabled, and either 17 or
> > 19 pages depending on X86_VERBOSE_BOOTUP if KASLR is enabled.
> > 
> > - The X86_VERBOSE_BOOTUP test shouldn't be done: that only disables
> >   debug messages, but warnings/errors are always output to VGA memory,
> >   so the two extra pages for mapping video RAM are always needed.
> > 
> > - The calculation wasn't updated for X86_5LEVEL, which requires at least
> >   one more page for the P4D level, and in theory could require two extra
> >   pages for each of the 4 mappings (compressed kernel, output kernel,
> >   boot_params and command line), though that would require a system with
> >   truly ginormous amounts of RAM.
> 
> Or sparse physical memory map. I hacked QEMU before for testing 5-level
> paging:
> 
> https://gist.github.com/kiryl/d45eb54110944ff95e544972d8bdac1d
> 
> > - If KASLR is disabled, there are only 6 pages, but now that we're
> >   always setting up our own page table, we need 1+(2+2)*3 (one PGD, and
> >   two PUD and two PMD pages for kernel, boot_params and command line),
> >   and 2 more pages for the video RAM, and more for 5-level. Even for
> >   !RELOCATABLE, 13 pages might be needed.
> 
> The comment for BOOT_PGT_SIZE has to be updated.
> 
> BTW, what happens if we underestimate BOOT_PGT_SIZE? Do we overwrite
> something?

No, it checks whether it ran out of pages, so it will just error out and
hang.

> 
> > - SEV-ES needs one more page because it needs to do a PTE-level mapping
> >   for the GHCB page.
> > 
> > - The static calculation is also busted because
> >   boot/compressed/{kaslr.c,acpi.c} can scan the setup data, EFI
> >   configuration tables and the EFI memmap, and none of these are
> >   accounted for. They used to be scanned while still on the
> >   firmware/bootloader page tables, but now our page tables have to cover
> >   them as well. Trying to add up the worst case for all of these, and
> >   anything else the compressed kernel might potentially access seems
> >   like a lost cause.
> > 
> > We could do something similar to what the main kernel does with
> > early_dynamic_pgts: map the compressed kernel at a fixed virtual
> > address (in negative address space, say); recycle all the other mappings
> > until we're done with decompression, and then map the output,
> > boot_params and command line. The number of pages needed for this can be
> > statically calculated, for 4-level paging we'd need 2 pages for the
> > fixed mapping, 12 pages for the other three, and one PGD page.
> 
> Recycling idea look promising to me, but it would require handling #PF in
> decompression code, right? It is considerable complication of the code.
> 

The #PF handler is already there now with the SEV-ES series, but I agree
it would still complicate things. It's simpler to just increase
BOOT_PGT_SIZE and make it unconditional (i.e. bump it to say 32 or 64
even if !KASLR). It's @nobits anyway so it would not increase the size
of the bzImage, just require a slightly larger memory allocation by the
bootloader.

Another alternative is reusing the KASLR code, which contains a memory
allocator, and use it to find system memory for the page tables, but
that also seems like an over-engineered approach.
