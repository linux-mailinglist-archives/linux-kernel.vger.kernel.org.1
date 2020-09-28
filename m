Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8A27AD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1MPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1MPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:15:54 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAAC221531
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601295353;
        bh=VzE5JnSqbWbSjqt1XZOKvxLhpPp01vzIUE5bLK2KBGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wWXeY/okl0iT74hT2/it3uy9M4LrKvjeaYovhf4wW2CVVgdbbUJDMoQezUnoDU6m/
         iALSmCVv7Qz5UzbbPvJzVCno8xPT988GV2/D+z2O5P6b6VcFhKypMLunwVjvUOBLna
         l8sde7Js1xU2hZUMlYLZEy3si575DxRqUlhDd7l8=
Received: by mail-oo1-f44.google.com with SMTP id t3so237257ook.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:15:53 -0700 (PDT)
X-Gm-Message-State: AOAM532ULsyobRCcoscwJwwByC9LLSgrT0YRcNxhiOVE3ui/zbqKlYws
        Cx/beF3Cd+yO8+LonNKdol4nX4YtzWZPj/1tuDY=
X-Google-Smtp-Source: ABdhPJxJ9X0j2i9aipMDD622TMXIK4KJvvyre4/xitAq7fB8wQ8A2zpZSJK+fOWTyYIB/ev7M7zwAeZw/2vm/fmpGtE=
X-Received: by 2002:a4a:4910:: with SMTP id z16mr612115ooa.41.1601295353098;
 Mon, 28 Sep 2020 05:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200928092641.2070-1-thunder.leizhen@huawei.com>
 <20200928092641.2070-3-thunder.leizhen@huawei.com> <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
 <e2d45592-ffc3-395e-0657-dcff0e094c1f@huawei.com>
In-Reply-To: <e2d45592-ffc3-395e-0657-dcff0e094c1f@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Sep 2020 14:15:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXziNDWxKNmD9nPWCmhpAPO--vWvJvr2nioQL+QJBfBQ@mail.gmail.com>
Message-ID: <CAMj1kXEXziNDWxKNmD9nPWCmhpAPO--vWvJvr2nioQL+QJBfBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: decompressor: relax the loading restriction of
 the decompressed kernel
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 at 13:57, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/9/28 18:14, Ard Biesheuvel wrote:
> > On Mon, 28 Sep 2020 at 11:27, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>
> >> mov     r4, pc
> >> and     r4, r4, #0xf8000000     //truncated to 128MiB boundary
> >> add     r4, r4, #TEXT_OFFSET    //PA(_start)
> >>
> >> Currently, the decompressed kernel must be placed at the position: 128MiB
> >> boundary + TEXT_OFFSET. This limitation is just because we masked PC with
> >> 0xf80000000. Actually, we can directly obtain PA(_start) by using formula
> >> : VA(_start) + (PHYS_OFFSET - PAGE_OFFSET).
> >>
> >> So the "PA(_start) - TEXT_OFFSET" can be 2MiB boundary, 1MiB boundary,
> >> and so on.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > No, this won't work.
>
> But it works well on my board.
>

That is because you load zImage at the base of DRAM.

> >
> > The whole reason for rounding to a multiple of 128 MB is that we
> > cannot infer the start of DRAM from the placement of the zImage (which
> > provides _start).
>
> Maybe this is further guaranteed by the following code:
>         /*
>          * Set up a page table only if it won't overwrite ourself.
>          * That means r4 < pc || r4 - 16k page directory > &_end.
>          * Given that r4 > &_end is most unfrequent, we add a rough
>          * additional 1MB of room for a possible appended DTB.
>          */
>
> In addition, the Image has already been loaded when this position is reached.
>
> ----------- <--128MiB boundary
> |          |
> ----------- <--TEXT_OFFSET <--
> | (1)Image |                 |
> ------------                 |
> |          |                 |
> -----------  (2)--copyto-----
> | (2)Image |
> -----------
>
> I don't think it's the case of (2), but (1). Because no code modification is
> required for the case (2).
>
> By the way, I'm not familiar with the arm32 code, so I'm just speculating.
>

The zImage code that runs has not received *any* information from the
platform on where DRAM starts, so the only info it has is the current
placement of zImage.

So when zImage is loaded at the intended base of DRAM, things work fine.

If the zImage is loaded close to the end of a 128 MB region, the
rounding would pick the start of that 128 MB region. However, the
_start symbol you are using will point to an address that is close to
the end of the 128 MB [given that it is inside zImage] so your logic
will pick an address that is much higher in memory.
