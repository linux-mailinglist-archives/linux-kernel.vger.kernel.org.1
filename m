Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB252C5E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 02:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392170AbgK0B4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 20:56:11 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50049 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgK0B4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 20:56:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UGdzEzw_1606442166;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGdzEzw_1606442166)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Nov 2020 09:56:07 +0800
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
To:     Vlastimil Babka <vbabka@suse.cz>,
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
 <2ba66325-e3c8-d809-a8dd-85af77c3904b@suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <166d0496-a304-5005-e14d-1963389b558b@linux.alibaba.com>
Date:   Fri, 27 Nov 2020 09:56:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2ba66325-e3c8-d809-a8dd-85af77c3904b@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/26 下午11:23, Vlastimil Babka 写道:
>>>
>>> I tried that, and .text became significantly larger, for reasons which
>>> I didn't investigate ;)
> 
> I found out that comparing whole .text doesn't often work as changes might be lost in alignment, or
> once in a while cross the alignment boundary and become exagerated. bloat-o-meter works nice though.
> 
>> Uh, BTW, with the gcc 8.3.1 and centos 7, goto or continue version has same size
>> on my side with or w/o DEBUG_LIST. But actually, this clean up patch could
>> add 10 bytes also with or w/o DEDBUG_LIST.
>>
>> Maybe related with different compiler?
> 
> gcc (SUSE Linux) 10.2.1 20201117 [revision 98ba03ffe0b9f37b4916ce6238fad754e00d720b]
> 
> ./scripts/bloat-o-meter vmscan.o.before mm/vmscan.o
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-1 (-1)
> Function                                     old     new   delta
> isolate_lru_pages                           1125    1124      -1
> Total: Before=57283, After=57282, chg -0.00%
> 
> Not surprising, as I'd expect the compiler to figure out by itself that list_move + continue
> repeats and can be unified.  The reason for goto to stay would be rather readability (subjective).

Hi Vlastimil,

Thanks for tool sharing! The gcc do give different.

My data is read from 'size' tool and isolate_lru_pages text size from 'objdump -d'. Maybe a
same way like bloat-o-meter. :)

Thanks
Alex
