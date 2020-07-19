Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678D7224EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 05:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGSDz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 23:55:56 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47538 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbgGSDzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 23:55:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U36kxME_1595130948;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U36kxME_1595130948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Jul 2020 11:55:49 +0800
Subject: Re: [PATCH v16 16/22] mm/mlock: reorder isolation sequence during
 munlock
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-17-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0Udcry01samXT54RkurNqFKnVmv-686ZFHF+iw4b+12T_A@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6e37ee32-c6c5-fcc5-3cad-74f7ae41fb67@linux.alibaba.com>
Date:   Sun, 19 Jul 2020 11:55:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Udcry01samXT54RkurNqFKnVmv-686ZFHF+iw4b+12T_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/18 上午4:30, Alexander Duyck 写道:
> On Fri, Jul 10, 2020 at 5:59 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> This patch reorder the isolation steps during munlock, move the lru lock
>> to guard each pages, unfold __munlock_isolate_lru_page func, to do the
>> preparation for lru lock change.
>>
>> __split_huge_page_refcount doesn't exist, but we still have to guard
>> PageMlocked and PageLRU for tail page in __split_huge_page_tail.
>>
>> [lkp@intel.com: found a sleeping function bug ... at mm/rmap.c]
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/mlock.c | 93 ++++++++++++++++++++++++++++++++++----------------------------
>>  1 file changed, 51 insertions(+), 42 deletions(-)
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 228ba5a8e0a5..0bdde88b4438 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -103,25 +103,6 @@ void mlock_vma_page(struct page *page)
>>  }
>>
>>  /*
>> - * Isolate a page from LRU with optional get_page() pin.
>> - * Assumes lru_lock already held and page already pinned.
>> - */
>> -static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
>> -{
>> -       if (TestClearPageLRU(page)) {
>> -               struct lruvec *lruvec;
>> -
>> -               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>> -               if (getpage)
>> -                       get_page(page);
>> -               del_page_from_lru_list(page, lruvec, page_lru(page));
>> -               return true;
>> -       }
>> -
>> -       return false;
>> -}
>> -
>> -/*
>>   * Finish munlock after successful page isolation
>>   *
>>   * Page must be locked. This is a wrapper for try_to_munlock()
>> @@ -181,6 +162,7 @@ static void __munlock_isolation_failed(struct page *page)
>>  unsigned int munlock_vma_page(struct page *page)
>>  {
>>         int nr_pages;
>> +       bool clearlru = false;
>>         pg_data_t *pgdat = page_pgdat(page);
>>
>>         /* For try_to_munlock() and to serialize with page migration */
>> @@ -189,32 +171,42 @@ unsigned int munlock_vma_page(struct page *page)
>>         VM_BUG_ON_PAGE(PageTail(page), page);
>>
>>         /*
>> -        * Serialize with any parallel __split_huge_page_refcount() which
>> +        * Serialize split tail pages in __split_huge_page_tail() which
>>          * might otherwise copy PageMlocked to part of the tail pages before
>>          * we clear it in the head page. It also stabilizes hpage_nr_pages().
>>          */
>> +       get_page(page);
> 
> I don't think this get_page() call needs to be up here. It could be
> left down before we delete the page from the LRU list as it is really
> needed to take a reference on the page before we call
> __munlock_isolated_page(), or at least that is the way it looks to me.
> By doing that you can avoid a bunch of cleanup in these exception
> cases.

Uh, It seems unlikely for !page->_refcount, and then got to release_pages(),
if so, get_page do could move down.
Thanks

> 
>> +       clearlru = TestClearPageLRU(page);
> 
> I'm not sure I fully understand the reason for moving this here. By
> clearing this flag before you clear Mlocked does this give you some
> sort of extra protection? I don't see how since Mlocked doesn't
> necessarily imply the page is on LRU.
> 

Above comments give a reason for the lru_lock usage,
>> +        * Serialize split tail pages in __split_huge_page_tail() which
>>          * might otherwise copy PageMlocked to part of the tail pages before
>>          * we clear it in the head page. It also stabilizes hpage_nr_pages().

Look into the __split_huge_page_tail, there is a tiny gap between tail page
get PG_mlocked, and it is added into lru list.
The TestClearPageLRU could blocked memcg changes of the page from stopping
isolate_lru_page.


>>         spin_lock_irq(&pgdat->lru_lock);
>>
>>         if (!TestClearPageMlocked(page)) {
>> -               /* Potentially, PTE-mapped THP: do not skip the rest PTEs */
>> -               nr_pages = 1;
>> -               goto unlock_out;
>> +               if (clearlru)
>> +                       SetPageLRU(page);
>> +               /*
>> +                * Potentially, PTE-mapped THP: do not skip the rest PTEs
>> +                * Reuse lock as memory barrier for release_pages racing.
>> +                */
>> +               spin_unlock_irq(&pgdat->lru_lock);
>> +               put_page(page);
>> +               return 0;
>>         }
>>
>>         nr_pages = hpage_nr_pages(page);
>>         __mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>>
>> -       if (__munlock_isolate_lru_page(page, true)) {
>> +       if (clearlru) {
>> +               struct lruvec *lruvec;
>> +
> 
> You could just place the get_page() call here.
> 
>> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>> +               del_page_from_lru_list(page, lruvec, page_lru(page));
>>                 spin_unlock_irq(&pgdat->lru_lock);
>>                 __munlock_isolated_page(page);
>> -               goto out;
>> +       } else {
>> +               spin_unlock_irq(&pgdat->lru_lock);
>> +               put_page(page);
>> +               __munlock_isolation_failed(page);
> 
> If you move the get_page() as I suggested above there wouldn't be a
> need for the put_page(). It then becomes possible to simplify the code
> a bit by merging the unlock paths and doing an if/else with the
> __munlock functions like so:
> if (clearlru) {
>     ...
>     del_page_from_lru..
> }
> 
> spin_unlock_irq()
> 
> if (clearlru)
>     __munlock_isolated_page();
> else
>     __munlock_isolated_failed();
> 
>>         }
>> -       __munlock_isolation_failed(page);
>> -
>> -unlock_out:
>> -       spin_unlock_irq(&pgdat->lru_lock);
>>
>> -out:
>>         return nr_pages - 1;
>>  }
>>
>> @@ -297,34 +289,51 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>>         pagevec_init(&pvec_putback);
>>
>>         /* Phase 1: page isolation */
>> -       spin_lock_irq(&zone->zone_pgdat->lru_lock);
>>         for (i = 0; i < nr; i++) {
>>                 struct page *page = pvec->pages[i];
>> +               struct lruvec *lruvec;
>> +               bool clearlru;
>>
>> -               if (TestClearPageMlocked(page)) {
>> -                       /*
>> -                        * We already have pin from follow_page_mask()
>> -                        * so we can spare the get_page() here.
>> -                        */
>> -                       if (__munlock_isolate_lru_page(page, false))
>> -                               continue;
>> -                       else
>> -                               __munlock_isolation_failed(page);
>> -               } else {
>> +               clearlru = TestClearPageLRU(page);
>> +               spin_lock_irq(&zone->zone_pgdat->lru_lock);
> 
> I still don't see what you are gaining by moving the bit test up to
> this point. Seems like it would be better left below with the lock
> just being used to prevent a possible race while you are pulling the
> page out of the LRU list.
> 

the same reason as above comments mentained __split_huge_page_tail() 
issue.

>> +
>> +               if (!TestClearPageMlocked(page)) {
>>                         delta_munlocked++;
>> +                       if (clearlru)
>> +                               SetPageLRU(page);
>> +                       goto putback;
>> +               }
>> +
>> +               if (!clearlru) {
>> +                       __munlock_isolation_failed(page);
>> +                       goto putback;
>>                 }
> 
> With the other function you were processing this outside of the lock,
> here you are doing it inside. It would probably make more sense here
> to follow similar logic and take care of the del_page_from_lru_list
> ifr clealru is set, unlock, and then if clearlru is set continue else
> track the isolation failure. That way you can avoid having to use as
> many jump labels.
> 
>>                 /*
>> +                * Isolate this page.
>> +                * We already have pin from follow_page_mask()
>> +                * so we can spare the get_page() here.
>> +                */
>> +               lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
>> +               del_page_from_lru_list(page, lruvec, page_lru(page));
>> +               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>> +               continue;
>> +
>> +               /*
>>                  * We won't be munlocking this page in the next phase
>>                  * but we still need to release the follow_page_mask()
>>                  * pin. We cannot do it under lru_lock however. If it's
>>                  * the last pin, __page_cache_release() would deadlock.
>>                  */
>> +putback:
>> +               spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>>                 pagevec_add(&pvec_putback, pvec->pages[i]);
>>                 pvec->pages[i] = NULL;
>>         }
>> +       /* tempary disable irq, will remove later */
>> +       local_irq_disable();
>>         __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
>> -       spin_unlock_irq(&zone->zone_pgdat->lru_lock);
>> +       local_irq_enable();
>>
>>         /* Now we can release pins of pages that we are not munlocking */
>>         pagevec_release(&pvec_putback);
>> --
>> 1.8.3.1
>>
>>
