Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25112E17B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgLWDTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgLWDTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:19:15 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0CC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:18:35 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id b23so8117121vsp.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5KXo634H8AVrpIQXiO9dBjapAtxmnNnBHRzxwMdKHI=;
        b=ddWCSCSOVyDtaeo9kTlkAlOUWYOzibX3dY5zQx/TVmggiAtgYdW4qFQWOO+ZCy84z7
         1tvbFWNHFCZgDfx9uBoiyqHpHJ/olkcJTAFuFVcR5Q4U1oglqseDij8BYP4L3SnuATfK
         gHZpy90/od05DqxaeqBpU6/YTQGO2/oLJxvvVgrb8l3RE4pBDBUvLifNNzVpKE0UHwBZ
         FtlnnRWEkiL1KORtDfbffhXRvBHqAXSDtN7cWmiw/pjdfeYbp6NMbUAh9U8mJUv8GGGY
         yaqAL04PY4xTDaicVRu4AyhUAlLLhFSzNdPGQvp3sq3PzPvoFaZhRIkM88q4M1VetsHY
         Vxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5KXo634H8AVrpIQXiO9dBjapAtxmnNnBHRzxwMdKHI=;
        b=Ak3PLyw38FPViVzeEJSXj+8SyRTIBUoFf0R1T3Y4mny1C+EO2wyQpc1kce/ms0Zirt
         80nx3crMaZxkJhk7ujEPybwmaa3Zm4rVr1VXCxFU/wilY6ZMRrZqoTwMICQk/GWTpaZY
         K99Ae20NwKCX4khHY/MeATLiIiJn84h75rZyHaN4V8yqZ6x2i2Q8rpVMlysI6lvvYYb4
         dKWy9HOj9BRbv6gryzLQr6CJIIS4dRKIgR2AvNKBl+27d4b1mK4sj2bxS3LvGr6r/+C3
         lwvATrxYdgFsv2cajrwx6UZWvLjOmQEdQAn2dRBcimxzRhBFm7S8Sgi6vo7z62N+Zzld
         ZwuQ==
X-Gm-Message-State: AOAM533pLPWHeSYaXz1Cz6bEMsj96bdMOXUWQ4ZpaESeSC6DHQcymecp
        do5y1OhoLPy4YmEBlncmH/8AyQssCXs91uT7uF31t1Pl9J4=
X-Google-Smtp-Source: ABdhPJx5IFP+CAFnNip3g0AbUoczXHv3s7OphmQOQhMSSTxC5tq3keIB7vO7XVHQWAlM9j/UszqQqtPWQlznnzzD6mk=
X-Received: by 2002:a05:6102:215c:: with SMTP id h28mr17070685vsg.58.1608693514664;
 Tue, 22 Dec 2020 19:18:34 -0800 (PST)
MIME-Version: 1.0
References: <1608693378-4392-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1608693378-4392-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 23 Dec 2020 08:48:23 +0530
Message-ID: <CAFqt6zY5bh3TzA3giymxN2=37CmCTV-dL6mjKR4nkH6m8r-AOA@mail.gmail.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 8:46 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Otherwise it causes a gcc warning:
>
> ../mm/filemap.c:830:14: warning: no previous prototype for
> `__add_to_page_cache_locked' [-Wmissing-prototypes]
>
> A previous attempt to make this function static led to compilation
> errors when CONFIG_DEBUG_INFO_BTF is enabled because
> __add_to_page_cache_locked() is referred to by BPF code.
>
> Adding a prototype will silence the warning.
>

Please ignore this patch. I forget to update version.

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  include/linux/mm.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5299b90a..c1e9081 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -216,6 +216,13 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
>                 loff_t *);
>  int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
>                 loff_t *);
> +/*
> + * Any attempt to mark this function as static leads to build failure
> + * when CONFIG_DEBUG_INFO_BTF is enabled because __add_to_page_cache_locked()
> + * is referred to by BPF code. This must be visible for error injection.
> + */
> +int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
> +               pgoff_t index, gfp_t gfp, void **shadowp);
>
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>
> --
> 1.9.1
>
