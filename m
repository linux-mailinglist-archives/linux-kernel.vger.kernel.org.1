Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8272B28EFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgJOKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:00:22 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:62700 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgJOKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:00:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UC62.Wb_1602756009;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UC62.Wb_1602756009)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 18:00:09 +0800
Date:   Thu, 15 Oct 2020 18:00:09 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 02/29] virtio-mem: simplify calculation in
 virtio_mem_mb_state_prepare_next_mb()
Message-ID: <20201015100009.GH86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-3-david@redhat.com>
 <20201015040204.GB86495@L-31X9LVDL-1304.local>
 <730d6536-f6a6-72e5-327f-00ce1224b730@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <730d6536-f6a6-72e5-327f-00ce1224b730@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:00:15AM +0200, David Hildenbrand wrote:
>On 15.10.20 06:02, Wei Yang wrote:
>> On Mon, Oct 12, 2020 at 02:52:56PM +0200, David Hildenbrand wrote:
>>> We actually need one byte less (next_mb_id is exclusive, first_mb_id is
>>> inclusive). Simplify.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>> drivers/virtio/virtio_mem.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>>> index a1f5bf7a571a..670b3faf412d 100644
>>> --- a/drivers/virtio/virtio_mem.c
>>> +++ b/drivers/virtio/virtio_mem.c
>>> @@ -257,8 +257,8 @@ static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
>>>  */
>>> static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
>>> {
>>> -	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id + 1;
>>> -	unsigned long new_bytes = vm->next_mb_id - vm->first_mb_id + 2;
>>> +	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
>>> +	unsigned long new_bytes = old_bytes + 1;
>> 
>> This is correct.
>> 
>> So this looks more like a fix?
>
>We allocate an additional new page "one memory block too early".
>
>So we would allocate the first page for blocks 0..510, and already
>allocate the second page with block 511, although we could have fit it
>into the first page. Block 512 will then find that the second page is
>already there and simply use the second page.
>
>So as we do it consistently, nothing will go wrong - that's why I
>avoided using the "fix" terminology.
>

Yes, my feeling is this is not a simplification. Instead this is a more
precise calculation.

How about use this subject?

virtio-mem: more precise calculation in virtio_mem_mb_state_prepare_next_mb()

>Thanks!
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
