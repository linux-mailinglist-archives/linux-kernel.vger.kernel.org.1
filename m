Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8C287669
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgJHOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbgJHOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:52:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E179C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:52:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v123so7257810qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ViQC4adlH6DM3wXlbVQ3zb3Oxu5Fu1Afsg8uzzNsK/Y=;
        b=POf30xef6TTw7lnoaxLDom81foreUnaPLzk1XnH/pPDXLSIIDekzinHxiapkVnN5LT
         ajc/+s8PZTUbXOVeqGx3pRaXQBd9QFkIx7FcMSuRtp+asDvuvTcoiHHBbLh7C6AP+sIJ
         /Qcb6khTjV+E9yfhR9+IJ79sM1xz3FLmyMygKw4Jc9M7Xt/qeXjUfUq8Cx0KYSDRvQ8B
         1P4uMSL0ZxOOOPAB99loIVFsdymyCeeVd15jhazecjwEYzEwRe+8+p57yWEE1ZGo9TYo
         7KbQqtr0IwkNSS9KGdhj/FafiH6HfPep/+yO4//JKzBhT489sN7GX3u7nN6MVlx+7vv8
         mN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ViQC4adlH6DM3wXlbVQ3zb3Oxu5Fu1Afsg8uzzNsK/Y=;
        b=VmUKn6nrSaSCO56na8emBDU3+7qGxPzKvmmoBNsLbvHavU5mvWoywKktPdOiQlHFE1
         8Ed2KuMQ99e4e47OAeegVOOgYYQigUKkvh/LybgI+xCj2OPgP8mKmkW7Q+bFVEj8Otg5
         Gn73VqG5ev8eZ1qQ8kO8s6aqF5m6LY5shf6yXPBSoAsj4Vxzoq22+QS0dPuQYzXkNYEv
         PRiw0K/tbsTNDvYulnUUUGWWwcm0jIcc/RhDkyf0rB/kkElcbTRiLPb3DwXtP5szKxbY
         2fa2CWU9XLZXrE7mhHw2jp1rN0PRdSFLYE/GIGRpYKyM1iNOgtqcQr+TArSz1QH75lAi
         9RyA==
X-Gm-Message-State: AOAM530NWLwARn89lY3lUskfGwuDphq+YxJ71KNDB7VpEn84RddjT8tm
        kj/EqA7W30uPaEaRuOQ+wH8GzGuzG81jAQ==
X-Google-Smtp-Source: ABdhPJwHgmuy9Csax37dleb07Bdx9m4g75smgkEH+A020+eDLLirVsf9bzEoxNsfFNoZzz7vxAhlxQ==
X-Received: by 2002:a05:620a:22f2:: with SMTP id p18mr1317457qki.113.1602168733698;
        Thu, 08 Oct 2020 07:52:13 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t10sm4011091qkt.55.2020.10.08.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:52:12 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 8 Oct 2020 10:52:11 -0400
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] x86/head/64: Disable stack protection for
 head$(BITS).o
Message-ID: <20201008145211.GE2429573@rani.riverdale.lan>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-6-nivedita@alum.mit.edu>
 <20201008084219.GC3209@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008084219.GC3209@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 10:42:19AM +0200, Joerg Roedel wrote:
> On Wed, Oct 07, 2020 at 03:53:51PM -0400, Arvind Sankar wrote:
> > On 64-bit, the startup_64_setup_env() function added in
> >   866b556efa12 ("x86/head/64: Install startup GDT")
> > has stack protection enabled because of set_bringup_idt_handler().
> > 
> > At this point, %gs is not yet initialized, and this doesn't cause a
> > crash only because the #PF handler from the decompressor stub is still
> > installed and handles the page fault.
> 
> Hmm, that is weird. Can you please share your config with which this
> happens? I have a commit in my local branch which disables page-faulting
> in the pre-decompression code before jumping to the uncompressed kernel
> image, and it did not break anything here.
> 
> Also, what compiler did you use to trigger this?
> 

The compiler is gcc-10.

QEMU usually puts the command line in the low 1Mb, so it needs to avoid
accessing the command line as well, as the stack canary is at 0x28. So
defconfig with
  AMD_MEM_ENCRYPT	enabled
  RANDOMIZE_BASE	disabled
  EARLY_PRINTK		disabled
crashes on boot if you disable the #PF handler.

I traced it down with the patch below, which produces
  $ qemu-system-x86_64 -m 2048 -kernel bzImage -append "earlyprintk=ttyS0,keep" -drive if=pflash,format=raw,readonly,file=OVMF_64.fd -nographic -enable-kvm
  
  ...
  
  Decompressing Linux... 
  Error Code: 0000000000000002
  CR2: 0x0000000003e00000
  RIP relative to _head: 0x000000000088521d
  
  Error Code: 0000000000000002
  CR2: 0x0000000004000000
  RIP relative to _head: 0x000000000088521d
  
  ...
  
  Error Code: 0000000000000002
  CR2: 0x0000000005a00000
  RIP relative to _head: 0x00000000008854d0
  Parsing ELF... done.
  Booting the kernel.
  
  Error Code: 0000000000000000
  CR2: 0x0000000000000028
  RIP relative to _head: 0xfffffffffe03b67c

That last page fault is in the main kernel at the stack canary's address.

Patch:

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 063a60edcf99..e0578dcbaecc 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -325,6 +325,13 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	unsigned long end;
 	bool ghcb_fault;
 
+	error_putstr("\nError Code: ");
+	error_puthex(error_code);
+	error_putstr("\nCR2: 0x");
+	error_puthex(address);
+	error_putstr("\nRIP relative to _head: 0x");
+	error_puthex(regs->ip - (unsigned long)_head);
+	error_putstr("\n");
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
 	address   &= PMD_MASK;
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c3de8b..d6f051e4b64b 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -50,6 +50,7 @@ static void parse_earlyprintk(void)
 	int pos = 0;
 	int port = 0;
 
+#if 0
 	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
 		char *e;
 
@@ -93,6 +94,8 @@ static void parse_earlyprintk(void)
 		if (baud == 0 || arg + pos == e)
 			baud = DEFAULT_BAUD;
 	}
+#endif
+	port = 0x3f8;
 
 	if (port)
 		early_serial_init(port, baud);
