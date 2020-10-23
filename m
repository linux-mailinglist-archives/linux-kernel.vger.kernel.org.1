Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F054296B66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460764AbgJWIt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:49:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460744AbgJWIt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:49:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603442997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQP6q9oOL6uHfyK9NBVdOP6qfH69+lrFj32xF4uY3+M=;
        b=exr/3/1dyO9JUS8nm3bM+htiQ1H5aNJRxDvfHIiVNsNvBu/QT5WFkha7DEbOtUpQorEdT6
        lr77P3p2w848RX5M+rtV1EkNIUd+bPoGFhtbxD2QNPJMIff+Y6ZdnN5nbnqg3J9CnLe/OI
        SKad5xidwVb0n2XUxle+sC/0W0AAvXI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49E9AABF4;
        Fri, 23 Oct 2020 08:49:57 +0000 (UTC)
Date:   Fri, 23 Oct 2020 10:49:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>, Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201023084956.GS23790@dhcp22.suse.cz>
References: <20201022124511.72448a5f@imladris.surriel.com>
 <alpine.LSU.2.11.2010221909060.1001@eggly.anvils>
 <932f5931911e5ad7d730127b0784b0913045639c.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932f5931911e5ad7d730127b0784b0913045639c.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-10-20 23:40:53, Rik van Riel wrote:
> On Thu, 2020-10-22 at 19:54 -0700, Hugh Dickins wrote:
[...]
> > But it's likely that they have accumulated some defrag wisdom, which
> > tmpfs can take on board - but please accept that in using a huge
> > mount,
> > the preference for huge has already been expressed, so I don't expect
> > anon THP alloc_hugepage_direct_gfpmask() choices will map one to one.
> 
> In my mind, the huge= mount options for tmpfs corresponded
> to the "enabled" anon THP options, denoting a desired end
> state, not necessarily how much we will stall allocations
> to get there immediately.

It is really unfortunate that our configuration space is so huge and
messy but we have to live with that now.

Anyway, I would tend to agree that with an absense of per-mount defrag
configuration it makes sense to use the global one. Is anybody aware of
usecases where a mount specific configuration would make sense?
-- 
Michal Hocko
SUSE Labs
