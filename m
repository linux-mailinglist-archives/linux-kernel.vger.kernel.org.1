Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A64D2CF19D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgLDQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLDQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:10:47 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5BC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:10:07 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id l7so4251013qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgRFU7+U3dcM21Ber7g78naiXHMx8/x0mx6S23m379c=;
        b=TxQQ3A4gPUb/c6DaNSH8sSZrpSZ6sh+4Kao8BUigB8ZB0+dG67Z7ykp2uwIWWShMWk
         UKN+qrOzqwIa1PPeKfy+NpjPfj04Ckq6aAHGudbjMJHEotnoqGM+emLLcQh1+ECQ7lbg
         1I4RWNBxawpsn4sERFYuKUnYJmx+QJnUXAQgtXZ+GYcfI7xeMKvpo1tnhquqzHMp6G95
         TpTsY3FOT91lCb0ofY3U/iMb+WVfV2Av8BcKN05VanSsIInlyn/ntD7UlBwoA4RzoeGX
         +zRTNsADj7a0zPLZ5xa+CWuiPQlu28cMhvJb9o1ykX60oLPDmsHXlwEXGAVBEqqILXEn
         +bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgRFU7+U3dcM21Ber7g78naiXHMx8/x0mx6S23m379c=;
        b=ZXG0Kosm9JF63wlAImNeIhiQCQUgfj6+fyskWU94yPjqBVMDbU6DXmTSH4P21s9pXq
         vWQRb5pSN3y9CS13IvVNhyAkAlxos9DkjXvMjl+OlAAEMY2Lt7dcbDU2HAVgJHmSu4aZ
         EBwS/eCAqbKF9YdewGXns2wELfClCaKbgblza1XPxCdUkAFj8NntwbIxjFcKL8gbSbww
         Wk0qvPrzvBHLxjsrzH4ErzFfm7rCjHL+1eNSSMGRylre2DGEWYJf+GxpFB1WJbESxQb9
         trdwy4bN9Se1lrE+sqmbOezHyXfMlcrwCB+cU8uHlTMIR7wuEeqU0bioeMqsUyIEvCYe
         Np1g==
X-Gm-Message-State: AOAM531Zh89afxCmy88KBzotqX6k/N1MiJYqpqakS1B6whC+kpi11HW4
        I6/Up0aXQAV/b5ktR5kqT9Q7AQ==
X-Google-Smtp-Source: ABdhPJyJBAEvJJb4cjudhvvR8M4t3aSdim44E4b1pefhuATcOoSqitkM9LGsEmvZ/5HNVRh6F6PjXA==
X-Received: by 2002:ac8:4f11:: with SMTP id b17mr10092063qte.338.1607098206515;
        Fri, 04 Dec 2020 08:10:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z20sm5167491qto.40.2020.12.04.08.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:10:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1klDen-005vbe-3D; Fri, 04 Dec 2020 12:10:05 -0400
Date:   Fri, 4 Dec 2020 12:10:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
Message-ID: <20201204161005.GD5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201204035953.GA17056@js1304-desktop>
 <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 10:55:30AM -0500, Pavel Tatashin wrote:
> On Thu, Dec 3, 2020 at 11:03 PM Joonsoo Kim <js1304@gmail.com> wrote:
> >
> > Hello,
> >
> > On Wed, Dec 02, 2020 at 12:23:24AM -0500, Pavel Tatashin wrote:
> > > When page is pinned it cannot be moved and its physical address stays
> > > the same until pages is unpinned.
> > >
> > > This is useful functionality to allows userland to implementation DMA
> > > access. For example, it is used by vfio in vfio_pin_pages().
> > >
> > > However, this functionality breaks memory hotplug/hotremove assumptions
> > > that pages in ZONE_MOVABLE can always be migrated.
> > >
> > > This patch series fixes this issue by forcing new allocations during
> > > page pinning to omit ZONE_MOVABLE, and also to migrate any existing
> > > pages from ZONE_MOVABLE during pinning.
> >
> > I love what this patchset does, but, at least, it's better to consider
> > the side-effect of this patchset and inform it in somewhere. IIUC,
> > ZONE_MOVABLE exists for two purposes.
> >
> > 1) increasing availability of THP
> > 2) memory hot-unplug
> >
> > Potential issue would come from the case 1). They uses ZONE_MOVABLE
> > for THP availability and hard guarantee for migration isn't required
> > until now. So, there would be a system with following congifuration.
> >
> > - memory layout: ZONE_NORMAL-512MB, ZONE_MOVABLE-512MB
> > - memory usage: unmovable-256MB, movable pinned-256MB, movable
> >   unpinned-512MB
> >
> > With this patchset, movable pinned should be placed in ZONE_NORMAL so
> > 512MB is required for ZONE_NORMAL. ZONE_NORMAL would be exhausted and
> > system performance would be highly afftect according to memory usage
> > pattern.
> >
> > I'm not sure whether such configuration exists or not, but, at least,
> > it's better to write down this risk on commit message or something
> > else.
> 
> Yes, this indeed could be a problem for some configurations. I will
> add your comment to the commit log of one of the patches.

It sounds like there is some inherent tension here, breaking THP's
when doing pin_user_pages() is a really nasty thing to do. DMA
benefits greatly from THP.

I know nothing about ZONE_MOVABLE, is this auto-setup or an admin
option? If the result of this patch is standard systems can no longer
pin > 80% of their memory I have some regression concerns..

Jason
