Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648792A9396
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKFKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKFKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:02:11 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DDC0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:02:09 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n11so764832ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pk2kOuIDyNkJ29R6DHQ3ZwTfwhAfAev58wxOeRlEcVQ=;
        b=JxYI6LDoYBIyKAFkO0mmU5GO0vKXW+XCgfB3nhMPB/96K75h8XEzFsF5vfwoI9o4Aa
         YXO5ScRni4mdNnVG7TEPzZnkXGbky0dU2v6WgMTgqxnDpBRtAtlXHbhIcZNyR+EoGosa
         88KCvZizdR0CJdRqQAGfzd4+9xfkExbEg2qoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pk2kOuIDyNkJ29R6DHQ3ZwTfwhAfAev58wxOeRlEcVQ=;
        b=Y4psIkPUuHOgEG/0mx94kolcMuyJ58CreoT1rz1KI6cVGZwZUMonI/o+wuFveDbmeU
         xbsmu7Lp5RIheYKpbQIGlVuHwzAXZpQAKUZAQXDi9KAAk8pDxkiiPdUS1K6l6+YCLmAX
         se/FJw/VirNErdpOMFPEzZ0/K/n8PPHzd1AJUXyz0mPy60DxU+Dw2HqQTicCgqGX6yKm
         01LXF1dBtTett9XaVcLM3oUqKI6b5H8AfWgy+0nhXlhveGvosC39dqSHamQqN2aj4i1E
         NIIXjOCbjhQXZLzP0yQ858jaHmS350PW0Wf8FUhipmDgs+Im6qNJgNfM1y6EHOb3z/gh
         erMw==
X-Gm-Message-State: AOAM533UxT5hr0iGcio2S6pv8+WNLoxoZZmXRiZjWkmx7sALSyZyMIWa
        xjV28EMLVh0EnTAihEm+jiABuLCautjr5vI2T9fh8g==
X-Google-Smtp-Source: ABdhPJy9+JOeNi7tvqFhbCecRqz/u5D2Qj576z0eBlCGtTEM4NmQBII1FIZeWz8GCbRUxBcA/Ididy+MZpD88l6oJcg=
X-Received: by 2002:a9d:6a19:: with SMTP id g25mr586779otn.303.1604656928858;
 Fri, 06 Nov 2020 02:02:08 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uEw701AWXNJbRNM8Z+FkyUB5FbWegmSzyWPy9cG4W7OLA@mail.gmail.com>
 <20201104140023.GQ36674@ziepe.ca> <CAKMK7uH69hsFjYUkjg1aTh5f=q_3eswMSS5feFs6+ovz586+0A@mail.gmail.com>
 <20201104162125.GA13007@infradead.org> <CAKMK7uH=0+3FSR4LxP7bJUB4BsCcnCzfK2=D+2Am9QNmfZEmfw@mail.gmail.com>
 <20201104163758.GA17425@infradead.org> <20201104164119.GA18218@infradead.org>
 <20201104181708.GU36674@ziepe.ca> <d3497583-2338-596e-c764-8c571b7d22cf@nvidia.com>
 <20201105092524.GQ401619@phenom.ffwll.local> <20201105124950.GZ36674@ziepe.ca>
 <7ae3486d-095e-cf4e-6b0f-339d99709996@nvidia.com>
In-Reply-To: <7ae3486d-095e-cf4e-6b0f-339d99709996@nvidia.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Nov 2020 11:01:57 +0100
Message-ID: <CAKMK7uGRw=xXE+D=JJsNeRav9+hdO4tcDSvDbAuWfc3T4VkoJw@mail.gmail.com>
Subject: Re: [PATCH v5 05/15] mm/frame-vector: Use FOLL_LONGTERM
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        "J??r??me Glisse" <jglisse@redhat.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Pawel Osciak <pawel@osciak.com>,
        KVM list <kvm@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 5:08 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/5/20 4:49 AM, Jason Gunthorpe wrote:
> > On Thu, Nov 05, 2020 at 10:25:24AM +0100, Daniel Vetter wrote:
> >>> /*
> >>>   * If we can't determine whether or not a pte is special, then fail immediately
> >>>   * for ptes. Note, we can still pin HugeTLB and THP as these are guaranteed not
> >>>   * to be special.
> >>>   *
> >>>   * For a futex to be placed on a THP tail page, get_futex_key requires a
> >>>   * get_user_pages_fast_only implementation that can pin pages. Thus it's still
> >>>   * useful to have gup_huge_pmd even if we can't operate on ptes.
> >>>   */
> >>
> >> We support hugepage faults in gpu drivers since recently, and I'm not
> >> seeing a pud_mkhugespecial anywhere. So not sure this works, but probably
> >> just me missing something again.
> >
> > It means ioremap can't create an IO page PUD, it has to be broken up.
> >
> > Does ioremap even create anything larger than PTEs?

gpu drivers also tend to use vmf_insert_pfn* directly, so we can do
on-demand paging and move buffers around. From what I glanced for
lowest level we to the pte_mkspecial correctly (I think I convinced
myself that vm_insert_pfn does that), but for pud/pmd levels it seems
just yolo.

remap_pfn_range seems to indeed split down to pte level always.

>  From my reading, yes. See ioremap_try_huge_pmd().

The ioremap here shouldn't matter, since this is for kernel-internal
mappings. So that's all fine I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
