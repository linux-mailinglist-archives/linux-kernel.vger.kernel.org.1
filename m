Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB9293069
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbgJSVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbgJSVWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:22:51 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD1C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:22:51 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j13so1897888ilc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMROXBh8/6wfGp68AF6x15iBnH3TW4WoaChmpktEEbU=;
        b=fSZdGCjxYBVbF8TdhDZyAQWXjzuL+YrBuE7vJkfCn0gbtKg8TtPaUW8mVSouTD8wOQ
         B42bZLFOHZRF9r0hLglY3YpNot0/hau8jrT5+klwLqC86iVrBkp9cHacpqMMnhQ2eBFc
         9B0u0JENLgbRdGbvXhfDKs2vomcWa7NiIbAEHjq0+NwsesenGhkzQckFbRkgjieYcLcZ
         8g599BhnCgnjVhFwxYSHU0zqYwjP0W8I4mckXDMdLf1Dvetb9P66Gc4rGljUm/ikOQ5p
         dcmEE/CQfN7BiQopTjaGlKvRhrQwQsn8C9r+Kih046QuiyX/uVPUPbh6cgNM4HLoRFPS
         7Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BMROXBh8/6wfGp68AF6x15iBnH3TW4WoaChmpktEEbU=;
        b=nWtfsTcZf3dZHQkcFRg20ZV0VAJwKT4AL6TCQE8Y0G+LgAeNE6//LkuUPr4tRv1FAU
         7za4u8f9sqB/nVTLT0HvD4MwWYRlYM5beARpZxWmamZWCbeJhZIANPU754wTlitCUGUH
         nzrBHxPe+U2Pwc5cx51a3sX6rHqMfnvdKtsXK4oLvHqudN4L8jCTYh0ypLcnyBsgbzHV
         PwMK7ODA8d0it2wTpQBxmDa/NSlU88pIHhwIPmJ6hheeXKJt68yL8NGSQOCV7dxGFcGC
         9VrU0FE7LRVl3XoqLPHC8qg5n/AVLpLVoyB2atd8KbSJ22SRiIlnSRTeKsCXM4wETAn0
         sP8g==
X-Gm-Message-State: AOAM530lOr1pCvPamUw1jyjzhbRIxIJQ/sWIDRXuPBEAX5iLnzK0aEgq
        0wvTKkeSjMUYAd8y492raKw=
X-Google-Smtp-Source: ABdhPJxNNGuh+DqJG+iHb64VqemWNXm9wXk1fpTGxV9BupOJ25bctfUcfUo8FfwECvjXO96LUIXXbA==
X-Received: by 2002:a92:858d:: with SMTP id f135mr1796749ilh.197.1603142570832;
        Mon, 19 Oct 2020 14:22:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c2sm1061853iot.52.2020.10.19.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:22:50 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 17:22:47 -0400
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201019212247.GA2815942@rani.riverdale.lan>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
 <20201019203345.GF3635@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019203345.GF3635@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 10:33:45PM +0200, Joerg Roedel wrote:
> Hi Arvind,
> 
> On Mon, Oct 19, 2020 at 01:00:08PM -0400, Arvind Sankar wrote:
> > On Mon, Oct 19, 2020 at 05:11:19PM +0200, Joerg Roedel wrote:
> > > +
> > > +	/* Store value to memory and keep it in %r10 */
> > > +	movq	%r10, sev_check_data(%rip)
> > > +
> > 
> > Does there need to be a cache flush/invalidation between this and the
> > read below to avoid just reading back from cache, or will the hardware
> > take care of that?
> 
> No, a cache flush is not needed. When the C bit position is correct,
> then the data will be mapped encrypted with the old and the new
> page-table. If the C bit position is wrong, the access goes to a
> different physical address.

Ok.

> 
> > > +	/* Backup current %cr3 value to restore it later */
> > > +	movq	%cr3, %r11
> > > +
> > > +	/* Switch to new %cr3 - This might unmap the stack */
> > > +	movq	%rdi, %cr3
> > 
> > Does there need to be a TLB flush after this? When executed from the
> > main kernel's head code, CR4.PGE is enabled, and if the original page
> > mapping had the global bit set (the decompressor stub sets that in the
> > identity mapping), won't the read below still use the original encrypted
> > mapping if we don't explicitly flush it?
> 
> The check only really matters for the boot CPU, not for the secondary
> CPUs. IIRC at this point in boot CR4.PGE is still off.
> 
> Regards,
> 
> 	Joerg
> 

The boot cpu also enables CR4.PGE -- that code is shared between boot
and secondary cpus. The boot cpu jumps to the first "1" label below,
just before the call to sev_verify_cbit you're adding.

	/* Form the CR3 value being sure to include the CR3 modifier */
	addq	$(init_top_pgt - __START_KERNEL_map), %rax
1:

	/* Enable PAE mode, PGE and LA57 */
	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
#ifdef CONFIG_X86_5LEVEL
	testl	$1, __pgtable_l5_enabled(%rip)
	jz	1f
	orl	$X86_CR4_LA57, %ecx
1:
#endif
	movq	%rcx, %cr4

	/* Setup early boot stage 4-/5-level pagetables. */
	addq	phys_base(%rip), %rax
	movq	%rax, %cr3

