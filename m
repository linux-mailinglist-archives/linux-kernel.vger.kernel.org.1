Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5905D2DE386
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgLRNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:52:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgLRNwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:52:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIDhskF182301;
        Fri, 18 Dec 2020 13:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1nv1g/KtgoryQbdpPqH+exDUcPgrLJWTtl2hHx3HJls=;
 b=pKrfmaXDgCvdiply/gV5hvErhDeLfv/Rzx8DUhpBtP+uT7HVksUSQaAPKHnCAPTw8wAX
 w1cOziGRtBt/uffZvgYjYyuSAPnlKdBvBUY/+8oYt4tqvbjK3m7TsgpOZOP0JPv2jpYW
 XGAm/K+N4vm0MSJzM7co1rro19OU/FFhdvf/sNF8pCNTJKu7NrmszyMA6Q9UzYawyneb
 O6s2Rx/jljZKH0E0Gq9HJ3LIQz3i0Hx314iQYDVTHvbyvvXs38/sswyHjyvho6qc4kUl
 q78glXHViuhAVBW9bCqcUJbJ/kHknfYrgDIMDGRVjVvQAKTnBZhH2BKKpjhH+Ham8Lq7 Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntmjamv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 13:52:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIDjMxv077150;
        Fri, 18 Dec 2020 13:52:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35d7esc4aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 13:52:01 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BIDpxtw015406;
        Fri, 18 Dec 2020 13:51:59 GMT
Received: from [10.191.15.101] (/10.191.15.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 05:51:58 -0800
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
 <20201218105153.GX32193@dhcp22.suse.cz>
From:   Jacob Wen <jian.w.wen@oracle.com>
Message-ID: <f376b551-9a90-c036-d34b-b32d93107b6c@oracle.com>
Date:   Fri, 18 Dec 2020 21:51:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218105153.GX32193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/20 6:51 PM, Michal Hocko wrote:
> On Fri 18-12-20 18:22:17, Jacob Wen wrote:
>> This patch reduces repetition of set_task_reclaim_state() around
>> do_try_to_free_pages().
> The changelog really should be talking about why this is needed/useful.
>  From the above it is not really clear whether you aimed at doing
> a clean up or this is a fix for some misbehavior. I do assume the former
> but this should be clearly articulated.

How about this?

mm/vmscan: remove duplicate code around do_try_to_free_pages()

This patch moves set_task_reclaim_state() into do_try_to_free_pages()
to avoid unnecessary repetition. It doesn't introduce functional
change.

>
>> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
>> ---
>>   mm/vmscan.c | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 257cba79a96d..4bc244b23686 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3023,6 +3023,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>>   	pg_data_t *last_pgdat;
>>   	struct zoneref *z;
>>   	struct zone *zone;
>> +	unsigned long ret;
>> +
>> +	set_task_reclaim_state(current, &sc->reclaim_state);
>> +
>>   retry:
>>   	delayacct_freepages_start();
>>   
>> @@ -3069,12 +3073,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>>   
>>   	delayacct_freepages_end();
>>   
>> -	if (sc->nr_reclaimed)
>> -		return sc->nr_reclaimed;
>> +	if (sc->nr_reclaimed) {
>> +		ret = sc->nr_reclaimed;
>> +		goto out;
>> +	}
>>   
>>   	/* Aborted reclaim to try compaction? don't OOM, then */
>> -	if (sc->compaction_ready)
>> -		return 1;
>> +	if (sc->compaction_ready) {
>> +		ret = 1;
>> +		goto out;
>> +	}
>>   
>>   	/*
>>   	 * We make inactive:active ratio decisions based on the node's
>> @@ -3101,7 +3109,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>>   		goto retry;
>>   	}
>>   
>> -	return 0;
>> +	ret = 0;
>> +out:
>> +	set_task_reclaim_state(current, NULL);
>> +	return ret;
>>   }
>>   
>>   static bool allow_direct_reclaim(pg_data_t *pgdat)
>> @@ -3269,13 +3280,11 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>>   	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
>>   		return 1;
>>   
>> -	set_task_reclaim_state(current, &sc.reclaim_state);
>>   	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>>   
>>   	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>>   
>>   	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
>> -	set_task_reclaim_state(current, NULL);
>>   
>>   	return nr_reclaimed;
>>   }
>> @@ -3347,7 +3356,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>   	 */
>>   	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>>   
>> -	set_task_reclaim_state(current, &sc.reclaim_state);
>>   	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
>>   	noreclaim_flag = memalloc_noreclaim_save();
>>   
>> @@ -3355,7 +3363,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>   
>>   	memalloc_noreclaim_restore(noreclaim_flag);
>>   	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
>> -	set_task_reclaim_state(current, NULL);
>>   
>>   	return nr_reclaimed;
>>   }
>> @@ -4023,11 +4030,9 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>>   
>>   	fs_reclaim_acquire(sc.gfp_mask);
>>   	noreclaim_flag = memalloc_noreclaim_save();
>> -	set_task_reclaim_state(current, &sc.reclaim_state);
>>   
>>   	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>>   
>> -	set_task_reclaim_state(current, NULL);
>>   	memalloc_noreclaim_restore(noreclaim_flag);
>>   	fs_reclaim_release(sc.gfp_mask);
>>   
>> -- 
>> 2.25.1
>>
