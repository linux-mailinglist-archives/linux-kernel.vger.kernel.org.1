Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470042BFF26
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKWEs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:48:28 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50397 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbgKWEs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:48:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UGBILz2_1606106903;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGBILz2_1606106903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Nov 2020 12:48:24 +0800
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201120151948.c3f4175ed18ed74e46760b87@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ae6509ef-66f5-eabe-2f9c-b28871b68db0@linux.alibaba.com>
Date:   Mon, 23 Nov 2020 12:46:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120151948.c3f4175ed18ed74e46760b87@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/21 ÉÏÎç7:19, Andrew Morton Ð´µÀ:
> On Fri, 20 Nov 2020 16:27:27 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> The current relock logical will change lru_lock when found a new
>> lruvec, so if 2 memcgs are reading file or alloc page at same time,
>> they could hold the lru_lock alternately, and wait for each other for
>> fairness attribute of ticket spin lock.
>>
>> This patch will sort that all lru_locks and only hold them once in
>> above scenario. That could reduce fairness waiting for lock reget.
>> Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
>> gain on my 2P*20core*HT machine.
> 
> But what happens when all or most of the pages belong to the same
> lruvec?  This sounds like the common case - won't it suffer?
> 
Hi Andrew,

My testing show no regression on this situation, like original centos7,
The most spending time is on lru_lock for lru sensitive case.

Thanks
Alex
