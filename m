Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50C2D1C89
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLGV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLGV62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:58:28 -0500
X-Gm-Message-State: AOAM530KFnro0aAy7+9XPC2TBRalQu0DnrYVCtLO1CcuQ9XBURl6xCTq
        qLmmN8GRhmgTE9VqckdObOmWfASN6LlWNVcCgCU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607378267;
        bh=ksOiwcQuyTdGZ/0xs0Rr3mLefm+gUEwoODlr/FTT3Ws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bn2nl2YOJ1o9oYaE9lF5+mCXzzqHF51w0qB54r5FqFF7X1izJlfvlnOw5I7Q8GHKP
         RoqU57WTKC6faoiDe3Zw67frqSRE0l+IEo3kY5u2Vfbvse1KdQbjOweX7H2w0q5oPl
         5EjwaDkh/2qkB3wiU25+Jehl4xlayHZGwHxYTOuQK09tDDJwgSQ/s8WtTmFLA/C34u
         Wcm4Gor8fnFiYwhYtL3P0Wg+nJLvxmtoBhWSCAz2jwBEr+8DPeBarLBzhc0QsAGg1v
         iX7/TvPgtiZIwV82aMuBpA/+U2BIFKFOysBUcnCkGagTgi2RB2/neq3C+OQDn145wv
         e7H2EYDeqISRg==
X-Google-Smtp-Source: ABdhPJwFFIJ6eWvVRpDubr3SS1DWxrsa13Jhn19Yuha6L2b5D9qVbE12GKTRLJcaOLffzSjg4EZrJuLVG8mRfpqw3IM=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr14853258otk.251.1607378267025;
 Mon, 07 Dec 2020 13:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org> <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com>
In-Reply-To: <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 7 Dec 2020 22:57:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
Message-ID: <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Daniel Kolesa <daniel@octaforge.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 9:50 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
> Am 07.12.20 um 21:47 schrieb Alex Deucher:
> > On Fri, Dec 4, 2020 at 3:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> As the DRM_AMD_DC_DCN3_0 code was x86-only and fails to build on
> >> arm64, merging it into DRM_AMD_DC means that the top-level symbol
> >> is now x86-only as well.
> >>
> >> Compilation fails on arm64 with clang-12 with
> >>
> >> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30=
.c:3641:6: error: stack frame size of 2416 bytes in function 'dml30_ModeSup=
portAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=3D]
> >> void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_l=
ib *mode_lib)
> >>
> >> I tried to see if the stack usage can be reduced, but this is code
> >> that is described as "This file is gcc-parsable HW gospel, coming
> >> straight from HW engineers." and is written in a way that is inherentl=
y
> >> nonportable and not meant to be understood by humans.
> >>
> >> There are probably no non-x86 users of this code, so simplify
> >> the dependency list accordingly.
> > + Daniel, Timothy
> >
> > Others contributed code to enable this on PPC64 and ARM64.
> > Unfortunately, we don't have these platforms to test with within AMD.
> > Does PPC64 have the same stack limitations as ARM64?  Harry, Leo, can
> > you take a look at fixing the stack usage?
>
> This reminds me that I wanted to reply on this.
>
> 2416 is even to much on x86 if you add -Werror :)
>
> So this needs to be fixed anyway.

Right, looking at my latest randconfig logs, I see the same problem on x86
builds with clang as well, though I'm not entirely sure which other
configuration
options are needed to trigger it.

So my patch can be disregarded, but I agree this needs a better fix,
either in clang or in the dcn driver.

       Arnd
