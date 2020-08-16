Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABA2457DD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgHPOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 10:11:28 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49271 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgHPOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:11:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U5ux5MB_1597587062;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5ux5MB_1597587062)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Aug 2020 22:11:03 +0800
Subject: Re: [PATCH 2/2] mm/pageblock: remove false sharing in pageblock_flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597549677-7480-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200816041720.GG17456@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <957eee62-1f46-49b6-4d5a-9671dc07c562@linux.alibaba.com>
Date:   Sun, 16 Aug 2020 22:10:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200816041720.GG17456@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2020/8/16 ����12:17, Matthew Wilcox д��:
> On Sun, Aug 16, 2020 at 11:47:57AM +0800, Alex Shi wrote:
>> Current pageblock_flags is only 4 bits, so it has to share a char size
>> in cmpxchg when get set, the false sharing cause perf drop.
>>
>> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
>> the only cost is half char per pageblock, which is half char per 128MB
>> on x86, 4 chars in 1 GB.
> 
> I don't believe this patch has that effect, mostly because it still does
> cmpxchg() on words instead of bytes.

Hi Matthew,

Thank a lot for comments!

Sorry, I must overlook sth, would you like point out why the cmpxchg is still
on words after patch 1 applied?


> 
> But which functions would benefit?  It seems to me this cmpxchg() is
> only called from the set_pageblock_migratetype() morass of functions,
> none of which are called in hot paths as far as I can make out.
> 
> So are you just reasoning by analogy with the previous patch where you
> have measured a performance improvement, or did you send the wrong patch,
> or did I overlook a hot path that calls one of the pageblock migration
> functions?
> 

Uh, I am reading compaction.c and found the following commit introduced 
test_and_set_skip under a lock. It looks like the pagelock_flags setting
has false sharing in cmpxchg. but I have no valid data on this yet.

Thanks
Alex

e380bebe4771548  mm, compaction: keep migration source private to a single compaction instance

                if (!locked) {
                        locked = compact_trylock_irqsave(zone_lru_lock(zone),
                                                                &flags, cc);
-                       if (!locked)
+
+                       /* Allow future scanning if the lock is contended */
+                       if (!locked) {
+                               clear_pageblock_skip(page);
                                break;
+                       }
+
+                       /* Try get exclusive access under lock */
+                       if (!skip_updated) {
+                               skip_updated = true;
+                               if (test_and_set_skip(cc, page, low_pfn))
+                                       goto isolate_abort;
+                       }
