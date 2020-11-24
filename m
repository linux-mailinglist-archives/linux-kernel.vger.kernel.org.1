Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9342C1FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgKXIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:24:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:33504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgKXIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:24:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606206274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SRGiXX4dxU6UG326yCVJi+Xa49zYVgh4TutwaobuZ0=;
        b=SVplqW+TiU0cTnmG6Ntf657Uk5Sw6JBrX7TI6Qnjta5Zl4MT6U/FzDecJ+tR8HlC20JFOp
        Ik3JmkeUjR0fPPXlhJMxRtBgJEBDTd3X0J5gTKIX46SL+4MyHP7HOIzDadFfYQOD8MnvHF
        1I3j+gP/duMmAofSJ1vP6Q4uw70+uYE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00B36AC48;
        Tue, 24 Nov 2020 08:24:33 +0000 (UTC)
Date:   Tue, 24 Nov 2020 09:24:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <20201124082433.GT27488@dhcp22.suse.cz>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <d668b0f2-2644-0f5e-a8c1-a6b8f515e9ab@suse.cz>
 <CA+CK2bBuEhH7cSEZUKTYE_g9mw_rwEG-v1Jk4BL6WuLWK824Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBuEhH7cSEZUKTYE_g9mw_rwEG-v1Jk4BL6WuLWK824Aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-11-20 11:31:59, Pavel Tatashin wrote:
> > Makes sense, as this means no userspace change.
> >
> > > 2. Add an internal move_pages_zone() similar to move_pages() syscall
> > > but instead of migrating to a different NUMA node, migrate pages from
> > > ZONE_MOVABLE to another zone.
> > > Call move_pages_zone() on demand prior to pinning pages from
> > > vfio_pin_map_dma() for instance.
> >
> > As others already said, migrating away before the longterm pin should be
> > the solution. IIRC it was one of the goals of long term pinning api
> > proposed long time ago by Peter Ziljstra I think? The implementation
> > that was merged relatively recently doesn't do that (yet?) for all
> > movable pages, just CMA, but it could.
> 
> From what I can tell, CMA is not solving exactly this problem. It
> migrates pages from CMA before pinning, but it migrates them to
> ZONE_MOVABLE.

CMA suffers from a very similar problem. The existing solution is
migrating out from the CMA region and it allows MOVABLE zones as well
but that is merely an implementation detail and something that breaks
movability on its own. So something to fix up, ideally for both cases.

-- 
Michal Hocko
SUSE Labs
