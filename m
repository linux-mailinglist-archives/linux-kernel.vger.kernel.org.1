Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67431E95EC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgEaG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgEaG4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:56:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E74C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 23:56:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x27so2087172lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BRC6PxCMSYpQthUGruvzlpBcl495wDuecekOV8RiOo=;
        b=hp154xEXW0lFEZ/FL0iQxEQb8rTUQ4p8v7y88Cxfy6c1JqanuUMZGtcyDHWtGMWqIz
         kr4GFicgGI7jZDiaUiem4TcOAhlc2+uKmxoSnXwcouTtPCBFtUTaJrboDQP1VfbZyvWG
         8MuxL1af1+87ncWSw+FnjCGGSo7u+ImRTrPY5tYdjXhTt5Qh+0yuDHIcz2cb91nQ3AUj
         waUBjMptzjjW1w0bRJFK7ZauSCKSCZLwxdqNqc4hSQIp98+cMdkSTsVPhWyzavAZX4Ta
         z/jo15cXW19y4/jp8mwXI+TG78VWNe2jUeNtu5fZMLB6xgLhJ8yRjMVf2w5eus3WiFS9
         R8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BRC6PxCMSYpQthUGruvzlpBcl495wDuecekOV8RiOo=;
        b=DpbFYcJ2NTZoqHpnyYQWRRoVZaWv4a/JOY4esbmUrRt6XWoUdySthGF2M5gwFaqzuS
         8VLdbuFFdRGWp7DZFhrYd7K8UCk0zp3UmM3anUcnzdkcncpufwS1VxtA7ehV9IKAuGy+
         EUnrvb8gurV4pxf70wGWVsTCLz/oxJIj6t6Kfoq3Hr1DXqg1e64fnyns1P2TuiLoazcT
         w7zOF8m/H6XWPefrzlqUz3tervQOjeiBNqynFZGQ3Yv1Pwgro9dUMC9ItkyKie0UzYlH
         TiMNh7ge1bnDMNHXs2v3kFTWhzjJGbH/ssdN57LL+Lt22vYIl4ihNyXiySa0IDXtjvL5
         LKPQ==
X-Gm-Message-State: AOAM531IwyOw3RdW7wmH7LsxNBlw+Uocm6pyxv9eJIMBjaNpeUY5rJ7f
        FLju1y9gxHsLOBiyElb5OeGoBVRuY99Z2A8fLFjkDjIEPIs=
X-Google-Smtp-Source: ABdhPJxIwy8oPSu6L5LEFDK1LdboBwKXWJr49JKRo2X72wFTEPqlMAldg5WQGbZwJ9U6IXioSOeRxLU3tP9w0qma7Is=
X-Received: by 2002:a05:6512:3208:: with SMTP id d8mr8453516lfe.38.1590908197035;
 Sat, 30 May 2020 23:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200527223243.884385-1-jhubbard@nvidia.com> <20200527223243.884385-2-jhubbard@nvidia.com>
In-Reply-To: <20200527223243.884385-2-jhubbard@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 31 May 2020 12:34:45 +0530
Message-ID: <CAFqt6zZr9rUZaXEpjwmtmicdNP9KhJ8UrjPPjk4bMHJ20VsVsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/gup: introduce pin_user_pages_locked()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 4:02 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> Introduce pin_user_pages_locked(), which is nearly identical to
> get_user_pages_locked() except that it sets FOLL_PIN and rejects
> FOLL_GET.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/gup.c           | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 98be7289d7e9..d16951087c93 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1700,6 +1700,8 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>                     struct vm_area_struct **vmas);
>  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>                     unsigned int gup_flags, struct page **pages, int *locked);
> +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +                   unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>                     struct page **pages, unsigned int gup_flags);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index 2f0a0b497c23..17418a949067 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2992,3 +2992,33 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>         return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
>  }
>  EXPORT_SYMBOL(pin_user_pages_unlocked);
> +
> +/*
> + * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
> + * Behavior is the same, except that this one sets FOLL_PIN and rejects
> + * FOLL_GET.
> + */
> +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +                          unsigned int gup_flags, struct page **pages,
> +                          int *locked)
> +{
> +       /*
> +        * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> +        * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> +        * vmas.  As there are no users of this flag in this call we simply
> +        * disallow this option for now.
> +        */
> +       if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> +               return -EINVAL;
> +
> +       /* FOLL_GET and FOLL_PIN are mutually exclusive. */
> +       if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> +               return -EINVAL;
> +
> +       gup_flags |= FOLL_PIN;

Right now get_user_pages_locked() doesn't have similar check for FOLL_PIN
and also not setting FOLL_GET internally irrespective of gup_flags
passed by user.
Do we need to add the same in get_user_pages_locked() ?

> +       return __get_user_pages_locked(current, current->mm, start, nr_pages,
> +                                      pages, NULL, locked,
> +                                      gup_flags | FOLL_TOUCH);
> +}
> +EXPORT_SYMBOL(pin_user_pages_locked);
> +
> --
> 2.26.2
>
>
