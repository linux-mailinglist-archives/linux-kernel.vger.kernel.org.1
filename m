Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB424E29B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 23:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHUVVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 17:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgHUVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:21:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7AC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:21:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so1677778pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zxJLsKDKPmlEOdAqEaMs/th95WQoPa5KmWk+Z1DjV8=;
        b=Z6d0JADM6ZgtFdmHVXm5tWDcsc0z+xRwVRI6J5P0qu7Wh8Wlh8hMqrvoVoPHscBSX5
         BPn31oZ1h8KocB9ca3F8q5MQ2YsQ1iVfBeigGJPS6Yoy6p0Po4/KSMrywwADhAagcgS9
         igh0vRz/eRmU7KOg9mT0Sb0Co7agth6mO4CkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zxJLsKDKPmlEOdAqEaMs/th95WQoPa5KmWk+Z1DjV8=;
        b=Q2iHnjn5Bb8pJzcN/Iyb/jI9+l4uHrgaDWLfrUESDwOlsn1KtQh6IaEud8/ZuDl7y7
         jXLICr7rVq6nxgecL8P4otkMEAahXvsONUwmn0wKempiD5THYSETjC7Tfu4n3ihMg54Y
         xGse0GdhdqrSknb7a7M+fAjF6cfABa8PI/Bv8ADGuPUBSaL5RaPgQAH/9/+X6+5+7Fre
         n/8HlM5X7jcSxy0LcQLtsoA+fdyP2RinAh65uSA+nZwIRYT5I4dpB5YT9FwKA5VoAasI
         lOz4vUxVmEHcjSccasF/Hyvmc3oJdP/gORfM0Miyd0D/gq5OYmUVfST1is4QJDwFYVp7
         qcmg==
X-Gm-Message-State: AOAM532ZWKaN9ob6ln6m+rB9eEftECVq0+Mg/Czc/ThmwHvLo7xbjCHI
        Y8t6+NtIoewoPpkkaFA3SPbvlA==
X-Google-Smtp-Source: ABdhPJwlauw3d/VbXEWNPYofZtpxXF3lSoJiQEDnVGrlctpzlU0ciKIkShtT/G6ZiVpcxESPW34GqQ==
X-Received: by 2002:a63:7550:: with SMTP id f16mr3613147pgn.118.1598044896892;
        Fri, 21 Aug 2020 14:21:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m22sm2843446pja.36.2020.08.21.14.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:21:35 -0700 (PDT)
Date:   Fri, 21 Aug 2020 14:21:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH v6 27/29] x86/boot/compressed: Remove, discard, or assert
 for unwanted sections
Message-ID: <202008211421.47347CA42@keescook>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-28-keescook@chromium.org>
 <20200821200159.GC1475504@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821200159.GC1475504@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 04:01:59PM -0400, Arvind Sankar wrote:
> On Fri, Aug 21, 2020 at 12:43:08PM -0700, Kees Cook wrote:
> > In preparation for warning on orphan sections, stop the linker from
> > generating the .eh_frame* sections, discard unwanted non-zero-sized
> > generated sections, and enforce other expected-to-be-zero-sized sections
> > (since discarding them might hide problems with them suddenly gaining
> > unexpected entries).
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> >  	.rel.dyn : {
> > -		*(.rel.*)
> > +		*(.rel.*) *(.rel_*)
> >  	}
> >  	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> >  
> >  	.rela.dyn : {
> > -		*(.rela.*)
> > +		*(.rela.*) *(.rela_*)
> >  	}
> >  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> >  }
> > -- 
> > 2.25.1
> > 
> 
> When do you get .rela_?

i386 builds, IIRC. I can try to hunt that down if you want?

-- 
Kees Cook
