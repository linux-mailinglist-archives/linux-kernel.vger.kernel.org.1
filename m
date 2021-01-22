Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F72FFEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbhAVIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbhAVIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611305229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOmCbqMHSDdmTGF/tqzLVzaW8YHMv4vFHvY64scKop8=;
        b=HE8zI8yvCE9kV41zFA0ruXp/+4XiHr78qxKjprXYEyOT3+U/kIWMsWJFKaI1dPVttL4ei7
        1iIa7+Dz2jHH4o0qPXVymEmWqQDrBzb9Vfra7hswwJgKgGbwqD1kbHvGdgfC4nuedlDTIj
        MqPqVNmEm9LraukQSSg6Q9oEFYQwJcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-eutT9E5TMiq-K76ZawIAlw-1; Fri, 22 Jan 2021 03:47:07 -0500
X-MC-Unique: eutT9E5TMiq-K76ZawIAlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF7C10054FF;
        Fri, 22 Jan 2021 08:47:06 +0000 (UTC)
Received: from localhost (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8B53100AE4F;
        Fri, 22 Jan 2021 08:47:02 +0000 (UTC)
Date:   Fri, 22 Jan 2021 16:46:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH] mm: fix prototype warning from kernel test robot
Message-ID: <20210122084659.GA29905@MiWiFi-R3L-srv>
References: <20210122070359.24010-1-bhe@redhat.com>
 <3fd62f11-bf44-3ede-aed1-10d9d4849f00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd62f11-bf44-3ede-aed1-10d9d4849f00@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22/21 at 09:40am, David Hildenbrand wrote:
> On 22.01.21 08:03, Baoquan He wrote:
> > Kernel test robot calling make with 'W=1' triggering warning like below
> > below for memmap_init_zone() function.
> > 
> > mm/page_alloc.c:6259:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
> >  6259 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> >       |                       ^~~~~~~~~~~~~~~~
> > 
> > Fix it by adding the function declaration in include/linux/mm.h.
> > Since memmap_init_zone() has a generic version with '__weak',
> > the declaratoin in ia64 header file can be simply removed.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  arch/ia64/include/asm/pgtable.h | 5 -----
> >  include/linux/mm.h              | 1 +
> >  2 files changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> > index 2c81394a2430..9b4efe89e62d 100644
> > --- a/arch/ia64/include/asm/pgtable.h
> > +++ b/arch/ia64/include/asm/pgtable.h
> > @@ -517,11 +517,6 @@ extern struct page *zero_page_memmap_ptr;
> >  	__changed;							\
> >  })
> >  #endif
> > -
> > -#  ifdef CONFIG_VIRTUAL_MEM_MAP
> > -  /* arch mem_map init routine is needed due to holes in a virtual mem_map */
> > -    extern void memmap_init_zone(struct zone *zone);
> > -#  endif /* CONFIG_VIRTUAL_MEM_MAP */
> >  # endif /* !__ASSEMBLY__ */
> >  
> >  /*
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 56bb239f9150..073049bd0b29 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2401,6 +2401,7 @@ extern void set_dma_reserve(unsigned long new_dma_reserve);
> >  extern void memmap_init_range(unsigned long, int, unsigned long,
> >  		unsigned long, unsigned long, enum meminit_context,
> >  		struct vmem_altmap *, int migratetype);
> > +extern void memmap_init_zone(struct zone *zone);
> >  extern void setup_per_zone_wmarks(void);
> >  extern int __meminit init_per_zone_wmark_min(void);
> >  extern void mem_init(void);
> > 
> 
> This patch is on top of your other series, no?
> 
> In -next, we have
> 
> extern void memmap_init_zone(unsigned long, int, unsigned long, ...
> 
> In that file, so something is wrong.

Right, this one is based on the memmap_init_xx clean up patchset. I
mentioned this the the sub-thread of kernel test robot reporting issues.

