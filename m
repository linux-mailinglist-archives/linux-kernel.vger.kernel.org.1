Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F62D1D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgLGW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLGW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:29:34 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480ADC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:28:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so10255875pgi.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWXoV2CMUKwuuJ9IGyn1rKyPqeDvcvXFpNW+D3PeZwc=;
        b=kdu710mWZmTmZmTippRswW3tNYS61Hyt5bfuXqwbc5QE25E3c+yvVvbeGQ6TqFEqgv
         3C+T9eGEchPhr7810GzQMYpyW0pfwBZiSQ1noHFBdceEU+6Y5WoVfe229HyXKeEpf2Gv
         4D8IlCK2FTh0VfqN4CJAE6yOZovksKJnnH3Z27ZSTvJeRD5DTnxCFy6Uf52DpFawOfyN
         EdZLPi4zpALMCG5G5DL+0sZ3aoNXyAzskwh4ceJQGcItrZuoFIRSZUbYZSnav4dNeSRi
         /dlborW2be3RN5R3tJsHMpb+Y1Al9qqt+Y2K0ekSmFV1spS6crIvHyLQZ700qoIu37NX
         nqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWXoV2CMUKwuuJ9IGyn1rKyPqeDvcvXFpNW+D3PeZwc=;
        b=h+pqBwjhQQ/SvjzlXZfIlHnBY149zuteP4YyB0wjxQk7yLSAZ/gwIqnkIAPzVQQY9Q
         DwgQSCHzTBIcNGZ1Oczz9Orw3oR1KDzSZmER8VeGQ1orJcaA5UXwukpIrk+GXq5xtWap
         CN4ytE2ZDEgY3NhcDR+HTmgMN2WyWPUzl0G/J+2yXU2Q2mDYUAZME3/NTpqfR5jl3+uf
         8sKArVZ8Ac52lqfyni4NKkm1JUUTChTo2a0nXYqsQ1ewS5jQ2jasGSF/tZsEXQp78aTL
         EUjEkUEGxXv61+Sbn0NVSwx1GtvMJytymZOyM7JVfTh7zZwOSXdLC5pI0/UiGQyxozTV
         F5Rw==
X-Gm-Message-State: AOAM531ai7lVfRtJeSodqQkghkGflWCBzVaOLBiVZbTY/GiME82pMFuQ
        rHtq1kAaVBdg9CA2oENA8k+cy7zuUk/bSvTnKDlWmw==
X-Google-Smtp-Source: ABdhPJzH235ZBy2+HtgSTmZfucYCnB2ALLUQMf094BhLSCBeBGevRQx+U8bJiscjIYvbi5B1I9kNRlXmGrr1BhXaY5I=
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr898064pjb.101.1607380133527;
 Mon, 07 Dec 2020 14:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org> <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com> <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
 <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com> <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
In-Reply-To: <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Dec 2020 14:28:42 -0800
Message-ID: <CAKwvOd=+w6vJvvq9Pwnv1EHHzwCx=o_=PbSozXpqryN6P1yxVQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 7, 2020 at 11:08 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Mon, Dec 7, 2020 at 1:57 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > >
> > > Right, looking at my latest randconfig logs, I see the same problem on x86
> > > builds with clang as well, though I'm not entirely sure which other
> > > configuration
> > > options are needed to trigger it.
> > >
> > > So my patch can be disregarded, but I agree this needs a better fix,
> > > either in clang or in the dcn driver.
> >
> > If you could give https://github.com/ClangBuiltLinux/frame-larger-than
> > a spin again, I would appreciate any feedback.
>
> I've already tried it, but the tool doesn't seem to like me, I never
> get the information out of it that I want. This time it failed because
> it could not parse the .o file correctly.

Can you send me a config to reproduce the .o file?
-- 
Thanks,
~Nick Desaulniers
