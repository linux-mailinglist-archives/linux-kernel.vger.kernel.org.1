Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431C3280E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJBIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:10:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBIKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:10:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601626252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohDDELRfBZ5fnVMTOVRtcfOH/3QcEOCGj4lb5+R6z9o=;
        b=hLFJAuYkibo3WCmxlXfl5Nnf7erkZKdfm21uustbsSQbLATOOaTdPDDrksB56pwfXg0mIE
        14vO/C1R80r6UepkkEnYr3W4abdXT5zDEelBtuU/kJrC9nDS4MMHPy3pIdmJ3Tz3loHefi
        aQrMDLL4QUmUFXiIMMc1Mv4A/jBjbd8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15F86B22E;
        Fri,  2 Oct 2020 08:10:52 +0000 (UTC)
Date:   Fri, 2 Oct 2020 10:10:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Message-ID: <20201002081023.GA4555@dhcp22.suse.cz>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-10-20 09:50:02, David Hildenbrand wrote:
> >>> - huge page sizes controllable by the userspace?
> >>
> >> It might be good to allow advanced users to choose the page sizes, so they
> >> have better control of their applications.
> > 
> > Could you elaborate more? Those advanced users can use hugetlb, right?
> > They get a very good control over page size and pool preallocation etc.
> > So they can get what they need - assuming there is enough memory.
> > 
> 
> I am still not convinced that 1G THP (TGP :) ) are really what we want
> to support. I can understand that there are some use cases that might
> benefit from it, especially:

Well, I would say that internal support for larger huge pages (e.g. 1GB)
that can transparently split under memory pressure is a useful
funtionality. I cannot really judge how complex that would be
consideting that 2MB THP have turned out to be quite a pain but
situation has settled over time. Maybe our current code base is prepared
for that much better.

Exposing that interface to the userspace is a different story of course.
I do agree that we likely do not want to be very explicit about that.
E.g. an interface for address space defragmentation without any more
specifics sounds like a useful feature to me. It will be up to the
kernel to decide which huge pages to use.
-- 
Michal Hocko
SUSE Labs
