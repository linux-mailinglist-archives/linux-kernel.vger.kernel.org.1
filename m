Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647CD2CF85D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgLEArW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLEArV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:47:21 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4676C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:46:18 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id o9so4914171pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=asXm/R3o12OEmZ60Ws/uh356OUWd4t72k3bkv592RHE=;
        b=DY8G/wumOi8WFxOcM8igIyidUriMkzLro07dT8Zq56ZkDkc9WjUuKHNtbDGeVn3kRY
         NE4X0tuVH9VcrOWVXUsuapHiH0T2lhDCax/1YxRW6oxPvDUlF5xia+Hju6QWJEP3PU0f
         FQI9j7hZ5docHhF+YmcUVaa/bErPUfoQF0CJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=asXm/R3o12OEmZ60Ws/uh356OUWd4t72k3bkv592RHE=;
        b=j6efarWUprh+oMX53ARZDoTRm2eY+HiHeKp9nocbNggShz1zAxva8PHuToKZGXy8ou
         GbXt0j+ouV3EOidkye755DcgVE/k970us7WserjREKsUOt4WIiM3jT553lqukqyecV8G
         YTiAjYwczP+7wIfhFRusSxR3ZKfTxk87trLGXCDcQL9jLKJfC3wkKVwDj/eGrRTxZ2XT
         rn1C0gixb5eLvCCyM69ovhMU1PSbmNCM0NhoAIr21KlLtZxxT8lf3W29O9avAVGPrv11
         G89cloMy578vtUL2jiJIA17kfM7KU7yP5maf+d7TbVxge7KQOAeq90zvz2vg2QThHfok
         OSOA==
X-Gm-Message-State: AOAM5325NvIOFsbUymz1HhTOeTObfHvXunOostY6/DUnruZhz1ST7PVN
        Ey6PCc3kUm7Xpt7sEN7SfSKgNw==
X-Google-Smtp-Source: ABdhPJxGNJvhgaodaFR511VAmyZzwkchxtKWG/VptJKY/whiIgAhDvSFYHmzS4PmYtLBh7/7ICECPg==
X-Received: by 2002:a62:27c3:0:b029:196:63f6:cfac with SMTP id n186-20020a6227c30000b029019663f6cfacmr6132838pfn.75.1607129178208;
        Fri, 04 Dec 2020 16:46:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k189sm6844098pfd.99.2020.12.04.16.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 16:46:17 -0800 (PST)
Date:   Fri, 4 Dec 2020 16:46:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Popescu <georgepope@android.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] ubsan: Enable for all*config builds
Message-ID: <202012041643.CB4EEED17@keescook>
References: <20201203004437.389959-1-keescook@chromium.org>
 <20201203004437.389959-6-keescook@chromium.org>
 <CAK8P3a1Br8JFJX2PxyjVxMPMhi-y8mxf+vdEAZQq_Wm2wYP7ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Br8JFJX2PxyjVxMPMhi-y8mxf+vdEAZQq_Wm2wYP7ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:51:40AM +0100, Arnd Bergmann wrote:
> On Thu, Dec 3, 2020 at 1:44 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > With UBSAN_OBJECT_SIZE disabled for GCC, only UBSAN_ALIGNMENT remained
> > a noisy UBSAN option. Disable it for COMPILE_TEST so the rest of UBSAN
> > can be used for full all*config builds or other large combinations.
> >
> > Link: https://lore.kernel.org/lkml/CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Have you checked if this has a notable impact on allmodconfig compile speed
> with gcc or clang? I think I've seen significant increases in build times before
> with this, but I don't remember the actual magnitude.
> 
> Making it 20% slower would probably be ok, but making it twice as slow might
> be too much.

For an x86_64 gcc allmodconfig before, I was seeing around 6m2s. After,
I'm seeing around 6m17s, so that's about 8% longer build time.

I will double-check clang...

-- 
Kees Cook
