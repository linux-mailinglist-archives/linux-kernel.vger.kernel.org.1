Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5652EA731
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbhAEJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:21:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAEJVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:21:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609838438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkWEVAne/Zp8rRQWRngkUvl4UBybdMI2J/82AEM+QYg=;
        b=Ow/Cqmex8Vu/mFIxqsr8sPRiLZJva5ws1xp7G4QywxnsDFYkOBWxL4goYV7K7MFPXGmSyv
        0+Ek2ps4Oro+Niefyb9alahZ0/wm8ZTZ1xQX2nLuHri6RXqxgnMA7WznpkCvQ3KrU1Wd4l
        ge8iAJ1j6RxsdCW5Jq1YLrx0TTu8f0k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02FA6B720;
        Tue,  5 Jan 2021 09:20:38 +0000 (UTC)
Date:   Tue, 5 Jan 2021 10:20:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
Message-ID: <20210105092037.GY13207@dhcp22.suse.cz>
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
 <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 15:00:31, Dave Hansen wrote:
> On 1/4/21 12:11 PM, David Hildenbrand wrote:
> >> Yeah, it certainly can't be the default, but it *is* useful for
> >> thing where we know that there are no cache benefits to zeroing
> >> close to where the memory is allocated.
> >> 
> >> The trick is opting into it somehow, either in a process or a VMA.
> >> 
> > The patch set is mostly trying to optimize starting a new process. So
> > process/vma doesn‘t really work.
> 
> Let's say you have a system-wide tunable that says: pre-zero pages and
> keep 10GB of them around.  Then, you opt-in a process to being allowed
> to dip into that pool with a process-wide flag or an madvise() call.
> You could even have the flag be inherited across execve() if you wanted
> to have helper apps be able to set the policy and access the pool like
> how numactl works.

While possible, it sounds quite heavy weight to me. Page allocator would
have to somehow maintain those pre-zeroed pages. This pool will also
become a very scarce resource very soon because everybody just want to
run faster. So this would open many more interesting questions.

A global knob with all or nothing sounds like an easier to use and
maintain solution to me.

> Dan makes a very good point about using filesystems for this, though.
> It wouldn't be rocket science to set up a special tmpfs mount just for
> VM memory and pre-zero it from userspace.  For qemu, you'd need to teach
> the management layer to hand out zeroed files via mem-path=.

Agreed. That would be an interesting option.

> Heck, if
> you taught MADV_FREE how to handle tmpfs, you could even pre-zero *and*
> get the memory back quickly if those files ended up over-sized somehow.

We can probably allow MADV_FREE on shmem but that would require an
exclusively mapped page. Shared case is really tricky because of silent
data corruption in uncoordinated userspace.
-- 
Michal Hocko
SUSE Labs
