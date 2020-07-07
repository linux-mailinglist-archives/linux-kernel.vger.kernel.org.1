Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF2216D31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGGMxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 08:53:33 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35189 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgGGMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:53:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U20c5Dc_1594126404;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U20c5Dc_1594126404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 20:53:25 +0800
Date:   Tue, 7 Jul 2020 20:53:24 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 3/4] mm/mremap: calculate extent in one place
Message-ID: <20200707125324.GA32982@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
 <20200626135216.24314-4-richard.weiyang@linux.alibaba.com>
 <20200706100729.y2wbkpc4tyvjojzg@box>
 <20200707013856.GA27805@L-31X9LVDL-1304.local>
 <20200707104722.j3awgkz4ncgm2bss@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707104722.j3awgkz4ncgm2bss@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:47:22PM +0300, Kirill A. Shutemov wrote:
>On Tue, Jul 07, 2020 at 09:38:56AM +0800, Wei Yang wrote:
>> On Mon, Jul 06, 2020 at 01:07:29PM +0300, Kirill A. Shutemov wrote:
>> >On Fri, Jun 26, 2020 at 09:52:15PM +0800, Wei Yang wrote:
>> >> Page tables is moved on the base of PMD. This requires both source
>> >> and destination range should meet the requirement.
>> >> 
>> >> Current code works well since move_huge_pmd() and move_normal_pmd()
>> >> would check old_addr and new_addr again. And then return to move_ptes()
>> >> if the either of them is not aligned.
>> >> 
>> >> In stead of calculating the extent separately, it is better to calculate
>> >> in one place, so we know it is not necessary to try move pmd. By doing
>> >> so, the logic seems a little clear.
>> >> 
>> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> >> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> >> ---
>> >>  mm/mremap.c | 6 +++---
>> >>  1 file changed, 3 insertions(+), 3 deletions(-)
>> >> 
>> >> diff --git a/mm/mremap.c b/mm/mremap.c
>> >> index de27b12c8a5a..a30b3e86cc99 100644
>> >> --- a/mm/mremap.c
>> >> +++ b/mm/mremap.c
>> >> @@ -258,6 +258,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>> >>  		extent = next - old_addr;
>> >>  		if (extent > old_end - old_addr)
>> >>  			extent = old_end - old_addr;
>> >> +		next = (new_addr + PMD_SIZE) & PMD_MASK;
>> >
>> >Please use round_up() for both 'next' calculations.
>> >
>> 
>> I took another close look into this, seems this is not a good suggestion.
>> 
>>    round_up(new_addr, PMD_SIZE)
>> 
>> would be new_addr when new_addr is PMD_SIZE aligned, which is not what we
>> expect.
>
>Maybe round_down(new_addr + PMD_SIZE, PMD_SIZE)?
>

To be honest, I don't like this which makes the code not that straight
forward. And when you look into the definition of pxd_addr_end(), they use the
format of ((addr + PXD_SIZE) & PXD_MASK) too.

I have another alternative to clean up this part with the help of
pmd_addr_end(). If you agree, I would like to append the following change in
next version to cleanup the next/extent staff especially.

Author: Wei Yang <richard.weiyang@linux.alibaba.com>
Date:   Tue Jul 7 17:42:49 2020 +0800

    mm/mremap: use pmd_addr_end to calculate extent

diff --git a/mm/mremap.c b/mm/mremap.c
index f5f17d050617..76e7fdf567c3 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -237,11 +237,12 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks)
 {
-	unsigned long extent, next, old_end;
+	unsigned long extent, old_next, new_next, old_end, new_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 
 	old_end = old_addr + len;
+	new_end = new_addr + len;
 	flush_cache_range(vma, old_addr, old_end);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
@@ -250,14 +251,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 
 	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
 		cond_resched();
-		next = (old_addr + PMD_SIZE) & PMD_MASK;
-		/* even if next overflowed, extent below will be ok */
-		extent = next - old_addr;
-		if (extent > old_end - old_addr)
-			extent = old_end - old_addr;
-		next = (new_addr + PMD_SIZE) & PMD_MASK;
-		if (extent > next - new_addr)
-			extent = next - new_addr;
+
+		old_next = pmd_addr_end(old_addr, old_end);
+		new_next = pmd_addr_end(new_addr, new_end);
+		extent = min((old_next - old_addr), (new_next - new_addr));
+
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
