Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69D2C4D70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbgKZCZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:25:04 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54227 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732673AbgKZCZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:25:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UGYyqEh_1606357500;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGYyqEh_1606357500)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 10:25:01 +0800
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
 <a355270e-5949-ebb2-30cb-a3723f6c93f8@linux.alibaba.com>
 <20201122123552.GF4327@casper.infradead.org>
 <728874d7-2d93-4049-68c1-dcc3b2d52ccd@linux.alibaba.com>
 <46ad053f-1401-31e8-50cf-09acda588f6f@suse.cz>
 <20201125154346.b2032c39cf3905bbebec3322@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ebbad64b-069a-26e0-ac0a-854649e20a97@linux.alibaba.com>
Date:   Thu, 26 Nov 2020 10:25:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201125154346.b2032c39cf3905bbebec3322@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/26 ÉÏÎç7:43, Andrew Morton Ð´µÀ:
> On Tue, 24 Nov 2020 12:21:28 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> On 11/22/20 3:00 PM, Alex Shi wrote:
>>> Thanks a lot for all comments, I picked all up and here is the v3:
>>>
>>>  From 167131dd106a96fd08af725df850e0da6ec899af Mon Sep 17 00:00:00 2001
>>> From: Alex Shi <alex.shi@linux.alibaba.com>
>>> Date: Fri, 20 Nov 2020 14:49:16 +0800
>>> Subject: [PATCH v3 next] mm/vmscan: __isolate_lru_page_prepare clean up
>>>
>>> The function just return 2 results, so use a 'switch' to deal with its
>>> result is unnecessary, and simplify it to a bool func as Vlastimil
>>> suggested.
>>>
>>> Also remove 'goto' by reusing list_move(), and take Matthew Wilcox's
>>> suggestion to update comments in function.
>>
>> I wouldn't mind if the goto stayed, but it's not repeating that much 
>> without it (list_move() + continue, 3 times) so...
> 
> I tried that, and .text became significantly larger, for reasons which
> I didn't investigate ;)
> 


Uh, BTW, with the gcc 8.3.1 and centos 7, goto or continue version has same size
on my side with or w/o DEBUG_LIST. But actually, this clean up patch could
add 10 bytes also with or w/o DEDBUG_LIST.

Maybe related with different compiler?

Thanks
Alex
