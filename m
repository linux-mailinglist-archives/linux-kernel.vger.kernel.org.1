Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1263C2F7F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbhAOPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:22:31 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:12973 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbhAOPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:22:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610724125; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=4kOGYe/Vih3B8yN/uLa3ELAeVENaldnb22XtkAgp3wM=; b=RxjHPBhgkRM/Av9xcwRIVaq1fSw8/Yp6RxKZ+u4X/fSsaKuppidG20c8S6ynwCVUf9uiSjdc
 VNKCv8eM/ef++PDI73TgNsWU9iDeZkG0gZZG9V/DMSqIlWVykHuJHU1GmcrW1HX9q+m6LjCz
 q7547s84xspICPaIKBCKYRMX+2s=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6001b2f51e3bf9b669671818 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Jan 2021 15:21:25
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E2F0C43462; Fri, 15 Jan 2021 15:21:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.144.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 238E1C43461;
        Fri, 15 Jan 2021 15:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 238E1C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm/compaction: return proper state in
 should_proactive_compact_node
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        mhocko@suse.com, khalid.aziz@oracle.com, ngupta@nitingupta.dev,
        vinmenon@codeaurora.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1610546586-18998-1-git-send-email-charante@codeaurora.org>
 <bc3eeda2-ffcc-4f86-a24a-3c194102df47@suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <f00b3812-a99c-8e96-2e5c-ee90ba632fab@codeaurora.org>
Date:   Fri, 15 Jan 2021 20:51:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bc3eeda2-ffcc-4f86-a24a-3c194102df47@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Vlastimil!!

On 1/15/2021 6:15 PM, Vlastimil Babka wrote:
> On 1/13/21 3:03 PM, Charan Teja Reddy wrote:
>> should_proactive_compact_node() returns true when sum of the
>> fragmentation score of all the zones in the node is greater than the
>> wmark_high of compaction which then triggers the proactive compaction
>> that operates on the individual zones of the node. But proactive
>> compaction runs on the zone only when the fragmentation score of the
>> zone is greater than wmark_low(=wmark_high - 10).
>>
>> This means that the sum of the fragmentation scores of all the zones can
>> exceed the wmark_high but individual zone scores can still be less than
>> the wmark_low which makes the unnecessary trigger of the proactive
>> compaction only to return doing nothing.
>>
>> Another issue with the return of proactive compaction with out even
>> trying is its deferral. It is simply deferred for 1 <<
>> COMPACT_MAX_DEFER_SHIFT if the scores across the proactive compaction is
>> same, thinking that compaction didn't make any progress but in reality
>> it didn't even try. With the delay between successive retries for
>> proactive compaction is 500msec, it can result into the deferral for
>> ~30sec with out even trying the proactive compaction.
>>
>> Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
>> 50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
>> sizes 5GB and 6GB respectively. After opening some apps on the android,
>> the fragmentation scores of these zones are 47 and 49 respectively.
>> Since the sum of these fragmentation scores are above the wmark_high
>> which triggers the proactive compaction and there since the individual
>> zone scores are below wmark_low, it returns without trying the
>> compaction. As a result the fragmentation scores of the zones are still
>> 47 and 49 which makes the existing logic to defer the compaction
>> thinking that noprogress is made across the compaction.
>>
>> So, run the proactive compaction on the node zones only when atleast one
>> of the zones fragmentation score is greater than wmark_low. This avoids
>> the unnecessary deferral and retries of the compaction.
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> 
> Good catch about the problem, but I wonder if the solution could be better.
> 
> fragmentation_score_node() is a weighted average of scores of all zones, that's
> why fragmentation_score_zone() adjusts the score by zone_present/node_present.
> 
> But when considering an individual zone in __compact_finished(), we shouldn't be
> using fragmentation_score_zone() with the adjustment. We are not calculating the
> weighted average for the whole node there, so it doesn't make sense to do the
> adjustment by size. So if it simply took extfrag_for_order(...) as the score, it
> should work as expected. In your example above, the score of each zone would be
> above 60. If the weighted average is above wmark_high, then individual score
> (not adjusted) of at least one zone has to be above wmark_high, and the extra
> check using max() is not necessary.
> 
> So I would split fragmentation_score_zone() to e.g. fragmentation_score_zone()
> and fragmentation_score_zone_weighted() and call the latter only from
> fragmentation_score_node(), and not from __compact_finished().

This suggestion looks good and much cleaner. Will raise V2 in couple of
days. Thanks.

> 
> Vlastimil
> 
>> ---
>>  mm/compaction.c | 27 +++++++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index e5acb97..f7a772a 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1964,6 +1964,26 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>>  	return score;
>>  }
>>  
>> +/*
>> + * Returns the maximum of fragmentation scores of zones in a node. This is
>> + * used in taking the decission of whether to trigger the proactive compaction
>> + * on the zones of this node.
>> + */
>> +static unsigned int fragmentation_score_node_zones_max(pg_data_t *pgdat)
>> +{
>> +	int zoneid;
>> +	unsigned int max = 0;
>> +
>> +	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
>> +		struct zone *zone;
>> +
>> +		zone = &pgdat->node_zones[zoneid];
>> +		max = max_t(unsigned int, fragmentation_score_zone(zone), max);
>> +	}
>> +
>> +	return max;
>> +}
>> +
>>  static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
>>  {
>>  	unsigned int wmark_low;
>> @@ -1979,13 +1999,16 @@ static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
>>  
>>  static bool should_proactive_compact_node(pg_data_t *pgdat)
>>  {
>> -	int wmark_high;
>> +	int wmark_low, wmark_high;
>>  
>>  	if (!sysctl_compaction_proactiveness || kswapd_is_running(pgdat))
>>  		return false;
>>  
>>  	wmark_high = fragmentation_score_wmark(pgdat, false);
>> -	return fragmentation_score_node(pgdat) > wmark_high;
>> +	wmark_low = fragmentation_score_wmark(pgdat, true);
>> +
>> +	return fragmentation_score_node(pgdat) > wmark_high &&
>> +		fragmentation_score_node_zones_max(pgdat) > wmark_low;
>>  }
>>  
>>  static enum compact_result __compact_finished(struct compact_control *cc)
>>
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
