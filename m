Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3A2CB1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgLBAq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:46:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbgLBAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606869900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDYVxD6tkiBev38C3oTUWFTeIWr7XSep6vYBO4i0itk=;
        b=jUAd+w9YzDvEHEBr6h4M90iH4kq8VOk8xEqAD0l9g3YVqrSDPbE+9nxqDZU1KOx7LtcYRi
        MBVJKjQiP8b3bOnPDx5pNRfH7xbMA8/JeUlzoAeoSnNeBJoZ8kWwtiNpX515fr1NAaC0Rg
        8hbRVrJFvnNswZczvz1gwFawr4dQZRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-eL0NjWgkPnip5CVDTHa03g-1; Tue, 01 Dec 2020 19:44:57 -0500
X-MC-Unique: eL0NjWgkPnip5CVDTHa03g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12EC805BE1;
        Wed,  2 Dec 2020 00:44:55 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D045C10013BD;
        Wed,  2 Dec 2020 00:44:51 +0000 (UTC)
Date:   Tue, 1 Dec 2020 19:44:51 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X8bjgw5LPAZrSrwp@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
 <20201126174601.GT123287@linux.ibm.com>
 <20201129123257.GY123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129123257.GY123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Sun, Nov 29, 2020 at 02:32:57PM +0200, Mike Rapoport wrote:
> Hello Andrea,
> 
> On Thu, Nov 26, 2020 at 07:46:05PM +0200, Mike Rapoport wrote:
> > On Thu, Nov 26, 2020 at 11:05:14AM +0100, David Hildenbrand wrote:
> > 
> > Let's try to merge init_unavailable_memory() into memmap_init().
> > Than it'll be able to set zone/nid for those nasty pfns that BIOS
> > decided to keep to itself, like in Andrea's case and will also take care
> > of struct pages that do not really have a frame in DRAM, but are there
> > because of arbitrary section size.
> 
> Did you have a chance to check if this solves your issue?
> If yes, I'll resend this as a formal patch.

I tested the patch you sent, but it doesn't seem to boot. Reverting it
booted.

Also I noticed leaving pages uninitialized already happened before and
was fixed in 124049decbb121ec32742c94fb5d9d6bed8f24d8 where literally
all holes were registered in memblock_reserve() by hand to workaround
this very same defect in memblock callee we're fixing again.

Then it was lifted in 9fd61bc95130d4971568b89c9548b5e0a4e18e0e since
the memblock was supposed to be able to initialize all pages.

Since this seems the second time this happens, I'd suggest to change
the graceful pfn, 0,0 initialization to memset(page, 0xff,
sizeof(struct page)) too like we mentioned earlier and then have at
least a DEBUG_SOMETHING=y to search for struct pages with all 1 in
page->flags to ensure the boot stage worked right so perhaps there's a
graceful notification at boot before a VM_BUG_ON triggers later. The
page struct validation could be done based on DEBUG_VM=y too since it
won't cause any runtime cost post boot.

Thanks,
Andrea

