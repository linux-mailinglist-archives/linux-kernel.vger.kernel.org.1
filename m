Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6D2C5D10
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbgKZUaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732042AbgKZUaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606422617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4IWgAW3hUuMrgNpfSLR0+xdfFj3tchIjnSaBTywvjU=;
        b=T/2z/kYKVbnuXaqJFuKuzMpQXwiUvNJvjPethk1CKjzgjcyd7kNAAnfCmk09Et5k6B8piC
        ZIadtnU1MdhGB1dz7DGGsEAtc7iBbKfrSN9uGxRblnkhwgcdBEc/l8blHg3uQKDJke1unM
        A3PJ3rg5uoSBV6wb16XfhuD6eB6uqnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-9iD_dsbMNqCqJABTDEEtbA-1; Thu, 26 Nov 2020 15:30:12 -0500
X-MC-Unique: 9iD_dsbMNqCqJABTDEEtbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF08107464B;
        Thu, 26 Nov 2020 20:30:11 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0CA10023B3;
        Thu, 26 Nov 2020 20:30:02 +0000 (UTC)
Date:   Thu, 26 Nov 2020 15:30:01 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X8AQSViIvYKyEOF6@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <X7/0CmrPwjq9LDUj@redhat.com>
 <20201126194426.GU123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126194426.GU123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 09:44:26PM +0200, Mike Rapoport wrote:
> TBH, the whole interaction between e820 and memblock keeps me puzzled
> and I can only make educated guesses why some ranges here are
> memblock_reserve()'d and some memblock_add()ed.

The mixed usage in that interaction between memblock.reserve and
memblock.memory where sometime it's used to reserve overlapping
memblock.memory ranges (clearly ok), and sometimes is used on ranges
with no overlap (not clear even why it's being called), is what makes
the current code messy.

We're basically passing down the exact same information (inverted),
through two different APIs, if there is no overlap.

> I think what should be there is that e820 entries that are essentially
> RAM, used by BIOS or not, should be listed in memblock.memory. Then
> using memblock_reserve() for parts that BIOS claimed for itself would
> have the same semantics as for memory allocated by kernel.
>
> I.e. if there is a DIMM from 0 to, say 512M, memblock.memory will have a
> range [0, 512M]. And areas such as 0x000-0xfff, 0x9d000-0x9ffff will be
> in memblock.reserved.
> 
> Than in page_alloc.c we'll know that we have a physical memory bank from
> 0 to 512M but there are some ranges that we cannot use.
>
> I suggested it back then when the issue with compaction was reported at
> the first time, but Baoquan mentioned that there are systems that cannot
> even tolerate having BIOS reserved areas in the page tables and I didn't
> continue to pursue this.

That explains why we can't add the e820 non-RAM regions to
memblock_add, what's not clear is why it should be required to call
memblock_reserve on a region that has no overlap with any memblock_add.

Instead of the patch that adds a walk to the memblock.reserve and that
requires adding even more memblock_reserve to e820__memblock_setup for
type 20, we can add a walk for the memblock.memory holes and then we
can remove the memblock_reserve for E820_TYPE_SOFT_RESERVED too.

Thanks,
Andrea

