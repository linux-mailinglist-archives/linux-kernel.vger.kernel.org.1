Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3A269550
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:15:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E21C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:15:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so1122625wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otkTAULWhgakQf2K8e6OJQkZhWIe/H1QBsJL/JJYQ4c=;
        b=Yon35tE9Wc9xWgrxr1p+no1Vm7P1R36MEpUbZ9T/yfQ66Y06F9LtPhXeQzl+QxTZYW
         ijZ/41gnNCAwAbC1eX7BtLdtJUhnuu1d2aWgKKPesWqtMF7/7YHpze87bWV5JfAWKM2A
         qw2iNybpOqFG4Bq475JqywdDEiK1n7mdoL+NibZu/g0Yl6s/nz+hr9SBUe2+GbhyNOPe
         Sepw/kexCZf34fIbjm+OvgizIq/8xmZLuaY1SpylK2GI1rcdpG80C8bK+Ez13+nronoP
         1L00VIFYO28KecN5xLeOTZJeI5tuN5OMpbxxn6zlkAMPFem5Wpd71CzHRR3CE90itbyO
         2UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otkTAULWhgakQf2K8e6OJQkZhWIe/H1QBsJL/JJYQ4c=;
        b=JzpUYe8wVBKmOvJyP+8mI3W+pSl+dVzXFVTZKtmJ8jQoibK0UgnZciqU0xbtZ3VSr0
         yHL+NasDVlRvAllxi7SKsWB/z7cHd0llmwA1zJAWOXsC6bxdeNIla5dHHgqv8iqHel7I
         qyDdT83KvG8EfSkmk00WXkcxEMFBPwMYg5tc2hEax+zV+Z0qHoHhKwbP0xcDvhdaONWL
         Y/RpTrrZ92ypjdexMCY7G4asYtOtK3xyjdxrPW9vd2brMaowkHiYxC51VptcRkYWjFHR
         FvQXuLqRt3UXHZyFLtj7JLcNUFBJTcUOvAFabgzG/NoBlmpG95QL+7wT8UtZWTqDOWza
         HkbA==
X-Gm-Message-State: AOAM532OiSTnjs7iouhq4iUAThZEa+7Tmzvtda8AA0vHRcfHJ7Zk8AfG
        u4ihbZA2Ozj558dfm3dg/t+G/RrPBaVIanBQWRk=
X-Google-Smtp-Source: ABdhPJx7o4K91MyAuQ9EPwsFKaX9MaW3JSQNMRKMl0vgwbZNjICM2HtwCfI0iMlvFmNu7YeWzkQ+XPp/9EaT+ZHZXxg=
X-Received: by 2002:a1c:2403:: with SMTP id k3mr782091wmk.153.1600110898792;
 Mon, 14 Sep 2020 12:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200914061931.21886-1-oss@malat.biz>
In-Reply-To: <20200914061931.21886-1-oss@malat.biz>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Mon, 14 Sep 2020 12:14:48 -0700
Message-ID: <CANr2Dbft5ax3eOc1DGztLWHGqR_GztAQM1n+5HJippD9R_1e=Q@mail.gmail.com>
Subject: Re: [PATCH] zstd: Fix decompression of large window archives on
 32-bit platforms
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:19 PM Petr Malat <oss@malat.biz> wrote:
>
> It seems some optimization has been removed from the code without removing
> the if condition which should activate it only on 64-bit platforms and as
> a result the code responsible for decompression with window larger than
> 8MB was disabled on 32-bit platforms.
>
> Signed-off-by: Petr Malat <oss@malat.biz>

Reviewed-by: Nick Terrell <terrelln@fb.com>

Thanks for the fix! I looked upstream and this fix corresponds to this
upstream commit:
https://github.com/facebook/zstd/commit/8a5c0c98ae5a7884694589d7a69bc99011add94d

Thanks,
Nick Terrell

> ---
>  lib/zstd/decompress.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
> index db6761ea4deb..509a3b8d51b9 100644
> --- a/lib/zstd/decompress.c
> +++ b/lib/zstd/decompress.c
> @@ -1457,12 +1457,8 @@ static size_t ZSTD_decompressBlock_internal(ZSTD_DCtx *dctx, void *dst, size_t d
>                 ip += litCSize;
>                 srcSize -= litCSize;
>         }
> -       if (sizeof(size_t) > 4) /* do not enable prefetching on 32-bits x86, as it's performance detrimental */
> -                               /* likely because of register pressure */
> -                               /* if that's the correct cause, then 32-bits ARM should be affected differently */
> -                               /* it would be good to test this on ARM real hardware, to see if prefetch version improves speed */
> -               if (dctx->fParams.windowSize > (1 << 23))
> -                       return ZSTD_decompressSequencesLong(dctx, dst, dstCapacity, ip, srcSize);
> +       if (dctx->fParams.windowSize > (1 << 23))
> +               return ZSTD_decompressSequencesLong(dctx, dst, dstCapacity, ip, srcSize);
>         return ZSTD_decompressSequences(dctx, dst, dstCapacity, ip, srcSize);
>  }
>
> --
> 2.20.1
>
