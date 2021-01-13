Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B282F54CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbhAMWEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbhAMWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:00:35 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E34C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:52:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r5so3543709eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkCEm6n1O2YDsdNDXJh8BIEgy3kecFF0HQkrvLtX2UM=;
        b=SRVHAUkpjdzGINze2D0SPtwgt3b82Lz/3p99J6k6sZtsuYKAjn5691k8Rp8b7FUCS9
         6Rl0wbuf5DR1iOh0Bu8H2VEZHjnIko2IpIeXpeyK7UoEOQcvVEg5ATgpU7ILN8FvrLOJ
         tU3S5Kbj9+NbosbQygaXJCjPhAON9p+WjNYl7vNEwbEZCP9WYe8jbt/lceuyN/JtZNF5
         +lFs1SUeHRZFbP1fqinWUwwE0BMOo8UJwXrlPxyWIiOOAWjRy+q03pNsCcP6kNzLLcBO
         RuItbDUV2Wl4/PPqfv0rryUy9n2oc//db/8GySCvN+q/K5oHMfeMYIBqGtgHAkGv+XnY
         d9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkCEm6n1O2YDsdNDXJh8BIEgy3kecFF0HQkrvLtX2UM=;
        b=Xrb+Kml+FyDhEbPGgFSvvpApgcBc8IHBPMGgT1GcQKTWs+qCnvuhxh8LIH0m55/zLu
         ZGt0pw4KNrexuRtWuXPBYpc0S8gDUkS7Lef9YHfqoKICL9OJI8wy5FMBlfcj2WP6lFLH
         rRgGhKT6Cu6CQJyMSxtrcveTvJdm+ESK0Bx9AXsybXqzrzb7raUcEeRFrglmTHcaym/4
         tcnfR7iotET8i1JKxA5KbOxxYE2NfQwIv62ayrrd+RStdJFYL1OFXWyeCrtiXfGlrtIf
         UrbWFjHn8Jeqku2qC621WK7iHNJnbfWZLQ1Qr1l+E1n+VuwhlRaVqvBPW44s6jUvFrJA
         wc+A==
X-Gm-Message-State: AOAM533IGiiktxmG9YiP/TC9Fn+Efd2DNTPBt/gnFuecvAUWntO+7yGv
        K3wikLAqzxDXGEKBx1h+9L8lftwODZdNXtCOO/lVlg==
X-Google-Smtp-Source: ABdhPJzSD6+Rzk4Z+duLWEpDKBIxKbqxC88SAUZRbhvaMudyDSDTALy3KwUquixL/d2ZtGuR3ksAPlHMa75yFMUJrmM=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr3362518edr.97.1610574743900;
 Wed, 13 Jan 2021 13:52:23 -0800 (PST)
MIME-Version: 1.0
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
 <230efa36-9192-fe52-b8b6-16b2feafb70b@redhat.com>
In-Reply-To: <230efa36-9192-fe52-b8b6-16b2feafb70b@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Jan 2021 13:52:14 -0800
Message-ID: <CAPcyv4i4yGjsMf2SyixLicDjzRGes97vaSa+mF4=Y9Uagk_0jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:29 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 13.01.21 08:35, Dan Williams wrote:
> > pfn_section_valid() determines pfn validity on subsection granularity
> > where pfn_valid() may be limited to coarse section granularity.
> > Explicitly validate subsections after pfn_valid() succeeds.
> >
> > Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Reported-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/memory_hotplug.c |   24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 55a69d4396e7..9f37f8a68da4 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
> >  struct page *pfn_to_online_page(unsigned long pfn)
> >  {
> >       unsigned long nr = pfn_to_section_nr(pfn);
> > +     struct mem_section *ms;
> > +
> > +     if (nr >= NR_MEM_SECTIONS)
> > +             return NULL;
> > +
> > +     ms = __nr_to_section(nr);
> > +     if (!online_section(ms))
> > +             return NULL;
> > +
> > +     /*
> > +      * Save some code text when online_section() +
> > +      * pfn_section_valid() are sufficient.
> > +      */
> > +     if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
> > +             if (!pfn_valid(pfn))
> > +                     return NULL;
>
> Nit:
>
> if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) &&
>     !pfn_valid(pfn))
>

Ok... I'll do a final resend "To: akpm" after the kbuild robot
finishes chewing on this series.
