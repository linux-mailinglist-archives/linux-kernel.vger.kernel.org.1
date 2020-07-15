Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B799A220307
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgGODqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:46:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42584 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728578AbgGODqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:46:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U2lkO7H_1594784760;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2lkO7H_1594784760)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Jul 2020 11:46:00 +0800
Date:   Wed, 15 Jul 2020 11:46:00 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: hide nr_nodes in the internal of
 for_each_node_mask_to_[alloc|free]
Message-ID: <20200715034600.GA88314@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
 <cd1651a0-35c6-7535-5782-ce7e31cc26e8@suse.cz>
 <807a1e32-926b-2882-740b-6484b8dca2b6@suse.cz>
 <20200714095713.GA86690@L-31X9LVDL-1304.local>
 <e0d384a7-34bc-43ce-dc20-db4808b0f736@suse.cz>
 <694bb1ac-4f9c-a6a5-7c87-1fc0cdd948a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694bb1ac-4f9c-a6a5-7c87-1fc0cdd948a6@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:12:03PM -0700, Mike Kravetz wrote:
>On 7/14/20 3:02 AM, Vlastimil Babka wrote:
>> On 7/14/20 11:57 AM, Wei Yang wrote:
>>> On Tue, Jul 14, 2020 at 11:22:03AM +0200, Vlastimil Babka wrote:
>>>> On 7/14/20 11:13 AM, Vlastimil Babka wrote:
>>>>> On 7/14/20 9:34 AM, Wei Yang wrote:
>>>>>> The second parameter of for_each_node_mask_to_[alloc|free] is a loop
>>>>>> variant, which is not used outside of loop iteration.
>>>>>>
>>>>>> Let's hide this.
>>>>>>
>>>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>>> ---
>>>>>>  mm/hugetlb.c | 38 ++++++++++++++++++++------------------
>>>>>>  1 file changed, 20 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>>> index 57ece74e3aae..9c3d15fb317e 100644
>>>>>> --- a/mm/hugetlb.c
>>>>>> +++ b/mm/hugetlb.c
>>>>>> @@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>>>>>  	return nid;
>>>>>>  }
>>>>>>  
>>>>>> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
>>>>>> -	for (nr_nodes = nodes_weight(*mask);				\
>>>>>> -		nr_nodes > 0 &&						\
>>>>>> +#define for_each_node_mask_to_alloc(hs, node, mask)			\
>>>>>> +	int __nr_nodes;							\
>>>>>> +	for (__nr_nodes = nodes_weight(*mask);				\
>>>>>
>>>>> The problem with this is that if I use the macro twice in the same block, this
>>>>> will redefine __nr_nodes and fail to compile, no?
>>>>> In that case it's better to avoid setting up this trap, IMHO.
>>>>
>>>> Ah, and it will also generate the following warning, if the use of for_each*
>>>> macro is not the first thing after variable declarations, but there's another
>>>> statement before:
>>>>
>>>> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>>>>
>>>> Instead we should switch to C99 and declare it as "for (int __nr_nodes" :P
>>>
>>> Hmm... I tried what you suggested, but compiler complains.
>>>
>>> 'for' loop initial declarations are only allowed in C99 or C11 mode
>> 
>> Yes, by "we should switch to C99" I meant that the kernel kbuild system would
>> need to switch. Not a trivial change...
>> Without that, I don't see how your patch is possible to do safely.
>
>Vlastimil, thanks for pointing out future potential issues with this patch.
>I likely would have missed that.
>
>Wei, thanks for taking the time to put together the patch.  However, I tend
>to agree with Vlastimil's assesment.  The cleanup is not worth the risk of
>running into issues if someone uses multiple instances of the macro.

Yep, thanks all for your feedback.

>-- 
>Mike Kravetz

-- 
Wei Yang
Help you, Help me
