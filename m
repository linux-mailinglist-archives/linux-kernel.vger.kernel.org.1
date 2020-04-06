Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98B319F173
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 10:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDFITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 04:19:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:39878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFITF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:19:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8BC5CAB7F;
        Mon,  6 Apr 2020 08:19:03 +0000 (UTC)
Subject: Re: [PATCH -V3] /proc/PID/smaps: Add PMD migration entry parsing
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20200403123059.1846960-1-ying.huang@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7308c5a2-a24e-85ee-7496-99cd28053af4@suse.cz>
Date:   Mon, 6 Apr 2020 10:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403123059.1846960-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 2:30 PM, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.
> 
> To test the patch, we run pmbench to eat 400 MB memory in background, then run
> /usr/bin/migratepages and `cat /proc/PID/smaps` every second.  The issue as
> follows can be reproduced within 60 seconds.
> 
> Before the patch, for the fully populated 400 MB anonymous VMA, some THP pages
> under migration may be lost as below.
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              407552 kB
> Pss:              407552 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    407552 kB
> Referenced:       301056 kB
> Anonymous:        407552 kB
> LazyFree:              0 kB
> AnonHugePages:    405504 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:		1
> VmFlags: rd wr mr mw me ac
> 
> After the patch, it will be always,
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              409600 kB
> Pss:              409600 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    409600 kB
> Referenced:       294912 kB
> Anonymous:        409600 kB
> LazyFree:              0 kB
> AnonHugePages:    407552 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:		1
> VmFlags: rd wr mr mw me ac
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!
