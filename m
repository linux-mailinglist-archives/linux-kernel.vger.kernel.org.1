Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED652DE866
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgLRRmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:42:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58330 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgLRRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIHe1LF095859;
        Fri, 18 Dec 2020 17:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=axWyhlKJ9A4lMzCz3/TdQOTDdJUf7qEcyqGr7D29Zoc=;
 b=yig6P5yGnCAAPSRyX3H+kQ4QFgSi+ZwLNtt8ckqTUYnQ8sBTB7vaM4cJPx39eDlE+xjl
 uBoLTMzXxQwWERIg/v9uJOVRVZleeu6OqQT4nmZXb7gZtLeSskDCFy+FvRl4HP15WvlY
 jjz4PeOuuBZggVUSy27H5ioHxu2xfongpxLhxWrbX8khhwETk9zfYqo+gaD7KYFb4Y6Z
 joLQqaQtGKKxmF/2j1LK2gs0McqpxysgP7H9Y01gWv4+FiTCbURgsg5L4WxFw0MXVbKb
 CPz6nkYL8/XSbVpH1BbTQnydYKcN63n/UHSeN+4icmUmd0fMCHlY0GgnGCBtcv8cDMbI 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35cntmkc60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 17:41:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIHaKca162324;
        Fri, 18 Dec 2020 17:41:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35d7t25y8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 17:41:12 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BIHfBJp020595;
        Fri, 18 Dec 2020 17:41:12 GMT
Received: from [10.0.0.100] (/221.221.52.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 09:41:11 -0800
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
 <20201218105153.GX32193@dhcp22.suse.cz>
 <f376b551-9a90-c036-d34b-b32d93107b6c@oracle.com>
 <20201218142717.GA32193@dhcp22.suse.cz>
From:   Jacob Wen <jian.w.wen@oracle.com>
Message-ID: <63e8a821-a3f6-47a6-f438-b27c32f4a05f@oracle.com>
Date:   Sat, 19 Dec 2020 01:41:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218142717.GA32193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/20 10:27 PM, Michal Hocko wrote:
> On Fri 18-12-20 21:51:48, Jacob Wen wrote:
>> On 12/18/20 6:51 PM, Michal Hocko wrote:
>>> On Fri 18-12-20 18:22:17, Jacob Wen wrote:
>>>> This patch reduces repetition of set_task_reclaim_state() around
>>>> do_try_to_free_pages().
>>> The changelog really should be talking about why this is needed/useful.
>>>   From the above it is not really clear whether you aimed at doing
>>> a clean up or this is a fix for some misbehavior. I do assume the former
>>> but this should be clearly articulated.
>> How about this?
>>
>> mm/vmscan: remove duplicate code around do_try_to_free_pages()
>>
>> This patch moves set_task_reclaim_state() into do_try_to_free_pages()
>> to avoid unnecessary repetition. It doesn't introduce functional
>> change.
> This is still more about what is changed more than why it is changed. I
> would go with something like the following:
> "
> reclaim_state has to be set for all reclaim paths because it acts as a
> storage to collect reclaim feedback. Currently set_task_reclaim_state is
> called from each highlevel reclaim function. Simplify the code flow by
> moving set_task_reclaim_state into core direct reclaim function
> (do_try_to_free_pages) for all direct reclaim paths.
> "
>
> To the patch itself. I am not opposed but I do not see an urgent reason
> to take it either. The net LOC increases slightly, it makes
> do_try_to_free_pages slightly more tricky due to different early return
> paths. Highlevel direct reclaim functions do not tend to change a lot.

set_task_reclaim_state() is a function with 3 lines of code of which 2 
lines contain WARN_ON_ONCE.

I am not comfortable with the current repetition.

>
>>>> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
>>>> ---
>>>>    mm/vmscan.c | 27 ++++++++++++++++-----------
>>>>    1 file changed, 16 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 257cba79a96d..4bc244b23686 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -3023,6 +3023,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>>>>    	pg_data_t *last_pgdat;
>>>>    	struct zoneref *z;
>>>>    	struct zone *zone;
>>>> +	unsigned long ret;
>>>> +
>>>> +	set_task_reclaim_state(current, &sc->reclaim_state);
>>>> +
>>>>    retry:
>>>>    	delayacct_freepages_start();
>>>> @@ -3069,12 +3073,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>>>>    	delayacct_freepages_end();
>>>> -	if (sc->nr_reclaimed)
>>>> -		return sc->nr_reclaimed;
>>>> +	if (sc->nr_reclaimed) {
>>>> +		ret = sc->nr_reclaimed;
>>>> +		goto out;
>>>> +	}
>>>>    	/* Aborted reclaim to try compaction? don't OOM, then */
>>>> -	if (sc->compaction_ready)
>>>> -		return 1;
>>>> +	if (sc->compaction_ready) {
>>>> +		ret = 1;
>>>> +		goto out;
>>>> +	}
>>>>    	/*
>>>>    	 * We make inactive:active ratio decisions based on the node's
>>>> @@ -3101,7 +3109,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>>>>    		goto retry;
>>>>    	}
>>>> -	return 0;
>>>> +	ret = 0;
>>>> +out:
>>>> +	set_task_reclaim_state(current, NULL);
>>>> +	return ret;
>>>>    }
>>>>    static bool allow_direct_reclaim(pg_data_t *pgdat)
>>>> @@ -3269,13 +3280,11 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>>>>    	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
>>>>    		return 1;
>>>> -	set_task_reclaim_state(current, &sc.reclaim_state);
>>>>    	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>>>>    	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>>>>    	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
>>>> -	set_task_reclaim_state(current, NULL);
>>>>    	return nr_reclaimed;
>>>>    }
>>>> @@ -3347,7 +3356,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>>    	 */
>>>>    	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>>>> -	set_task_reclaim_state(current, &sc.reclaim_state);
>>>>    	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
>>>>    	noreclaim_flag = memalloc_noreclaim_save();
>>>> @@ -3355,7 +3363,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>>    	memalloc_noreclaim_restore(noreclaim_flag);
>>>>    	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
>>>> -	set_task_reclaim_state(current, NULL);
>>>>    	return nr_reclaimed;
>>>>    }
>>>> @@ -4023,11 +4030,9 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>>>>    	fs_reclaim_acquire(sc.gfp_mask);
>>>>    	noreclaim_flag = memalloc_noreclaim_save();
>>>> -	set_task_reclaim_state(current, &sc.reclaim_state);
>>>>    	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>>>> -	set_task_reclaim_state(current, NULL);
>>>>    	memalloc_noreclaim_restore(noreclaim_flag);
>>>>    	fs_reclaim_release(sc.gfp_mask);
>>>> -- 
>>>> 2.25.1
>>>>
