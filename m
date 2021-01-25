Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31874302596
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbhAYNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:40:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:36126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbhAYNhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:37:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FF5AAC45;
        Mon, 25 Jan 2021 13:36:23 +0000 (UTC)
Date:   Mon, 25 Jan 2021 14:36:20 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210125133544.GA31473@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
 <20210125103951.GA27851@linux>
 <20210125105557.GA28363@linux>
 <64b0dca6-4460-ec6c-66f6-88db24ec288f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b0dca6-4460-ec6c-66f6-88db24ec288f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:02:53PM +0100, David Hildenbrand wrote:
> Assume you have two consecutive memory blocks with 56 sizeof(struct page).
> The first one allocates a PMD (2097152) but only consumes 1835008, the second
> one reuses the remaining part and allocates another PMD (1835008),
> only using parts of it.
> 
> Ripping out a memory block, along with the PMD in the vmemmap would
> remove parts of the vmemmap of another memory block.

Bleh, yeah, I was confused, you are right.

> You might want to take a look at:

Thanks a lot for the hints, I will have a look ;-)


-- 
Oscar Salvador
SUSE L3
