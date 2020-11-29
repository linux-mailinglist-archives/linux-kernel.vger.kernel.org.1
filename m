Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4172C778B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 05:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgK2Eol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 23:44:41 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58061 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgK2Eol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 23:44:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UGqPWhq_1606625033;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGqPWhq_1606625033)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 Nov 2020 12:43:53 +0800
Subject: Re: [PATCH] mm/memcg: bail out early when !memcg in mem_cgroup_lruvec
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201127200215.dc96a839cdd816361e7093e6@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9ddb17cd-cf5f-15b1-6a7d-986ee44fd5df@linux.alibaba.com>
Date:   Sun, 29 Nov 2020 12:43:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201127200215.dc96a839cdd816361e7093e6@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/28 ÏÂÎç12:02, Andrew Morton Ð´µÀ:
> On Fri, 27 Nov 2020 11:08:35 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
>> so we could get out early in the situation to avoid useless checking.
>>
>> Also warning if both parameter are NULL.
> 
> Why do you think a warning is needed here?

Uh, Consider there are no problem for long time, it could be saved.

> 
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -613,14 +613,13 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>>  	struct mem_cgroup_per_node *mz;
>>  	struct lruvec *lruvec;
>>  
>> -	if (mem_cgroup_disabled()) {
>> +	VM_WARN_ON_ONCE(!memcg && !pgdat);
>> +
>> +	if (mem_cgroup_disabled() || !memcg) {
>>  		lruvec = &pgdat->__lruvec;
>>  		goto out;
>>  	}
>>  
>> -	if (!memcg)
>> -		memcg = root_mem_cgroup;
>> -
> 
> This change isn't obviously equivalent, is it?

If !memcg, the root_mem_cgroup will still lead the lruvec to a pgdat
same as parameter.

> 
>>  	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>>  	lruvec = &mz->lruvec;
>>  out:
> 
> And the resulting code is awkward:
> 
> 	if (mem_cgroup_disabled() || !memcg) {
> 		lruvec = &pgdat->__lruvec;
> 		goto out;
> 	}
> 
> 	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> 	lruvec = &mz->lruvec;
> out:
> 
> 
> could be
> 
> 	if (mem_cgroup_disabled() || !memcg) {
> 		lruvec = &pgdat->__lruvec;
> 	} else {
> 		mem_cgroup_per_node mz;
> 
> 		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> 		lruvec = &mz->lruvec;
> 	}
> 

Right. remove 'goto' is better for understander.

So, is the following patch ok?

From 225f29e03b40a7cbaeb4e3bb76f8efbcd7d648a2 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Wed, 25 Nov 2020 14:06:33 +0800
Subject: [PATCH v2] mm/memcg: bail out early when !memcg in mem_cgroup_lruvec

Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
so we could get out early in the situation to avoid useless checking.

Polished as Andrew Morton's suggestion.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3e6a1df3bdb9..4ff2ffe2b73d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -610,20 +610,17 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 					       struct pglist_data *pgdat)
 {
-	struct mem_cgroup_per_node *mz;
 	struct lruvec *lruvec;
 
-	if (mem_cgroup_disabled()) {
+	if (mem_cgroup_disabled() || !memcg) {
 		lruvec = &pgdat->__lruvec;
-		goto out;
-	}
+	} else {
+		struct mem_cgroup_per_node *mz;
 
-	if (!memcg)
-		memcg = root_mem_cgroup;
+		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+		lruvec = &mz->lruvec;
+	}
 
-	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
-	lruvec = &mz->lruvec;
-out:
 	/*
 	 * Since a node can be onlined after the mem_cgroup was created,
 	 * we have to be prepared to initialize lruvec->pgdat here;
-- 
2.29.GIT

