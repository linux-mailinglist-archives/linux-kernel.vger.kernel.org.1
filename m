Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25372C10B9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbgKWQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgKWQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:32:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8238C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:32:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d18so17746059edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEbsa5HntcIdBOrGyUXi03wOc7HPqT6OCL9AKHl623g=;
        b=JcEmEqmZ5YVK3pKO04CD9oQmQCLnELQLzua8f5fXbSIiJnbSxM1z/pJlUKmuvdrff6
         stFtRiKKcVo+tzBS2B+a0SPwL0Vizlvm8sKbSv8tqJcb3iVYLg557b9ZVNGpZlh1+Pmr
         kRVtCqShkcbuNliqdPmADaMb1KQr2MEPncsHK5QB3G+qH110ElyaG10C7ZRvZm+KE8Nd
         TfjZyeq3+gmJis6cKNWZ/N6mqrWENXzdHRxmfvKI+4mnBdFP0mW78bFvsirFFTgH5o01
         6K6PcEQWA6Tongd41DiZaj5w5lpGxcDvg1jYwfT8pIPM2HyUD1m1ewAnXWMgh+63NcsP
         l9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEbsa5HntcIdBOrGyUXi03wOc7HPqT6OCL9AKHl623g=;
        b=SQjngnA+miIyl4gtuX4RjgYN7G5m8zftPw8+e8EI7tcG6SHICLz9QfOE/tGcFHVT/M
         HJokc2fE8921+VsWJoOJQcLKzAYDExmmuLmSyeSindIIk0q0x2RTHzflW9jDCdzQNoS6
         wC02/Xgxg6AYpmqStQ880Sge9gXBlHuTGWyeMO9Xxy4bOXiGCjGW2TJGfFIBt0mcQ9lJ
         ygdvKNKwTVsF4ZAbxtgaXa+SEgwV9gHecYScYvcpom9vWLlji4ar05XGUt4LujgSVqjM
         7gUMZC7veQKTs3Wm5gctLD1Ehr6zpjFuL8YluxqITClesqA/61sMz7sH7zlAy1hkZrPn
         bFjg==
X-Gm-Message-State: AOAM530guJL+VoLByT/c7tKdpAKPn3XhzftboeAR+i17iywmN4fIgoOO
        BaG2kRWvb+ytCoql3JIi7tIhnYmTIfXeVQhefwPw+xhKoPQrAQ==
X-Google-Smtp-Source: ABdhPJyOWUtbV4XCremShmwksPGxuhOH2vLBSCgXGmGwoVIAY4yigU44H7ddoM3DsgNMnPRHPbGaTG1z2Gf3RGlI1RA=
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr38863edb.116.1606149155388;
 Mon, 23 Nov 2020 08:32:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <d668b0f2-2644-0f5e-a8c1-a6b8f515e9ab@suse.cz>
In-Reply-To: <d668b0f2-2644-0f5e-a8c1-a6b8f515e9ab@suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 23 Nov 2020 11:31:59 -0500
Message-ID: <CA+CK2bBuEhH7cSEZUKTYE_g9mw_rwEG-v1Jk4BL6WuLWK824Aw@mail.gmail.com>
Subject: Re: Pinning ZONE_MOVABLE pages
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Makes sense, as this means no userspace change.
>
> > 2. Add an internal move_pages_zone() similar to move_pages() syscall
> > but instead of migrating to a different NUMA node, migrate pages from
> > ZONE_MOVABLE to another zone.
> > Call move_pages_zone() on demand prior to pinning pages from
> > vfio_pin_map_dma() for instance.
>
> As others already said, migrating away before the longterm pin should be
> the solution. IIRC it was one of the goals of long term pinning api
> proposed long time ago by Peter Ziljstra I think? The implementation
> that was merged relatively recently doesn't do that (yet?) for all
> movable pages, just CMA, but it could.

From what I can tell, CMA is not solving exactly this problem. It
migrates pages from CMA before pinning, but it migrates them to
ZONE_MOVABLE. Also, we still need to take care of the fault scenario.

>
> > 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> > pages from non-movable zone. When a user application knows that it
> > will do DMA mapping, and pin pages for a long time, the memory that it
> > allocates should never be migrated or hot-removed, so make sure that
> > it comes from the appropriate place.
> > The benefit of adding madvise() flag is that we won't have to deal
> > with slow page migration during pin time, but the disadvantage is that
> > we would need to change the user interface.
>
> It's best if we avoid involving userspace until it's shown that's it's
> insufficient.

Agree.

Thank you,
Pasha
