Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB427513A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIWGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:11:07 -0400
Received: from verein.lst.de ([213.95.11.211]:47372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIWGLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:11:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DCEC767373; Wed, 23 Sep 2020 08:11:02 +0200 (CEST)
Date:   Wed, 23 Sep 2020 08:11:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Nitin Gupta <ngupta@vflare.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: use vmap in shmem_pin_map
Message-ID: <20200923061102.GA15762@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-4-hch@lst.de> <20200921191157.GX32101@casper.infradead.org> <20200922062249.GA30831@lst.de> <43d10588-2033-038b-14e4-9f41cd622d7b@linux.intel.com> <20200922143141.GA26637@lst.de> <e429c3e6-2143-f51a-4c1c-c1470076ad3e@linux.intel.com> <20200922163346.GA1701@lst.de> <1b05b9d6-a14c-85cd-0728-d0d40c9ff84b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b05b9d6-a14c-85cd-0728-d0d40c9ff84b@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 06:04:37PM +0100, Tvrtko Ursulin wrote:
> Only reason I can come up with now is if mapping side is on a latency 
> sensitive path, while un-mapping is lazy/delayed so can be more costly. 
> Then fast map and extra cost on unmap may make sense.

In general yes.  But compared to the overall operations a small kmalloc
is in the noise, so I'd really like to see numbers.

> It more applies to the other i915 patch, which implements a much more used 
> API, but whether or not we can demonstrate any difference in the perf 
> profiles I couldn't tell you without trying to collect some.

The other patch keeps the stack, as avoiding it would not simplify the
code as significantly.  I still doubt it is all that useful, though.


>> We could do vmalloc_to_page, but that is fairly expensive (not as bad
>> as reading from the page cache..).  Are you really worried about the
>> allocation?
>
> Not so much given how we don't even use shmem_pin_map outside selftests.
>
> If we start using it I expect it will be for tiny objects anyway. Only if 
> they end up being pinned for the lifetime of the driver, it may be a 
> pointless waste of memory compared to the downsides of vmalloc_to_page. But 
> we can revisit this particular edge case optimization if the need arises.

For tiny object we could either look into using kmap, or in fact
ensure the shmem files aren't in highmem, in which case you could
always use single-page mappings without any extra mapping.
