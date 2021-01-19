Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45F2FB8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392352AbhASN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404136AbhASNUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:20:19 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841FC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:11:52 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id u27so3171695uaa.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBCytU2tF2X6uPBN9VdsZsC0tQnDuvsMDL0KGzBzCMU=;
        b=hxAZPtDJ6bUT3b2INOC7YVy3qWLFjcFkw7/nk0DMFpL33XpcKNr7Crukzxd2RiE5Kc
         mkS+sRMYRcL/0Ubxx01jxTOxjZGUo4X7RHeXNZsbwzoKQmTWKBZLn2Z9Hj3X/OILYigf
         e+mtA5pe8FexGOWspKNAssJ7RJ3LwYUFfWhHna44kRD6n6wLDsqt+509qc2pE0fCDzBE
         hmja+6hXE5t+OocADu4rkTVznrmSTAPb7P53WivqmU7L3F+J9H9Shs5WjObhSxOLPJtl
         R/ZdMZfNs8UKmRbqP69xySLBHq6edwjMF1/7/qcEHuxrWAOoi7AjW3/uW/CGR/zNIptS
         b9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBCytU2tF2X6uPBN9VdsZsC0tQnDuvsMDL0KGzBzCMU=;
        b=Vg7ewBc2sQjf33mXS3bqyazFrKodgoEBLWoVCIXO6yKj1rX0z12857y8nZQlC84tdB
         wgWjBbLDT3ynB0dGon3G/b8VyiIDDUuXvqjYYbhI6s1+qLfIjg/k3VYuJhxi9BRfeGhV
         FhkbTnwEAWyZMu5c+5I8oGcDklkJoUrvozmxP90d8RzqnTQKcpDL6GBSdxhWpNZ/UzXV
         RlNnaqlO/0Ikvbr3xqEgvis6dGWzE0tDjDArBG4A6qgs+VilQL2SgaBWpLSjusO4pwYq
         NFAkBQRV7bEAy+8P53VY6lUtO0/iDw0vLDEPC8kXPB6aodWtuXIO9NLswGfN6bmkXE/J
         mnEw==
X-Gm-Message-State: AOAM530qWICSGDi+W26vn2RgsyLYG2Mh0mH5rHJeBab9ZdBDJwJ2V1+c
        1upvaPLzr6IdcVpoR7fuyLoT4aam1G0R4Jw+xdkqfA==
X-Google-Smtp-Source: ABdhPJzbTV3Tj80gHuisSCGfdH5eJWfgr/hnn3526HhEGa4vMB/JFqMrctqxXAkTLOdWfhaWFVYby2dTs9FAW/S4z6M=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr2023850uam.19.1611061912130;
 Tue, 19 Jan 2021 05:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20201222133355.19807-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201222133355.19807-1-zhengyongjun3@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:11:16 +0100
Message-ID: <CAPDyKFpGsAuBdmdcau8CwGUZYXaTF_RoQs=a-eoLOwZknZGBcw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: core: use roundup macro to to calculate blk_sz
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 at 14:34, Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Don't open-code roundup() kernel macro.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mmc/core/sdio_io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 79dbf90216b5..35c69bdeb40e 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -263,8 +263,7 @@ unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz)
>                  * Realign it so that it can be done with one request,
>                  * and recheck if the controller still likes it.
>                  */
> -               blk_sz = ((sz + func->cur_blksize - 1) /
> -                       func->cur_blksize) * func->cur_blksize;
> +               blk_sz = roundup(sz, func->cur_blksize);

If I understand correctly, roundup() assumes func->cur_blksize is a
power of 2. The above doesn't, which means there is no open coding
happening here.

>                 blk_sz = _sdio_align_size(blk_sz);
>
>                 /*
> --
> 2.22.0
>

Kind regards
Uffe
