Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8E26D004
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 02:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIQAiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 20:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQAh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 20:37:59 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:37:59 EDT
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:32:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so692861ejf.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Mv7tExlpUblwPxLiVpXmkZ8FmM1lPrmg1IaKwA589A=;
        b=Nyn3bRg6PHcnF7IuwL/gRVkBgDaad/CL/2NSJZ0OutWVN+rLpFcTmjBIwmdnvS7L1f
         KpcGPsPoNcqBSERqX6KNUU2oY3DDWJAysYSBs/+GNwOWa7iO3mu2Cuu1tL3HZGhiiF7U
         aDeRTy4URUfTy8YCLNz26Og1BmAZVMoBYFFlFlpyirDo1mox6qHLIwmStC0FIZiiwbwR
         HQFYKUdlVDk2Z43AObV/K7iA21j7phnPbKo9hBoswiWiZuzKOUASgRCeBAq3FpkpdePv
         tAixWxs/DLtrXqENpjRjy3BuinknZ/U9iFZz5rjVlc+VGP1yqGG7+c/XpXyX3YmsMzRy
         w6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Mv7tExlpUblwPxLiVpXmkZ8FmM1lPrmg1IaKwA589A=;
        b=tr0H9ajZMYpiACEGzp6QRgkYVFlgsnIAOxjs4cNDDyBwTu9IC0GtsfQoYj4e//EI6I
         FppE3CpMN871sLsx9u1gcn2gZgC28TGo56Sz/D7O0N3GcNw6ngnYt1P9VJ+WaypyvmWL
         E/PxsOsT0Hzgl9Jwf8/WI9C8S3KK263LnIto8LTL0RAHZtxJKzfVkNEH2MPO9U4zYF2a
         8QqG35rnCF7kchYMjgfj+aUV3p/6mhyFn3Cr/SY6LtW8AqupoCQmwpqyItrZE8ULXblI
         E8+Pz7K6/WqMbWQjRf76pG3EYS2KcfvKlTnKk0vgbkcsIwAV9DuC1/P57H9rrnlh0kTT
         6AVw==
X-Gm-Message-State: AOAM533vKNJiMT4QSY26/AIuYjaRVMpcaf9FSrwU5/Uwvwt4FwUCyorD
        dK6Ny8yhStnZ2DswVztTeEOmnnfcCcAqVqZUWicUsg==
X-Google-Smtp-Source: ABdhPJy/lCk/syWt2cUyaBBnBYt0rGos8cgelGTbE0LkeTPJKrWQ68aUyhQaP5VfsnlhpQpt3kFMUBVG5Q3xTQrQUd0=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr27697015ejw.323.1600302775371;
 Wed, 16 Sep 2020 17:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200914224509.17699-1-rcampbell@nvidia.com> <CAPcyv4gVJuWsOtejrKvWgByq=c1niwQOZ0HHYaSo4h6vc-Xw+Q@mail.gmail.com>
 <10b4b85c-f1e9-b6b5-74cd-6190ee0aca5d@nvidia.com> <20200915162956.GA21990@infradead.org>
 <6dff5231-26d5-1aec-0c05-6880cf747642@nvidia.com> <20200916053653.GA7321@lst.de>
 <d3f80030-2ac4-384c-fd7e-66affb229577@nvidia.com>
In-Reply-To: <d3f80030-2ac4-384c-fd7e-66affb229577@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Sep 2020 17:32:43 -0700
Message-ID: <CAPcyv4h=fWucxiiwZ9ZVbax-QTcHMJGkzdYRKCkL+E6+AUqwEw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove extra ZONE_DEVICE struct page refcount
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux MM <linux-mm@kvack.org>, kvm-ppc@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 5:29 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
>
> On 9/15/20 10:36 PM, Christoph Hellwig wrote:
> > On Tue, Sep 15, 2020 at 09:39:47AM -0700, Ralph Campbell wrote:
> >>> I don't think any of the three ->page_free instances even cares about
> >>> the page refcount.
> >>>
> >> Not true. The page_free() callback records the page is free by setting
> >> a bit or putting the page on a free list but when it allocates a free
> >> device private struct page to be used with migrate_vma_setup(), it needs to
> >> increment the refcount.
> >>
> >> For the ZONE_DEVICE MEMORY_DEVICE_GENERIC and MEMORY_DEVICE_PCI_P2PDMA
> >> struct pages, I think you are correct because they don't define page_free()
> >> and from what I can see, don't decrement the page refcount to zero.
> >
> > Umm, the whole point of ZONE_DEVICE is to have a struct page for
> > something that is not system memory.  For both the ppc kvm case (magic
> > hypervisor pool) and Noveau (device internal) memory that clear is the
> > case.  But looks like test_hmm uses normal pages to fake this up, so
> > I was wrong about the third caller.  But I think we can just call
> > set_page_count just before freeing the page there with a comment
> > explaining what is goin on.
>
> Dan Williams thought that having the ZONE_DEVICE struct pages
> be on a free list with a refcount of one was a bit strange and
> that the driver should handle the zero to one transition.
> But, that would mean a bit more invasive change to the 3 drivers
> to set the reference count to zero after calling memremap_pages()
> and setting the reference count to one when allocating a struct
> page. What you are suggesting is what I also proposed in v1.

IIUC, isn't what Christoph recommending is that drivers handle
set_page_count() directly rather than the core since some are prepared
for it to be zero on entry?
