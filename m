Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF75C2E17D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgLWDnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgLWDnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:43:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF9C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:42:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x20so36858421lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ybqpSjFFFFHlPBLk8nUiODbC32XCT34HJ3orNNILNM=;
        b=q802V44G+iqYoHXuiqs3/R4CRSg1mxfDB1ak3G8DwEfKd19hRyh8w35dG9qbFFy5Vr
         tZerxaYM3bzwVzcTOb28xScuWVLpzW/gb9n0+OfRtuWwB6bDL0Se1Nlby9615BzJKGlx
         uaWeX0GG3cXhLJmJ8HmawYI8us+b/km/IMDXcybJkOLtn7SMpvsaeINnZDxC3qgpYmhC
         puhQk8gmB+9xNzWLQSIy1vyVlYIz0thUW6KQmpFS1QtFdtfacixdHjaUOaN+ywvVYC+4
         e4/m/aYfPAdcqw40d8HStwHHOMj/tmj+PCdkyOzJZSVgvUn6cPFSLZKXWt0qG9qyL+Q7
         XkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ybqpSjFFFFHlPBLk8nUiODbC32XCT34HJ3orNNILNM=;
        b=XZggClEq+JG+/sMRS25hU2janIgmdD3zzpqUDeNTyhAybnDoaa2cKZOYdkcNcBEqYp
         oB2ddOb8SMhOatF1KtU/8y0nH7CRQN23mrvuomneL0O6deRIM5abu7XFIkL24cVsc6ur
         2MeqvXarRkwwiaqLLwGXMbjYqqLRVArtWnqMMPOc78vlR39dKfjgoUcIjNABnCnjIXzy
         WIfzNpenGEq6wVJj1cUa2jjaYW1+39D3njPhYO0S74U/M3s5TussnjC0xOvTSIrB+Ezl
         odqt5Khuo8Fq4clRxjgOGW4NWZvkrca2AgGflXND3nvDg0+In8RvwF3c9qx1WWE3lhPn
         8ukw==
X-Gm-Message-State: AOAM531wF1/rDWIpt8B0ufj7AVCSustXsW3Sjg2difaJQZPnTI872RrB
        JykpR/pIfPWQ1P0H92gf6+KzQZ6Tto3VCYcxTzw=
X-Google-Smtp-Source: ABdhPJx265cqM52gdhbhsGHYsq7df5bDeK+RzTSogLsOrDLz4OYfazEqIXTLJEizjC1b4nEwlLSTBCMR3o0+/2touKA=
X-Received: by 2002:ac2:5c08:: with SMTP id r8mr10135064lfp.12.1608694944427;
 Tue, 22 Dec 2020 19:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain>
 <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com> <52a6cb93-1fed-dfd7-d21e-f14197a9c9dc@oracle.com>
In-Reply-To: <52a6cb93-1fed-dfd7-d21e-f14197a9c9dc@oracle.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Wed, 23 Dec 2020 11:42:12 +0800
Message-ID: <CA+2MQi_ajOZge-_1S0pAt+o-beT6QQru9ogYBcwzAs+tWqrPcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
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
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 12/22/20 11:59 AM, Alexander Duyck wrote:
> > On Mon, Dec 21, 2020 at 11:47 PM Liang Li <liliang.opensource@gmail.com> wrote:
> >> +
> >> +       if (huge_page_order(h) > MAX_ORDER)
> >> +               budget = HUGEPAGE_REPORTING_CAPACITY;
> >> +       else
> >> +               budget = HUGEPAGE_REPORTING_CAPACITY * 32;
> >
> > Wouldn't huge_page_order always be more than MAX_ORDER? Seems like we
> > don't even really need budget since this should probably be pulling
> > out no more than one hugepage at a time.
>
> On standard x86_64 configs, 2MB huge pages are of order 9 < MAX_ORDER (11).
> What is important for hugetlb is the largest order that can be allocated
> from buddy.  Anything bigger is considered a gigantic page and has to be
> allocated differently.
>
> If the code above is trying to distinguish between huge and gigantic pages,
> it is off by 1.  The largest order that can be allocated from the buddy is
> (MAX_ORDER - 1).  So, the check should be '>='.
>
> --
> Mike Kravetz

Yes, you're right!  thanks

Liang
