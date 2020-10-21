Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAA2954C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506692AbgJUWZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506685AbgJUWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:25:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79633C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:25:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so2311677pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8CEok3vbung1AhO88Lhvw62MF/+SVjC5VIcNaMPw5U=;
        b=BK+E+wakdfwRJnfLmhs+U8gNDHtfVkmV8MwmMTNQBCrrzVDkj7VhHf17LARBZFuEb3
         E0ScuwvnzzhWRNSRmXbt7TxDtSs+coXad7+mfzEn+yXG3JO8v1tLcnQpfzLw7cOhDofY
         LJnTlvzhlD/YDRok08DlAFHJsccc8D8N4FL0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8CEok3vbung1AhO88Lhvw62MF/+SVjC5VIcNaMPw5U=;
        b=F0mwIOaSRw44FItTu8S2j+x6nMMXmlbCSmLFiFy9RpRnW+L97/L59ldos5pV/xAyj1
         QS529BV3wb1VOrMWG5M3z97wUrrfCfEZL0tbwPLLOSuceC5s1UEN+0xMytODLDYiYZzJ
         03ZqCOUoV9uX5pyq88NECCi6Ppawj5ykzskkZfJE6PxgvPWDMdfmPAGiJ+A3+1Yrx9Hm
         54MjBJFE/07KT4Iqq2LFa2vK88noygyHh8ZFiBBGRQhL7TRDxME8Lt5wlgheumfEVWj7
         cmSWqDCcz3DPyHj3iCxvyI2baMoc11gTF9bRUnCTjoySbL8VGaYP0ZZszFFw2vyFEkNK
         pEKg==
X-Gm-Message-State: AOAM530szPAp1JaJjlw2FQKZ3tDpNt8WTd7cXIWuqm/lvYxHNyyNlqQq
        5J/JcqO8zZb6ZDAiQeAsmO9+YA==
X-Google-Smtp-Source: ABdhPJzWSs3xtfa1F0UBSrMOTHHa9ICC8KdPaaqaPc5Uxe5EBdyA9sAepRMnw6mmT4BKn2PgWqIMaA==
X-Received: by 2002:a05:6a00:15d1:b029:155:5c2c:c28e with SMTP id o17-20020a056a0015d1b02901555c2cc28emr83051pfu.3.1603319108059;
        Wed, 21 Oct 2020 15:25:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20sm3126932pfn.39.2020.10.21.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 15:25:07 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:25:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <202010211523.EC217C9@keescook>
References: <20201005025720.2599682-1-keescook@chromium.org>
 <202010211303.4F8386F2@keescook>
 <20201021222215.GC4050@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021222215.GC4050@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:22:15AM +0200, Borislav Petkov wrote:
> On Wed, Oct 21, 2020 at 01:04:35PM -0700, Kees Cook wrote:
> > [thread ping: x86 maintainers, can someone please take this?]
> 
> $ ./scripts/get_maintainer.pl -f include/asm-generic/vmlinux.lds.h
> Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
> ...
> 
> so that's Arnd's AFAICT.

It was a fix for the series Ingo took, so I seemed sensible to keep it
together. Though at this point, I don't care who takes it. :)

Arnd, do you have a tree that'll go to Linus before -rc1?

-- 
Kees Cook
