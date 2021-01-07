Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E779A2EC7DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 02:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAGBvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 20:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGBvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 20:51:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47FC0612F3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 17:50:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so11075655lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 17:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuS9RFtdF0FSUG+Qus6FJ7bGLYFqsL5wnuYCJEt6Kb0=;
        b=gBnrY7alv2bsniRlpXrslYlz5zCHsPCg9HVAyMrrsYsO6fa8Fx/JJI2i+Ed2CKM9Hq
         kwaVRdiWZ6hZerEm7PFP+F3557eBswhDr4tNVlYYBgQVOmTPz6+VXmhmwqrGtJeY3bZn
         2zpF1kqD7GFLG7SMhUiMt6e6a47tCVE4G2auXbPYSpzxA15UZDGWHaxubl4cgwl0inpW
         Mtl0hXyHwAt1yW+4WvA10IDkzf9TzSTQwELoPod/730gf7U/GthD0Jr5TW0Arwufx37v
         5iUPS4jb9+FnNz6FmoYduw2j2tuHQRwBRTQg4snwPCLYe5j6rEVHRSPky14EH2EHk8Fz
         ZNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuS9RFtdF0FSUG+Qus6FJ7bGLYFqsL5wnuYCJEt6Kb0=;
        b=qcwl5gCVNWYCm4xo7Knyzy46OKndO6QFIG+X8yaRDmsx8yhVOfu2Q9fhcsfHsq7ZkK
         hD1ptsZrxUOkneEEuC1nMOem0ZiaX9vdOy48aBy0hd1C4MvZ4MhzTo0w0wSDNxNNckk/
         H+fNgZtZIP+U/JjHTGPFWnhErWdL9pC/Z1PA11WWKGGWPUGhsLampX6pwZOzC/aoC2Jg
         ltoFeyaw38V/RkCtG3hntWcAiLlr/OZTRTHdxj+pPP0u4O/OqE1L0Z4eKbMXLZrZG+KT
         uaYtPKno4XMI8LOgCzvtj/ZLMDhpRBSa4bzPyxsoXVplmbKxoicqLy52nDP1sWNIP9sK
         HfPQ==
X-Gm-Message-State: AOAM531QyV7esCBhUWmxNxcKkSA+NyRta3RY/8GnIKV1PfbZhgHQaBA1
        Xacf8wbOlD+a+6ZsywCdgoNl0baiNicu9iXu7lU=
X-Google-Smtp-Source: ABdhPJw4/jZgVZBc8G/tHe60zJSX2H/7Py1HFEDuWXFYjlClXEGFpq354dcg+/dyXm4CWpJ1P5VMPsd2wXBUjngAhu0=
X-Received: by 2002:a19:848f:: with SMTP id g137mr3061829lfd.622.1609984249325;
 Wed, 06 Jan 2021 17:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20210106034623.GA1128@open-light-1.localdomain> <effc0673-0452-08d8-819b-70aee14643c5@redhat.com>
In-Reply-To: <effc0673-0452-08d8-819b-70aee14643c5@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 7 Jan 2021 09:50:35 +0800
Message-ID: <CA+2MQi9=4p8Xzqa7JAseQW8iFv+hKBNvdsm7c3o4_y5wr4mN-Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] hugetlbfs: support free page reporting
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 5:41 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.01.21 04:46, Liang Li wrote:
> > A typical usage of hugetlbfs it's to reserve amount of memory
> > during the kernel booting stage, and the reserved pages are
> > unlikely to return to the buddy system. When application need
> > hugepages, kernel will allocate them from the reserved pool.
> > when application terminates, huge pages will return to the
> > reserved pool and are kept in the free list for hugetlbfs,
> > these free pages will not return to buddy freelist unless the
> > size of reserved pool is changed.
> > Free page reporting only supports buddy pages, it can't report
> > the free pages reserved for hugetlbfs. On the other hand,
> > hugetlbfs is a good choice for system with a huge amount of RAM,
> > because it can help to reduce the memory management overhead and
> > improve system performance.
> > This patch add the support for reporting hugepages in the free
> > list of hugetlbfs, it can be used by virtio_balloon driver for
> > memory overcommit and pre zero out free pages for speeding up
> > memory population and page fault handling.
>
> You should lay out the use case + measurements. Further you should
> describe what this patch set actually does, how behavior can be tuned,
> pros and cons, etc... And you should most probably keep this RFC.
>
> >
> > Most of the code are 'copied' from free page reporting because
> > they are working in the same way. So the code can be refined to
> > remove duplication. It can be done later.
>
> Nothing speaks about getting it right from the beginning. Otherwise it
> will most likely never happen.
>
> >
> > Since some guys have some concern about side effect of the 'buddy
> > free page pre zero out' feature brings, I remove it from this
> > serier.
>
> You should really point out what changed size the last version. I
> remember Alex and Mike had some pretty solid points of what they don't
> want to see (especially: don't use free page reporting infrastructure
> and don't temporarily allocate huge pages for processing them).
>
> I am not convinced that we want to use the free page reporting
> infrastructure for this (pre-zeroing huge pages). What speaks about a
> thread simply iterating over huge pages one at a time, zeroing them? The
> whole free page reporting infrastructure was invented because we have to
> do expensive coordination (+ locking) when going via the hypervisor. For
> the main use case of zeroing huge pages in the background, I don't see a
> real need for that. If you believe this is the right thing to do, please
> add a discussion regarding this.
>
> --
> Thanks,
>
> David / dhildenb
>
>
I will take all your advice and give more detail in the next revision,
Thanks for your comments!

Liang
