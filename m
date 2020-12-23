Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C72E1AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgLWKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgLWKNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:13:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6DAC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 02:13:00 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id b9so10929430qtr.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7ul2mtHp6U+xwxNPA6N4h6XzfrNSOVuPWwpcUY8qBM=;
        b=PpGHY0IiIVhEmCzBqflwf2fFnjo7bpqTuaMYXAWsADJr/f5KnE0GRnxX9yRMFUENkn
         7yY7eK1t2Hf5aWFWE4r94bhU0Pts87fdAwP2PFWi9V22rhGjvFQD9GweEF+j2JyeXcrw
         RioFJ1Yih/DkSonJqI60CPmazjQZiFq0tZ1cRdpoK48GUdq4baT4ffWTjLg2tSk35twG
         xSw4YDNc2RtbKIDu/zTs/J3vsiVB7ahGCLFq9m1WHllAKEUfi3b8IIoyR9GD7TT1HpHa
         1XzhYUXJnF5x5B0Fz3gX7tRyqahF/kZ6M+hlqbdwfcFvs0jyIHj3WvxB1XXP+YZQYQ3I
         MSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7ul2mtHp6U+xwxNPA6N4h6XzfrNSOVuPWwpcUY8qBM=;
        b=FQ9IFkRfmEIM2kG+G+DJePZM51I6EKE8TutPwicLmSNUbootPXg/3Da+tRNRppDAjK
         U18GNar8P6y7HQ9FRGQWeA2F1uA3566bNUmROIo0MeAy0NUN4QiGbDHioYwcU1dOt71s
         GmsgY+GxHtcL8j9yebWI0fmVloCUZ49sa81g/FMS/hLT0K1wp5EjdjuGJ8wrKn3OxzIe
         n7HRSQHYiS/kWruAnyNE3eRxoLNIfQuG8shj+2GMGZbQ2mY4bfhq+i68/A1+FUTazPuQ
         0EmZiNJ7uU3gMCgPAyQrhJfpKKh/0NTKRaOrfxF51xFBeWDXUR3oHpqXCctWZaBHEWqS
         JmWQ==
X-Gm-Message-State: AOAM533TDxlR8nKwuZfuYSf2rML1ZLJhDEWo/m9NQTh4nfbgkc57WKGE
        wWaKukmPfIvvKP0b0QTzU5vVPXwGuj5UFb/79RPVqmOeIl8=
X-Google-Smtp-Source: ABdhPJyb7Ntv2c8KzUjwzT3h0jelzrxFvanPB4xg5gsMQc9kpysHJpGGCtalvWYnko43dgPlRXwEiicHDM2xuEwOpnA=
X-Received: by 2002:ac8:53c2:: with SMTP id c2mr24922721qtq.245.1608718380120;
 Wed, 23 Dec 2020 02:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20201216130728.14034-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201216130728.14034-1-zhengyongjun3@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 23 Dec 2020 11:12:49 +0100
Message-ID: <CAFLxGvx_xpYprmdwbcGXNZkaaBGZwAeFeyOAgZpM7C+fvOPRrA@mail.gmail.com>
Subject: Re: [PATCH -next] ubi: eba: Delete useless kfree code
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 2:13 PM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> The parameter of kfree function is NULL, so kfree code is useless, delete it.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mtd/ubi/eba.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
> index 0edecfdbd01f..9c2840ffd2e9 100644
> --- a/drivers/mtd/ubi/eba.c
> +++ b/drivers/mtd/ubi/eba.c
> @@ -142,7 +142,6 @@ struct ubi_eba_table *ubi_eba_create_table(struct ubi_volume *vol,
>         return tbl;
>
>  err:
> -       kfree(tbl->entries);
>         kfree(tbl);
>
>         return ERR_PTR(err);

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
