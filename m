Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6D2F498C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhAMLEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbhAMLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:04:40 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976EDC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:04:00 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so1001570pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq0sIowdqwCy9ipBvQmxiVHT6coiYZ3i+NvaIZ45Kq8=;
        b=nNNuIxA8Zxb5hbY0dGnCfyTJ3sc3lW+PoG3W/0Kn8axCab7hhhojw4MbztYBa7UcdX
         vIFyyqhzjBr7ZUwfkfkz4UkNmiydfJ6qLbxpAjmpMRlCWQeEk5LKTk50D+pBxFBF2uw7
         /4TFsvAf76lqDypT4xR5Ih1h5usJYuZ30f9b42Apiktc7u6kMuqAQ9qk13Vafe9y6t3o
         55zky9/snLZByYPZ1ObmtYpdNb1jCET5se6kdCOZB9+6tmbh4/URWMQ9r75kAt0cYJAO
         muJWJS1rZR6AbkYUYWSGJ3mpfL4FZGi+SJG93HgyRJ6tHS2EYtaGtRceh9FwxMl0Gff9
         Y1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq0sIowdqwCy9ipBvQmxiVHT6coiYZ3i+NvaIZ45Kq8=;
        b=DvNucXe6pSyzA7IdSEd3RHqy9Al8TvI62PMDBYXcZ8FXtNiYZ/oeT+xQwpEu32cAPU
         9nzGhehZ0qkFlD6w+rd9QJG1CWPXU/JPuo4CUdQJphc7jjWOl9Cwvosts+mU7TVw9ht7
         uac+ukOj0hBMf8hTQbOucF+SI08petdpNRxXhdl+hMTgpumCSu+FswQLIuMvlZjUuzHJ
         6fb/jzUNq/i3cEji/8csvXRdD2uRT0I1IGLTcLnyrwCxdcgNinrSRZ3oO3k5YGFiYd4i
         K2CmLLRtBZOXSKAhAyqAuaGNAJuKwiLIVW/YXYTozN5vNvp4a8XqvhsT/wffTGw/F1oL
         EFlw==
X-Gm-Message-State: AOAM532zGwqe+SXuOXRzcCyZXPBQj5dtUjyBqdym/Unj2bYqR3ienhJc
        XKXGzkBmufwk33vLsxVlpryLoIvzOKgBrXty2ZEANw==
X-Google-Smtp-Source: ABdhPJyn+jUaco2N/T1+7oLFKfPMaFPzzCfwa/Phoij/8DTFE73bZ00WKAtENC2GHM3mKzUcgeQr23uxu9JK2Qhrb6o=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr1589804pgf.31.1610535840163;
 Wed, 13 Jan 2021 03:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-2-songmuchun@bytedance.com> <20210113105657.GA26599@linux>
In-Reply-To: <20210113105657.GA26599@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 13 Jan 2021 19:03:21 +0800
Message-ID: <CAMZfGtW52Du6XXVSGcziFG8HSK5G=Xu12p7-F+TOjWM0hizUkQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 6:57 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Jan 13, 2021 at 01:22:04PM +0800, Muchun Song wrote:
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
>
> I was a bit puzzled as why we did not go to the "goto" block that already does
> this, but then I saw the put_new_page/new_hpage handlind further down.
> It could be re-arranged but out of scope, so:

Agree. I also thought about this. :)

>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>

Thanks.

>
> --
> Oscar Salvador
> SUSE L3
