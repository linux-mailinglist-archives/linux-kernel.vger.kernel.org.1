Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAAE2069F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbgFXCOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 22:14:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730898AbgFXCOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592964852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72tXMCYAWaryjLEebqft3+tOxDV8hdqHpypK5kqi+nM=;
        b=G5rQlP4B0lXbsEqfdspxC1b6ErqpQ4sdZezDKA15tutEKBYysmA24x/MT4RL1lzFEDSqF3
        gwAYqpKDECuzzFyPyDEjWkrdsm9slJfYOTPjW4REQrABoT04Gb4RIoTY/Qx7FvvIl/Uq+Y
        oqQv1cb4goHFpYRQtYYlXG4aTrcD4DE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-cLOg42qFM8SspIKJJo__wQ-1; Tue, 23 Jun 2020 22:14:10 -0400
X-MC-Unique: cLOg42qFM8SspIKJJo__wQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE1257094;
        Wed, 24 Jun 2020 02:14:09 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 369521DC;
        Wed, 24 Jun 2020 02:14:05 +0000 (UTC)
Date:   Wed, 24 Jun 2020 10:14:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624021403.GH3346@MiWiFi-R3L-srv>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
 <20200624014737.GG3346@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624014737.GG3346@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 at 09:47am, Baoquan He wrote:
> On 06/23/20 at 05:21pm, Dan Williams wrote:
> > On Tue, Jun 23, 2020 at 2:43 AM Wei Yang
> > <richard.weiyang@linux.alibaba.com> wrote:
> > >
> > > For early sections, we assumes its memmap will never be partially
> > > removed. But current behavior breaks this.
> > 
> > Where do we assume that?
> > 
> > The primary use case for this was mapping pmem that collides with
> > System-RAM in the same 128MB section. That collision will certainly be
> > depopulated on-demand depending on the state of the pmem device. So,
> > I'm not understanding the problem or the benefit of this change.
> 
> I was also confused when review this patch, the patch log is a little
> short and simple. From the current code, with SPARSE_VMEMMAP enabled, we
> do build memmap for the whole memory section during boot, even though
> some of them may be partially populated. We just mark the subsection map
> for present pages. 
> 
> Later, if pmem device is mapped into the partially boot memory section,
> we just fill the relevant subsection map, do return directly, w/o building
> the memmap for it, in section_activate(). Because the memmap for the
> unpresent RAM part have been there. I guess this is what Wei is trying to 
> do to keep the behaviour be consistent for pmem device adding, or

OK, from Wei's reply I realized this patch is a necessary fix. If we
depoluate the partial memmap for pmem removing, the later pmem re-adding
won't have a valid memmap.

> pmem device removing and later adding again.
> 
> Please correct me if I am wrong.
> 
> To me, fixing it looks good. But a clear doc or code comment is
> necessary so that people can understand the code with less time.
> Leaving it as is doesn't cause harm. I personally tend to choose
> the former.
> 
> 	paging_init()
> 	    ->sparse_init()
> 	        ->sparse_init_nid()
> 	          {
>                       ...
>                       for_each_present_section_nr(pnum_begin, pnum) {
>                           ...
>                           map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
>                                      nid, NULL);
>                           ...
>                       }
>                   }
>              ...
>              ->zone_sizes_init()
>                  ->free_area_init()
>                    {
>                        for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
>                            subsection_map_init(start_pfn, end_pfn - start_pfn);
>                        }
>                    {
> 		
>          __add_pages()
>              ->sparse_add_section()
>                  ->section_activate()
>                    {
>                        ...
>                        fill_subsection_map();
>                        if (nr_pages < PAGES_PER_SECTION && early_section(ms))   <----------*********
>                            return pfn_to_page(pfn);
>                        ...
>                    }
> > 
> 
> 

