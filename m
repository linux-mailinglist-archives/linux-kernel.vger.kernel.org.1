Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E22E9BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbhADRDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbhADRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:03:51 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB33C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 09:03:11 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id d189so32794864oig.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkfKIc8TYv8/nRpoPVoMEofElitz2KLsBoBEwufJSM0=;
        b=iGIjA39XdTndy0R3+OqGy5LlHrdqOClBY1/FWEX5jyoMeg3HRVh87Ta21eQsaZnafO
         j3v/KCXJ/0iGc8LDxzKuPWravYhZk0rczR5/b6B//M+D1COrM4LDB80FALGQWNQGXMCR
         v0Qkxb70zsuujhkJJcLO/ungyAjilF5qjZf45da4Qb2ftbQpNpNHYMOZL0IfC9xJrCQT
         qXmoU38fF+1t4Hu2NraVXvCe+X3FHiTSrSdXAWAhq1LbrZTRNlFtjYICJBc/Wmb5vaQB
         mGxl/DIWqhVvUmpDJIRskxfFmckEGMfCz3qgS8jHz4talJtLXnj9eoq6DY88MJ2Sllaj
         g3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkfKIc8TYv8/nRpoPVoMEofElitz2KLsBoBEwufJSM0=;
        b=i63U6pUQs/lzNV/ofd2lGyXnY39cHOAfrudkenmS+WjUc4E4kfksja446AXXmaI/io
         jHCUjyqzDUg6TATbiW51BwnLTutNG9IqyOTwspwVcQYjGAJx9N6V9PYQdNawxKl56GzF
         gvRvTQZ+sN072TAfuwywzwGs40HfxCegMEwez1TfB1WcwVeriYcsOs2QXcFE1UCkeZ1a
         +tGIxNjyYUKZA4KdLOQ9T6Ctj3lmf/H5KPygKImctBLFb81mdiYaQpoRZpSNUWxSqprV
         P9U8aADz3GMQKtUR2RUs+JBxUj9vp+2tHCNal3yvyAL/ev3E/D0+7B0QRMwjGC+fgy0z
         NXiw==
X-Gm-Message-State: AOAM530UwPy55VS8j91vrj/CoQIGzTSMrb7rQwFekqOsIcQ4AcPbJmX+
        h8qsjYcloy8kmV7dtYNjTe5YyBStPpf+g1i2L10=
X-Google-Smtp-Source: ABdhPJxA/GM8cZ0BIWwtLaCo/AOxg5iblCGFiV28MHKxwkGcJDu7ZQLBuCsqx/yHA/FkZSq2MLM+ksDZ9eivPBKDDGM=
X-Received: by 2002:aca:6202:: with SMTP id w2mr17652648oib.5.1609779790520;
 Mon, 04 Jan 2021 09:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20201222133100.19470-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201222133100.19470-1-zhengyongjun3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Jan 2021 12:02:59 -0500
Message-ID: <CADnq5_M6a0LOS3UrteaMcPtZVApJQoV=fR8jizbVzk96VFTHrA@mail.gmail.com>
Subject: Re: [PATCH -next] gpu/drm/radeon: use DIV_ROUND_UP macro to do calculation
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 2:06 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Don't open-code DIV_ROUND_UP() kernel macro.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
> index 390a9621604a..a3aea5329712 100644
> --- a/drivers/gpu/drm/radeon/r600_cs.c
> +++ b/drivers/gpu/drm/radeon/r600_cs.c
> @@ -219,7 +219,7 @@ int r600_fmt_get_nblocksx(u32 format, u32 w)
>         if (bw == 0)
>                 return 0;
>
> -       return (w + bw - 1) / bw;
> +       return DIV_ROUND_UP(w, bw);
>  }
>
>  int r600_fmt_get_nblocksy(u32 format, u32 h)
> @@ -233,7 +233,7 @@ int r600_fmt_get_nblocksy(u32 format, u32 h)
>         if (bh == 0)
>                 return 0;
>
> -       return (h + bh - 1) / bh;
> +       return DIV_ROUND_UP(h, bh);
>  }
>
>  struct array_mode_checker {
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
