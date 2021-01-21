Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064472FE09F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbhAUE0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbhAUEZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:25:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:24:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id g15so791766pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ruSWkvxK7Tj2d5WiCdrWnjESQKPua96iUP2imnkCtM=;
        b=thRPG2ixZmZ5O9C8k8fShWS7WfDE3xez0UCXRdEywxhpqP2n5AUYErMXBPaKP903eH
         5PO5YVhsoMJcXps5uTI+g6ffOL/xILzU3V1zsedKiyB2hmr0gdCaibu/Ffv+3MOdHHhy
         L9EX/M7YBMhmots7hLdQGUUWEae3D3M0SmMxHMraAcBUusLDWsilyDBMGqpr2rkevARD
         SDSL28jNtovi0Zm0ZBGtkaSBijGYe77W98I4zSarrrL3C7iQYT+MZtn0nNHvqMs7wSyS
         A6VfLsOZOaf/cqnkg0tUSe9NJ76BOBW5b7/xt9JEs0PH1T0v+L8yzx2hPoScubnGVNTK
         lyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ruSWkvxK7Tj2d5WiCdrWnjESQKPua96iUP2imnkCtM=;
        b=hSqSUry2w7zDxkqCKMSjw1dPHIbIAMp4gxZu6QgDDEkg8dc8eck418zmOC249wg8gU
         ZMOE+DS6R9vp+S1VNKrGkicgzOXvgiBYWPxFpIH2qtc616S7dHFUFM8qJDhzcok+SjrL
         SFevMH8awkSa76eEfG+/nCGLWmrzKKyGit3819SnwbZkaQctxz/k8yc9VxlOFnDxqcAb
         ZdpcQpJEerbC2YkmjIx9l6Wzs6lRpscmI+5ghwXX1expcsD+9nIt8zE6M+L06A5qqbcX
         tgjkWDwrbUeac/QwdX4Q/4VXGTRvCDJRPODEKwxk3MNf+LiuQFADseruB2XDpGueQPaY
         jc1w==
X-Gm-Message-State: AOAM531EaXSmINAZy0PORWpO0NklCkAp3AT/HPgzfz0Xo9NiZRhFY5cQ
        lgXJrI1gBoOI9LXl0UYrgpdQMHpRVi4ZxX86Bretig==
X-Google-Smtp-Source: ABdhPJyQ/UYu8hH0zEEM+kuMCErzeP3MEmB5zWNtA1Ixe5qMBCuatVII84KHwmAAEweYzUXyS1G6YbWIn0upb00TnZ4=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr9279888pjf.25.1611203080496;
 Wed, 20 Jan 2021 20:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
 <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
 <CAKwvOdnVwkxQTQ-LkdZi4pFWTMg6d0Lddddp=j4pCEh-JT-34Q@mail.gmail.com> <YAj/VBzbRaBy7zLv@rani.riverdale.lan>
In-Reply-To: <YAj/VBzbRaBy7zLv@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 20:24:29 -0800
Message-ID: <CAKwvOdkLuVBzyvOxHR6SRz8qd3xyLzXsuMc=wnK2bEG5T_RWRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 8:13 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 20, 2021 at 03:09:53PM -0800, Nick Desaulniers wrote:
> > So I'm thinking if we extend out this pattern to the rest of the
> > functions, we can actually avoid calls to
> > kernel_neon_begin()/kernel_neon_end() for cases in which pointers
> > would be too close to use the vectorized loop version; meaning for GCC
> > this would be an optimization (don't save neon registers when you're
> > not going to use them).  I would probably consider moving
> > include/asm-generic/xor.h somewhere under arch/arm/
> > perhaps...err...something for the other users of <asm-generic/xor.h>.
>
> We can't directly do the patch below since there are other users of the
> asm-generic/xor.h implementations than just the neon file.  If it's too
> much work to check and add __restrict everywhere, I think we'd either
> need to copy the code into the xor-neon file,

Yes; I'd rather copy that code into xor-neon, or someone under
arch/arm/ at least.

> or maybe do some ifdeffery
> so __restrict is only used for the neon version.

-- 
Thanks,
~Nick Desaulniers
