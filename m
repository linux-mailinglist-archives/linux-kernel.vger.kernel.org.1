Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD332DAF97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgLOPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:00:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54260 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbgLOO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:59:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFEtqDl048242;
        Tue, 15 Dec 2020 14:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+EM7jbZkICVrB62xTbpxTrFzsL7ejuGbgzgUDh1wIpc=;
 b=KoJgMJEITXdSU6QBpyK1itjyJSZWZSIzwk/SIdIM5T/iTF4kP+jV4yKmyLqsq1iqS4Uz
 Rr7K8AIQvrSmQj14KAzgICsWEoProAHx8rjDu06w5hvCU9RgUSy8EAUWhVyFP9rzDeyY
 lN2y25b6qlQYvBKsWvrlO+XX+558GNVihAc5Y1Ep5cvEnpGlp1c6BUORWduemydXHp2v
 +vw31KOCcqC3To/eCmnvOIkmAT2wxPceiKDHDlws0juxk8z1RPEOzMVZ5DsJ/4B7pFrl
 cvweYaLUVGX1+IYQ9KSw9CB1zgjbvG6eYywXtE0KTHz5DFruoSxQ7foPUaZyOjrYye99 Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35ckcbb4k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 14:57:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFEtPHS029883;
        Tue, 15 Dec 2020 14:56:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35e6jr7p1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 14:56:59 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BFEulno012932;
        Tue, 15 Dec 2020 14:56:49 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 06:56:46 -0800
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <20201206173418.GC201514@google.com>
 <20201209185203.GC6876@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
 <X9e9dcLMrMJThZs+@google.com>
 <16a390e4-b44d-b0eb-1df6-6e56d78d009f@oracle.com>
 <20201214232541.GF201514@google.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <56050aff-fde9-621a-9f6d-87e4bcdd87fa@oracle.com>
Date:   Tue, 15 Dec 2020 09:56:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201214232541.GF201514@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/20 6:25 PM, Joel Fernandes wrote:
> On Mon, Dec 14, 2020 at 02:44:09PM -0500, chris hyser wrote:
>> On 12/14/20 2:31 PM, Joel Fernandes wrote:
>>>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>>>> index cffdfab..50c31f3 100644
>>>> --- a/kernel/sched/debug.c
>>>> +++ b/kernel/sched/debug.c
>>>> @@ -1030,6 +1030,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>>>>    #ifdef CONFIG_SCHED_CORE
>>>>    	__PS("core_cookie", p->core_cookie);
>>>> +	__PS("core_task_cookie", p->core_task_cookie);
>>>>    #endif
>>>
>>> Hmm, so the final cookie of the task is always p->core_cookie. This is what
>>> the scheduler uses. All other fields are ingredients to derive the final
>>> cookie value.
>>>
>>> I will drop this hunk from your overall diff, but let me know if you
>>> disagree!
>>
>>
>> No problem. That was there primarily for debugging.
> 
> Ok. I squashed Josh's changes into this patch and several of my fixups. So
> there'll be 3 patches:
> 1. CGroup + prctl  (single patch as it is hell to split it)
> 2. Documentation
> 3. ksefltests
> 
> Below is the diff of #1. I still have to squash in the stop_machine removal
> and some more review changes. But other than that, please take a look and let
> me know anything that's odd.  I will test further as well.

Will do. Looking at it now and just started a build.

-chrish

