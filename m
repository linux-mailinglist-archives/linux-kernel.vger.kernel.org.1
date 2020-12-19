Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659802DEE25
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgLSKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgLSKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:21:22 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806AC0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 02:20:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id y19so11859936lfa.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 02:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KuMNpEWRPz2T71g8hiLTxxkoiK9tvmHyh46ViDzZU4=;
        b=tdwnV2QUnapSUPLlbQ2+uohghX+wGoEaVxuEh7qeg/6XNoRfCe/HWZtWZp6qXKL+rZ
         H29h5u2iN0L+1gXvix/aN7d2fr7v/UdVAmTH5pCBj7g0BgMoDqwXhJvvlGxMDWtN4HGn
         0Z43YzSDxyXqWwdhmMQkFkwpz86Bmo2kkBiTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KuMNpEWRPz2T71g8hiLTxxkoiK9tvmHyh46ViDzZU4=;
        b=IgYN6TFKq9y5CQabAqi0PZnmZYVxakB6YC2GJzMcYF9I4KkO+a+4qn9bN3IsArl/8q
         eEMolW3Ra6aQOEHUKKs8TR2jExEsvfLA82VU3cYy/bj442v7o/c0b4xvjFnQ/KFvrQga
         l3dW66dejHlx2ktq9w3zAayRT8a0hzL5bGbhF0keb8BEvrZIWjhadohT7yScq28Bqym1
         era9OuZncF36VPIHmkG1Fs35L2EZi2URcvEARQU0xVX6QemNs/0dD7xgglNWcq9+WdjN
         L8cLNzdbE7GrPn8VY8tNK8wmTnf53JlAUVR5/Qw3MQ7eKvWy79QHdqvc9teZ8aVyJYwz
         +xgg==
X-Gm-Message-State: AOAM531JCARJfitMQbAZuxYfu2/as6mAbprDerOnu1l48dLEPkvNZHmT
        MuAcwMS1EJca4vdBz3YnJ/FQ0EAncplL4CtdgX6snw==
X-Google-Smtp-Source: ABdhPJyS5237VjZv8BaL8lzHDUw8/UMYpZzMyH8GXJUJoKKf130EFm9+Mt6/YnPzIPmJmwoia5/r7JZ7q9rUZreszHQ=
X-Received: by 2002:a05:6512:54b:: with SMTP id h11mr3211671lfl.407.1608373240114;
 Sat, 19 Dec 2020 02:20:40 -0800 (PST)
MIME-Version: 1.0
References: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de> <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de>
In-Reply-To: <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sat, 19 Dec 2020 11:20:29 +0100
Message-ID: <CAM4kBBJYZzbXAixrKvy9MeO2eUsVVi8=iUBUc+pbSMXudy7hkw@mail.gmail.com>
Subject: Re: [patch] zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap()
 might_sleep() splat
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sat, Dec 19, 2020 at 11:12 AM Mike Galbraith <efault@gmx.de> wrote:
>
> (mailer partially munged formatting? resend)
>
> mm/zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap() might_sleep() splat
>
> zsmalloc map/unmap methods use preemption disabling bit spinlocks.  Take the
> mutex outside of pool map/unmap methods in zswap_frontswap_load() as is done
> in zswap_frontswap_store().

oh wait... So is zsmalloc taking a spin lock in its map callback and
releasing it only in unmap? In this case, I would rather keep zswap as
is, mark zsmalloc as RT unsafe and have zsmalloc maintainer fix it.

Best regards,
   Vitaly

> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Fixes: 1ec3b5fe6eec "mm/zswap: move to use crypto_acomp API for hardware acceleration"
> ---
>  mm/zswap.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1258,20 +1258,20 @@ static int zswap_frontswap_load(unsigned
>
>         /* decompress */
>         dlen = PAGE_SIZE;
> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
>         src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
>         if (zpool_evictable(entry->pool->zpool))
>                 src += sizeof(struct zswap_header);
>
> -       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
>         ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> -       mutex_unlock(acomp_ctx->mutex);
>
>         zpool_unmap_handle(entry->pool->zpool, entry->handle);
> +       mutex_unlock(acomp_ctx->mutex);
>         BUG_ON(ret);
>
>  freeentry:
>
