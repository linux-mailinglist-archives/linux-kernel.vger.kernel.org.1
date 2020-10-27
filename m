Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42529CB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373693AbgJ0VQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:16:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41841 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896161AbgJ0VO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:14:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id b69so2653397qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfQfyJn5ySwwdiAztxo+8CCD2uAVoDXGmrDltfs0hCY=;
        b=ifYWHQOVg8yLeXFT1653iuhVUzvKj8EySWfnoSUqj1qQNxA0ua9rWBnQMk37J4R/Bs
         qYOUzFHC27rxP/vavQbF7BErmYNeyjceDc5BxPqDeSihzrX7/MV+YTySdnRslwEqmr/h
         +TfziS5MgtmJiPC5ENRmcYRbTpL7NALOk3vxJarMGMBSAb5JenlV7HLN1ifbZYR0KIyf
         vGjFty6dxtsz8b/32FWy6qMUrxjisqh3b1yinJae2rVjJZmG38OqlCheZNX4i6CtMSvf
         p1fPJ4eID8sxi/5texobGAT3enqZPCNELsDgd1dc4uh1lAUkEB0ZL8Pm5V90FAasXFFW
         kZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lfQfyJn5ySwwdiAztxo+8CCD2uAVoDXGmrDltfs0hCY=;
        b=G3S6taW/vnw/vRi/HPLniMq0GcyKNreZ+n9phcXX2mPpmyXZftxAuiSxYcybKUV5xC
         kd+YpfgKaRdkKOski9to6U3EcVdLEJj72ZUclt2GOoq8rhDeCuwAtIxplWMGlyGqRXXj
         zCbWo7t0TPhyHxt39HNphTfQm56MHtdJ2xZeX+4fzyhTWsgT+DtQT7tF4NYRNPmHdH4M
         i77iL6BSzA1y1HdaCcLDKYXGUvDWAZa5X5Q341leTL/P02KP5eEwLRYl4PIclLFisFGG
         3kPlINkrIkhrnJABsn3w7+ksgC/hggqb+CtGa9sgG0Gi1p3ddKQ99DR6PeAg8IlLt6jh
         PjQA==
X-Gm-Message-State: AOAM533MKe4E2VvLoqy1BB0Ifb3Q5ABXaAaktEeN30Mjsna9tCK4ZPNf
        6JUhbuaE/Lt6fchYp6JJAgI=
X-Google-Smtp-Source: ABdhPJwK/HU9BxOa0wOe173KE8s7VQS8ysXIPEfp8BEa9GAOVb16iW6Wy80PjIyyBrJX8nTV6Jef+Q==
X-Received: by 2002:a05:620a:784:: with SMTP id 4mr4458qka.177.1603833264973;
        Tue, 27 Oct 2020 14:14:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x5sm1573262qkf.44.2020.10.27.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 14:14:24 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 27 Oct 2020 17:14:22 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201027211422.GC1833548@rani.riverdale.lan>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
 <20201027200803.GL15580@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027200803.GL15580@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 09:08:03PM +0100, Borislav Petkov wrote:
> On Mon, Oct 05, 2020 at 11:15:39AM -0400, Arvind Sankar wrote:
> > Commit b4e0409a36f4 ("x86: check vmlinux limits, 64-bit") added a check
> > that the size of the 64-bit kernel is less than KERNEL_IMAGE_SIZE.
> > 
> > The check uses (_end - _text), but this is not enough. The initial PMD
> > used in startup_64() (level2_kernel_pgt) can only map upto
> > KERNEL_IMAGE_SIZE from __START_KERNEL_map, not from _text.
> > 
> > The correct check is the same as for 32-bit, since LOAD_OFFSET is
> > defined appropriately for the two architectures. Just check
> > (_end - LOAD_OFFSET) against KERNEL_IMAGE_SIZE unconditionally.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index bf9e0adb5b7e..b38832821b98 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -454,13 +454,12 @@ SECTIONS
> >  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> >  }
> >  
> > -#ifdef CONFIG_X86_32
> >  /*
> >   * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
> >   */
> >  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
> >  	   "kernel image bigger than KERNEL_IMAGE_SIZE");
> > -#else
> > +#ifdef CONFIG_X86_64
> >  /*
> >   * Per-cpu symbols which need to be offset from __per_cpu_load
> >   * for the boot processor.
> > @@ -470,18 +469,12 @@ INIT_PER_CPU(gdt_page);
> >  INIT_PER_CPU(fixed_percpu_data);
> >  INIT_PER_CPU(irq_stack_backing_store);
> >  
> > -/*
> > - * Build-time check on the image size:
> > - */
> > -. = ASSERT((_end - _text <= KERNEL_IMAGE_SIZE),
> > -	   "kernel image bigger than KERNEL_IMAGE_SIZE");
> 
> So we have this:
> 
> SECTIONS
> {       
> #ifdef CONFIG_X86_32
>         . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
>         phys_startup_32 = ABSOLUTE(startup_32 - LOAD_OFFSET);
> #else     
>         . = __START_KERNEL;
> 	^^^^^^^^^^
> 
> which sets the location counter to
> 
> #define __START_KERNEL          (__START_KERNEL_map + __PHYSICAL_START)
> 
> which is 	0xffffffff80000000 + ALIGN(CONFIG_PHYSICAL_START, CONFIG_PHYSICAL_ALIGN)
> 
> and that second term after the '+' has effect only when
> CONFIG_RELOCATABLE=n and that's not really used on modern kernel configs
> as RELOCATABLE is selected by EFI_STUB and RANDOMIZE_BASE depends on at
> and and ...
> 
> So IOW, in a usual .config we have:
> 
> __START_KERNEL_map at 0xffffffff80000000
> _text		   at 0xffffffff81000000
> 
> So practically and for the majority of configs, the kernel image really
> does start at _text and not at __START_KERNEL_map and we map 16Mb which
> is 4 PMDs of unused pages. So basically you're correcting that here -
> that the number tested against KERNEL_IMAGE_SIZE is 16Mb more.
> 
> Yes, no?
> 
> Or am I missing some more important aspect and this is more than just a
> small correctness fixlet?
> 
> Thx.
> 

This is indeed just a small correctness fixlet, but I'm not following
the rest of your comments. PHYSICAL_START has an effect independent of
the setting of RELOCATABLE. It's where the kernel image starts in
virtual address space, as shown by the 16MiB difference between
__START_KERNEL_map and _text in the usual .config situation. In all
configs, not just majority, the kernel image itself starts at _text. The
16MiB gap below _text is not actually mapped, but the important point is
that the way the initial construction of pagetables is currently setup,
the code cannot map anything above __START_KERNEL_map + KERNEL_IMAGE_SIZE,
so _end needs to be below that.

If KASLR was disabled (either at build-time or run-time), these
link-time addresses are where the kernel actually lives (in VA space);
and if it was enabled, it will make sure to place the _end of the kernel
below KERNEL_IMAGE_SIZE when choosing a random virtual location.

That said, AFAICT, RELOCATABLE and PHYSICAL_START look like historical
artifacts at this point: RELOCATABLE should be completely irrelevant for
the 64-bit kernel, and there's really no reason to be able to configure
the start VA of the kernel, that should just be constant independent of
PHYSICAL_START.

Thanks.
