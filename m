Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2F2C56A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbgKZOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389847AbgKZOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:04:41 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E088C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:04:41 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so2448887edl.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2msFitdz7jneyi5nHmujXpbaLFZfcSY4FLaJaH2640k=;
        b=D1LbUTmPTvKUgRmGIV/rJfCW0JlkVcwSY4SyBOipgdzYjUKMiOTSf8irLD4IA8Ym9n
         qfZlNZm8eUzJuFd//Swf+63RvVTsiDA9WnIfFXium5KpySlYdiwpvovai1mydjKR6ZM8
         ly6NiQzxpYPweX4AoYLMbCyqikWGG5/VALPox3MxPiDzuIsyEqEJd8NCWcamyRPzFp/i
         ICV0TU/mX7bFeImElF0Ax7JdPQpoDGEclt0eIIyuAkMZa6+zLvoHwxIwTf02Lfr4V2ys
         QTovNLhRVJjAv4Lo6AFZr99zsmGzQxvGSc9kHbWyV2OzrFCr+94Wn4eDEFncRbRJxH1O
         PLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2msFitdz7jneyi5nHmujXpbaLFZfcSY4FLaJaH2640k=;
        b=sgFVFA1hUtJsW7reVNfIS1gbY3HzorfISpHLfLPU23laZtPcjBU/ybjhTugg7rPco7
         JMqLPn2NHtuPBD7CisSdogJpHeKmsoUyEGGj2bQcQh554pMd+tuQs3DP/QIsHFsCQnpm
         2sg0bkx2kJ0NEWBn4tS1/n5fLrez2+pvtm0p+VFKPfiSS2bsO6VuIeNK8UB1qkxlt6I+
         g96TK36SibZvFtVcw3g12pgkhPxtFmTbB0oomdksgcAnQz7lt0wSiYuvIEAq2TV1Ye06
         tY3BdyIF6uCkYjZJOfUGvcVw8BTDBJZnCXxIEenc1JwwNpgbq0zS6Hy95MUKRkynjh1S
         k4ow==
X-Gm-Message-State: AOAM531ghknPT9DYLh43hMAgYoBjbtC0FqYvfl94i9xFoknz43fHZhdS
        JxEAgumlObxYHyIq0gqsZmukmC8uB6PkwE8UXpB+UA==
X-Google-Smtp-Source: ABdhPJxHwAF6TBjrA3BlhhsXGld+74AMCQCcrgzWOJcVzqJ3JM1iGXjxUIPi+TT0f2Oi5VMsdhtV0xl6k++BTrDYNYc=
X-Received: by 2002:a50:c30d:: with SMTP id a13mr2658012edb.89.1606399479885;
 Thu, 26 Nov 2020 06:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20201125124647.30327-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20201125124647.30327-1-bobo.shaobowang@huawei.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 26 Nov 2020 15:04:29 +0100
Message-ID: <CAMGffEn--=SspdwND785Y7CcxFZhnf_6f86F50wPgSJUbtuEzA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: server: Fix error return code in rnbd_srv_create_dev_sysfs()
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 1:47 PM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Fix to return -ENOMEM error code from the error handling case where
> kobject_create_and_add() failed instead of 0 in rnbd_srv_create_dev_sysfs(),
> as done elsewhere in this function.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Thanks Shaobo, we have a fix for more cases:
https://lore.kernel.org/linux-block/20201126104723.150674-8-jinpu.wang@cloud.ionos.com/T/#u
> ---
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
> index 106775c074d1..5ba1a31ad626 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -52,8 +52,10 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
>
>         dev->dev_sessions_kobj = kobject_create_and_add("sessions",
>                                                         &dev->dev_kobj);
> -       if (!dev->dev_sessions_kobj)
> +       if (!dev->dev_sessions_kobj) {
> +               ret = -ENOMEM;
>                 goto put_dev_kobj;
> +       }
>
>         bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
>         ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
> --
> 2.17.1
>
