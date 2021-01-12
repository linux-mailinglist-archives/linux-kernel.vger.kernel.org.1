Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826062F31CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbhALNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:32:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:60566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbhALNb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:31:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 727A7ACB0;
        Tue, 12 Jan 2021 13:31:16 +0000 (UTC)
Date:   Tue, 12 Jan 2021 14:31:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 4/5] powerpc/memhotplug: Enable MHP_MEMMAP_ON_MEMORY when
 supported
Message-ID: <20210112133108.GA15667@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-5-osalvador@suse.de>
 <a8fc4fb8-5c88-35a4-4cd7-8cea818acd3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8fc4fb8-5c88-35a4-4cd7-8cea818acd3a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:55:37PM +0100, David Hildenbrand wrote:
> On 17.12.20 14:07, Oscar Salvador wrote:
 
> With 16MB LMBs it's quite wasteful - you won't even have a huge page
> fitting the the remaining part.
> 
> I do wonder if we want this on powerpc only with a bigger LMB/memory
> block size (e.g., 256 MB, which is AFAIK the maximum usually found).

Yeah, powerpc is trickier than the others.
It is more difficult to take advante of this in this platfowm as depending
on the page's size, a larger memory are might have been mapped before,
and so, further hot-add operations will be a noop wrt. populating sections,
until the range to be added falls in non-mapped area.

Nevertheless, I will make this wired to larger memory blocks as you said.

-- 
Oscar Salvador
SUSE L3
