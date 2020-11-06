Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B352A9B84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgKFSDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:03:14 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:03:14 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h12so1363909qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1CcGa5j+LtJL5zURX6fDA5w3O8+Vz5UmqHSHkyTHyI=;
        b=M24HNHlp2Av/ocP/HGwx3Kfvpq/m2n7nwu3HWio44Ma0zLCwSG6KK+jBNEjW2t/mVc
         2dV1A4AFVHInwbI8eMn6R6RRtsPKyWNYfCrhRhF11AixmfINzps6OPhE4oHI8EQnk/yh
         d/ei6kv7tzW/15vtjRB8bMBp2+VOjdO5JHzcUsyB8LkmzR8/vVizjzUfn+P34qnbsndo
         1pX6jGKVxX/8WuJv/PiD5dUFlR6JJgiF0KFnMLtqEOJzWxVDVWHjRRRt0gNHpvU54EE1
         nSwxyMX1hlW+bStOrKd2jY3KUvWtXxJV291FDH8f9MXg4kz4rZfdx/i54l9jjMMLA7Fg
         4Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1CcGa5j+LtJL5zURX6fDA5w3O8+Vz5UmqHSHkyTHyI=;
        b=qtJ/+x58Xw2koYhAHgESOEyjuDC6ELk1qSZ/aapDCMl5/mIszjOB/6OCnZG//O+Wuv
         p5XoymYm4UMFHYXVLXBgVy0npsN6Z3YXZoww9sGRWNoLRxOYRAOvoj2n2lFHPp8cNfYr
         sBMcfsz3LhVDsSSoYiyhTAz8AVOh7eLXQU1F3tROLEZMZw/VgH+n7zkleWxQ6pOl4EsF
         bC5zvA2cutWsTyAPw7g0rddbsLBd6KVcVeeb62emnmo6J4bHaPkV+DmO9jH9J+uT3ZJj
         ah2y5qg1HWNBZ+gXzTo9ygaTiZkf9YcPwf78Us0f4I9OgYva0m6liQniIOMhAKiPuIXF
         /AqQ==
X-Gm-Message-State: AOAM532ODioM2AwukvE/FMJTRXPh3vYjm1G/exVoGKhqL9lFL0M0g6hy
        j2bl3DAhy4QtfFF8ic8c7PI=
X-Google-Smtp-Source: ABdhPJy7PvOTlP6z2fkw7p/r4ZDxeOC9ZDf7brV+12OHkv0igghG75GEiUiDfAngXmxe30fv56Oeig==
X-Received: by 2002:ac8:705b:: with SMTP id y27mr2626562qtm.192.1604685793651;
        Fri, 06 Nov 2020 10:03:13 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id d18sm996591qka.41.2020.11.06.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:03:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:03:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
Message-ID: <20201106180311.GC2959494@ubuntu-m3-large-x86>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-2-adrian.ratiu@collabora.com>
 <CAK8P3a0kXkoeAbNiPH5-7-73V2nAsnCMkQSrPZq4ysVYNyE-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0kXkoeAbNiPH5-7-73V2nAsnCMkQSrPZq4ysVYNyE-WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:46:36PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 6, 2020 at 6:14 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> >
> > From: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Drop warning because kernel now requires GCC >= v4.9 after
> > commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> >  arch/arm/lib/xor-neon.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > index b99dd8e1c93f..e1e76186ec23 100644
> > --- a/arch/arm/lib/xor-neon.c
> > +++ b/arch/arm/lib/xor-neon.c
> > @@ -19,15 +19,8 @@ MODULE_LICENSE("GPL");
> >   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> >   * NEON instructions.
> >   */
> > -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> > +#ifdef CONFIG_CC_IS_GCC
> >  #pragma GCC optimize "tree-vectorize"
> > -#else
> > -/*
> > - * While older versions of GCC do not generate incorrect code, they fail to
> > - * recognize the parallel nature of these functions, and emit plain ARM code,
> > - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> > - */
> > -#warning This code requires at least version 4.6 of GCC
> >  #endif
> 
> I think we still need the #else path, otherwise we don't warn about
> clang being broken here.
> 
> If it is intentional that we now silently build this code with clang
> without it working as intended, that should be mentioned in the
> changelog.
> 
>       Arnd

Maybe patch 2/2 should come before this one? With that patch, we are not
even going to build this code so this patch purely becomes a "we do not
support this GCC version anymore" cleanup patch.

Cheers,
Nathan
