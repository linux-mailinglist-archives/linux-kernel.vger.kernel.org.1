Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6CF2F2AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbhALJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbhALJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:16:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:15:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so2419198ejf.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RSCBUADFHXC7ujFfJT5dXXGGcwPYqsp6Fb9kyT+trQ=;
        b=aFkV8dYZxRlzaXtnSF1vMe/nuMAjesIm9kXVgiquMIls/7DGln3YaMuyCNL7TQmOBZ
         3MSp4t4Ivvd8E7gIj18rCSbZMIS9TwiKlMxBbc9wIYaeQwHv92lw82fr5IEMucJEPdBA
         gfvHlPQShpw7Hmv8FL/XN0nxLRT6QF2SNCThvmxuT+DODjdWq0UpRk4Ih4/rqwmAX5no
         xZ92cSUOQdo6YD/J6j6Arek27Eg6qw3EHCNWqVMU5xd2ag2A+vbu4ousQ7entX9dTtsP
         g4DC5MJfrXfEV25Fb43Pt3Ew6Unwlsv+Bz20ymrys9JzvBHQ1jQpOViB21fHAmHfx3NS
         oTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RSCBUADFHXC7ujFfJT5dXXGGcwPYqsp6Fb9kyT+trQ=;
        b=QqtyjXoEPqS9J5C1J66ikbcJGGIXNkb1vbwqicZ/R0ModWxkITi/Y9/62sDUiDRflW
         MXehR5T73SJa1bLCTMaTPGRz22FXWvq55cZIyHfZC7bshUqJofhwTcp9A9DF9to9KZCG
         Xqw70R0sXZH2N4aRIh6haUh3fDqdQOcJf0jSzARa0F0+ES/8mcfLE5/Fd49zTc8KGjy0
         0oDdW0Wnwlblkilpad1KjZsqNrBOm91/se3cVezaL92Guv+TxQn4K/ZRH2K8BHV1mozR
         PIsps5flCC+Ev1gniHse5r5tntrq+3VPH0gu+sp/+Jf39el9C4son/cQQlfB/jPSy+6t
         M0dA==
X-Gm-Message-State: AOAM53250GyFxzs7s9zMjb75OGzCKOXqag98QQn9KmQX/9eDVok7hjHA
        b5Uc8Wm+66UPAHZi3MqigApFLGO6u/cyrO00zS5Ik19U+R+YTg==
X-Google-Smtp-Source: ABdhPJytswuCe1ZVtIFZmx19O/N9mBn86fY/YP41ACHamXYnf2Gjp1cj+YNM+Z+dqpmFoVcyQucXbvgSXmNyVlDfwUs=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr2514293ejz.45.1610442922252;
 Tue, 12 Jan 2021 01:15:22 -0800 (PST)
MIME-Version: 1.0
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210106095520.GJ13207@dhcp22.suse.cz>
In-Reply-To: <20210106095520.GJ13207@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 01:15:12 -0800
Message-ID: <CAPcyv4jc_+UvA=y7-AX-wi-nMgDmCiukfkPwTYBye8Es=fecgw@mail.gmail.com>
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 1:55 AM Michal Hocko <mhocko@suse.com> wrote:
>


> On Tue 05-01-21 20:07:18, Dan Williams wrote:
> > While pfn_to_online_page() is able to determine pfn_valid() at
> > subsection granularity it is not able to reliably determine if a given
> > pfn is also online if the section is mixed with ZONE_DEVICE pfns.
>
> I would call out the problem more explicitly. E.g. something like
> "
> This means that pfn_to_online_page can lead to false positives and allow
> to return a struct page which is not fully initialized because it
> belongs to ZONE_DEVICE (PUT AN EXAMPLE OF SUCH AN UNITIALIZED PAGE
> HERE). That can lead to either crash on PagePoisoned assertion or a
> silently broken page state with debugging disabled.
> "

Apologies for the long pause in this conversation, I went off and
wrote a test to trigger this condition so I could quote it directly.
It turns out soft_offline_page(), even before fixing
pfn_to_online_page(), is broken as it leaks a page reference.

>
> I would also appreciate a more specific note about how the existing HW
> can trigger this. You have mentioned 64MB subsection examples in the
> other email. It would be great to mention it here as well.

Sure.

>
> > Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
> > section that mixes ZONE_DEVICE pfns with other online pfns. With
> > SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
> > back to a slow-path check for ZONE_DEVICE pfns in an online section.
> >
> > With this implementation of pfn_to_online_page() pfn-walkers mostly only
> > need to check section metadata to determine pfn validity. In the
> > rare case of mixed-zone sections the pfn-walker will skip offline
> > ZONE_DEVICE pfns as expected.
>
> The above paragraph is slightly confusing. You do not require
> pfn-walkers to check anything right? Section metadata is something that
> is and should be hidden from them. They are asking for an online page
> and get it or NULL. Nothing more nothing less.
>

Yeah, I'll drop it. I was describing what service pfn_to_online_page()
performs for a pfn-walker, but it's awkwardly worded.

>
> > Other notes:
> >
> > Because the collision case is rare, and for simplicity, the
> > SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
>
> I do not see a problem with that.
>
> > pfn_to_online_page() was already borderline too large to be a macro /
> > inline function, but the additional logic certainly pushed it over that
> > threshold, and so it is moved to an out-of-line helper.
>
> Worth a separate patch.
>
> The approach is sensible. Thanks!
>
> I was worried that we do not have sufficient space for a new flag but
> the comment explains we have 6 bits available.  I haven't double checked
> that for the current state of the code. The comment is quite recent and
> I do not remember any substantial changes in this area. Still something
> that is rather fragile because an unexpected alignment would be a
> runtime failure which is good to stop random corruptions but not ideal.
>
> Is there any way to explicitly test for this? E.g. enforce a shared
> section by qemu and then trigger a pfn walk?
>
> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Reported-by: Michal Hocko <mhocko@suse.com>
> > Reported-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> [...]
>
> > +static int zone_id(const struct zone *zone)
> > +{
> > +     struct pglist_data *pgdat = zone->zone_pgdat;
> > +
> > +     return zone - pgdat->node_zones;
> > +}
>
> We already have zone_idx()

Noted.

>
> > +
> > +static void section_taint_zone_device(struct zone *zone, unsigned long pfn)
> > +{
> > +     struct mem_section *ms = __nr_to_section(pfn_to_section_nr(pfn));
> > +
> > +     if (zone_id(zone) != ZONE_DEVICE)
> > +             return;
> > +
> > +     if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
> > +             return;
> > +
> > +     ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
> > +}
> > +
> >  /*
> >   * Associate the pfn range with the given zone, initializing the memmaps
> >   * and resizing the pgdat/zone data to span the added pages. After this
> > @@ -707,6 +769,15 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> >       resize_pgdat_range(pgdat, start_pfn, nr_pages);
> >       pgdat_resize_unlock(pgdat, &flags);
> >
> > +     /*
> > +      * Subsection population requires care in pfn_to_online_page().
> > +      * Set the taint to enable the slow path detection of
> > +      * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
> > +      * section.
> > +      */
> > +     section_taint_zone_device(zone, start_pfn);
> > +     section_taint_zone_device(zone, start_pfn + nr_pages);
>
> I think it would be better to add the checks here and only set the flag
> in the called function. SECTION_TAINT_ZONE_DEVICE should go to where we
> define helpers for ther flags.
>

Done.
