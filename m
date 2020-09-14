Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C52269249
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgINQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:58:21 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60694 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgINQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:57:13 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 29AFE209F328;
        Mon, 14 Sep 2020 09:57:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29AFE209F328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600102631;
        bh=0u24k8S5lXuXUtMsnQNd52G+gBoj3GQRheubAy+FDGo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LhutyMdvUoCAjdLUtmf9ycAFMWdHR5PirBZITaskngFn8Y4k4wg1lHQedIs4tloCf
         KHVVk81gXdLpzT6uTGvsoZXFGbllf7ugTYaWv03Q3GQxBNDUsdG3dCT+DCEzWTeVkk
         856xM4hCiyVCAdPQsOECRdZ/ET2gOpOGQzIXW+mI=
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vijay Balakrishna <vijayb@linux.microsoft.com>
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
Date:   Mon, 14 Sep 2020 09:57:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914143312.GU16999@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2020 7:33 AM, Michal Hocko wrote:
> On Thu 10-09-20 13:47:39, Vijay Balakrishna wrote:
>> When memory is hotplug added or removed the min_free_kbytes must be
>> recalculated based on what is expected by khugepaged.  Currently
>> after hotplug, min_free_kbytes will be set to a lower default and higher
>> default set when THP enabled is lost. This leaves the system with small
>> min_free_kbytes which isn't suitable for systems especially with network
>> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
>> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
>> kills.
> 
> Care to explain some more please? The whole point of increasing
> min_free_kbytes for THP is to get a larger free memory with a hope that
> huge pages will be more likely to appear. While this might help for
> other users that need a high order pages it is definitely not the
> primary reason behind it. Could you provide an example with some more
> data?

Thanks Michal.  I haven't looked into THP as part of my investigation, 
so I cannot comment.

In our use case we are hotplug removing ~2GB of 8GB total (on our SoC) 
during normal reboot/shutdown.  This memory is hotplug hot-added as 
movable type via systemd late service during start-of-day.

In our stress test first we ran into HW WATCHDOG recovery, on enabling 
kernel watchdog we started seeing soft lockup hung task notices, failure 
symptons varied, where stack trace of hung tasks sometimes trying to 
allocate GFP_ATOMIC memory, looping in do_notify_resume, NETDEVICE 
WATCHDOG timeouts, OOM process kills etc.,  During investigation we 
reran stress test without hotplug use case.  Surprisingly this run 
didn't encounter the said problems.  This led to comparing what is 
different between the two runs, while looking at various globals, 
studying hotplug code I uncovered the issue of failing to restore 
min_free_kbytes.  In particular on our 8GB SoC min_free_kbytes went down 
to 8703 from 22528 after hotplug add.

I'm going send a new patch to fix the issue Kirill A. Shutemov raised:
NAK. It would override min_free_kbytes set by user.

Vijay


> 
> I do see how the inconsistency between boot and hotplug watermarks
> setting is not ideal but I do worry about interaction with the user
> specific values as a potential problem. set_recommended_min_free_kbytes
> happens early enough that user space cannot really interfere but the
> hotplug happens at any time.
>   
>> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
>>
>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   include/linux/khugepaged.h |  5 +++++
>>   mm/khugepaged.c            | 13 +++++++++++--
>>   mm/memory_hotplug.c        |  3 +++
>>   3 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
>> index bc45ea1efbf7..c941b7377321 100644
>> --- a/include/linux/khugepaged.h
>> +++ b/include/linux/khugepaged.h
>> @@ -15,6 +15,7 @@ extern int __khugepaged_enter(struct mm_struct *mm);
>>   extern void __khugepaged_exit(struct mm_struct *mm);
>>   extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>>   				      unsigned long vm_flags);
>> +extern void khugepaged_min_free_kbytes_update(void);
>>   #ifdef CONFIG_SHMEM
>>   extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
>>   #else
>> @@ -85,6 +86,10 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
>>   					   unsigned long addr)
>>   {
>>   }
>> +
>> +static inline void khugepaged_min_free_kbytes_update(void)
>> +{
>> +}
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   
>>   #endif /* _LINUX_KHUGEPAGED_H */
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index cfa0dba5fd3b..4f7107476a6f 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -56,6 +56,9 @@ enum scan_result {
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/huge_memory.h>
>>   
>> +static struct task_struct *khugepaged_thread __read_mostly;
>> +static DEFINE_MUTEX(khugepaged_mutex);
>> +
>>   /* default scan 8*512 pte (or vmas) every 30 second */
>>   static unsigned int khugepaged_pages_to_scan __read_mostly;
>>   static unsigned int khugepaged_pages_collapsed;
>> @@ -2292,8 +2295,6 @@ static void set_recommended_min_free_kbytes(void)
>>   
>>   int start_stop_khugepaged(void)
>>   {
>> -	static struct task_struct *khugepaged_thread __read_mostly;
>> -	static DEFINE_MUTEX(khugepaged_mutex);
>>   	int err = 0;
>>   
>>   	mutex_lock(&khugepaged_mutex);
>> @@ -2320,3 +2321,11 @@ int start_stop_khugepaged(void)
>>   	mutex_unlock(&khugepaged_mutex);
>>   	return err;
>>   }
>> +
>> +void khugepaged_min_free_kbytes_update(void)
>> +{
>> +	mutex_lock(&khugepaged_mutex);
>> +	if (khugepaged_enabled() && khugepaged_thread)
>> +		set_recommended_min_free_kbytes();
>> +	mutex_unlock(&khugepaged_mutex);
>> +}
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index e9d5ab5d3ca0..3e19272c1fad 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/compaction.h>
>>   #include <linux/rmap.h>
>> +#include <linux/khugepaged.h>
>>   
>>   #include <asm/tlbflush.h>
>>   
>> @@ -857,6 +858,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>>   	zone_pcp_update(zone);
>>   
>>   	init_per_zone_wmark_min();
>> +	khugepaged_min_free_kbytes_update();
>>   
>>   	kswapd_run(nid);
>>   	kcompactd_run(nid);
>> @@ -1600,6 +1602,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
>>   	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>>   
>>   	init_per_zone_wmark_min();
>> +	khugepaged_min_free_kbytes_update();
>>   
>>   	if (!populated_zone(zone)) {
>>   		zone_pcp_reset(zone);
>> -- 
>> 2.28.0
>>
> 
