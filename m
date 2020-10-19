Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A963C292C60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgJSRNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgJSRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:13:03 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81892C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:13:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p16so950024ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RDu94x4BYZJnG/qs56Rfu0KDVan1/VqP6NcDqGm6Sw=;
        b=n8PqptnwPe6qFuVdJc5Yfdz9JyHNfdnLoogUqqiHeZwGNRhJdMcRXIsp9hr21hkH9R
         d3eM9aevySrDxkwgIQQO7Ag0ZXmoTI928AQE6x5og+in2qzDhBhDdFouqOO/WGCstBLD
         srVA5CqOXqOINtOhh52y2YtigPi2ZhPfRzpz3GI5dH5j0Yb2Qnj3Cv6RWc/AKrUzA7Hb
         zq2BD86JF1xf56/dDxOTaK7DZzTict8Zd+PuwU9k9txhZ+4oZgPIEvmQAtTbHPCrJVeC
         ct2GDBvAyjswK534ilkug7IYDXlSUkZiXYhPEZxZcTi0TYdi0jwvcDqSe3WV12fGnaPo
         +DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5RDu94x4BYZJnG/qs56Rfu0KDVan1/VqP6NcDqGm6Sw=;
        b=Jnx4N3yXWn9rl6+ytgjoJGmf8Xgi3MnyOltGzG+rPHEXoImskMOjgb12W7k4sIHgUk
         vJPezlim4uFoUGbNroW7YC1ezpdejIxFHeep118s+YylO6yCMUkupdZ0CvFM0Z1K1M2M
         9KA3GajbetJGbfuz9vZRjJ8tQoK8iN4CoHhRRnEnul29AW0HOU9rnFZcUXFbZ7XEa8vZ
         +qXhKZfG1Q2U9sLLBoPqzf3BSh2YnT4JsjoNghEF7qGpZcRBZ0VT6vVEtqDUuh3hiLxh
         7nERu8fhB/Unmv4kvl9+StEzaNaNtjLEYBll2sjqFHHpNLsf8Lo2LZ7BEy3Yfmf8s8NF
         hZgA==
X-Gm-Message-State: AOAM530otJ0ttLCcR5/CWxC7WWdF8HktSigNiMF2b9KngcF7vNLn7VcA
        VisBtSgWZgWaWdLSsDRqL/4=
X-Google-Smtp-Source: ABdhPJywHLMkAUMZ6jYk+Gmv6jDg0VYRPSZinQb2gMX+QqRu5xHS2GXIpD0ALkctEW21UzF9ciBEHQ==
X-Received: by 2002:a92:7742:: with SMTP id s63mr855535ilc.74.1603127582768;
        Mon, 19 Oct 2020 10:13:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r17sm332509iov.7.2020.10.19.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:13:01 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 13:12:59 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201019171259.GC2701355@rani.riverdale.lan>
References: <20201016173232.GI8483@zn.tnic>
 <20201016200404.1615994-1-nivedita@alum.mit.edu>
 <20201019145115.GB24325@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019145115.GB24325@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 04:51:15PM +0200, Borislav Petkov wrote:
> On Fri, Oct 16, 2020 at 04:04:01PM -0400, Arvind Sankar wrote:
> > Commits
> > 
> >   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> >   8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in KASLR code")
> > 
> > set up a new page table in the decompressor stub, but without explicit
> > mappings for boot_params and the kernel command line, relying on the #PF
> > handler instead.
> > 
> > This is fragile, as boot_params and the command line mappings are
> > required for the main kernel. If EARLY_PRINTK and RANDOMIZE_BASE are
> > disabled, a QEMU/OVMF boot never accesses the command line in the
> > decompressor stub, and so it never gets mapped. The main kernel accesses
> > it from the identity mapping if AMD_MEM_ENCRYPT is enabled, and will
> > crash.
> > 
> > Fix this by adding back the explicit mapping of boot_params and the
> > command line.
> > 
> > Note: the changes also removed the explicit mapping of the main kernel,
> > with the result that .bss and .brk may not be in the identity mapping,
> > but those don't get accessed by the main kernel before it switches to
> > its own page tables.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Reviewed-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  arch/x86/boot/compressed/head_64.S      |  3 +++
> >  arch/x86/boot/compressed/ident_map_64.c | 24 +++++++++++++++++++++---
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index 1c80f1738fd9..3976b4e92e1b 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -544,6 +544,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
> >  	pushq	%rsi
> >  	call	set_sev_encryption_mask
> >  	call	load_stage2_idt
> > +	/* Pass boot_params to initialize_identity_maps */
> > +	popq	%rdi
> > +	pushq	%rdi
> 
> Any reason why you're not doing
> 
> 	movq    (%rsp), %rdi
> 
> here instead?
> 

No real reason. This will disappear anyway in the cleanup patch.
