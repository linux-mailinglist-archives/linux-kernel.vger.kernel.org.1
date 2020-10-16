Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B2A29056A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405315AbgJPMnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394970AbgJPMnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:43:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F09AC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:43:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r4so3616254ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6hQgOzL6sOM6eLWh0nINz4OXRKDihiFpacrVqvj6Ks4=;
        b=Nm2Vvoo4AWTA69/l3zltGws3/Mza2vChrhkOniY8pO2FHFA7ridMw2ZIKKcAxDbQ2T
         9/kPG9pB6n1Gjap21t+HD/2vaGlNl4WymcE+BwwCgU0qHmY/VdBXhDL7Ay/MNigXHClP
         WqFyttYMkFABeIeAOWOYt9wJLyodyN0TqN53U3lt0rc0Hk+XEcOpGQPX40+Ykd1yireD
         Vln0AIvphGZmE/PACGJNMSsIV9ssukyA8M1YfLV4VwopAiCHvNsRW/fvoul6zGzfo38H
         48e5Qfif1dyZplAHCSbVLnYZPCIWA09nO9QSYEqOsw3TqttnfGlYF6bojnolK927XtW8
         7jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6hQgOzL6sOM6eLWh0nINz4OXRKDihiFpacrVqvj6Ks4=;
        b=S7z0jd3/mm5KmNC3WHUz8N6vjQvPsU5MLDyKYDYfpLgIXxNXSl5fqO9JoyJaoArfgM
         y1tQ89I6QXo1NJH5B63QgW4vJ7BJ7XMEEfN/czyTwIIJmrtnGB440l40l5BvzFavgI3s
         pBao2srpklB4Bv1ZCuoOlwi/Y9KJXLZzML7xnCRuwHCC7d7Bu2yGBdtz10HDEReGjipV
         RbYGydvrue3sBTfvNdWosDHfspLx9ivAyjLMmxtsLoB/7ZB8eGLz5hnUF9f4IhL4HPdl
         jM3ZObKkIOCH2TM8TGALeTsrPikdQx/68qlDVJXoh5vAS3+wSkR2JOJkb/tVhr2yLj8J
         VjuA==
X-Gm-Message-State: AOAM5335V+BFCvAW8nIqAmxpsyfE1TnOlDS+9iF33EFd6GSdquIY7OKS
        PLasBoRYlVXcfXfMmrDKeOY=
X-Google-Smtp-Source: ABdhPJz9UNIhUyTQwk4IvX62eGSUDwZ3pxeSB2tWiUIepRrm8qiHW5OgmLsMFbkxZEl985eyf/xn6A==
X-Received: by 2002:a5d:96ce:: with SMTP id r14mr2180718iol.146.1602852184449;
        Fri, 16 Oct 2020 05:43:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r4sm2289004ilc.32.2020.10.16.05.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:43:03 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 08:43:01 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201016124301.GA1040839@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-6-nivedita@alum.mit.edu>
 <20201016111703.GD8483@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016111703.GD8483@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:17:03PM +0200, Borislav Petkov wrote:
> On Thu, Oct 08, 2020 at 03:16:23PM -0400, Arvind Sankar wrote:
> > On 64-bit, the startup_64_setup_env() function added in
> >   866b556efa12 ("x86/head/64: Install startup GDT")
> > has stack protection enabled because of set_bringup_idt_handler().
> 
> Where? I don't see it.
> 
> I have
> 
> CONFIG_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR_STRONG is not set

You need STACKPROTECTOR_STRONG -- I was testing with defconfig and the
option is enabled by default. You also need AMD_MEM_ENCRYPT enabled,
which it looks like you do.

> 
> and a __stack_chk_fail call is nowhere to be found in the resulting
> head64.s file.
> 
> startup_64_setup_env:
> # arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
> 	leaq	startup_gdt(%rdi), %rax	#, tmp99
> # arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
> 	subq	$_text, %rax	#, tmp101
> 	movq	%rax, startup_gdt_descr+2(%rip)	# tmp101, startup_gdt_descr.address
> # ./arch/x86/include/asm/desc.h:209: 	asm volatile("lgdt %0"::"m" (*dtr));
> #APP
> # 209 "./arch/x86/include/asm/desc.h" 1
> 	lgdt startup_gdt_descr(%rip)		# startup_gdt_descr
> # 0 "" 2
> # arch/x86/kernel/head64.c:600: 	asm volatile("movl %%eax, %%ds\n"
> #NO_APP
> 	movl	$24, %eax	#, tmp102
> #APP
> # 600 "arch/x86/kernel/head64.c" 1
> 	movl %eax, %ds
> movl %eax, %ss
> movl %eax, %es
> 
> # 0 "" 2
> # arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
> #NO_APP
> 	leaq	bringup_idt_table(%rdi), %r9	#, tmp105
> 	leaq	bringup_idt_descr(%rdi), %r8	#, tmp103
> 	leaq	vc_no_ghcb(%rdi), %rsi	#, tmp107
> # arch/x86/kernel/head64.c:91: 	return ptr - (void *)_text + (void *)physaddr;
> 	subq	$_text, %r9	#, _11
> 	subq	$_text, %r8	#, _8
> 	subq	$_text, %rsi	#, tmp109
> # arch/x86/kernel/head64.c:572: 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
> 	movq	%r9, %rdi	# _11,
> 	call	set_bringup_idt_handler.constprop.0	#
> # arch/x86/kernel/head64.c:575: 	desc->address = (unsigned long)idt;
> 	movq	%r9, 2(%r8)	# _11, MEM[(struct desc_ptr *)_8].address
> # ./arch/x86/include/asm/desc.h:214: 	asm volatile("lidt %0"::"m" (*dtr));
> #APP
> # 214 "./arch/x86/include/asm/desc.h" 1
> 	lidt (%r8)		# MEM[(const struct desc_ptr *)_8]
> # 0 "" 2
> # arch/x86/kernel/head64.c:605: }
> #NO_APP
> 	ret
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
