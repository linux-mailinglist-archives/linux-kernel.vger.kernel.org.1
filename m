Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79402268252
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 03:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgINBjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgINBju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 21:39:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA8C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:39:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so11627036lfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnUgkIkMqqnc27k61GemXkCaQKDhpmdd2t1I1NW/d5M=;
        b=tcwpWpINjiQI3CuCSAOSH7LVJDvDgijaT1mRFN4cwQqeY+deg7p2v0y8vQyTvWgTNo
         B/6wj74b1/9VG/HMspppMTng+fAzzpq8NXo1h9ecCcfyNpt8akleTImUGp5X1QJKSbI/
         1IeCg085+ruBXQCb+KzuVPv6OP8xv7e0PUy6DcO0wrbPWkpdRZsSyH5Aw9Nye4tMKyhD
         2mEkvDuTkONfROIkaaZvjnk+hyeXfQMaqdri9oYOu6qePd+13yMmI5msPCJFLwPugcAh
         MfdxKpYUSGLf3ujx645wpHUodzpzhzAqLSHqjMQGwmigah9YB4HI3NCyg1SGS4h/KU96
         CbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnUgkIkMqqnc27k61GemXkCaQKDhpmdd2t1I1NW/d5M=;
        b=YcZS9j6mS/RAm+dUkwlbAwq57IYtxSScYNaiO71e1nfLaHSFZXjXm0UJi7+c/X09EY
         4FFw83dJ5/bbyhlsw0qSjfZOcH/8sA//qWr0TLaaJ3Msuv6qMdMBifgyegnKEwiu8954
         MCoJIDHJQslyvX3ePBgE9zsiRDeIj2f/1U+jW8R4W1x0p9Gfs2EvEXE3eMA3GPlhZNzs
         Q/UBXUazz2+r8UoK64Kd/cV7CuTStAMKe73HPMVClNt3yI45WvAHOh26Wue3neKfTdN9
         4bcSEM8IAu+MxNMvq+lN7XsNDSUdasHuNGIyD5HKbOrdnRaPJ0nsWc6BG5RD53EM2GJb
         h0tw==
X-Gm-Message-State: AOAM532AcUqsyEJQM7NFiLSYpNAgtIGck+Snov3pf8G5gMJQOViei6sU
        cv9drQRP3vVr69Eqv99SCK4UPq5PkybJ1ZhWNZOW9O3z8wo=
X-Google-Smtp-Source: ABdhPJzM8hMuZslEJwFizGAWRCu3KmRYfalUQjGGXfAI6viBMHE0ha0YE+e6gvprk7b9UWwLC0RuBNim05nHq2kNAeA=
X-Received: by 2002:a19:4a57:: with SMTP id x84mr4026278lfa.258.1600047587953;
 Sun, 13 Sep 2020 18:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <1599972131-31770-1-git-send-email-jrdr.linux@gmail.com> <20200913202909.GA1018725@jade>
In-Reply-To: <20200913202909.GA1018725@jade>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 14 Sep 2020 07:09:36 +0530
Message-ID: <CAFqt6zb3=JgD0FPwj9=RNvHRVEQF_fCvaH10eSidwZryTOMZ5A@mail.gmail.com>
Subject: Re: [PATCH] tee/tee_shm.c: Fix error handling path
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 1:59 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> On Sun, Sep 13, 2020 at 10:12:11AM +0530, Souptick Joarder wrote:
> > When shm->num_pages <= 0, we should avoid calling
> > release_registered_pages() in error handling path.
> What are we fixing?

Current code is working fine and this patch is not needed. Sorry for the noise.
>
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  drivers/tee/tee_shm.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 00472f5..e517d9f 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -260,8 +260,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >               rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
> >               kfree(kiov);
> >       }
> > -     if (rc > 0)
> > -             shm->num_pages = rc;
> > +     shm->num_pages = rc;
> Why not avoiding assigning invalid values to shm->num_pages?
> By the way, shm->num_pages is a size_t.
>
> >       if (rc != num_pages) {
> >               if (rc >= 0)
> >                       rc = -ENOMEM;
> > @@ -309,7 +308,9 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >                       idr_remove(&teedev->idr, shm->id);
> >                       mutex_unlock(&teedev->mutex);
> >               }
> > -             release_registered_pages(shm);
> > +             if (shm->pages && (shm->num_pages > 0))
> > +                     release_registered_pages(shm);
> > +
> With this we'll leak if shm->pages has been assigned something.
>
> >       }
> >       kfree(shm);
> >       teedev_ctx_put(ctx);
> > -
