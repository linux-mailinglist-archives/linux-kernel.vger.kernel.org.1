Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46B32D1CCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgLGWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:08:46 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC0C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:08:06 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t7so11673313pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RH4pdeWWvfre3cu7j/0GaN4hr0feg8IAaGOFeWc7Icc=;
        b=tKQPYnaxHUT3G2ejHD48wVGmGAxvUk613h0F7isSh8Rgc19Xi7ydBlmSLt+L32+7oY
         oaI8J5ctkEvu4NmRRHSbig6Mwk8l/sPJN4pQ1dFXoLheHhD7L7F/TV8xzqy3iKTBP7D0
         VTLTwaXLdWl7QvZUXqoMT/FCnBtw4rwVKi1VaQklokAx67u+UrEnuDn5OxSNsZbPdveG
         5MdDQZMADa8lqv5gr27CUEnqeCW3aoM1Ap7KwfsRIStNtMC8K0Jr1RSz+BiWK/c7Dw6k
         UXWpYeADZyZffIi3l3+VK73Ra1zI5PQ73b8TAGv9keK7rW9e9cPSGgieCY5M8JLiA6ve
         WBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RH4pdeWWvfre3cu7j/0GaN4hr0feg8IAaGOFeWc7Icc=;
        b=qyRbMzBxvGAeLpR955GicxZV2l6HFDl83wBjomM08voSFbEKWlJ42VzU9dpCA3ZmyF
         v4i5aASl+a6L4/x9q+VbSPIgL/N1wSpPGVa43vd8IchHgWeSS0Ymkcogsftw+vxEYkYs
         4eUxT7h0vqx0oY+RPRhKDxYtKtIwXQtBJdklOWKpux5QXzzzC4cqG/f9vMXlkegd6cXC
         WcM4IiVcVzTVBt+3T7N0fXGyMSfAoBg0VZvPeze+TinnSqQlmerj9uoC9HjYq7Laua7/
         RkrzWnKkk5gVuvtRGEw81vIP4cn24XQ/kFenTK+0QVazmGIUYvgaqgQI28Oz1SBXfiqb
         6igA==
X-Gm-Message-State: AOAM532bI6HdTnxQvly3VN7PecQLPjy3VspXb0BmXbFYicR5YENW88VK
        kOo/p2bpvEIP9BhqrgzhJ0pIf34S6pcwKKM+FuC9Sg==
X-Google-Smtp-Source: ABdhPJwcEAD4avRJlrTqe4+EmXzyDwFajmE/uvoR8AgoDacymps++P6aOkJQm3MqgeYJqxpQEM4PRYwTnZFflhmAPRQ=
X-Received: by 2002:a17:90a:6fa1:: with SMTP id e30mr921328pjk.32.1607378885707;
 Mon, 07 Dec 2020 14:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org> <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com> <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
In-Reply-To: <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Dec 2020 14:07:53 -0800
Message-ID: <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
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

On Mon, Dec 7, 2020 at 1:57 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 7, 2020 at 9:50 PM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> > Am 07.12.20 um 21:47 schrieb Alex Deucher:
> > > On Fri, Dec 4, 2020 at 3:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >> From: Arnd Bergmann <arnd@arndb.de>
> > >>
> > >> As the DRM_AMD_DC_DCN3_0 code was x86-only and fails to build on
> > >> arm64, merging it into DRM_AMD_DC means that the top-level symbol
> > >> is now x86-only as well.
> > >>
> > >> Compilation fails on arm64 with clang-12 with
> > >>
> > >> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_=
30.c:3641:6: error: stack frame size of 2416 bytes in function 'dml30_ModeS=
upportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=3D]
> > >> void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode=
_lib *mode_lib)
> > >>
> > >> I tried to see if the stack usage can be reduced, but this is code
> > >> that is described as "This file is gcc-parsable HW gospel, coming
> > >> straight from HW engineers." and is written in a way that is inheren=
tly
> > >> nonportable and not meant to be understood by humans.
> > >>
> > >> There are probably no non-x86 users of this code, so simplify
> > >> the dependency list accordingly.
> > > + Daniel, Timothy
> > >
> > > Others contributed code to enable this on PPC64 and ARM64.
> > > Unfortunately, we don't have these platforms to test with within AMD.
> > > Does PPC64 have the same stack limitations as ARM64?  Harry, Leo, can
> > > you take a look at fixing the stack usage?
> >
> > This reminds me that I wanted to reply on this.
> >
> > 2416 is even to much on x86 if you add -Werror :)
> >
> > So this needs to be fixed anyway.
>
> Right, looking at my latest randconfig logs, I see the same problem on x8=
6
> builds with clang as well, though I'm not entirely sure which other
> configuration
> options are needed to trigger it.
>
> So my patch can be disregarded, but I agree this needs a better fix,
> either in clang or in the dcn driver.

If you could give https://github.com/ClangBuiltLinux/frame-larger-than
a spin again, I would appreciate any feedback.


--=20
Thanks,
~Nick Desaulniers
