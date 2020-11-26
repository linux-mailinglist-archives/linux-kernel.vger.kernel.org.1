Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D355F2C580B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391320AbgKZPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:23:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:52066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389920AbgKZPXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:23:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46064ACC4;
        Thu, 26 Nov 2020 15:23:45 +0000 (UTC)
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
 <ebbad64b-069a-26e0-ac0a-854649e20a97@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
Message-ID: <2ba66325-e3c8-d809-a8dd-85af77c3904b@suse.cz>
Date:   Thu, 26 Nov 2020 16:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ebbad64b-069a-26e0-ac0a-854649e20a97@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 3:25 AM, Alex Shi wrote:
> 
> 
> ÔÚ 2020/11/26 ÉÏÎç7:43, Andrew Morton Ð´µÀ:
>> On Tue, 24 Nov 2020 12:21:28 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
>> 
>>> On 11/22/20 3:00 PM, Alex Shi wrote:
>>>> Thanks a lot for all comments, I picked all up and here is the v3:
>>>>
>>>>  From 167131dd106a96fd08af725df850e0da6ec899af Mon Sep 17 00:00:00 2001
>>>> From: Alex Shi <alex.shi@linux.alibaba.com>
>>>> Date: Fri, 20 Nov 2020 14:49:16 +0800
>>>> Subject: [PATCH v3 next] mm/vmscan: __isolate_lru_page_prepare clean up
>>>>
>>>> The function just return 2 results, so use a 'switch' to deal with its
>>>> result is unnecessary, and simplify it to a bool func as Vlastimil
>>>> suggested.
>>>>
>>>> Also remove 'goto' by reusing list_move(), and take Matthew Wilcox's
>>>> suggestion to update comments in function.
>>>
>>> I wouldn't mind if the goto stayed, but it's not repeating that much 
>>> without it (list_move() + continue, 3 times) so...
>> 
>> I tried that, and .text became significantly larger, for reasons which
>> I didn't investigate ;)

I found out that comparing whole .text doesn't often work as changes might be lost in alignment, or
once in a while cross the alignment boundary and become exagerated. bloat-o-meter works nice though.

> Uh, BTW, with the gcc 8.3.1 and centos 7, goto or continue version has same size
> on my side with or w/o DEBUG_LIST. But actually, this clean up patch could
> add 10 bytes also with or w/o DEDBUG_LIST.
> 
> Maybe related with different compiler?

gcc (SUSE Linux) 10.2.1 20201117 [revision 98ba03ffe0b9f37b4916ce6238fad754e00d720b]

./scripts/bloat-o-meter vmscan.o.before mm/vmscan.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-1 (-1)
Function                                     old     new   delta
isolate_lru_pages                           1125    1124      -1
Total: Before=57283, After=57282, chg -0.00%

Not surprising, as I'd expect the compiler to figure out by itself that list_move + continue
repeats and can be unified.  The reason for goto to stay would be rather readability (subjective).

> Thanks
> Alex
> 

