Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92B2E9E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbhADTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbhADTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:45:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB04C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 11:44:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h16so28575932edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rP6JMMmN2qDx0vY3UL4gUA6b6UKruldSZyuo0iGykOg=;
        b=PjxBCzAlllrQggSRUGJfQNSuIopENh3Tqqzt/7RRTb6hLC/P7UDNt31vlXRBGg5zol
         3utT36Rb1LJGR8DknNAVpi/teLnQFlGGTK8EX8Dmh6q6BsBucmQW5TnK5y3oVvsjA2/E
         QeOr/wncwGiABC2S/A6PWGg8fp2CfwFCZQPRjISiuVB7dVbevqym7L2adJrqEZOEsYa3
         84weLdY46t5Rg9xJpTFFSZ47qKXQJJiXqRVeh08NSJND2xwvvzTs/XHUDOIP9AqAhGPD
         GHZbUVG/6lTNQOLvYgpPqGNS4BI757RkFAqhOaFwkXIEv+iHJH1uonwCIDZjGtGPnz3z
         f3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rP6JMMmN2qDx0vY3UL4gUA6b6UKruldSZyuo0iGykOg=;
        b=tB7iS4usTXkiIRO+7ArCyRZbN98B0EhVJwTfM8nboX6tFP8KhOJBmunTlRSI/1JD7+
         vFVju8NQ0L3nSZTCNrNUUkO3E3NHhTi/6Co9elbIIUJhI/bv6VjWcQwPsmI2lfGDfxGs
         WB19DRlaEtyww6KsUSJZ3gCAHfQlwCScgfOt5p6zAGbL36VtJ/tekr2c9GEg+sObmKH9
         A31ncowA3Skgkfq2Qq3MFixmOcWKsIfTZ5bMrRSazBwfz0eKcPB34i0sM2/C71rFOmQc
         kBy25Ka4WkH5TJO+Pdvin1Jc3/dyuYFRPFKgUMjjdsikKbSWhnXS8ee9wiDcRnfSx+/B
         YvXA==
X-Gm-Message-State: AOAM5302hYFzllYDNdePGZ7GQQ2SEbP6VxS+lnDF9TG0AzQ62VgCKktA
        EBfK/h9/QiLbU+P9VyZ2gXSdYGY+5A0FjyHY9VfzXlt2tk0=
X-Google-Smtp-Source: ABdhPJxM5u0mPWYjqwv13UO1NgJU5Gjj6vsx1dKrs7kAvLR/LzlFcy/fYt6pCYA6VMk0dl4Dbt+XvD5Me2QpaPWn6Tw=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr71465283edr.97.1609789461007;
 Mon, 04 Jan 2021 11:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20201221163024.GA22532@open-light-1.localdomain>
 <0e8b6a2f-527d-7c77-efcf-04f21ef2a77c@intel.com> <20210104192753.GD22407@casper.infradead.org>
In-Reply-To: <20210104192753.GD22407@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Jan 2021 11:44:15 -0800
Message-ID: <CAPcyv4ig_REkFOWJwFwuRnz-YinsBNYkH35TNo+=qY+3X_7FJA@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 04, 2021 at 11:19:13AM -0800, Dave Hansen wrote:
> > On 12/21/20 8:30 AM, Liang Li wrote:
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -137,6 +137,9 @@ enum pageflags {
> > >  #endif
> > >  #ifdef CONFIG_64BIT
> > >     PG_arch_2,
> > > +#endif
> > > +#ifdef CONFIG_PREZERO_PAGE
> > > +   PG_zero,
> > >  #endif
> > >     __NR_PAGEFLAGS,
> >
> > I don't think this is worth a generic page->flags bit.
> >
> > There's a ton of space in 'struct page' for pages that are in the
> > allocator.  Can't we use some of that space?
>
> I was going to object to that too, but I think the entire approach is
> flawed and needs to be thrown out.  It just nukes the caches in extremely
> subtle and hard to measure ways, lowering overall system performance.

At a minimum the performance analysis should at least try to quantify
that externalized cost. Certainly that overhead went somewhere. Maybe
if this overhead was limited to run when the CPU would otherwise go
idle, but that might mean it never runs in practice...
