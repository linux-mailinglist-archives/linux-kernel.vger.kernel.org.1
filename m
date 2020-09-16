Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5326CA07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgIPTmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:42:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44226 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgIPTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:01 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id C347C20B7178;
        Wed, 16 Sep 2020 12:18:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C347C20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600283894;
        bh=16V0MyC5Nylnc0p/3+ujIlxV7WalEW8tyaMt/ccOWNo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TE04mFt30GIcedYweK0xVeKcVTITE8HaMpVCve7+Ex48Fmg1lTkWRqdr9ZP1WW95b
         NPbyr4eMoMFrCQYgQ02NSFOvT647nlsRG2FsC7bvYXyNi/rUszJUyJnLP9rJPSs5XH
         8GTVnWVenWAWJ1bjOTfn7/REIOhf9OGF3je5CYXw=
Subject: Re: [v2 2/2] mm: khugepaged: avoid overriding min_free_kbytes set by
 user
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1600204258-13683-1-git-send-email-vijayb@linux.microsoft.com>
 <1600204258-13683-2-git-send-email-vijayb@linux.microsoft.com>
 <20200916075900.GE18998@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <7f4816ce-cdb0-b549-c94b-66328b65a85d@linux.microsoft.com>
Date:   Wed, 16 Sep 2020 12:18:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200916075900.GE18998@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2020 12:59 AM, Michal Hocko wrote:
> On Tue 15-09-20 14:10:58, Vijay Balakrishna wrote:
>> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
>> user.  Post start-of-day THP enable or memory hotplug operations can
>> lose user specified min_free_kbytes, in particular when it is higher than
>> calculated recommended value.  Also modifying "recommended_min" variable
>> type to "int" from "unsigned long" to avoid undesired result noticed
>> during testing.  It is due to comparing "unsigned long" with "int" type.
>>
>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>> ---
>>   mm/khugepaged.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 4f7107476a6f..b4b753ba411a 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2253,7 +2253,7 @@ static void set_recommended_min_free_kbytes(void)
>>   {
>>   	struct zone *zone;
>>   	int nr_zones = 0;
>> -	unsigned long recommended_min;
>> +	int recommended_min;
>>   
>>   	for_each_populated_zone(zone) {
>>   		/*
>> @@ -2280,12 +2280,12 @@ static void set_recommended_min_free_kbytes(void)
>>   
>>   	/* don't ever allow to reserve more than 5% of the lowmem */
>>   	recommended_min = min(recommended_min,
>> -			      (unsigned long) nr_free_buffer_pages() / 20);
>> +			      (int) nr_free_buffer_pages() / 20);
> 
> nr_free_buffer_pages can oveflow in int on very large machines.

Good point.  I will address it.

> 
>>   	recommended_min <<= (PAGE_SHIFT-10);
>>   
>> -	if (recommended_min > min_free_kbytes) {
>> +	if (recommended_min > user_min_free_kbytes) {
> 
> This can decrease the size theoretically. Because user_min_free_kbytes
> is -1 by default and recommended_min might be <= min_free_kbytes.
> 
> You need to check both. Also can we make user_min_free_kbytes 0 by
> default? From a quick look, nobody should really care.

Let me rework.

Thanks,
Vijay

> 
>>   		if (user_min_free_kbytes >= 0)
>> -			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>> +			pr_info("raising min_free_kbytes from %d to %d to help transparent hugepage allocations\n",
>>   				min_free_kbytes, recommended_min);
>>   
>>   		min_free_kbytes = recommended_min;
>> -- 
>> 2.28.0
>>
> 
