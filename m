Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5E254D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 20:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgH0SmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0SmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:42:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268A2C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:42:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so4179945pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BmbfAVxRe/F8iiJt3iISrZyB/d5knaBHzvOCP4+rex4=;
        b=YDvG6dnGAicsmO1S1KW8632GTesg0wpMPEKYvHU4H5dajTuG6V0INqsMkJ3IP4o04D
         WgBCjB53TWPkWpcwQxVtGgTUQt1F6WwDZ/BrRagy1KclNKfouGGR5QCkjmRGWYjkIIEH
         X1SkJmCPHN6+FNE2DmmXHuNZggU50vrZPtoeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmbfAVxRe/F8iiJt3iISrZyB/d5knaBHzvOCP4+rex4=;
        b=rj6hOKBfTmyvPe5WpuuIgtNQ3P0LJzTZAXYWDcBnXhYcCopLZnEVzY92n7DZxTnJtu
         C9ctNENIK1aqxAuxF5XqTgFzE4D5agOE87yNCt8OY1pJYcA6Faoiolaup36I8EOiEpwv
         Mp9Xs7XOYgNMwdTVEVN+zubPZUH7t+w/0MhcTybWRBgkZZnkDozCZnxL/s4v9JSvJ6Vo
         Nqe/eNK87Sm7+oJrVqrWcyhWHERyyiihNVJ2JID4HhSJOmZtjKl3P1QK13GqLyqZXEqr
         0upTav/lD2z9hra4bTmpX8ZzfgR7qiE4fZECyKkzCulnBrj8NWJLwAXuq6TNtdu923Me
         AFrQ==
X-Gm-Message-State: AOAM530oFVru13SzHhEzE3j1wl9JLv88UZhJ6uIptr5NyrwPI2K/GcRa
        S7fTIUB0gr5c+2FCbgJHIhhQLw==
X-Google-Smtp-Source: ABdhPJwbCsIW6xG7Bh4T+x733pBXLgOLKeN8eYBtrpfpSZf44srCc7oQjNjkjGvZxLdRmcJ6y6gVAw==
X-Received: by 2002:a17:902:c689:: with SMTP id r9mr11455864plx.275.1598553729557;
        Thu, 27 Aug 2020 11:42:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e127sm3555948pfe.152.2020.08.27.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:42:08 -0700 (PDT)
Date:   Thu, 27 Aug 2020 11:42:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
Message-ID: <202008271138.0FA7400@keescook>
References: <202008271145.xE8qIAjp%lkp@intel.com>
 <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com>
 <20200827082447.GA3185@gondor.apana.org.au>
 <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
 <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:55:32AM -0700, Linus Torvalds wrote:
> On Thu, Aug 27, 2020 at 10:34 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > How are you guys testing? I have UBSAN and GCOV on, and don't see
> > crazy frames on either i386 or x86-64.
> 
> Oh, never mind. I also have COMPILE_TEST on, so it ends up disabling
> GCOV_PROFILE_ALL and UBSAN_SANITIZE_ALL.
> 
> And yeah, this seems to be a gcc bug. It generates a ton of stack
> slots for temporaries. It's -fsanitize=object-size that seems to do
> it.
> 
> And "-fstack-reuse=all" doesn't seem to make any difference.
> 
> So I think
> 
>  (a) our stack size check is good to catch this
> 
>  (b) gcc and -fsanitize=object-size is basically an unusable combination
> 
> and it's not a bug in the kernel.

Do you mean you checked both gcc and clang and it was only a problem with gcc?
(If so, I can tweak the "depends" below...)

This should let us avoid it, I'm currently testing:

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 774315de555a..24091315c251 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -47,6 +47,19 @@ config UBSAN_BOUNDS
 	  to the {str,mem}*cpy() family of functions (that is addressed
 	  by CONFIG_FORTIFY_SOURCE).
 
+config UBSAN_OBJECT_SIZE
+	bool "Check for accesses beyond known object sizes"
+	default UBSAN
+	depends on !COMPILE_TEST
+	help
+	  This option enables detection of cases where accesses may
+	  happen beyond the end of an object's size, which happens in
+	  places like invalid downcasts, or calling function pointers
+	  through invalid pointers.
+
+	  This uses much more stack space, and isn't recommended for
+	  cases were stack utilization depth is a concern.
+
 config UBSAN_MISC
 	bool "Enable all other Undefined Behavior sanity checks"
 	default UBSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 27348029b2b8..3ff67e9b17fd 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -7,12 +7,15 @@ ifdef CONFIG_UBSAN_BOUNDS
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
 endif
 
+ifdef CONFIG_UBSAN_OBJECT_SIZE
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
+endif
+
 ifdef CONFIG_UBSAN_MISC
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bool)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=enum)
 endif

-- 
Kees Cook
