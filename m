Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEBA2E0E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLVTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:14:38 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA866C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 11:13:57 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y5so12953610iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QJAkIaRAmbTjT49QW8oYv7QzM88P6GE6t4wSLLc/GcU=;
        b=aPF/YAZ9erWveRdWO/2hLJheEsEUVZm7epizh5j/VC7kd5b1Or/+tJGPitWc8dSQJP
         GYAtfRS/iPRCqfuJh9isOkZeiQaHR/W9ZPkmeyYncwIgToIvh4y8xmVs/5oK/tqpHpwj
         DICtixudSLvfYeRUBOCe0XmxF9mvT+NZwpUa5M36qLPwiW0Jlpze8AF/V0Ql5w9Q8O3W
         iOShXZkUa915bP42rj1Dmmjh3R4RqVNe7xyqCdswjsY1+7z8cdkhDh0KBMYV/9fVQFm8
         +CutoBZSQk7bBC50n1TqdRbxekHfa/PPIO3Fh2PHqlr9OAzu5NuuAc/fmBau3hVgVHb7
         SWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QJAkIaRAmbTjT49QW8oYv7QzM88P6GE6t4wSLLc/GcU=;
        b=g9rJBVOn5F5OCJZeudmsqpVCV1NxQYiYT3wG1MXJf840LWj5KwvQjgxaQ1CD2Uykd8
         C+3j74+zMpHPKd2fo4SYWgYxMbSXULufdaArN11xJVzdHnI2J3jejukP0G5x0x3P+rC+
         5hpevuJZ8nylIMoM/K8STzYb6NQdEOw7DoEM+w2fTIvDQBJxQdGIae/hLD5y2Gc5Z3ft
         AJhU2tbxO/cPGB6E/VsPaVJQb/Vut8ej0KutcUX8NocGzuit15Yz+jYRB7K0jBAXG/G5
         fFkk0cGjfb/HJORm4gd1QRVU0jTChaq8cIl2O7Shkg1ZLB7ZMmuAftJT1lPLQDHultC4
         UUlQ==
X-Gm-Message-State: AOAM533ysuy4+1s6qDvDVNiv+zzym5gfpz4N0/pP3Zz5YNqmJOERsJRR
        +nZR5tWipjYaJp3OOAztkiK4iUYI1aF3xfJrCyE=
X-Google-Smtp-Source: ABdhPJwiH4X66f06EOxSYK8GgRP7F1wU/QPbZByPqPm8NohKnqOwio5inBXgbitqxNy/JmW3UyhM48dXA4yo6r9vqWA=
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr18941096iow.88.1608664437267;
 Tue, 22 Dec 2020 11:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain>
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 22 Dec 2020 11:13:46 -0800
Message-ID: <CAKgT0UcT8YafkMzGLV1Bnoys4qFsJP-e9cxLUEr_xQZKn1r+bg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 8:25 AM Liang Li <liliang.opensource@gmail.com> wrote:
>
> The first version can be found at: https://lkml.org/lkml/2020/4/12/42
>
> Zero out the page content usually happens when allocating pages with
> the flag of __GFP_ZERO, this is a time consuming operation, it makes
> the population of a large vma area very slowly. This patch introduce
> a new feature for zero out pages before page allocation, it can help
> to speed up page allocation with __GFP_ZERO.
>
> My original intention for adding this feature is to shorten VM
> creation time when SR-IOV devicde is attached, it works good and the
> VM creation time is reduced by about 90%.
>
> Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
> =====================================================
> QEMU use 4K pages, THP is off
>                   round1      round2      round3
> w/o this patch:    23.5s       24.7s       24.6s
> w/ this patch:     10.2s       10.3s       11.2s
>
> QEMU use 4K pages, THP is on
>                   round1      round2      round3
> w/o this patch:    17.9s       14.8s       14.9s
> w/ this patch:     1.9s        1.8s        1.9s
> =====================================================
>
> Obviously, it can do more than this. We can benefit from this feature
> in the flowing case:

So I am not sure page reporting is the best thing to base this page
zeroing setup on. The idea with page reporting is to essentially act
as a leaky bucket and allow the guest to drop memory it isn't using
slowly so if it needs to reinflate it won't clash with the
applications that need memory. What you are doing here seems far more
aggressive in that you are going down to low order pages and sleeping
instead of rescheduling for the next time interval.

Also I am not sure your SR-IOV creation time test is a good
justification for this extra overhead. With your patches applied all
you are doing is making use of the free time before the test to do the
page zeroing instead of doing it during your test. As such your CPU
overhead prior to running the test would be higher and you haven't
captured that information.

One thing I would be interested in seeing is what is the load this is
adding when you are running simple memory allocation/free type tests
on the system. For example it might be useful to see what the
will-it-scale page_fault1 tests look like with this patch applied
versus not applied. I suspect it would be adding some amount of
overhead as you have to spend a ton of time scanning all the pages and
that will be considerable overhead.
