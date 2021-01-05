Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604D92EB204
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbhAESFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbhAESFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:05:40 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B0C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:04:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b73so1466643edf.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XDnRNruv1BMN32pgPpm0wYF2+zLKqENUZJC1YcQG8E=;
        b=UMmnZ7onPSCcBs/9pq3qdK0GKHAyO+Sslt6oiVhPTtbpSmnsvh1uwAkd81ohspRKrY
         E8nBzprH+kCMQarh7Tk+smtUsZqJ7rYkpmN8hUsfwnnrCY+h8WJeJy+q/9S4EMo/nItA
         5tB0f+6sktCE1+N6Akse8qaRQdyf4URe+uoB/Dmei6HSX+ofZYR7079IE4KC3C/dzk0p
         /ZGLCNmL0ooYEWw8OaC72La+EMudidWjXATKfOi94Txolpr4bSJksHv7RxJ8IVpzPUs4
         EU6MYyqU+SDuCnUlnsYKF9ADMAGbqv4MEbcdZVvOsvCaRIOpllpV3cXE1OlTc6S2xpu/
         0XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XDnRNruv1BMN32pgPpm0wYF2+zLKqENUZJC1YcQG8E=;
        b=YMlwopNREuuV6C+aR2vR4AkH5G60MBU1Ac3V8BB7XXjlGvFzt73kfvpC3e5ydN1w/2
         NBEzGmOUxh/PEy5OQM7oaF6rMKT1RSMQY6H+U5qqg8nXP/YZ4ecRZMZye0Ku0om8ZVRi
         6PYFrn0lestRsoM/tie9TUt2SZCn77+w8Qc5lOBF/xsUGayMKxX8gy4l7djJYjKXGu5Y
         5Csj862cohtond3s/dhvRoBNcOz+G9i0YPxfKGt7TDsHNRVyhzE0kqqbgxImMwcCzwio
         NnJSmxgul/VlO9JoS257MBHWineGiNfGBz0G5wpIZIKVnkVjtvs6XjYaSP5odaDH+abz
         yN7w==
X-Gm-Message-State: AOAM531PNioH7KHxkXeUvCTYMsyNB5kF6bIIU2ps6xyu06yTbSPodY3r
        fGhnge3NTR5yOldMCraxMGEp4oZCH0/QQ7UA2ms=
X-Google-Smtp-Source: ABdhPJx+L930FDjLcQS1ibgZAJNKrpVQt6flaJ6sFWwBPA8TLp5Vkh+bzsAAQzJrLnTl5xc+J4b460PrAVLDVpN7nEw=
X-Received: by 2002:a05:6402:746:: with SMTP id p6mr950652edy.313.1609869897809;
 Tue, 05 Jan 2021 10:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 5 Jan 2021 10:04:44 -0800
Message-ID: <CAHbLzkpNKzL052VQxFaOnwSGSMMFDzZotk8KRa_4LVZfO134ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        hillf.zj@alibaba-inc.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 11:01 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If the refcount is one when it is migrated, it means that the page
> was freed from under us. So we are done and do not need to migrate.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/migrate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4385f2fb5d18..a6631c4eb6a6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>                 return -ENOSYS;
>         }
>
> +       if (page_count(hpage) == 1) {
> +               /* page was freed from under us. So we are done. */
> +               putback_active_hugepage(hpage);
> +               return MIGRATEPAGE_SUCCESS;
> +       }
> +

Acked-by: Yang Shi <shy828301@gmail.com>

>         new_hpage = get_new_page(hpage, private);
>         if (!new_hpage)
>                 return -ENOMEM;
> --
> 2.11.0
>
>
