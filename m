Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6883F2F7571
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbhAOJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:29:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:58788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbhAOJ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:29:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C9EEB732;
        Fri, 15 Jan 2021 09:28:52 +0000 (UTC)
Date:   Fri, 15 Jan 2021 10:28:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: avoid unnecessary hugetlb_acct_memory()
 call
Message-ID: <20210115092849.GC4092@linux>
References: <20210115092013.61012-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115092013.61012-1-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:20:13AM -0500, Miaohe Lin wrote:
> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
> and releasing hugetlb_lock. We should avoid this unnecessary hugetlb_lock
> lock/unlock cycle which is happening on 'most' hugetlb munmap operations by
> check delta against 0 at the beginning of hugetlb_acct_memory.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

I would avoid mentioning gbl_reserve as not all callers use it, and focus
on what delta means:

"When reservation accounting remains unchanged..", but anyway:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
