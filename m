Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F8F2E8709
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbhABLYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 06:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbhABLYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 06:24:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30CB207CD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609586617;
        bh=QkAtYWKA5NhUKSgBrKt3Um+b8JsODNS1rc7ga3g5SHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgATpEfsWXamt8ySvK2iYAfXRczn34Y0UgUZBPJY0UgZw985oNTVaoG4BbULlRBIB
         Q9aBTTWNjizwgF6gud7fLYsnjPbMpCKKo6KZLIPRcfdqQtm1tci3FlaHL/vTiPHgcU
         q9ePbNvQj2p4CHa/KmdSuKFzELGx51O1Khdy6YK3xlEa35zO1NpHFmghjWmg8sqh0n
         b36unRniR0uJ3IvEuAJ1+vtDqez7MQzTMUBdUrqL1XPJziunLJU/udGwGAVdZMTFs/
         MHaV6lubp1QvphvWbNLN/elKic4ZLDkPKhvt7TQGlkv93VPrbmOU6yTaltDB4/mOOa
         cCpDL9OIKc0/A==
Received: by mail-ot1-f44.google.com with SMTP id j12so21707473ota.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 03:23:36 -0800 (PST)
X-Gm-Message-State: AOAM532U4AyySrOVgBWIppCRFRMkayEJqbOm4TvTCRi8zyueRYlXC9yd
        o3GBkOG38PL+++tGUCXVyM1VZh3HGf3iRvVZqoA=
X-Google-Smtp-Source: ABdhPJxtNm2L3E+7cUbGuFw8FJsQ5ZXduzpGG24W4VGko6nC5XeZqvgH+bJbgT94nbPC/zq9Pz+doj4j9bk+F3IDAWg=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr49011301ots.251.1609586616367;
 Sat, 02 Jan 2021 03:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20201230153928.456260-1-arnd@kernel.org> <160934377188.21284.5702573697011773996@build.alporthouse.com>
In-Reply-To: <160934377188.21284.5702573697011773996@build.alporthouse.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 2 Jan 2021 12:23:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LWLKs+0quG_OS6EPgg2uSAOM69SKTix47tEUmuZWRdw@mail.gmail.com>
Message-ID: <CAK8P3a0LWLKs+0quG_OS6EPgg2uSAOM69SKTix47tEUmuZWRdw@mail.gmail.com>
Subject: Re: [PATCH] i915: fix shift warning
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 4:56 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Arnd Bergmann (2020-12-30 15:39:14)
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Randconfig builds on 32-bit machines show lots of warnings for
> > the i915 driver for incorrect bit masks like:
>
> mask is a u8.
>
> VCS0 is 2, I915_MAX_VCS 4
>
> (u8 & GENMASK(5, 2)) >> 2

Ah right, I misread the warning then.

> > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2584:9: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >         return hweight64(VDBOX_MASK(&i915->gt));
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
> >  #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
>
> So it's upset by hweight64() on the unsigned long?

I suspect what is going on is that clang once again warns because it performs
more code checks before dead-code elimination than gcc does. The warning is
for the __const_hweight64() case, which is not actually used here because the
input is not a compile-time constant.

> So hweight_long?

That seems to work, I'll send a new version with that.

> Or use a cast, hweight8((intel_engine_mask_t)VDMASK())?
>
> static __always_inline int engine_count(intel_engine_mask_t mask)
> {
>         return sizeof(mask) == 1 ? hweight8(mask) :
>                 sizeof(mask) == 2 ? hweight16(mask) :
>                 sizeof(mask) == 4 ? hweight32(mask) :
>                 hweight64(mask);
> }

Fine with me as well. If you prefer that way, I'll let you handle that.

        Arnd
