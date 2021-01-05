Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE02EB12A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbhAERPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbhAERPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:15:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED857C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 09:14:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i24so1293490edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 09:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+304jrLdAurAmJH5NqHDACRNonQepT8iVWzqqXWcJc=;
        b=Xj6/eR9CvYPYbUrKWvQ8JDsfo+OG5VqNCb3TwIdnvnN9ufJzbYW1DQuM7TsK42+6wU
         q6BgmCCUZKHwPHxiClDijJkO3L5Pve9zzH3t1tHJXZWZlfyicKrzNxY1y9bV15qdWfeN
         pOsY7esyazalszVXu8funaSICWEGLnvZxMAKZm9LJmP6JZs3QS2bNoNPR7FEny/Qz8y/
         g8sxQQl6FhxoPgEV29Vg9PKYbT+VeBqiLPSqfK+Qo/nJ5u0gYgTlcdixsSY7c0MNbooh
         7BDZ/u/AZELOhjJFf445H+hVE8s9OrRWob/IKA41AiK72OhyY/b4utuBpig6AQgLPefj
         do2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+304jrLdAurAmJH5NqHDACRNonQepT8iVWzqqXWcJc=;
        b=es6Q10my6aCA2LixbFxEo+oAPBG1Whj5G/O4hwc5uheda614rsk8XYE3b0oU/yjFoo
         NVIY7xxDCynu6DO3XMek+Z/ioL/eQSr13VPUt3qzGziZyCbrJaxs9P75sNIjwxxizGWa
         +lEqj0ujDfERP16VMXh2s+CNLVrhy3iFCdi3/i+S3Mr1izI9dSVn7KhuKL5HNEQJwvc0
         wracEG3R2H3RzVur2Aplut6RRkZS+oTFGV+GX0KyYwp1qKINFe753pTHw/ATvNfAetQ/
         XupUavIPlOz1SzNJWK/GQDIwEUTw2zk5SczHAmfh7nvVXuYmjHq0nd9dB1LYW851kaYa
         QHCw==
X-Gm-Message-State: AOAM531RoJwEXXzB6dkCirCDAKZfH4gQ2DjhKU8+YEVL5ISv6TBRouiw
        CpHBYjsButdzGVEg0gm1iS6bbPsqGXLfLJWmlQ4=
X-Google-Smtp-Source: ABdhPJyZ0yJFQ+aCP6nEoSqqYgjLKcz/grwxVjrn9wNYJdtq4qsQ6W5Uw5RgFtiwGIWKfOLkjzAGHY8cTfAStuMapDc=
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr792831edr.366.1609866863724;
 Tue, 05 Jan 2021 09:14:23 -0800 (PST)
MIME-Version: 1.0
References: <456a021c7ef3636d7668cec9dcb4a446a4244812.1609855564.git.jstancek@redhat.com>
In-Reply-To: <456a021c7ef3636d7668cec9dcb4a446a4244812.1609855564.git.jstancek@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 5 Jan 2021 09:14:11 -0800
Message-ID: <CAHbLzkoN3bdnHa-xOmGWQhN+dw7AQtbwygsH=VS5or=QoBk0Jg@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: initialize err in do_migrate_pages
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zi Yan <ziy@nvidia.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 6:14 AM Jan Stancek <jstancek@redhat.com> wrote:
>
> After commit 236c32eb1096 ("mm: migrate: clean up migrate_prep{_local}")',
> do_migrate_pages can return uninitialized variable 'err' (which is
> propagated to user-space as error) when 'from' and 'to' nodesets
> are identical. This can be reproduced with LTP migrate_pages01,
> which calls migrate_pages() with same set for both old/new_nodes.
>
> Add 'err' initialization back.

Thanks for catching this. Acked-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: 236c32eb1096 ("mm: migrate: clean up migrate_prep{_local}")
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 8cf96bd21341..2c3a86502053 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1111,7 +1111,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>                      const nodemask_t *to, int flags)
>  {
>         int busy = 0;
> -       int err;
> +       int err = 0;
>         nodemask_t tmp;
>
>         migrate_prep();
> --
> 2.18.1
>
