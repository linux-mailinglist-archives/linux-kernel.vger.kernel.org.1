Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55E2CCCC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgLCCow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgLCCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:44:52 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F678C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 18:44:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so491759pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 18:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGuFg1S14gs2YEMw5LNgUgwD+agRMT9+4pAvuMm+HS4=;
        b=nMCYvkHOSPfFgS87lYzMW+G8A6GCd5cIAeCz0dsLSspJ+UWEmjA+KxFSkMQV5/RLtu
         2o7HySDS/Z4e1Wc8gHubSDmKciamq43ErDtyreK5kVTH366EhxQCst797aNZAVaXLpSI
         hGwYeFScwBON2kKmUeOwnQ5Y4lFW70EDhDjfAyB5PC3X66yYdE4VZ8c7wfFONlDY0HCm
         2mnlWiU1xUm3HxV1NJZrMwRowUW3/PdYfr3TQ1HC9l8INIqGT5Cun2oMJoQdpATvOy6D
         X+m3m7s0+nBSxRfwh7icX2SAMnmZA6GRAQ57qkhfZycjK6oD7iTdWWQzrRKa/EDcNQ+5
         V2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGuFg1S14gs2YEMw5LNgUgwD+agRMT9+4pAvuMm+HS4=;
        b=hXGvRV8A7ANOwHQeLl3vfV9xMRaAgYfvBZWa9ZdR6x8mL287dKdW5dcUdtfaN6+mK1
         GB8V10PehaSxsi0MQav6ImNCfT6pouTl9rhOhdYf7gBsbR8+r6fiOCFi5+4QMl101k3X
         RrbCMDTPeHfh6Ms/sYpn6rmT5YI48gAalM9L3mf7mQFQmJzIUBAdCeFh/EKAULE2qEAi
         EStpm/fDPQ9NlogmO7peh6/lVuLW+TZ2BwKVORnldxOiAigwCRtEydjhuwwEmCxHXQI4
         dueLOro8kYPwnM/kgZcdw0/VidUcOb/0aK9+Aw5LRYinWyCh5sGUOV79d0SKgdK6zkOW
         3yFw==
X-Gm-Message-State: AOAM532TS6DK95tMJMx3VhUIViLMqkR5bKGWbcEHquhVT8ksKi7+/pfX
        TJLOxPVf9Q/HzI0Vhdlt3IBDn1/jo4aVM+zoli0HKrGUwWbj2g==
X-Google-Smtp-Source: ABdhPJw5va3/PbWm71+wN+KlF2E2zlC4vEOKwJNc+m63LB4gni5Q3iGqI5c8YqP9y4tEfE/Hfq4MXnQn9lsrDklu8mk=
X-Received: by 2002:aa7:8055:0:b029:19b:694:34b2 with SMTP id
 y21-20020aa780550000b029019b069434b2mr1290531pfm.2.1606963445723; Wed, 02 Dec
 2020 18:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20201202122114.75316-1-songmuchun@bytedance.com> <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
In-Reply-To: <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 3 Dec 2020 10:43:29 +0800
Message-ID: <CAMZfGtWd2VO7xdnKrHrRAWiuRo=BKO1LMXY8d4xxZDfMeoazyg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/page_isolation: do not isolate the max
 order page
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 8:03 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/2/20 1:21 PM, Muchun Song wrote:
> > The max order page has no buddy page and never merge to other order.
> > So isolating and then freeing it is pointless.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> > ---
> >  mm/page_isolation.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index a254e1f370a3..bddf788f45bf 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> >        */
> >       if (PageBuddy(page)) {
> >               order = buddy_order(page);
> > -             if (order >= pageblock_order) {
> > +             if (order >= pageblock_order && order < MAX_ORDER - 1) {
> >                       pfn = page_to_pfn(page);
> >                       buddy_pfn = __find_buddy_pfn(pfn, order);
> >                       buddy = page + (buddy_pfn - pfn);
>
> Hm I wonder if order == MAX_ORDER - 1, then the buddy can actually be a
> !pfn_valid() in some corner case? pfn_valid_within(buddy_pfn) that follows would
> only catch it on archs with holes in zone. Then is_migrate_isolate_page(buddy)
> might access an invalid buddy. So this might be actually a bug fix and not just
> optimization, just the bug hasn't been observed in practice.

Agree. Should we add a Fixes tag in the commit log? Thanks.

>
> >
>


-- 
Yours,
Muchun
