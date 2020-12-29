Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB32E7195
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 16:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgL2PIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgL2PIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:08:19 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D11C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 07:07:38 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d203so14883451oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 07:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqvfcvBB/yuJN88cknZSgA0GC7ju7WQsqKbZVnzon9A=;
        b=rcYdCtotJM+LpY7Zu7AX9yGCRCcl+q2r5SXVbMFfkoXpoZ8WDV/Hc7fHIijlA5hicY
         uOcqjg0wmvJsVzeQMwHLisl9uzMf3YRVSE+lgPeihRVUNVxzJYwLD/GsvmzkmcCLRPRJ
         6+ffFonT6L/DPJVdkI//S/yINgTmuXTZtY31pR4M3j6rZOniXPHroG6ivM11QsBSmwKu
         Ksi31p54tgkrUqUOTqtLp+++7PjXKKpF7TDIoQKncd1Ht3YrSkXUiKeAHsJwDgY7Tq4L
         4Ws0lRjBLS6vJ1ifUOveTlj7BVwWJatShcc2qlHOyxGoKsyBabt6p/wN48L7o5rtOM2K
         yb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqvfcvBB/yuJN88cknZSgA0GC7ju7WQsqKbZVnzon9A=;
        b=RqWdJHMVq2DBu+wIFyfZLFlUhny2bgo5Qk3n2cTJ7xp8FojqAslb3N2wBCq9M7Vb1J
         iAQuRRs9l3TXv4alJquX3YUSbgn6etvxbNwfSJD5puVcLszZ3bUbOHGHLTt9ilGcm7vK
         b6hgGSY5jH3mCYT6v9TUhrr6uOfFQhDe2sftPWw54js0udfjcXVk5LC9n1WVhRU85nbn
         JzJ9FL8U+C2Wx4kbTNWQMfXHMsQMlXpLD4BKs5ksis4mZ2zoM5Oihwn5EE6rvbRrrzU+
         INJBO6PAiAsU+b0NqZsxyiLiq1y/KlceU7OBZfmHJSxmIXZYSxZjXRewj4T/l0KVLh3P
         WoGA==
X-Gm-Message-State: AOAM530beH+RtG2OFjLow40mG9Zh+wxtxzS/a46z/gX3W4AIZe7gSLr2
        rtjZZDI6M5w/16uqkHLfCuc96X/Be6GL/1YLAyw=
X-Google-Smtp-Source: ABdhPJzC2MH8SjmAcuJHIWCLv3XOp2I/AEt3ZNbGPd3fKXcTSy+TUAWZJnrJznG1ESwJk4StebJOioPc98JbCD+BjVQ=
X-Received: by 2002:a54:4083:: with SMTP id i3mr2552418oii.120.1609254458047;
 Tue, 29 Dec 2020 07:07:38 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twrkJdUqTLXXsNygtzkrc4P2iyw4kwU1T83D4_+-gdpDA@mail.gmail.com>
 <CAHk-=whf+kw=YSDbmvgiSvNL9ckHc8EpkTgZzMXu-bMw941GYQ@mail.gmail.com>
In-Reply-To: <CAHk-=whf+kw=YSDbmvgiSvNL9ckHc8EpkTgZzMXu-bMw941GYQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Dec 2020 10:07:27 -0500
Message-ID: <CADnq5_N_2iYnh13p-z5vrvNK9rzKV-5TYtCC-FiEYjvi--_org@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Harry Wentland <hwentlan@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>, Josip Pavic <Josip.Pavic@amd.com>,
        Bindu Ramamurthy <bindu.r@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 5:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 23, 2020 at 6:29 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Xmas eve pull request present. Just some fixes that trickled in this
> > past week. Mostly amdgpu fixes, with a dma-buf/mips build fix and some
> > misc komeda fixes.
>
> Well, I already pulled and pushed out my merge, but only noticed
> afterwards that clang complains about this, and I think it's a real
> bug:
>
>   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_mpc.c:475:6: warning:
>      variable 'val' is used uninitialized whenever 'if' condition is
> false [-Wsometimes-uninitialized]
>
> and it sure is true: the code literally does
>
>         uint32_t val;
>
>         if (opp_id < MAX_OPP && REG(MUX[opp_id]))
>                 REG_GET(MUX[opp_id], MPC_OUT_MUX, &val);
>
>         return val;
>
> so clearly 'val' isn't initialized if that if-statement isn't true.
>
> I assume 'opp_id' is always presumed to be valid, but that code really
> is disgusting.
>
> Just make it return 0 (or whatever) for invalid, possibly together
> with a WARN_ON_ONCE(). Ok?

Harry, Nick, Hersen,

Can you take a look?

Thanks,

Alex

>
>              Linus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
