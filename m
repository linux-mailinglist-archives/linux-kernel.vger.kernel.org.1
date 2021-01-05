Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7F2EA7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbhAEJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbhAEJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:40:20 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A43C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:39:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so71112569lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i2OQSP8J84ALBsEAvjQwanW64SI0jNYanTtGLf4k6pk=;
        b=HEGsym/m2D3XZVcE9neY09JeOa1OmfrRG+7sxaN4x4ohoDWwDRZhrAArDwLi1fwV4b
         n7ARQzRJRBxeU9MGYfIaOUgtRVHULXYHuRsBrSNaFx2hoFpyN/mS6Ar/Fmxc/CnRVHM0
         iYe3WEfAQ2ngN/QZ71I4wJSUA392S0RdXnP/SzoDDlfDsLw2fWw72J4b8+C/nC0zE8F4
         4bBD9k5GX0teImtAHfy1NtKu0cRStrqyRN9hrubT6DcfI/UNEFT+pWW08AsqjyzIM865
         fWXWogRlzqb8mKHNopuQoo4nz5yfhg+/b8VP9wN8R5kXtyzbYft+KEHFYGhasHWVkWOt
         Tcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i2OQSP8J84ALBsEAvjQwanW64SI0jNYanTtGLf4k6pk=;
        b=DUlNoFs2/8g+w/3eDWZ4/WJEs/hfXS44J0oKDfNkEVOoXJwiYIqhOXdW7hq5AXZvNQ
         TkVNOLe59kBO0wjJ9G/VlAevxijwASCyrTFIRKcstfVlFuYiAM1aEJroqc9cAj1I0JeR
         1PObkS1qnjjopDjjrOQTD1sDNesrmcZhyIBJ0zMkBmNqHEwq5ONhk0DV96AU4vK9pOf4
         R0++GvIu+1b6HVMjYHk1pybE0QpZ/Y19wUbQ+b4+RYU//EnQPs26xc/urZdNUYNuFu92
         wnQdqVMDM1CQ3/Ou3FjHzZEZXp5U4PX20ZhOMs2NRa1tE550Ex/L/lI3qY4gib5V6vm+
         UCUA==
X-Gm-Message-State: AOAM530sIHkD6uHt3iTfSRjo6lhSTqy52AzTyWt4etduNCJ44BK9Sw5d
        ci2+XiORyrvVPHGAgBPM+uNZYjacMcuBBGzveFjShQlg
X-Google-Smtp-Source: ABdhPJw3BgRE3gSvQc/Fh6/SsVhA0l3Jkse4uAPKN9VCXwMQx1yufbP7YdJ7cyJadCH5HsXqUASTq4WOcMkonn/2srY=
X-Received: by 2002:a05:651c:22b:: with SMTP id z11mr36244037ljn.38.1609839578767;
 Tue, 05 Jan 2021 01:39:38 -0800 (PST)
MIME-Version: 1.0
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com> <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
 <20210105092037.GY13207@dhcp22.suse.cz> <71953119-06ff-0bb8-1879-09e24bf80446@redhat.com>
In-Reply-To: <71953119-06ff-0bb8-1879-09e24bf80446@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 5 Jan 2021 17:39:27 +0800
Message-ID: <CA+2MQi-9CmtRoPmOcjpfNt53wkAzF9JB=OE_fx8SARTVe_JR=w@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 5:30 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.01.21 10:20, Michal Hocko wrote:
> > On Mon 04-01-21 15:00:31, Dave Hansen wrote:
> >> On 1/4/21 12:11 PM, David Hildenbrand wrote:
> >>>> Yeah, it certainly can't be the default, but it *is* useful for
> >>>> thing where we know that there are no cache benefits to zeroing
> >>>> close to where the memory is allocated.
> >>>>
> >>>> The trick is opting into it somehow, either in a process or a VMA.
> >>>>
> >>> The patch set is mostly trying to optimize starting a new process. So
> >>> process/vma doesn=E2=80=98t really work.
> >>
> >> Let's say you have a system-wide tunable that says: pre-zero pages and
> >> keep 10GB of them around.  Then, you opt-in a process to being allowed
> >> to dip into that pool with a process-wide flag or an madvise() call.
> >> You could even have the flag be inherited across execve() if you wante=
d
> >> to have helper apps be able to set the policy and access the pool like
> >> how numactl works.
> >
> > While possible, it sounds quite heavy weight to me. Page allocator woul=
d
> > have to somehow maintain those pre-zeroed pages. This pool will also
> > become a very scarce resource very soon because everybody just want to
> > run faster. So this would open many more interesting questions.
>
> Agreed.
>
> >
> > A global knob with all or nothing sounds like an easier to use and
> > maintain solution to me.
>
> I mean, that brings me back to my original suggestion: just use
> hugetlbfs and implement some sort of pre-zeroing there (worker thread,
> whatsoever). Most vfio users should already be better of using hugepages.
>
> It's a "pool of pages" already. Selected users use it. I really don't
> see a need to extend the buddy with something like that.
>

OK, since most people prefer hugetlbfs, I will send another revision for th=
is.

Thanks
Liang
