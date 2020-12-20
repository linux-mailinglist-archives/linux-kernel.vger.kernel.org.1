Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205692DF836
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLUE0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgLUE03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:26:29 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23084C061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:25:33 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b64so7805869qkc.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6uzmAaKy6Tpw6472b4l28CsRG+K9Idwpy1rMAZdnEI=;
        b=emmaaPK7eQb08PlZ4lpNFAEqxAucZreW++pSIMdzKcKO1pjomXibpBvgu7Qx8BcPFd
         Zztfx236CzyXSQtQ4C0IbdoqN042/m8xZdE39SaEflP3WeWj6yWOvLcMngz5I9nz8S4D
         UqIT72fobV2g2+4jN5dD3qzAUTC732KseG6TboPyex0L1e/4xulEn8b482C+59wApRhK
         d+UEUZ3LYpTrHAkH0Jy41FZhubV/iDqE0QmeiqddgA90hoVww1wS0dQnpX2bGK+nwgCk
         alGZ298K5tIVtpxylcKBkiFyfdqXEVl3M7Nlz7iiBRIdpyDZUMGFqAaEn/RvUrSMq4WE
         nyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6uzmAaKy6Tpw6472b4l28CsRG+K9Idwpy1rMAZdnEI=;
        b=fudtb/FqXRViy+G8e2Zt2zl5kTBUXK+6UXN9X5mRUwl6zRzY5nlbOINvsY0O0sFU8V
         BbmZ4U1JC4HDYCNYj+sWM2XLnCEFneug9y6eGjRVbZ4EPejOXt4VNGLQu4uD/iLyb1+L
         JXXcAZI7CuUMdrkt1FSPsm2nKAqZtQ+VfBPvRS6iCOWVWs6fc0tTNq/tw8G8/Cvh1QHC
         XMz5ubpu/Rb1M/t5PkxGP2F3MtCJxY92QLia0z3zMgAcjmgcn1hwquD63Jh0qvi9WduG
         52BUIyTE3JGMxksemCjv8jJv2yjOcVHK030ZyvpSVlpoD0t0eqGNkfitZNR1Eq5YnhYD
         kN3g==
X-Gm-Message-State: AOAM532mZbbPBcsdGKh9r7ro8iQICKljkEm480gzJnS7F4YOvxHU0J/0
        ERJmsilNMdKOoEzkP6uInr09rRRGZ7m0Dj2aqFuOaT84
X-Google-Smtp-Source: ABdhPJzfLoLk+OzIA3X+/glzoot3vKjcNRcsGID4CFp9Nji7KF0mmXNRb8yl+v4+dkvdR6YyHD8hwgONp0CdFiWoAew=
X-Received: by 2002:a37:9a4a:: with SMTP id c71mr15037964qke.56.1608498950121;
 Sun, 20 Dec 2020 13:15:50 -0800 (PST)
MIME-Version: 1.0
References: <1608382150-102703-1-git-send-email-zhongjubin@huawei.com>
In-Reply-To: <1608382150-102703-1-git-send-email-zhongjubin@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 20 Dec 2020 22:15:39 +0100
Message-ID: <CAFLxGvz5d__+yNLeRqHfF=5M7hKf-PoQrJ8EBy_tu7R1S6n6yA@mail.gmail.com>
Subject: Re: [PATCH] ubi: remove dead code in validate_vid_hdr()
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        wangfangpeng1@huawei.com, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 1:52 PM Jubin Zhong <zhongjubin@huawei.com> wrote:
>
> data_size is already checked against zero when vol_type matches
> UBI_VID_STATIC. Remove the following dead code.
>
> Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>
> ---
>  drivers/mtd/ubi/io.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index 2f3312c..8a7306c 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -913,12 +913,7 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
>                                 ubi_err(ubi, "bad data_size");
>                                 goto bad;
>                         }
> -               } else if (lnum == used_ebs - 1) {
> -                       if (data_size == 0) {
> -                               ubi_err(ubi, "bad data_size at last LEB");
> -                               goto bad;
> -                       }
> -               } else {
> +               } else if (lnum > used_ebs - 1) {
>                         ubi_err(ubi, "too high lnum");
>                         goto bad;
>                 }
> --

Looks good, applied to my 5.12 queue!

-- 
Thanks,
//richard
