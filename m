Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343562CE6DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgLDEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgLDEEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:04:45 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D9C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 20:04:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q22so2781502pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 20:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eDAiT8JpRdOpG10yNUSKknpQ9yn3vAvz1tZiPhPn3k=;
        b=fwVknYJb6jPBmqvk6s6cfeEUQx+gsVHVu78ys5R+u0CDGq4UWVO0sUdnc1thF2NHGy
         RTkZJ8aqha4+ap8yz5AvnoPwVl3NJyrHwAyd8N/bSdyuJikCfmwf+SgSywJ7VP0MOyH1
         IG+lSErohD9I2fTblNKKlBRf0PlUB3R9AVdSxwmNdGSYyZWSnwQxQcUiuC3CHZ8TwLpp
         C2pTyCNfC4nQQ5yDFUeJQpacZnf/iU63wGNKT/7aXtTw3FWaRLcnTI3haf7rsbQTIXo3
         USQZiYC5ogIhBcYGwEJJAdq4ahonSkjTzgpuWGo1egHCZ4eXoXlUuTXbCeXFRiktCWUy
         Vb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eDAiT8JpRdOpG10yNUSKknpQ9yn3vAvz1tZiPhPn3k=;
        b=URFHChWPneigy9Vz3aBDrtVulfnNf/MxE2eWpJJLh+UqKWE+WhOTQ5SfRvnuuXOBmL
         Eu5WSCZNvhpuaZBd8QdxNq0K1Upkzv5eglBPj27rD4pw1xDbXDhrltbIUMFjk/JRmdAC
         iHj7yEnOzqAvo/x9jmnolBL+f31Cpsy1yJiVxnS/q80iVXN7vARoBojMd1ULCM0ajYjS
         oqe1UWznl7cYBijcA/5didnThf/85CWtznb8ae7QQmgdECqDwK0sYcVR0pHTPH1HGJjZ
         tGgkiSK31luluSeLTBzjy1Zb0NsFYmmOs20hPVU+KeYHl2012Uqyz3eQVwTI+7RSdHvg
         uq3g==
X-Gm-Message-State: AOAM533cr2cAODYBMMYWJW4aicjVNPruOFZql6Fzj77Prqd3HEQZJxX+
        /HidjVuZ5bHr4hBwILMys9+8DRrWRSJi55XOAj0TOw==
X-Google-Smtp-Source: ABdhPJyhRx3B/Sl+EWbtdAIQ7o9hmGRtatp3AEm01dQvzs1sJ2EfeJQpUqP1ABanFUAqEehdsORysmAoAGm3k5yrb+8=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr1992887pfi.49.1607054644672; Thu, 03 Dec
 2020 20:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20201202121838.75218-1-songmuchun@bytedance.com> <320c8522-4ed5-809f-e6fc-8a185587519c@suse.cz>
In-Reply-To: <320c8522-4ed5-809f-e6fc-8a185587519c@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 4 Dec 2020 12:03:28 +0800
Message-ID: <CAMZfGtUAWSoH+HanAoifUGad_hfSkbR=x_8ZBdFMiMpoxmGcaQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/page_alloc: speeding up the iteration
 of max_order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 1:37 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/2/20 1:18 PM, Muchun Song wrote:
> > When we free a page whose order is very close to MAX_ORDER and greater
> > than pageblock_order, it wastes some CPU cycles to increase max_order
> > to MAX_ORDER one by one and check the pageblock migratetype of that page
>
> But we have to do that. It's not the same page, it's the merged page and the new
> buddy is a different pageblock and we need to check if they have compatible
> migratetypes and can merge, or we have to bail out. So the patch is wrong.
>
> > repeatedly especially when MAX_ORDER is much larger than pageblock_order.
>
> Do we have such architectures/configurations anyway?
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/page_alloc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 141f12e5142c..959541234e1d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
> >               pfn = combined_pfn;
> >               order++;
> >       }
> > -     if (max_order < MAX_ORDER) {

If we free a page with order == MAX_ORDER - 1, it has no buddy.
The following pageblock operation is also pointless.

> > +     if (max_order < MAX_ORDER && order < MAX_ORDER - 1) {
> >               /* If we are here, it means order is >= pageblock_order.
> >                * We want to prevent merge between freepages on isolate
> >                * pageblock and normal pageblock. Without this, pageblock
> > @@ -1062,6 +1062,8 @@ static inline void __free_one_page(struct page *page,
> >                                               is_migrate_isolate(buddy_mt)))
> >                               goto done_merging;
> >               }
> > +             if (unlikely(order != max_order - 1))
> > +                     max_order = order + 1;
>
> Or maybe I just don't understand what this is doing. When is the new 'if' even
> true? We just bailed out of "while (order < max_order - 1)" after the last
> "order++", which means it should hold that "order == max_order - 1")?

No, I do not agree. The MAX_ORDER may be greater than 11.

# git grep "CONFIG_FORCE_MAX_ZONEORDER"
# arch/arm/configs/imx_v6_v7_defconfig:CONFIG_FORCE_MAX_ZONEORDER=14
# arch/powerpc/configs/85xx/ge_imp3a_defconfig:CONFIG_FORCE_MAX_ZONEORDER=17
# arch/powerpc/configs/fsl-emb-nonhw.config:CONFIG_FORCE_MAX_ZONEORDER=13

Have you seen it? On some architecture, the MAX_ORDER
can be 17. When we free a page with an order 16. Without this
patch, the max_order should be increased one by one from 10 to
17.

Thanks.


> Your description sounds like you want to increase max_order to MAX_ORDER in one
> step, which as I explained would be wrong. But the implementation looks actually
> like a no-op.
>
> >               max_order++;
> >               goto continue_merging;
> >       }
> >
>


--
Yours,
Muchun
