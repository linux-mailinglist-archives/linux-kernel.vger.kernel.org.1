Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56CD2F2D58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbhALLBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:01:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:55310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhALLBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:01:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D567AD18;
        Tue, 12 Jan 2021 11:00:31 +0000 (UTC)
Date:   Tue, 12 Jan 2021 12:00:28 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: Teach pfn_to_online_page() about ZONE_DEVICE
 section collisions
Message-ID: <20210112110028.GB12956@linux>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 01:34:53AM -0800, Dan Williams wrote:
> While pfn_to_online_page() is able to determine pfn_valid() at
> subsection granularity it is not able to reliably determine if a given
> pfn is also online if the section is mixes ZONE_{NORMAL,MOVABLE} with
> ZONE_DEVICE. This means that pfn_to_online_page() may return invalid
> @page objects. For example with a memory map like:
> 
> 100000000-1fbffffff : System RAM
>   142000000-143002e16 : Kernel code
>   143200000-143713fff : Kernel rodata
>   143800000-143b15b7f : Kernel data
>   144227000-144ffffff : Kernel bss
> 1fc000000-2fbffffff : Persistent Memory (legacy)
>   1fc000000-2fbffffff : namespace0.0
> 
> This command:
> 
> echo 0x1fc000000 > /sys/devices/system/memory/soft_offline_page
> 
> ...succeeds when it should fail. When it succeeds it touches
> an uninitialized page and may crash or cause other damage (see
> dissolve_free_huge_page()).

[...]
 
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
