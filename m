Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47322350AC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgHAFfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgHAFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 01:35:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A710C061757
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 22:35:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j20so15484084pfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBcnbrjbFajVyHxfld/Fszj/ZWv73cYyddExdUQ2/uM=;
        b=cFCUN8WXYxpQmHqvnAsD23Rv5tXKfwQzwAyoxQ1/JYow58GgNyXFPX7XCri2QGRyOz
         fMUDsZUFNJ1c3ZWyB9hIi75jCK6E730XjbidYpIfiKW9JQgUuI+PdO+zmUr54szeh1Sp
         bAMamjFO4xz22zoSMDGpRAWZ5EifvoT6RMeQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBcnbrjbFajVyHxfld/Fszj/ZWv73cYyddExdUQ2/uM=;
        b=JZI5zfDbvKpJ/YFA8wygM+zqIbqC7vGkaJIJ8lTAP7V2XoiWDWUwEbKEBY2tmUj/kd
         RTKF+CuiHChkmNDawUOQznU/vuLQzfePaQoNO2qM6qybodDTtscXZNGpYOSZxRV3MJG1
         GwAYISAvdAOaINT1BstZaHnFS/qLY69mo8egSaKTqg0s+LkE2MaZZoDbOZZSPUUtr/IZ
         u9x9noUc0W/jFol83J9KLIuLKtCInYrowisp18+4WyOM2kZFs4GiGU3khAR/QG3suE+2
         FcFZ7MV/AHoHXLAjSkJyQyOsT+L7aBF2VWNHMN03io2v0vfMPivBxldI9ynHwZQ5jjNF
         MKCA==
X-Gm-Message-State: AOAM531CvtB+4AV5invfTadVEqKSY7uU6mqLNqA19cDkvabfGBllViwI
        sOCltMDSwOptGXEg9wKq1+cEJA==
X-Google-Smtp-Source: ABdhPJzmUkHyL0osdBwrYpqVmxuELT6zFultPsT6Drkr31FLEpKF10iLb5ALASMh1jJ636fIC2pkxQ==
X-Received: by 2002:a62:164a:: with SMTP id 71mr6825401pfw.266.1596260115966;
        Fri, 31 Jul 2020 22:35:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i21sm12412582pfa.18.2020.07.31.22.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 22:35:15 -0700 (PDT)
Date:   Fri, 31 Jul 2020 22:35:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Message-ID: <202007312233.1BA0E2EFC@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801014755.GA2700342@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > For readability, move the zero-sized sections to the end after DISCARDS
> > and mark them NOLOAD for good measure.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 3c2ee9a5bf43..42dea70a5091 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -42,18 +42,16 @@ SECTIONS
> >  		*(.rodata.*)
> >  		_erodata = . ;
> >  	}
> > -	.rel.dyn : {
> > -		*(.rel.*)
> > -	}
> > -	.rela.dyn : {
> > -		*(.rela.*)
> > -	}
> > -	.got : {
> > -		*(.got)
> > -	}
> >  	.got.plt : {
> >  		*(.got.plt)
> >  	}
> > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > +#ifdef CONFIG_X86_64
> > +	       SIZEOF(.got.plt) == 0x18,
> > +#else
> > +	       SIZEOF(.got.plt) == 0xc,
> > +#endif
> > +	       "Unexpected GOT/PLT entries detected!")
> >  
> >  	.data :	{
> >  		_data = . ;
> > @@ -85,13 +83,23 @@ SECTIONS
> >  	ELF_DETAILS
> >  
> >  	DISCARDS
> > -}
> >  
> > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > -#ifdef CONFIG_X86_64
> > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > -#else
> > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > -#endif
> > +	/*
> > +	 * Sections that should stay zero sized, which is safer to
> > +	 * explicitly check instead of blindly discarding.
> > +	 */
> > +	.got (NOLOAD) : {
> > +		*(.got)
> > +	}
> > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> >  
> > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > +	.rel.dyn : {
> > +		*(.rel.*)
> > +	}
> > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > +	.rela.dyn : {
> > +		*(.rela.*)
> > +	}
> > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > +}
> > -- 
> > 2.25.1
> > 
> 
> There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> passed, they won't be present in the file at all anyway.

I did not find that universally true. I found some sections be written
out with a 0 size. Some I could remove from disk with NOLOAD, others did
not like that so much.

> The only section for which there might be a point is .got.plt, which is
> non-empty on 32-bit, and only if it is first moved to the end. That
> saves a few bytes.

What do you mean about "only if it is first moved to the end"? Would it
be zero-sized if it was closer to .text?

-- 
Kees Cook
