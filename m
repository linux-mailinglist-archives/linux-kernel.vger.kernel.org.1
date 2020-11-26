Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052242C5C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404641AbgKZS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:29:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403953AbgKZS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606415380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dt5+0Amx9XqMpkDRqxtwE80sB6LlnzBoDhEoiCtsP50=;
        b=Y5rQYQXFJh9ACuLl5OBp/04RH2y4MhLHmdS/jzLEQK5T9gFPFIafSJQi84+X7Ty8DAneva
        ssQ98Hko7ixcVDCLeaA+MlMoz2zGsBTbLnSlKha4xxWjE7nK1WzDJ4zp5sZFuTCYQIWZXI
        S+jMExgROMlMeKIx6ZBne5ATqZSWdTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-fGCv3kwxN4CgxN9pTmDxfQ-1; Thu, 26 Nov 2020 13:29:38 -0500
X-MC-Unique: fGCv3kwxN4CgxN9pTmDxfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F9F8064B3;
        Thu, 26 Nov 2020 18:29:31 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A02C5D6AC;
        Thu, 26 Nov 2020 18:29:31 +0000 (UTC)
Date:   Thu, 26 Nov 2020 13:29:30 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X7/0CmrPwjq9LDUj@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126093602.GQ123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:36:02AM +0200, Mike Rapoport wrote:
> memory.reserved cannot be calculated automatically. It represents all
> the memory allocations made before page allocator is up. And as
> memblock_reserve() is the most basic to allocate memory early at boot we
> cannot really delete it ;-)

Well this explanation totally covers "memory allocated early at
boot" that overlaps with memblock.memory.

Does the E820_TYPE_SOFT_RESERVED range added to memblock.reserve
define as "memory allocated early at boot"?

Does it overlap ranges added with any RAM added to memblock.memory?

		if (entry->type == E820_TYPE_SOFT_RESERVED)
			memblock_reserve(entry->addr, entry->size);

		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
			continue;

		memblock_add(entry->addr, entry->size);

To me the above looks it's being used for something completely
different than from reserving "memory allocated early at boot".

Why there is no warning at boot if there's no overlap between
memblock.resereve and memblock.memory?

My question about memblock.reserve is really about the non overlapping
ranges: why are ranges non overlapping with memblock.memory regions,
added to memblock.reserve, and why aren't those calculated
automatically as reverse of memblock.memory?

It's easy to see that when memblock.reserve overlaps fully, it makes
perfect sense and it has to stay for it. I was really only thinking at
the usage like above of memblock_reserve that looks like it should be
turned into a noop and deleted.

Thanks,
Andrea

