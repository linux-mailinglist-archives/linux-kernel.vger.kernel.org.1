Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60F2EB1F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbhAESFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbhAESFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:05:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF58C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:04:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b2so1583312edm.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9dWEenEa1Tbu2wF3XZKdyzz1Vq1iEFWmTgkC1pdmgE=;
        b=gbHxkwq9CjvYKdpKPtd2ZRrJEAevgMtRmYOb22xACgeJQuGsT2kP/c6aINE2iyvqDh
         tdJH1JdM40naCrddYIyMiMsUENx53xvhNMADzgLohYngGBuX0McumeV6/7gbDztyy67e
         oWl8U90wipDPcVTOylJwuJSgvaDFkudEhEdKy0z85h+dvWIYq7TwqJjK1ZliE9r37x/P
         Nf4fANZwZ4WLBw5I2MbWU9tvHHR6hqLH2dvzrurTCXvRUtgJojsDVF1GeWEzRPdTR+Gp
         hOIQ3Is353X0KpdkYQhw8Amkqx+8xBUZcDw1Zb4JxHmT1787wDciaHU+koprkXTiO/cc
         LzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9dWEenEa1Tbu2wF3XZKdyzz1Vq1iEFWmTgkC1pdmgE=;
        b=oosAlngV3/Z6yMgUX0uf1uyN83QogfFui8CIVMz7MY07OW1yKUkA3dJJcIRb4bE3BI
         pO4EN/TVoFoL55hoIN6yCKkrQbwdLzehq90/exczTxUdGUs+vQ8+PMkBPIuvlAMxElt+
         TTV57C/0ePkMbjLi53hJfM/Rz+kCNvdn9uCYWtxfKzWp9WEdsJH0M0I+ozCUdZdQZ1VF
         p29OjuiLEo/eMyWaDIuvLKdA2Cbwrt0i05JgwvFJwRYBGyMIBmpKU51rGX9lEKhPjjVh
         uyVumJRIyfBk/ghHvgRQsvfcwcTRIn4WUU5Q62Jla+lMnIvFLToIGFDMwL+IvdTm3VPi
         eY7Q==
X-Gm-Message-State: AOAM531e1z+g73GH/pM5hNvsm336Qd7MuBD6yuk0MtRs/0MD7Tp4PQY0
        2iBs4vS02wZYbkOv4xMGpgq2Qu0VSogCfyA4YLA=
X-Google-Smtp-Source: ABdhPJy2q8y1vT9nVv1PXe/O7TiK+riynHFEQmh3eJty2cejYpnhb5xJ60LuQuiK08rsZfPpjTkqH1DQnwPYWgp75Ss=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr956808edb.137.1609869865933;
 Tue, 05 Jan 2021 10:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com> <d81664e1-bde0-4dcb-f602-6eb201ceada0@redhat.com>
In-Reply-To: <d81664e1-bde0-4dcb-f602-6eb201ceada0@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 5 Jan 2021 10:04:13 -0800
Message-ID: <CAHbLzko4BH6GOJsz33NEbwLTxJQJxVHH3qLzHzoM1LycT=ccbg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Tue, Jan 5, 2021 at 8:58 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 04.01.21 07:58, Muchun Song wrote:
> > If the refcount is one when it is migrated, it means that the page
> > was freed from under us. So we are done and do not need to migrate.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/migrate.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 4385f2fb5d18..a6631c4eb6a6 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >               return -ENOSYS;
> >       }
> >
> > +     if (page_count(hpage) == 1) {
> > +             /* page was freed from under us. So we are done. */
> > +             putback_active_hugepage(hpage);
> > +             return MIGRATEPAGE_SUCCESS;
> > +     }
> > +
> >       new_hpage = get_new_page(hpage, private);
> >       if (!new_hpage)
> >               return -ENOMEM;
> >
>
> This series seems to fix quite some important cases (thanks). Do we want
> to cc stable some/all?

For this particular one, I don't think so IMHO. It is an optimization
rather than a bug fix.

>
> --
> Thanks,
>
> David / dhildenb
>
>
