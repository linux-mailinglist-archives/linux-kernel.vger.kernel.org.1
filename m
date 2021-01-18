Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5410A2FAA06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393959AbhARTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:23:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437116AbhARTRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:17:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IJEa0x174708;
        Mon, 18 Jan 2021 19:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wJc3W+HbrFUHSTbk0nIfWGFMmS6YYO5fWKcXYyEazuk=;
 b=aH/WIs4zD6s8e9xYNLA3wvFG0zBdQTJ/hGvmRfF2HqwDvdJEJfXmt8p/bHHll274rWgT
 FsIHO3Bk1PkXmwr+2FkudG6NIZf+50R3XOhTYFpjOkaECmTfIa3NiXzG3b6XtOPa9QOt
 CJT6FJTGcMdxkOAmAZEXSmg9AR2GPBXmGE04kwvbCTbi0tzp2s5kb1LwlvGck7hmzUrw
 0oyUs6fT0js9ZwvK3Ub8CxNm2ba88AwyNQCMKx1b1CS/S450rFT1S+D7Iw5EZNPdlmlP
 OLhAOgxSrO4BZdSmjL2IUwbU+YgLh5jfZDYwU1Dv5Icz53VY73lrm2Mc6GXpSkEhG9Ac qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 363nnaejv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 19:16:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IJD6S9091840;
        Mon, 18 Jan 2021 19:14:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3649wqcdt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 19:14:12 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10IJE5dl017636;
        Mon, 18 Jan 2021 19:14:05 GMT
Received: from [10.191.133.57] (/10.191.133.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jan 2021 11:14:05 -0800
Subject: Re: [RFC PATCH] Remove redundant sched_numa_balancing check.
To:     Mel Gorman <mgorman@suse.de>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210118103218.204373-1-imran.f.khan@oracle.com>
 <20210118105757.GA20777@suse.de>
From:   Imran Khan <imran.f.khan@oracle.com>
Message-ID: <bcef7a38-7c60-0949-3d3b-1462638a5d4c@oracle.com>
Date:   Tue, 19 Jan 2021 06:13:57 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118105757.GA20777@suse.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/1/21 9:57 pm, Mel Gorman wrote:
> On Mon, Jan 18, 2021 at 09:32:18PM +1100, Imran Khan wrote:
>> task_numa_fault is invoked from do_numa_page/do_huge_pmd_numa_page,
>> for task_numa_work induced memory faults. task_numa_work is scheduled
>> from task_tick_numa which is invoked only if sched_numa_balancing
>> is true.
>>
>> So task_numa_fault will not get invoked if sched_numa_balancing is
>> false and hence we can avoid checking it again in task_numa_fault.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> 
> If NUMA balancing is disabled at runtime, there may still be PTEs that
> are marked for NUMA balancing. While these still get handled at fault,
> there is no point tracking the fault information in task_numa_fault and
> this function can still get called after sched_numa_balancing is
> disabled.
> 

Okay, understood. Thanks for clarifying.
