Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF6273D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIVIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:25:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:44343 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgIVIYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:24:09 -0400
IronPort-SDR: qk+tlc/MYUqMS/0sSiFxa5UDTD+BgM0SwENAafdxKBPIi2rxAefbdHoYnP19aTUzr2iJlGqMKH
 Yk06wQ8H8rsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222152847"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="222152847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 01:24:08 -0700
IronPort-SDR: hYPYeshgQ9gLbxA+nGdC2UUT7a+sUMfvmmOdnILx1oZilih/OM+HLuWniJZ+KnDxCiUxxvah+K
 LMJGx+/weQGQ==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="454404248"
Received: from atroib-mobl2.ger.corp.intel.com (HELO [10.214.238.184]) ([10.214.238.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 01:24:02 -0700
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: use vmap in shmem_pin_map
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, Nitin Gupta <ngupta@vflare.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-4-hch@lst.de>
 <20200921191157.GX32101@casper.infradead.org> <20200922062249.GA30831@lst.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <43d10588-2033-038b-14e4-9f41cd622d7b@linux.intel.com>
Date:   Tue, 22 Sep 2020 09:23:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922062249.GA30831@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/09/2020 07:22, Christoph Hellwig wrote:
> On Mon, Sep 21, 2020 at 08:11:57PM +0100, Matthew Wilcox wrote:
>> This is awkward.  I'd like it if we had a vfree() variant which called
>> put_page() instead of __free_pages().  I'd like it even more if we
>> used release_pages() instead of our own loop that called put_page().
> 
> Note that we don't need a new vfree variant, we can do this manually if
> we want, take a look at kernel/dma/remap.c.  But I thought this code
> intentionally doesn't want to do that to avoid locking in the memory
> for the pages array.  Maybe the i915 maintainers can clarify.

+ Chris & Matt who were involved with this part of i915.

If I understood this sub-thread correctly, iterating and freeing the 
pages via the vmapped ptes, so no need for a
shmem_read_mapping_page_gfp loop in shmem_unpin_map looks plausible to me.

I did not get the reference to kernel/dma/remap.c though, and also not 
sure how to do the error unwind path in shmem_pin_map at which point the 
allocated vm area hasn't been fully populated yet. Hand-roll the loop 
walking vm area struct in there?

Regards,

Tvrtko
