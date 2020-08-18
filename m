Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0324886B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHRO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHRO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:58:27 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B71C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:58:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s1so8339548iot.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOEA2rP9/JD6Cf76I2R3GGke75F7JOtu4CdmYgf8vDY=;
        b=sObKysrY/m6k71IrKg0OKwNuztPj+2ApCNCaDg5eevrRQ+xH5K4vrlPCXTOjWYnhBx
         N5gWOfpWzu45gDBj3AmUDpXLCo02KiGLddVIxkvkmFEEZQSccy8ViWZdSDpQackugrQx
         P3XeZwcPxMEvZbMTP/OxJSz4mFyrpJId3fjzupe5RHJOJHi4I+BfU/SI9hqVu16kKS32
         qRK1/HmLKkgXJ3XXvAI3KoE+G3QWCKE8Qx5xgseT51v+FyyboOuunaNv/IW5WS9z2tYT
         G6WLGh4XR+YcYhsWkb53O/Vz+gKZ9lbhawwb8MuLAvkMJ3ilWr+rUcom2roj3loVLhSS
         27aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOEA2rP9/JD6Cf76I2R3GGke75F7JOtu4CdmYgf8vDY=;
        b=d4ovtHQeIjW7GB9zcBjCjCPtluDoO/pWHqkLFRbdWqV/8hgI+MGtKT9UJhhMFqjS3B
         VdgTvfQXbn//MzuuiOFpMPP+0OvpjukAn+57HIFbAkvrvFgBvCUhAgk5AGadEz9E7TmW
         iXELPxwB0VuXTb63bWVRFBoEaynoYvkzEASSXL6OTCjNb1I3q6ik9Ki19PdnGxI05fMC
         jHwS2rMszTYmwFiLYbBF8oOhvWlCEJpTzXslLF8xXFaF83qlZCd0WgioDSuwUcV69aX9
         JT0ldPYlBAkIDzD8PPy82ln/kfKqg8+ukm/BPsE2xdN5QnLTm10RBw17FmX4q9SxP8qy
         TlBQ==
X-Gm-Message-State: AOAM531Y60nGZaaaWqzTsJiKoMGAJ6AeALo/Aj9zM5XzSaNDwcDICFJP
        cUw39HbsOmwDbX4KXYOp6JVUFe5BIlX72QLxH4o=
X-Google-Smtp-Source: ABdhPJy11n6vtEdpb4Yt79Cgo6EA4IQ4lhtjTCOOWRi3rSkmsGOG4Jca6HSsIzdteiY+8sKovq1y/uZMuLnb/A9ujV8=
X-Received: by 2002:a5d:8f09:: with SMTP id f9mr16787030iof.187.1597762705945;
 Tue, 18 Aug 2020 07:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084836.29216-1-richard.weiyang@linux.alibaba.com>
 <fa97519b-a860-5fea-9511-2237f195caeb@redhat.com> <aaa56d83-2444-d74e-025a-508a2be6b772@linux.intel.com>
 <20200818032217.GA31960@L-31X9LVDL-1304.local>
In-Reply-To: <20200818032217.GA31960@L-31X9LVDL-1304.local>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 18 Aug 2020 07:58:14 -0700
Message-ID: <CAKgT0UdiRw4WMe8RxOZ3A6fcQJ9Tp7BAWBbuYkje7YWiT0cVOA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_reporting: the "page" must not be the list head
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 8:22 PM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
>
> On Mon, Aug 17, 2020 at 09:05:32AM -0700, Alexander Duyck wrote:
> >
> >
> >On 8/17/2020 2:35 AM, David Hildenbrand wrote:
> >> On 17.08.20 10:48, Wei Yang wrote:
> >> > If "page" is the list head, list_for_each_entry_safe() would stop
> >> > iteration.
> >> >
> >> > Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> > ---
> >> >   mm/page_reporting.c | 2 +-
> >> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> >> > index 3bbd471cfc81..aaaa3605123d 100644
> >> > --- a/mm/page_reporting.c
> >> > +++ b/mm/page_reporting.c
> >> > @@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> >> >             * the new head of the free list before we release the
> >> >             * zone lock.
> >> >             */
> >> > -          if (&page->lru != list && !list_is_first(&page->lru, list))
> >> > +          if (!list_is_first(&page->lru, list))
> >> >                    list_rotate_to_front(&page->lru, list);
> >> >            /* release lock before waiting on report processing */
> >> >
> >>
> >> Is this a fix or a cleanup? If it's a fix, can this be reproduced easily
> >> and what ere the effects?
> >>
> >
> >This should be a clean-up. Since the &page->lru != list will always be true.
> >
> >If I recall at some point the that was a check for &next->lru != list but I
> >think I pulled out an additional conditional check somewhere so that we just
> >go through the start of the loop again and iterate over reported pages until
> >we are guaranteed to have a non-reported page to rotate to the top of the
> >list with the general idea being that we wanted the allocator to pull
> >non-reported pages before reported pages.
>
> Hi, Alexander,
>
> I see you mentioned in the changelog, this change "mm/page_reporting: rotate
> reported pages to the tail of the list" brings some performance gain.
>
> Would you mind sharing more test detail? I would like to have a try at my
> side.
>
> Thanks :-)

I seem to recall my default test for most of this was the page_fault1
test from the will-it-scale suite of tests. Basically I was running
that while leaving page reporting enabled. However I don't know how
much visibility you would have into the performance impact as I seem
to recall I had to modify the frequency of scheduling for the
reporting polling task in order to see much of an impact.

Thanks.

- Alex
