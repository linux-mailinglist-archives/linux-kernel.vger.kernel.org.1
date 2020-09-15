Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4BB26AFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIOVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:52:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgIOVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:51:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FLnmoR027388;
        Tue, 15 Sep 2020 21:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rHvhpgj7laAjHgkr4DLOBBS/uirpv7rnF3o3VrDMY1U=;
 b=GYNOL+0hzTDueVI/QSHkhCYwsLq8QUBznLkJcb54m93BSAMIqauW7e9cQ6AuZrOsJebq
 ims/bWmF/mwRoHuKRoRR1JWYFSPO9OJmAc/8D+m4oTaC9m7WcPsxl92uEtVrd1yXgyRH
 n8qzQ75chTQmJIhCLHMo+ixV/02KXHxjxf8vMDivCxV6TUbfE/bB6CNu7LFCQ5x8Sfea
 lZ0Cneuc3x77p+C7lF6NPjOjrl7T53YZ5cfl8eopNCNiST1gEI/Hz7U/OeRFZoqzudBp
 O4TZGZ+XtjyNHsuXMqlSSjqtSZyvwMdhZdLVFR/N2Pkh+kpu3OY+MheHNguW0vwItA4n EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrqysy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 21:49:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FLTSF4011393;
        Tue, 15 Sep 2020 21:49:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33h8864sd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 21:49:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FLnTwH002605;
        Tue, 15 Sep 2020 21:49:30 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 21:49:29 +0000
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <f20f4d5b-574a-7c3d-8c08-3e6b7893fc58@oracle.com>
Date:   Tue, 15 Sep 2020 17:49:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 3:51 PM, Julien Desfossez wrote:
> From: Aaron Lu <aaron.lwe@gmail.com>
> 
> This patch provides a vruntime based way to compare two cfs task's
> priority, be it on the same cpu or different threads of the same core.
> 
> When the two tasks are on the same CPU, we just need to find a common
> cfs_rq both sched_entities are on and then do the comparison.
> 
> When the two tasks are on differen threads of the same core, each thread
> will choose the next task to run the usual way and then the root level
> sched entities which the two tasks belong to will be used to decide
> which task runs next core wide.
> 
> An illustration for the cross CPU case:
> 
>     cpu0         cpu1
>   /   |  \     /   |  \
> se1 se2 se3  se4 se5 se6
>      /  \            /   \
>    se21 se22       se61  se62
>    (A)                    /
>                         se621
>                          (B)
> 
> Assume CPU0 and CPU1 are smt siblings and cpu0 has decided task A to
> run next and cpu1 has decided task B to run next. To compare priority
> of task A and B, we compare priority of se2 and se6. Whose vruntime is
> smaller, who wins.
> 
> To make this work, the root level sched entities' vruntime of the two
> threads must be directly comparable. So one of the hyperthread's root
> cfs_rq's min_vruntime is chosen as the core wide one and all root level
> sched entities' vruntime is normalized against it.
> 
> All sub cfs_rqs and sched entities are not interesting in cross cpu
> priority comparison as they will only participate in the usual cpu local
> schedule decision so no need to normalize their vruntimes.
> 
> Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
> ---
>   kernel/sched/core.c  |  23 +++----
>   kernel/sched/fair.c  | 142 ++++++++++++++++++++++++++++++++++++++++++-
>   kernel/sched/sched.h |   3 +
>   3 files changed, 150 insertions(+), 18 deletions(-)


While investigating reported 'uperf' performance regressions between core sched v5 and core sched v6/v7, this patch 
seems to be the first indicator of about a 40% perf loss in moving between v5 and v6 (and the accounting here is carried 
forward into this patch). Unfortunately, it is not the easiest thing to trace back as the patchsets are not directly 
comparable in this case and moving into v7, the base kernel revision has changed from 5.6 to 5.9.

The regressions were duplicated with the following setup: on a 24 core VM, create a cgroup and in it, fire off the uperf 
server and the client running 2 mins worth of 100 threads doing short TCP reads and writes. Do this for both the cgroup 
core sched tagged and not tagged (technically tearing everything down and rebuilding it in between). Short and easy to 
do dozens of runs for statistical averaging.

What ever the above version of this test might map to in real life, it presumably exacerbates the competition between 
softirq threads and the core sched tagged threads which was observed in the reports.

Here are the uperf results of the various patchsets. Note, that disabling smt is better for these tests and that that 
presumably reflects the overall overhead of core scheduling which went from bad to really bad. The primary focus in this 
email is to start to understand what happened within core sched itself.

patchset          smt=on/cs=off  smt=off    smt=on/cs=on
--------------------------------------------------------
v5-v5.6.y      :    1.78Gb/s     1.57Gb/s     1.07Gb/s
pre-v6-v5.6.y  :    1.75Gb/s     1.55Gb/s    822.16Mb/s
v6-5.7         :    1.87Gs/s     1.56Gb/s    561.6Mb/s
v6-5.7-hotplug :    1.75Gb/s     1.58Gb/s    438.21Mb/s
v7             :    1.80Gb/s     1.61Gb/s    440.44Mb/s

If you start by contrasting v5 and v6 on the same base 5.6 kernel to try to rule out kernel to kernel version 
differences, bisecting v6 pointed to the v6 version of (ie this patch):

"[RFC PATCH v7 11/23] sched/fair: core wide cfs task priority comparison"

although all that really seems to be saying is that the new means of vruntime accounting (still present in v7) has 
caused performance in the patchset to drop which is plausible; different numbers, different scheduler behavior. A rough 
attempt to verify this by backporting parts of the new accounting onto the v5 patchset show where that initial switching 
from old to new accounting dropped perf to about 791Mb/s and the rest of the changes (as shown in the v6 numbers though 
not backported), only bring the v6 patchset back to 822.16Mb/s. That is not 100% proof, but seems very suspicious.

This change in vruntime accounting seems to account for about 40% of the total v5-to-v7 perf loss though clearly lots of 
other changes have occurred in between. Certainly not saying there is a bug here, just time to bring in the original 
authors and start a general discussion.

-chrish
