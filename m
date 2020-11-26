Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E92C5272
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbgKZKvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:51:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:59910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgKZKvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:51:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A73DAC22;
        Thu, 26 Nov 2020 10:51:36 +0000 (UTC)
Date:   Thu, 26 Nov 2020 10:51:34 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201126105134.GP3306@suse.de>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
 <cd9f0b9f-c4f6-b80c-03cd-12697324bfca@redhat.com>
 <20201125141325.GK123287@linux.ibm.com>
 <3a25844f-f6c4-a794-69ef-fdf49e5b7cf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3a25844f-f6c4-a794-69ef-fdf49e5b7cf8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:42:37PM +0100, David Hildenbrand wrote:
> > Now the loop is for interesection of [zone_start_pfn, zone_end_pfn] with
> > memblock.memory and for x86 reserved ranges are not in memblock.memory,
> > so the memmap for them remains semi-initialized.
> 
> As far as I understood Mel, rounding these ranges up/down to cover full
> MAX_ORDER blocks/pageblocks might work.
> 

Yes, round down the lower end of the hole and round up the higher end to
the MAX_ORDER boundary for the purposes of having valid zone/node
linkages even if the underlying page is PageReserved.

-- 
Mel Gorman
SUSE Labs
