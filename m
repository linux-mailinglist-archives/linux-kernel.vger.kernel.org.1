Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC62C6BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgK0TJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:09:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:48502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbgK0THG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:07:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D4F5AC0C;
        Fri, 27 Nov 2020 19:06:38 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
References: <20201112184106.733-1-georgi.djakov@linaro.org>
 <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
 <02f682e2-0e9b-76a8-04fa-487891e18bdf@suse.cz>
 <3ef3d770-d74b-5588-6672-f092c1526461@linaro.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bdf8727f-1191-34bd-d8ec-69b2a3d50c1b@suse.cz>
Date:   Fri, 27 Nov 2020 20:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <3ef3d770-d74b-5588-6672-f092c1526461@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 7:57 PM, Georgi Djakov wrote:
> Hi Vlastimil,
> 
> Thanks for the comment!
> 
> On 11/27/20 19:52, Vlastimil Babka wrote:
>> On 11/12/20 8:14 PM, Andrew Morton wrote:
>>> On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org> 
>>> wrote:
>>>
>>>> From: Liam Mark <lmark@codeaurora.org>
>>>>
>>>> Collect the time for each allocation recorded in page owner so that
>>>> allocation "surges" can be measured.
>>>>
>>>> Record the pid for each allocation recorded in page owner so that
>>>> the source of allocation "surges" can be better identified.
>>>
>>> Please provide a description of why this is considered useful.  What
>>> has it been used for, what problems has it been used to solve?
>> 
>> Worth noting that on x86_64 it doubles the size of struct page_owner
>> from 16 bytes to 32, so it better be justified:
> 
> Well, that's true. But for debug options there is almost always some penalty.
> The timestamp and pid information is very useful for me (and others, i believe)
> when doing memory analysis. On a crash for example, we can get this information
> from kdump (or RAM-dump) and look into it to catch memory allocation problems
> more easily.

Right. Btw, you should add printing the info to __dump_page_owner().

> If you find the above argument not strong enough, how about a separate config
> option for this? Maybe something like CONFIG_PAGE_OWNER_EXTENDED, which could
> be enabled in addition to CONFIG_PAGE_OWNER?

It might be strong enough if it's mentioned in changelog, and also what exactly 
the space tradeoff is :)

You can also mention that SLUB object tracking has also pid+timestamp.

> Thanks,
> Georgi
> 
>> 
>> struct page_owner {
>>          short unsigned int         order;                /*     0     2 */
>>          short int                  last_migrate_reason;  /*     2     2 */
>>          gfp_t                      gfp_mask;             /*     4     4 */
>>          depot_stack_handle_t       handle;               /*     8     4 */
>>          depot_stack_handle_t       free_handle;          /*    12     4 */
>>          u64                        ts_nsec;              /*    16     8 */
>>          int                        pid;                  /*    24     4 */
>> 
>>          /* size: 32, cachelines: 1, members: 7 */
>>          /* padding: 4 */
>>          /* last cacheline: 32 bytes */
>> };
>> 
> 

