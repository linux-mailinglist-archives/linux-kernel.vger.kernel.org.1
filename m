Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B663293ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408145AbgJTOdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408012AbgJTOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:33:18 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4946C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:33:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j13so2507553ilc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jj9glYe0gvbVcAodw3qv6Kp672I6hibQ7u2mjdDL0BQ=;
        b=FDIUTpY+EczYabB3zudGGYlm2bXqozLmyLzyoExIYHR74w7QRpS4sJspfDnhCBQCrZ
         rDd6xn+vxM6k6oRSHVwJXr3Oy8ZpCNUJNYIDIYgK1AMsFVKsONCeeVXSgJk7Y08FTrWA
         iA0AT8GwhxKQG/+b2KElJWMiC7kHIBANpiJlNLyRM1bDcROLideHgki/V5BsFGYhldei
         dLfg8wswxwhDzKBZu9wAGVCHSL81rzqFqwU0QfNbvw3d9OKPqvQWF3BkCvQDW+dyeuSh
         yiSy+cbks/hvdd8CPM6hXenTJqxHoKLjeA5yunkUiPruWS+V5aBNkaPvnhnHHitc+3NK
         4z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jj9glYe0gvbVcAodw3qv6Kp672I6hibQ7u2mjdDL0BQ=;
        b=bq7Bb2l8ionPii3MKw0d90rn5xK0P1pU/DhkzfbgQ5eC0fsZF2P9DV4nV91HStN2JH
         0N4lZRhbuY8f6mOiAQ/6lCiAcMgium2r48NwPKTiAB84DMJNuNufgacRKyEQL5YWpNjl
         B6vRCEqKU3AnsBjcE4Eyu5bWt5u0ubUhYTQQusdRWbRGFggF1HsGfR0t+Nw0YhAJwNJv
         QC+JDnJcJzVkfTZoGUvqwWpYrzZ07SA/bB+MicExLVfaGOZY0PgLG25i1aJaD4ZDWg+c
         3scGWMLIsuUeVU+aNyLRJGR+QqUr9gSHFYtNsgP+eNcaRxoAd3A8Uxj99MgZPpbQPKuY
         E3fA==
X-Gm-Message-State: AOAM5322byL5iL6/nAV2tg+Mcg+9sPWnD5E/nkM+94SBzdpEwFq3BLZc
        Vlj90ZjV21Zj74FTKnDqips=
X-Google-Smtp-Source: ABdhPJyYF9qRrSJYkXVPlgaKnxArlTa7yCTr5aX9oZ+hVDLUhiaThsqvbF3cotHBSetaSWUETWVayA==
X-Received: by 2002:a05:6e02:4c8:: with SMTP id f8mr2034088ils.159.1603204396133;
        Tue, 20 Oct 2020 07:33:16 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d14sm1820275ila.42.2020.10.20.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 07:33:15 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 20 Oct 2020 10:33:12 -0400
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
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
Message-ID: <20201020143312.GE2996696@rani.riverdale.lan>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
 <20201019175447.GA2720155@rani.riverdale.lan>
 <20201019203935.GG3635@8bytes.org>
 <20201019213106.GB2815942@rani.riverdale.lan>
 <20201020085957.GF9328@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020085957.GF9328@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:59:57AM +0200, Joerg Roedel wrote:
> On Mon, Oct 19, 2020 at 05:31:06PM -0400, Arvind Sankar wrote:
> > Is it possible to take advantage of this to make the check independent
> > of the original page tables? i.e. switch to the new pagetables, then
> > write into .data or .bss the opcodes for a function that does
> > 	movabs	$imm64, %rax
> > 	jmp	*%rdi	// avoid using stack for the return
> > filling in the imm64 with the RDRAND value, and then try to execute it.
> > If the C-bit value is wrong, this will probably crash, and at any rate
> > shouldn't return with the correct value in %rax.
> 
> That could work, but is not reliable. When the C bit is wrong the CPU
> would essentially execute random data, which could also be a valid
> instruction stream. A crash is not guaranteed.
> 

That doesn't feel like a big loss: if a malicious hypervisor wanted to
induce completely random code execution, it can do that anyway by just
messing with the guest-to-host translation, no?

We would need to avoid calling this in the secondary cpu startup, I guess.

I was hoping to be able to clean up the identity mapping in
__startup_64(), which currently maps the entire kernel using wraparound
entries, to just map the head page of the kernel, since AFAICT nothing
else is actually used from the identity mapping after switching to the
new page tables. But we'd need to keep it to support this check.
