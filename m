Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323F2EA61E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbhAEHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:45:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:39412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbhAEHpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:45:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609832700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZvIHglRXPVzsIw6aGokI+OdkiIsJ0foIp1wMTrMEbw=;
        b=KzPvVaUgbYSu+YZYoPNmg7zVkoZ5IIN52R0227tJfW51hiywAopxwcmq1HGypt0NpSJjR2
        7ewRVYuLWl77aFQEebR2mq6AcdPqMiO5vQqS5iobe7qp44qtzZZTI6chjkUitShDNGngsR
        t/JTBbjOltBbuN/K/Lxux6pCKHwZDzU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9B04AA35;
        Tue,  5 Jan 2021 07:45:00 +0000 (UTC)
Date:   Tue, 5 Jan 2021 08:44:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210105074459.GR13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz>
 <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <20210104155931.GN13207@dhcp22.suse.cz>
 <a2e8f11a-24b0-5d30-2d8f-1940b268392c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e8f11a-24b0-5d30-2d8f-1940b268392c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 17:30:48, David Hildenbrand wrote:
> >> Let's assume this is indeed a reserved pfn in the altmap. What's the
> >> actual address of the memmap?
> > 
> > Not sure what exactly you are asking for but crash says
> > crash> kmem -p 6060000
> >       PAGE          PHYSICAL      MAPPING       INDEX CNT FLAGS
> > fffff8c600181800     6060000                0        0  0 fffffc0000000
> 
> ^ this looks like it was somewhat initialized. All flags zero, nid/zone
> set to -1 (wild guess) and thus the crash? weird

Yes that made me scratch my head as well.
  
> >> I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
> >> part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
> > 
> > I am not really familiar with the pmem so I would need more assistance
> > here. I've tried this (shot into the dark):
> > crash> struct page.pgmap fffff8c600181800
> >       pgmap = 0xfffff8c600181808
> 
> That's weird. If the memmap is at fffff8c600181800, why should the pgmap
> be at an offset of 8 bytes from there. The "pgmap" field is actually at
> an offset of 8 bytes within the memmap ...

I haven't noticed this is an offset into struct page. This is indeed
weird because the structure is much larger than struct page. But maybe
it reuses storage of several struct pages in a row. Or maybe it is not
pgmap but something else that shares the offset in the structure.
-- 
Michal Hocko
SUSE Labs
