Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A930278E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgIYQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:32:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50092 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:32:02 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id DBF9A20B7179;
        Fri, 25 Sep 2020 09:32:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBF9A20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601051521;
        bh=axHGvPGQ3Uucmw9dJfiXiWiyXRYSF8alJrmu9OrwpnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OckwlBNKRaG9cq0lrITdg3JNuRgehsftGDd9tpS2SU7+hPmZBXBRGCWV2eLZoJW88
         8OYn62ojxVtLOn6up6/D07T6Qyy4HJ0U4ftZiCkQ2wloLAaPxs1nkIvhPRqJJ9G1qG
         Dj8UCOQF3StjUHVzc5Rbp9I9gMzlDodHOgqihPCc=
Subject: Re: [v3 1/2] mm: khugepaged: recalculate min_free_kbytes after memory
 hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
 <1600305709-2319-2-git-send-email-vijayb@linux.microsoft.com>
 <20200925074215.GA3389@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <751cd286-5919-fc0a-21b4-75460934e305@linux.microsoft.com>
Date:   Fri, 25 Sep 2020 09:31:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200925074215.GA3389@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2020 12:42 AM, Michal Hocko wrote:
> On Wed 16-09-20 18:21:48, Vijay Balakrishna wrote:
>> When memory is hotplug added or removed the min_free_kbytes must be
>> recalculated based on what is expected by khugepaged.  Currently
>> after hotplug, min_free_kbytes will be set to a lower default and higher
>> default set when THP enabled is lost.  This change restores min_free_kbytes
>> as expected for THP consumers.
>>
>> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
>>
>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> I am ok with this patch. I am not sure this is worth backporting to
> stable trees becasuse this is not a functional bug. Surprising behavior,
> yes, but not much more than that.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks Michal.

> 
> One minor comment below
> [...]
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
> 
> Can we move khugepaged_min_free_kbytes_update into
> init_per_zone_wmark_min? If it stays external we might hit the same
> problem when somebody else needs to modify min_free_kbytes. Early init
> call will be likely too early for khugepaged but that shouldn't matter
> AFAICS because it will call khugepaged_min_free_kbytes_update on its
> own.

Sure, let me take a look and post v4 next week.

Thanks,
Vijay

> 
