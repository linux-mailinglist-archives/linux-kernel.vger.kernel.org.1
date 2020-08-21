Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDC24DF51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHUSTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgHUSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:19:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D0C061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:19:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v16so1256508plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1UNk1AGGEwhw+lM3t9AwUmUxfOaOF1KAPiPeob9V2WI=;
        b=kMpbG4iRuCojoWkd9Kr7f3KqtxxxnZ10DzhhdpflsKagz8HB7it+PRVF5wN7+8u6I4
         sqBh30VQTJPNbvblPyfm/F9b+BO+6jM1CyemdUgNWau96AHd6FqGN/+ea6xfBpWIWBKp
         hsFaBfhftz0hmT5UiB/RyPDzi3o3unARrGvu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1UNk1AGGEwhw+lM3t9AwUmUxfOaOF1KAPiPeob9V2WI=;
        b=Pu7PTPBqhwdjPYqictJ9/gfk40wVwFPoi3WYZfHh9Ha56/CUYz6GDFs8mqLuSBzhxX
         d6fGD3D7l2Wx0TfgVmyoyuV3NBNuYnOU+PnDeB45rfqNkCZGoImi6MFTSfmjaZUSTBYB
         Y2oimnO2IXMhWJD83cVbs5WFyznsaUPWv2hVHWi+uNCUMJ9QH0Kqa8ZNXfjYkPe39C2X
         1DMUBjIorhxUMxiVCyXNT5VicYZPZCucGYY1erOwNeuwZ/boy5VIu3X6yKQkfSUJ9K5I
         6yd6j6tTiuEQyUA9Pdac/5Gi9pmyDYgccMEmoGJV8oqv9I78HHi7pJCR2S+2K2r+C21P
         m4Ug==
X-Gm-Message-State: AOAM530yakFEmfe1RyQmi9xWPP6eTItY4pu3nd2/HcrnpFkD3nRi4o28
        4Et77KvmkAndC9FIXxAegpZMBw==
X-Google-Smtp-Source: ABdhPJzZTS1JRIXsH9Qe8ywfl5m5EX+fz/bw1Bxes5X8MeXUUxEITYki8dcePvVFwXnhyN1uHyj01g==
X-Received: by 2002:a17:90a:c0f:: with SMTP id 15mr3438069pjs.193.1598033948161;
        Fri, 21 Aug 2020 11:19:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm3316084pfq.118.2020.08.21.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:19:07 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:19:06 -0700
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
Message-ID: <202008211113.F872C40ED@keescook>
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

That's a good point, yes. I will adjust this.

> The only section for which there might be a point is .got.plt, which is
> non-empty on 32-bit, and only if it is first moved to the end. That
> saves a few bytes.

Yeah, also this. :) I will try it.

-- 
Kees Cook
