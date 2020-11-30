Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F982C83D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgK3MEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:04:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgK3MEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:04:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07553AE8C;
        Mon, 30 Nov 2020 12:04:06 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
References: <20201112184106.733-1-georgi.djakov@linaro.org>
 <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
 <02f682e2-0e9b-76a8-04fa-487891e18bdf@suse.cz>
 <3ef3d770-d74b-5588-6672-f092c1526461@linaro.org>
 <bdf8727f-1191-34bd-d8ec-69b2a3d50c1b@suse.cz>
 <CAFqt6zaZ8NCUUMpXA_-r2D-c_J99yrhjfRrpPFYhcebASeHebw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <43993267-7644-3553-8d1f-53f2f39909a6@suse.cz>
Date:   Mon, 30 Nov 2020 13:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaZ8NCUUMpXA_-r2D-c_J99yrhjfRrpPFYhcebASeHebw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 8:23 PM, Souptick Joarder wrote:
> On Sat, Nov 28, 2020 at 12:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/27/20 7:57 PM, Georgi Djakov wrote:
>> > Hi Vlastimil,
>> >
>> > Thanks for the comment!
>> >
>> > On 11/27/20 19:52, Vlastimil Babka wrote:
>> >> On 11/12/20 8:14 PM, Andrew Morton wrote:
>> >>> On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org>
>> >>> wrote:
>> >>>
>> >>>> From: Liam Mark <lmark@codeaurora.org>
>> >>>>
>> >>>> Collect the time for each allocation recorded in page owner so that
>> >>>> allocation "surges" can be measured.
>> >>>>
>> >>>> Record the pid for each allocation recorded in page owner so that
>> >>>> the source of allocation "surges" can be better identified.
>> >>>
>> >>> Please provide a description of why this is considered useful.  What
>> >>> has it been used for, what problems has it been used to solve?
>> >>
>> >> Worth noting that on x86_64 it doubles the size of struct page_owner
>> >> from 16 bytes to 32, so it better be justified:
>> >
>> > Well, that's true. But for debug options there is almost always some penalty.
>> > The timestamp and pid information is very useful for me (and others, i believe)
>> > when doing memory analysis. On a crash for example, we can get this information
>> > from kdump (or RAM-dump) and look into it to catch memory allocation problems
>> > more easily.
>>
>> Right. Btw, you should add printing the info to __dump_page_owner().
>>
>> > If you find the above argument not strong enough, how about a separate config
>> > option for this? Maybe something like CONFIG_PAGE_OWNER_EXTENDED, which could
>> > be enabled in addition to CONFIG_PAGE_OWNER?
>>
>> It might be strong enough if it's mentioned in changelog, and also what exactly
>> the space tradeoff is :)
> 
> Just a thought ... putting it inside CONFIG_PAGE_OWNER_DEBUG might be
> better if it is used
> purely for debugging purposes.

I don't think we need to introduce new config just yet, until someone makes the 
case for it. Even then, it could be instead doable as an extension to 
"page_owner=on" boot option.
I mean let's add those fields, but improve the changelog.

>>
>> You can also mention that SLUB object tracking has also pid+timestamp.
>>
>> > Thanks,
>> > Georgi
>> >
>> >>
>> >> struct page_owner {
>> >>          short unsigned int         order;                /*     0     2 */
>> >>          short int                  last_migrate_reason;  /*     2     2 */
>> >>          gfp_t                      gfp_mask;             /*     4     4 */
>> >>          depot_stack_handle_t       handle;               /*     8     4 */
>> >>          depot_stack_handle_t       free_handle;          /*    12     4 */
>> >>          u64                        ts_nsec;              /*    16     8 */
>> >>          int                        pid;                  /*    24     4 */
>> >>
>> >>          /* size: 32, cachelines: 1, members: 7 */
>> >>          /* padding: 4 */
>> >>          /* last cacheline: 32 bytes */
>> >> };
>> >>
>> >
>>
>>
> 

