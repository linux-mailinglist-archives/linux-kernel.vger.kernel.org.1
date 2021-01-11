Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696C2F0D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbhAKG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 01:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 01:57:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F7C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 22:57:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d17so23131579ejy.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 22:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lyh1ppXIwVihU1vaSfQka7MGwNTcAyGaSNwcJGbRT4=;
        b=BQBzzfbH/m620+N7MJFkTRbdXbHw1MUrP0quVj3E0xdU1n2clxvwAGEiwraS10+8wv
         5YhjkZ3NlYaWjnaKX9eaU0oJjf87JLch1FudPerJMgAB7/qykhrg7meIlOpAS3GcWIv0
         FTHEDoNm/NR1NEbXDTo97QP4rm2/9SUSbQ5aEg/Sk44HEVGROyg3gteWKUGXJPuBSTga
         h1fvzfhtXT3hFNbeCb1DJf7GWqmDCYnxJZknrJn7yfWvsk1Dteqr8oQnR9HkIZlDZQyV
         ztqmSCP7kNR3rhoRWY2IVpXhkK5UxH2D2x9s9J64edPJWJySO1SKjzVGlxafdTuHJz+z
         ciqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lyh1ppXIwVihU1vaSfQka7MGwNTcAyGaSNwcJGbRT4=;
        b=b5lOdvIxPD4sUhBUx+lUBy8+cdvIvRFGA2TXgd4ks4iZ9EPzAbQFxTAQVGL5smMCMC
         be5RBel0U8TJv6fI4pgK/R1/GGchE2x02cYpI+mjNJIktji5CoDRF4J6Nc25P6GsvGAQ
         kVHGhHeFZGNjrKbZkyN2CPvu3uYaxRT5P8rKKm+Ii9LKrkEA6Q1io3WzXSVba8PKHQdp
         iOC31lFBJCo6cO8QN5V5W+dhwF2PfOGOOm/lidUv3kz4PmeLDhG/rfxOxFajcOocVy8A
         ojJX540QvpXEHdY1ISQD2Xch75+wxV1qTtxwuUCfP28734eu0+xe+ashOrp3svCfa7zZ
         Pt+w==
X-Gm-Message-State: AOAM533klUgZNu71VJ6KvPLCMgAylDJynH9WG7Byu+wYwc8Q1qbDF2X9
        nRy0Y6TzzwI1DaSIxupDS9MrTLilmbPUT5cF5pk7Bw==
X-Google-Smtp-Source: ABdhPJxcnwOKJW+7PaRjv13AJnR4ZY6ZtOFxqa2IamjgxWQFkIE/NHsiwfD6EjJH5ZqQEQnEASWUNRA8l4hbVsBzU6s=
X-Received: by 2002:a17:907:4243:: with SMTP id np3mr9714493ejb.212.1610348235838;
 Sun, 10 Jan 2021 22:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20210110215726.861269-1-trix@redhat.com>
In-Reply-To: <20210110215726.861269-1-trix@redhat.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 11 Jan 2021 07:57:05 +0100
Message-ID: <CAMGffEnM0qD68x8bA17gWcqM-PkzveX+E02t-ircy68ses0rGw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt: improve find_or_create_sess() return check
To:     Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, ndesaulniers@google.com,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:58 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this problem
>
> rnbd-clt.c:1212:11: warning: Branch condition evaluates to a
>   garbage value
>         else if (!first)
>                  ^~~~~~
>
> This is triggered in the find_and_get_or_create_sess() call
> because the variable first is not initialized and the
> earlier check is specifically for
>
>         if (sess == ERR_PTR(-ENOMEM))
>
> This is false positive.
>
> But the if-check can be reduced by initializing first to
> false and then returning if the call to find_or_creat_sess()
> does not set it to true.  When it remains false, either
> sess will be valid or not.  The not case is caught by
> find_and_get_or_create_sess()'s caller rnbd_clt_map_device()
>
>         sess = find_and_get_or_create_sess(...);
>         if (IS_ERR(sess))
>                 return ERR_CAST(sess);
>
> Since find_and_get_or_create_sess() initializes first to false
> setting it in find_or_create_sess() is not needed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
Less LOC is better :)
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks Tom and Nathan!
> ---
>  drivers/block/rnbd/rnbd-clt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 96e3f9fe8241..251f747cf10d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -919,6 +919,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
>         return NULL;
>  }
>
> +/* caller is responsible for initializing 'first' to false */
>  static struct
>  rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>  {
> @@ -934,8 +935,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>                 }
>                 list_add(&sess->list, &sess_list);
>                 *first = true;
> -       } else
> -               *first = false;
> +       }
>         mutex_unlock(&sess_lock);
>
>         return sess;
> @@ -1203,13 +1203,11 @@ find_and_get_or_create_sess(const char *sessname,
>         struct rnbd_clt_session *sess;
>         struct rtrs_attrs attrs;
>         int err;
> -       bool first;
> +       bool first = false;
>         struct rtrs_clt_ops rtrs_ops;
>
>         sess = find_or_create_sess(sessname, &first);
> -       if (sess == ERR_PTR(-ENOMEM))
> -               return ERR_PTR(-ENOMEM);
> -       else if (!first)
> +       if (!first)
>                 return sess;
>
>         if (!path_cnt) {
> --
> 2.27.0
>
