Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCACF273275
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgIUTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:07:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52410 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgIUTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:07:25 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 056FB20B7179;
        Mon, 21 Sep 2020 12:07:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 056FB20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600715244;
        bh=xFQyWZ09JYTz1ea8EvmYsjd9gkpv8PinmSTBjsmoFsU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NLm6cj99WAXyA5dNxCeKJSK4CUlX6HEGfBxod83mGICxcHqbylk7abpAxQ60kb50/
         FsA1RqKicfvg4Hheun7VAdiNx7TJzVhErLZfkYH9R0xcnqRZvIitmB7gyBD8+iHl30
         DiKWpyG2STH2fEzdl+tXhJCdWSchHv1H34DRO84c=
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
 <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
 <20200917175217.GD29887@dhcp22.suse.cz>
 <f2231b44-6d14-fb63-43cd-43aaad02bef1@linux.microsoft.com>
 <20200918055637.GB28827@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <e4eb32bb-f905-d15b-8596-13bf387b9f57@linux.microsoft.com>
Date:   Mon, 21 Sep 2020 12:07:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200918055637.GB28827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 10:56 PM, Michal Hocko wrote:
> On Thu 17-09-20 11:16:55, Vijay Balakrishna wrote:
>>
>>
>> On 9/17/2020 10:52 AM, Michal Hocko wrote:
>>> On Thu 17-09-20 10:27:16, Vijay Balakrishna wrote:
>>>>
>>>>
>>>> On 9/17/2020 2:28 AM, Michal Hocko wrote:
>>>>> On Wed 16-09-20 23:39:39, Vijay Balakrishna wrote:
>>>>>> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
>>>>>> user.  Post start-of-day THP enable or memory hotplug operations can
>>>>>> lose user specified min_free_kbytes, in particular when it is higher than
>>>>>> calculated recommended value.
>>>>>
>>>>> I was about to recommend a more detailed explanation when I have
>>>>> realized that this patch is not really needed after all. Unless I am
>>>>> missing something.
>>>>>
>>>>> init_per_zone_wmark_min ignores the newly calculated min_free_kbytes if
>>>>> it is lower than user_min_free_kbytes. So calculated min_free_kbytes >=
>>>>> user_min_free_kbytes.
>>>>>
>>>>> Except for value clamping when the value is reduced and this likely
>>>>> needs fixing. But set_recommended_min_free_kbytes should be fine.
>>>>>
>>>>
>>>> IIUC, after start-of-day if a user performs
>>>> - THP disable
>>>> - modifies min_free_bytes
>>>> - THP enable
>>>> above sequence currently wouldn't result in calling init_per_zone_wmark_min.
>>>
>>> I will not, but why do you think this matters? All we should care about
>>> is that auto-tuning shouldn't reduce user provided value [1] and that
>>> the memory hotplug should be consistent with the boot time heuristic.
>>> init_per_zone_wmark_min should make sure that the user value is not
>>> reduced and thp heuristic makes sure it will not reduce this value.
>>> So the property should be transitive with the existing code (modulo the
>>> problem I have highlighted).
>>>
>>> [1] one could argue that it shouldn't even increase the value strictly
>>> speaking because an admin might have a very good reason to decrease the
>>> value but this has never been the semantic and changing it now might be
>>> problematic
>>>
>>
>> I made an attempt to address Kirill A. Shutemov's comment.
> 
> This is for Kirill to comment on but my take would be that memory
> hotplug really has to alter the user defined min_free_kbytes because it
> is manipulating the amount of memory. There are usecases which are
> adding a lot of memory.
> 
> We are trying to not decrease the value which is arguably a weird semantic
> but this is what've been doing for years. We would need to hear a
> specific usecase where this matters (e.g. memory hotremove heavy
> workalod with manually tuned min_free_kbytes) that misbehaves.

In our use case memory hotremove done normally during shutdown and we 
aren't manually tuning min_free_kbytes.

> 
>> And incrased
>> min_free_kbytes to see the issue in my testing and attempted a fix.  I'm ok
>> leaving as it is.  Do not want introduce any changes that may cause
>> regression.
> 
> I would recommend reposting the patch which adds heuristic for THP (if
> THP is enabled) into the hotplug path, arguing with the consistency and
> surprising results when adding memory decreases the value.

I hope my reposted patch
([v3 1/2] mm: khugepaged: recalculate min_free_kbytes after memory 
hotplug as expected by khugepaged)
change log is ok:

When memory is hotplug added or removed the min_free_kbytes must be
recalculated based on what is expected by khugepaged.  Currently
after hotplug, min_free_kbytes will be set to a lower default and higher
default set when THP enabled is lost.  This change restores 
min_free_kbytes as expected for THP consumers.


> Your initial
> problem is in sizing as mentioned in other email thread and you should
> be investigating more but this inconsistency might really come as a
> surprise.
> 
> All that if Kirill is reconsidering his initial position of course.
> 

Kirill, can you comment or share your opinion?

Thanks,
Vijay
