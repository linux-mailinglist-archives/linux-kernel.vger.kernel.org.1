Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECBD29176B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 14:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgJRMlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 08:41:08 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58668 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJRMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 08:41:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCMqU.1_1603024864;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCMqU.1_1603024864)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Oct 2020 20:41:05 +0800
Date:   Sun, 18 Oct 2020 20:41:04 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 20/29] virtio-mem: nb_sb_per_mb and subblock_size are
 specific to Sub Block Mode (SBM)
Message-ID: <20201018124104.GD50506@L-31X9LVDL-1304>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-21-david@redhat.com>
 <20201016085319.GD44269@L-31X9LVDL-1304.local>
 <7b55ffe1-95fc-1e71-ea6b-82bd0a98a6b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b55ffe1-95fc-1e71-ea6b-82bd0a98a6b4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:17:06PM +0200, David Hildenbrand wrote:
>On 16.10.20 10:53, Wei Yang wrote:
>> On Mon, Oct 12, 2020 at 02:53:14PM +0200, David Hildenbrand wrote:
>>> Let's rename to "sbs_per_mb" and "sb_size" and move accordingly.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> 
>> One trivial suggestion, could we move this patch close the data structure
>> movement patch?
>> 
>> I know this would be some work, since you have changed some of the code logic.
>> This would take you some time to rebase.
>
>You mean after patch #17 ?

Yes

>
>I guess I can move patch #18 (prereq) a little further up (e.g., after
>patch #15). Guess moving it in front of #19 shouldn't be too hard.
>
>Will give it a try - if it takes too much effort, I'll leave it like this.
>

Not a big deal, while it will make the change more intact to me.

This is a big patch set to me. In case it could be split into two parts, like
bug fix/logic improvement and BBM implementation, that would be more friendly
to review.

>Thanks!
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
