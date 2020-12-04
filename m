Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22712CE6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgLDELz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727676AbgLDELz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607055028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaTwcm53OtninOzBBz2Gca30oq4arEzjy5m9qeAMvIc=;
        b=cWwvtOyWo2GXLm5uYUVFu9QIRQUKjm57ee/+dCD3E98X+uIT9z7I0891TpYol9CVwX4Fxq
        O6gvRsN2vGSW7W8Mcvdf1ZsC5/X7OlxsQsUV5+mK+p3yKxevVPf+J61qFrIfC1fChAz+kQ
        JwEXzs+744WouEJFIvtesu05Yi4DC8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-4YB5W3gIPUy0qLpFRPBY0w-1; Thu, 03 Dec 2020 23:10:27 -0500
X-MC-Unique: 4YB5W3gIPUy0qLpFRPBY0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C9199CC0D;
        Fri,  4 Dec 2020 04:10:25 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA825C1CF;
        Fri,  4 Dec 2020 04:10:19 +0000 (UTC)
Date:   Thu, 3 Dec 2020 23:10:18 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <X8m2qv9h7+e79UjJ@redhat.com>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
 <20201204023051.GL108496@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204023051.GL108496@xz-x1>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Dec 03, 2020 at 09:30:51PM -0500, Peter Xu wrote:
> I'm just afraid there's no space left for a migration entry, because migration
> entries fills in the pfn information into swp offset field rather than a real
> offset (please refer to make_migration_entry())?  I assume PFN can use any bit.
> Or did I miss anything?
> 
> I went back to see the original proposal from Hugh:
> 
>   IIUC you only need a single value, no need to carve out another whole
>   swp_type: could probably be swp_offset 0 of any swp_type other than 0.
> 
> Hugh/Andrea, sorry if this is a stupid swap question: could you help explain
> why swp_offset=0 won't be used by any swap device?  I believe it's correct,
> it's just that I failed to figure out the reason myself. :(
> 

Hugh may want to review if I got it wrong, but there's basically three
ways.

swp_type would mean adding one more reserved value in addition of
SWP_MIGRATION_READ and SWP_MIGRATION_WRITE (kind of increasing
SWP_MIGRATION_NUM to 3).

swp_offset = 0 works in combination of SWP_MIGRATION_WRITE and
SWP_MIGRATION_READ if we enforce pfn 0 is never used by the kernel
(I'd feel safer with pfn value -1UL truncated to the bits of the swp
offset, since the swp_entry format is common code).

The bit I was suggesting is just one more bit like _PAGE_SWP_UFFD_WP
from the pte, one that cannot ever be set in any swp entry today. I
assume it can't be _PAGE_SWP_UFFD_WP since that already can be set but
you may want to verify it...

It'd be set on the pte (not in the swap entry), then it doesn't matter
much what's inside the swp_entry anymore. The pte value would be
generated with this:

 pte_swp_uffd_wp_unmap(swp_entry_to_pte(swp_entry(SWP_MIGRATION_READ, 0)))

(maybe SWP_MIGRATION_READ could also be 0 and then it can be just
enough to set that single bit in the pte and nothing else, all other
bits zero)

We never store a raw swp entry in the pte (the raw swp entry is stored
in the xarray, it's the index of the swapcache).

To solve our unmap issue we only deal with pte storage (no xarray
index storage). This is why it can also be in the arch specific pte
representation of the swp entry, it doesn't need to be a special value
defined in the swp entry common code.

Being the swap entry to pte conversion arch dependent, such bit needs
to be defined by each arch (reserving a offset or type value in swp
entry would solve it in the common code).

#define SWP_OFFSET_FIRST_BIT	(_PAGE_BIT_PROTNONE + 1)

All bits below PROTNONE are available for software use and we use bit
1 (soft dirty) 2 (uffd_wp). protnone bit 8 itself (global bit) must
not be set or it'll look protnone and pte_present will be true. Bit 7
is PSE so it's also not available because pte_present checks that
too.

It appears you can pick between bit 3 4 5 6 at your own choice and it
doesn't look like we're running out of those yet (if we were there
would be a bigger incentive to encode it as part of the swp entry
format). Example:

#define _PAGE_SWP_UFFD_WP_UNMAP	_PAGE_PWT

If that bit it set and pte_present is false, then everything else in
that that pte is meaningless and it means uffd wrprotected
pte_none.

So in the migration-entry/swapin page fault path, you could go one
step back and check the pte for such bit, if it's set it's not a
migration entry.

If there's a read access it should fill the page mark with
shmem_fault, keep the pte wrprotected and then set _PAGE_UFFD_WP on
the pte. If there's a write access it should invoke handle_userfault.

If there's any reason where the swp_entry reservation is simpler
that's ok too, you'll see an huge lot of more details once you try to
implement it so you'll be better able to judje later. I'm greatly
simplifying everything but this is not simple feat...

Thanks,
Andrea

