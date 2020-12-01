Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC82C9919
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgLAIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:21:17 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51459 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbgLAIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:21:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UH7E2fz_1606810833;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UH7E2fz_1606810833)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 16:20:34 +0800
Subject: Re: [PATCH 1/3] mm/swap.c: pre-sort pages in pagevec for
 pagevec_lru_move_fn
To:     Michal Hocko <mhocko@suse.com>
Cc:     vbabka@suse.cz, Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201126155553.GT4327@casper.infradead.org>
 <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201201081031.GQ17338@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0a679cbb-bd4e-b958-f875-de8350e13c08@linux.alibaba.com>
Date:   Tue, 1 Dec 2020 16:20:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201201081031.GQ17338@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/12/1 ÏÂÎç4:10, Michal Hocko Ð´µÀ:
> On Tue 01-12-20 16:02:13, Alex Shi wrote:
>> Pages in pagevec may have different lruvec, so we have to do relock in
>> function pagevec_lru_move_fn(), but a relock may cause current cpu wait
>> for long time on the same lock for spinlock fairness reason.
>>
>> Before per memcg lru_lock, we have to bear the relock since the spinlock
>> is the only way to serialize page's memcg/lruvec. Now TestClearPageLRU
>> could be used to isolate pages exculsively, and stable the page's
>> lruvec/memcg. So it gives us a chance to sort the page's lruvec before
>> moving action in pagevec_lru_move_fn. Then we don't suffer from the
>> spinlock's fairness wait.
> Do you have any data to show any improvements from this?
> 

Hi Michal,

Thanks for quick response.

Not yet. I am running for data. but according to the lru_add result, there
should be a big gain for multiple memcgs scenario.

Also I don't except a quick accept, just send out the idea for comments 
when the thread is still warm. :)

Thanks
Alex
