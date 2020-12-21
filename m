Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E162E0091
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgLUS6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:58:51 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B6AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:58:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m25so26092539lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/pMFitTeMS+SZfLhILcW8lAedkFnNH/feyJuKcA9ek=;
        b=g9GyuadCYSxVzn4tADWDBbWTq3TfRw2c2Ofi3qE5PVtEAKYFtMDTyhnfV/7MUWmLmv
         P34u2MAbS5Z1mdsC/wXjzLtAvEWmvHzmuqowTwqds9XHAYuZHz9WFpM6qIT5d/FkCfMJ
         hqmblE3/00jmRCzd5pNHQI5JcElWJds/D1b89cqQCM8+9Nl69Ia0qnvDida55uNQq4Eb
         cIlYJ38qa12sH3k/JJS+jbf3tnM+u7y2u9AK+0UnbVclhOhw4BRRyifnpg9SZx1G72XS
         pV1orEjGjG1FHKvls16Ry90CXz5BJKUgZMY/FrDbiSAZ94U0L9XyQvtqUuBWgpUzLuIc
         Vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/pMFitTeMS+SZfLhILcW8lAedkFnNH/feyJuKcA9ek=;
        b=ZipA9UpIt9frImzfz2Q0R65hgB0oZ5e1yAg9GT7fpOf9u3ompjq66qP8966JbVIwTf
         +K8Pf+dKR5rsCZdcGWgeJEvjFYF8vV1WbU8v4VSwKgIktjMlgx8ZY6+/RovOp4ZG4bum
         nOQE4GSPzcBlflMOmOHYjMLBY+zuQUHremaRlYdfDtKoH8KZTMvlYvFyacV7pZgVVITc
         l/1oMZPPcqx7xQS5VEluemUYv0bbPt4IJElFpAImg9Jo3k01eK7SpevGRinbioWFrwuR
         yMAoA9zBxIK7A1F6X9G90weYQ+1kIhO/oyVHnbVQIa89tHnFeWKDp+qxAUPUHaxPq3W5
         jAKA==
X-Gm-Message-State: AOAM533297mNQ5K07+BIN/HSEq02VSP79i+LQGpJ1QUnT0OM5vB7gHf6
        rjt3YOaS2x6WQRoupLU7vZ6+znz/0/lauaYE/brRbQ==
X-Google-Smtp-Source: ABdhPJyxrKg97zBWXTkyrsWFhF3VCzkHd45rp5oHml2UwhRkwsders8MGcLgCppQHKJbB9yyPqE+I1QvMFPVbJt+5wU=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr8051416ljg.155.1608577088932;
 Mon, 21 Dec 2020 10:58:08 -0800 (PST)
MIME-Version: 1.0
References: <1608277668-3740-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1608277668-3740-1-git-send-email-huangzhaoyang@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 21 Dec 2020 10:57:57 -0800
Message-ID: <CAHRSSEwGHqQHRzyBUAyqVZk4azr8aeJ_Hgw=_XzaSkfTiVEBcg@mail.gmail.com>
Subject: Re: [PATCH] driver: staging: count ashmem_range into SLAB_RECLAIMBLE
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Hridya Valsaraju +Suren Baghdasaryan


On Thu, Dec 17, 2020 at 11:48 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Add SLAB_RECLAIM_ACCOUNT to ashmem_range cache since it has registered
> shrinker, which make memAvailable more presiced.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 74d497d..b79301f 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -893,7 +893,7 @@ static int __init ashmem_init(void)
>
>         ashmem_range_cachep = kmem_cache_create("ashmem_range_cache",
>                                                 sizeof(struct ashmem_range),
> -                                               0, 0, NULL);
> +                                               0, SLAB_RECLAIM_ACCOUNT, NULL);
>         if (!ashmem_range_cachep) {
>                 pr_err("failed to create slab cache\n");
>                 goto out_free1;
> --
> 1.9.1
>
