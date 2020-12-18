Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1F2DE2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgLRM0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgLRM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:26:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6152C061285
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 04:25:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lt17so2958127ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lhuweqQlhHO7hy/V02BEkOocTAj67fYHbIRgEWFXLs=;
        b=MJ6K37SnOv0MOV1yNPGIsCJSfLdzIW59btJg0j0VNKWwYOIneNWAlzLezFS+4P1UIg
         kvtBTojCVh9e1FShHJeAPucWvI2ftbOUroXc3gg7yM9AHLhxecDsp8JqaLP16g3CYZ95
         KNP1Cnk6441ZWkLzWsRgdtvMxmnJkXOKrDk8xEK6tCfLPgJxrVR4w/situU0UMdI+ZPY
         SogVsfeoRkuyNuOHCbCzgcc9dcFBT5d5ugBKWROYrsUZM6AezfJFecEcH9aIqwQZ1vsU
         gurHn2N1ewEy9LbesQUw63usbfVnz6ZqRvJr4uYOp33JrXL8bIpGh2UkjhHGhGLVcJy7
         FOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lhuweqQlhHO7hy/V02BEkOocTAj67fYHbIRgEWFXLs=;
        b=OXg8534btIjkIepo8/9W4EdaCwx4wAn5hxQQyyCw6qcQxK5Rc7BPxHdoDkZfxTuTJo
         tE3Ylj0ZH11z0V+R86YbUrBmow+Fdjm0/LFdx4c8x1Vqklt7ef0Xq6OR8tX27IczP1OJ
         fj+ArD74n1KPzLjGcW0xTR9X8Ti2GQ4ZKVDp+HDRar/qUf7xSprPFZ/mOSJftrjH6fz/
         6ukqGgzL2KFKRxVyJqyDLrOVvqV3/51QxHfvR7cwC+h5yek5nvzDEjK6VrAi42ivtIPl
         2xlXx/6m/sSJYC2qycWPlHeM6oDgrc/TkcNt7KuiIj+Da3LZ+poRbDGx6YnXLe4Phosl
         +UsA==
X-Gm-Message-State: AOAM531qrjaWkf6tQmxGOdbFJT8IbcYp2HMERj9P7MVwkjisE1jL/UYh
        TMiEGDqhH8YYfitHiTAGG8odnBKiyPyUi0n0kkR0NA==
X-Google-Smtp-Source: ABdhPJxS61dnQ5BtpBbJ0RZj2DWMhhsRQ2d4te1FBg4JvHGVH2QxOB81QucqauKQ/kxnWqUevwveMDcth6n5BZbPruM=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr3761264ejb.314.1608294329649;
 Fri, 18 Dec 2020 04:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-6-pasha.tatashin@soleen.com> <20201218094324.GT32193@dhcp22.suse.cz>
In-Reply-To: <20201218094324.GT32193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 18 Dec 2020 07:24:53 -0500
Message-ID: <CA+CK2bAKiWC5E4h4CZOqQrh4QzQQ-3_TUJgB=r4H23gu3cqvAA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mm/gup: migrate pinned pages out of movable zone
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 4:43 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 17-12-20 13:52:38, Pavel Tatashin wrote:
> > +      * 1. Pinned pages: (long-term) pinning of movable pages is avoided
> > +      *    when pages are pinned and faulted, but it is still possible that
> > +      *    address space already has pages in ZONE_MOVABLE at the time when
> > +      *    pages are pinned (i.e. user has touches that memory before
> > +      *    pinning). In such case we try to migrate them to a different zone,
> > +      *    but if migration fails the pages can still end-up pinned in
> > +      *    ZONE_MOVABLE. In such case, memory offlining might retry a long
> > +      *    time and will only succeed once user application unpins pages.
>
> I still dislike this. Pinning can fail so there shouldn't be any reasons
> to break MOVABLE constrain for something that can be handled. If
> anything there should be a very good reasoning behind this decision
> documented.

This is basically current behaviour, after patch 8, we can never pin
pages in the movable zone, so I will update this comment in that
patch.

Thank you,
Pasha

> --
> Michal Hocko
> SUSE Labs
