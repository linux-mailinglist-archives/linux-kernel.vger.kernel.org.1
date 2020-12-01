Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15FF2CB0F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgLAXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgLAXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:39:13 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ED7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 15:38:27 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z24so3452809oto.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcUljttS1/Kv9szBrro01vh8YqqJASGgC7Alt3BmlWo=;
        b=CyOy3yOcWwb512J6zbdkSYqy0VmZT8LjbKvW5Ky+B3G9Z7qUsmCHoGpbA7yV3cUOjs
         ip2Oy1mvs3e72TrbAVkqZqwnrCQzLpybnu0i+q/GSgEpZfuqNu2sVHUqKOvwkgar/PBj
         1ZN0M8jT/41HGZ+A72nYrBwgA+LlOlis+FtY8ssnKqPHb6uJ3qDr5BwMOtmf2bwA6+6k
         dv/i1SRkl7IM+qxg3BUtn32XMZ8MZaeNnDEMPaLMKyPzTL+LhJ9LwoHLRvK5Ei8VMerb
         /YyXsuqWwkuud/IDiJpGaq7nDUutOqhJsHgHuXRl0o/7TUKs00JD7vth9PRfzWEYWCkC
         XcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcUljttS1/Kv9szBrro01vh8YqqJASGgC7Alt3BmlWo=;
        b=G/1q1P3A3ssgfq7NjzINamXhmdn9ptv7l3sgV1oM6ECDPEhYdSxBvq0GjxQdcd6VBT
         d8HsM3enbwBzt9oJ6XVp4ELSZkEcZc0HvP8kdcnxJSUojMMh7CXZ+Qdp//NyhLBQDhtg
         ht925CpuXmP0WQMB0W2fHfVRxiPGcHhF63w8sZ7k4l6LiH5d1aWfmJL0Pk5OjBiEDQWh
         OUaB+jAotmGSnTf3yxRWlsouq2wAO8Mz2+D76v2briu6x0mG9OXPoadWVZ6UJqXBBLZF
         1sgEnAdirszKsMIk2yJxuMPnIrZy9LQv3bErdJw0TbbUDLtaDFc7jFIV+rB9QBjR8TB7
         cpJw==
X-Gm-Message-State: AOAM532Dl4ABn0Vl9xm42taWfgI9CS2rTz5FAprHw0quOvVRqbNXBnrZ
        MmLoeCHZt/aEjDUEBMcL3KitwOVoxmSka4a9aVjMgw==
X-Google-Smtp-Source: ABdhPJzqg9/cJFXzsEKuui5LLQmcVlIxqfx8S0xbUl9UXyu4UIrtiWJuNliEU6VKkP4JD9lJJVAJhVhQ6gN0sNwiUhw=
X-Received: by 2002:a9d:851:: with SMTP id 75mr3804830oty.102.1606865906861;
 Tue, 01 Dec 2020 15:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20201201175144.3996569-1-minchan@kernel.org> <20201201175144.3996569-5-minchan@kernel.org>
 <CALAqxLXFeUStaJ8Mtm5v3kSxmeqnjzLTsyathkrKF0ke3fYGiQ@mail.gmail.com> <20201201225554.GA3968963@google.com>
In-Reply-To: <20201201225554.GA3968963@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 1 Dec 2020 15:38:14 -0800
Message-ID: <CALAqxLW-n4-VSd9dj=KXS4WRDrPmKOShAwP9tCfCZnk+4kxW-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dma-buf: heaps: add chunk heap to dmabuf heaps
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Hyesoo Yu <hyesoo.yu@samsung.com>,
        Matthew Wilcox <willy@infradead.org>, david@redhat.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        Suren Baghdasaryan <surenb@google.com>,
        KyongHo Cho <pullip.cho@samsung.com>,
        John Dias <joaodias@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:55 PM Minchan Kim <minchan@kernel.org> wrote:
> On Tue, Dec 01, 2020 at 11:48:15AM -0800, John Stultz wrote:
> > On Tue, Dec 1, 2020 at 9:51 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Thanks for reworking and resending this!
> >
> > ...
> > > +static int __init chunk_heap_init(void)
> > > +{
> > > +       struct cma *default_cma = dev_get_cma_area(NULL);
> > > +       struct dma_heap_export_info exp_info;
> > > +       struct chunk_heap *chunk_heap;
> > > +
> > > +       if (!default_cma)
> > > +               return 0;
> > > +
> > > +       chunk_heap = kzalloc(sizeof(*chunk_heap), GFP_KERNEL);
> > > +       if (!chunk_heap)
> > > +               return -ENOMEM;
> > > +
> > > +       chunk_heap->order = CHUNK_HEAP_ORDER;
> > > +       chunk_heap->cma = default_cma;
> > > +
> > > +       exp_info.name = cma_get_name(default_cma);
> >
> > So, this would create a chunk heap name with the default CMA name,
> > which would be indistinguishable from the heap name used for the plain
> > CMA heap.
> >
> > Probably a good idea to prefix it with "chunk-" so the heap device
> > names are unique?
>
> That will give an impression to user that they are using different CMA
> area but that's not true. IMHO, let's be honest at this moment.

I disagree.  The dmabuf heaps provide an abstraction for allocating a
type of memory, and while your heap is pulling from CMA, you aren't
"just" allocating CMA as the existing CMA heap would suffice for that.

Since you need a slightly different method to allocate high order
pages in bulk, we really should have a unique way to name the
allocator interface. That's why I'd suggest the "chunk-" prefix to the
heap name.

thanks
-john
