Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53EF26CD34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgIPUzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:55:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50810 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgIPUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:55:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GKmvqv127452;
        Wed, 16 Sep 2020 20:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nXffF4S9pPIX29xhz9P7Sama3JOSorZnFBUS+oYAGmI=;
 b=of5EYOsO2NCCMDZNn4ZZ8/8PREAz9snozAp3nNZPvtZ4e5a6XoF522gu9ikvZXnTCrBI
 AqNMYYoJQjTcAo9Ay7dfz8QGkWMufog/taTU5sjXPb5GWH4yunsd8RbuiYO7rIRZEhiB
 83vrqYooxffXkyR5Xr8j9ZqFjaaYcvzq+SAp2z9yV3gstFC3WmZ2KJSQBm9PvNDGhtAx
 dC7p1mEYd2Rthd/UF01B39x1iVZFIRj+q+JGPbS3mkmPkDwtr0WVYNBsnKEocNn4lEpB
 iJiGBML7AXR5hM744bhXWGyiTbZATo620pmQS/scC7tzgYWDPGbPmLeEmwp+DHqSNJ4P Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33gp9mdf3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 20:53:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GKkmje069605;
        Wed, 16 Sep 2020 20:53:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33h892dvbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 20:53:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GKrF9a025829;
        Wed, 16 Sep 2020 20:53:16 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 20:53:15 +0000
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
From:   chris hyser <chris.hyser@oracle.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
        Aaron Lu <ziqian.lzq@antfin.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <f20f4d5b-574a-7c3d-8c08-3e6b7893fc58@oracle.com>
 <81b208ad-b9e6-bfbf-631e-02e9f75d73a2@linux.intel.com>
 <51424491-b7e0-b245-1062-319021eb1845@oracle.com>
Message-ID: <b7bfdba2-b1db-2acd-5f50-e6eb0008c817@oracle.com>
Date:   Wed, 16 Sep 2020 16:53:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <51424491-b7e0-b245-1062-319021eb1845@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/20 10:24 AM, chris hyser wrote:
> On 9/16/20 8:57 AM, Li, Aubrey wrote:
>>> Here are the uperf results of the various patchsets. Note, that disabling smt is better for these tests and that that 
>>> presumably reflects the overall overhead of core scheduling which went from bad to really bad. The primary focus in 
>>> this email is to start to understand what happened within core sched itself.
>>>
>>> patchset          smt=on/cs=off  smt=off    smt=on/cs=on
>>> --------------------------------------------------------
>>> v5-v5.6.y      :    1.78Gb/s     1.57Gb/s     1.07Gb/s
>>> pre-v6-v5.6.y  :    1.75Gb/s     1.55Gb/s    822.16Mb/s
>>> v6-5.7         :    1.87Gs/s     1.56Gb/s    561.6Mb/s
>>> v6-5.7-hotplug :    1.75Gb/s     1.58Gb/s    438.21Mb/s
>>> v7             :    1.80Gb/s     1.61Gb/s    440.44Mb/s
>>
>> I haven't had a chance to play with v7, but I got something different.
>>
>>    branch        smt=on/cs=on
>> coresched/v5-v5.6.y    1.09Gb/s
>> coresched/v6-v5.7.y    1.05Gb/s
>>
>> I attached my kernel config in case you want to make a comparison, or you
>> can send yours, I'll try to see I can replicate your result.
> 
> I will give this config a try. One of the reports forwarded to me about the drop in uperf perf was an email from you I 
> believe mentioning a 50% perf drop between v5 and v6?? I was actually setting out to duplicate your results. :-)

The first thing I did was to verify I built and tested the right bits. Presumably as I get same numbers. I'm still 
trying to tweak your config to get a root disk in my setup. Oh, one thing I missed in reading your first response, I had 
24 cores/48 cpus. I think you had half that, though my guess is that that should have actually made the numbers even 
worse. :-)

The following was forwarded to me originally sent on Aug 3, by you I believe:

> We found uperf(in cgroup) throughput drops by ~50% with corescheduling.
> 
> The problem is, uperf triggered a lot of softirq and offloaded softirq
> service to *ksoftirqd* thread.
> 
> - default, ksoftirqd thread can run with uperf on the same core, we saw
>   100% CPU utilization.
> - coresched enabled, ksoftirqd's core cookie is different from uperf, so
>   they can't run concurrently on the same core, we saw ~15% forced idle.
> 
> I guess this kind of performance drop can be replicated by other similar
> (a lot of softirq activities) workloads.
> 
> Currently core scheduler picks cookie-match tasks for all SMT siblings, does
> it make sense we add a policy to allow cookie-compatible task running together?
> For example, if a task is trusted(set by admin), it can work with kernel thread.
> The difference from corescheduling disabled is that we still have user to user
> isolation.
> 
> Thanks,
> -Aubrey

Would you please elaborate on what this test was? In trying to duplicate this, I just kept adding uperf threads to my 
setup until I started to see performance losses similar to what is reported above (and a second report about v7). Also, 
I wasn't looking for absolute numbers per-se, just significant enough differences to try to track where the performance 
went.

-chrish
