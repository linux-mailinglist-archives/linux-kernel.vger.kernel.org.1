Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473302D1D27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgLGWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgLGWRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:17:42 -0500
X-Gm-Message-State: AOAM533ClF5LdrJzEvZxwOUiv3Cn5Og+y2bADq2miv74sUmFSbdxUOx7
        75ffJzxkupKE4oojCbBI/YGtOpzZrENFYRluiFY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607379421;
        bh=Qo26HfaA4XRlpGslDUwq/ehGvtgfvzRfg7lWwq+xSdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GNNdf5C6kPAulfIHOlXgLwGL0VQaGTkBpP/oM86lEUVUW3GNVK8R6zHtzNfHx72kY
         IggtFl4dOv0G4yGD8Dz2qr3liOUfUa4wNnCmV6JbHHaY9adGhF9MprLKBZAvo6XNyD
         zDuQ0yvXHl7xWtDOg2HMsv+xB9zt/lk5Sm1d+rkU3u8O1JYaZbZvb9TAPDnLuVxEeR
         ikeBj27cakygQKSrh4tkPWVSnlUKyt1wlQMic+xn7kZq3iWY1jyhA5cEA/JQ5qoSV5
         xVi2ysvXoT42wZWTBjCaUg2A9nTWsGJHzYp0HIVBFHAnPiIU5Uop8lUkmrrT72n4NU
         EY6CqdnS2AYLA==
X-Google-Smtp-Source: ABdhPJxhvfVvbp6iz6JPSBKSOMtCXq60tyJBjKK1QaVYl7mA38/ysmrpzmlk5ZqOf0a8vzfq1bNy/SW2zSGANIgq5Oo=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr10918089otm.305.1607379420605;
 Mon, 07 Dec 2020 14:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org> <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com> <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
 <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 7 Dec 2020 23:16:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
Message-ID: <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Dec 7, 2020 at 11:08 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Dec 7, 2020 at 1:57 PM Arnd Bergmann <arnd@kernel.org> wrote:

> >
> > Right, looking at my latest randconfig logs, I see the same problem on x86
> > builds with clang as well, though I'm not entirely sure which other
> > configuration
> > options are needed to trigger it.
> >
> > So my patch can be disregarded, but I agree this needs a better fix,
> > either in clang or in the dcn driver.
>
> If you could give https://github.com/ClangBuiltLinux/frame-larger-than
> a spin again, I would appreciate any feedback.

I've already tried it, but the tool doesn't seem to like me, I never
get the information out of it that I want. This time it failed because
it could not parse the .o file correctly.

      Arnd
