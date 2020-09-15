Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3126ADA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgIOTdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:33:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgIOTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:32:29 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id DE8AE20A0867;
        Tue, 15 Sep 2020 12:31:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE8AE20A0867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600198317;
        bh=vEx4iggKRYKKd1K2MkTTPBcXxVR8S1YXGdK8CJ04Tek=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n1Hhv5oMQqsAKpWmedVfh4jymNsNnG9jc1Eq0s+x2wQZjEq5tFRadOx9kAjKYH03J
         VuD3VSwBcTphepRh/D53Ml+xHzOQ5QX2Ek2MEp4OI8GQ6cEBloASqrypyjaSEBaVbI
         wf3kaxNibfKPKmfuc5GDvwxIWfEYJfrsdBFAuGCk=
Subject: Re: [v1] mm: khugepaged: avoid overriding min_free_kbytes set by user
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <1600145748-26518-1-git-send-email-vijayb@linux.microsoft.com>
 <CA+CK2bDH-BGAWhCYLpsxwhS1+eHibqmjLiXAhyr0i94YJspYuA@mail.gmail.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <db07095f-45d1-8e20-ccc7-0607e57ad91d@linux.microsoft.com>
Date:   Tue, 15 Sep 2020 12:31:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bDH-BGAWhCYLpsxwhS1+eHibqmjLiXAhyr0i94YJspYuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2020 11:27 AM, Pavel Tatashin wrote:
> On Tue, Sep 15, 2020 at 12:55 AM Vijay Balakrishna
> <vijayb@linux.microsoft.com> wrote:
>>
>> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
>> user.  Post start-of-day THP enable or memory hotplug operations can
>> lose user specified min_free_kbytes, in particular when it is higher than
>> calculated recommended value.
>>
>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Cc: stable@vger.kernel.org
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
>>          struct zone *zone;
>>          int nr_zones = 0;
>> -       unsigned long recommended_min;
>> +       int recommended_min;
> 
> Hi Vijay,
> 
> Please explain in log the type change. user_min_free_kbytes is  of
> "int" type and is initialized to -1, so comparing to unsigned leads to
> undesired effect.

Hi Pasha,

I will update log.  I uncovered it when trying to understand why 
one-line change to address issue raised by Kirill didn't work!

> 
> 
>>
>>          for_each_populated_zone(zone) {
>>                  /*
>> @@ -2280,12 +2280,12 @@ static void set_recommended_min_free_kbytes(void)
>>
>>          /* don't ever allow to reserve more than 5% of the lowmem */
>>          recommended_min = min(recommended_min,
>> -                             (unsigned long) nr_free_buffer_pages() / 20);
>> +                             (int) nr_free_buffer_pages() / 20);
>>          recommended_min <<= (PAGE_SHIFT-10);
>>
>> -       if (recommended_min > min_free_kbytes) {
>> +       if (recommended_min > user_min_free_kbytes) {
> 
> Took me a while to understand, but this change is correct. It is the
> same logic that is done in init_per_zone_wmark_min().
> 
> Please join the two patches you have in one patch series.
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Will do.

Thanks,
Vijay
> 
> Thank you,
> Pasha
> 
