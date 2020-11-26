Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8F2C4EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbgKZGjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:39:07 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41037 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731252AbgKZGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:39:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UGZY9rf_1606372743;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGZY9rf_1606372743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 14:39:03 +0800
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
To:     Yu Zhao <yuzhao@google.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201126045234.GA1014081@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
Date:   Thu, 26 Nov 2020 14:39:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201126045234.GA1014081@google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/26 ÏÂÎç12:52, Yu Zhao Ð´µÀ:
>>   */
>>  void __pagevec_lru_add(struct pagevec *pvec)
>>  {
>> -	int i;
>> -	struct lruvec *lruvec = NULL;
>> +	int i, nr_lruvec;
>>  	unsigned long flags = 0;
>> +	struct page *page;
>> +	struct lruvecs lruvecs;
>>  
>> -	for (i = 0; i < pagevec_count(pvec); i++) {
>> -		struct page *page = pvec->pages[i];
>> +	nr_lruvec = sort_page_lruvec(&lruvecs, pvec);
> Simply looping pvec multiple times (15 at most) for different lruvecs
> would be better because 1) it requires no extra data structures and
> therefore has better cache locality (theoretically faster) 2) it only
> loops once when !CONFIG_MEMCG and !CONFIG_NUMA and therefore has no
> impact on Android and Chrome OS.
> 

With multiple memcgs, it do help a lot, I had gotten 30% grain on readtwice
case. but yes, w/o MEMCG and NUMA, it's good to keep old behavior. So 
would you like has a proposal for this?

Thanks
Alex
