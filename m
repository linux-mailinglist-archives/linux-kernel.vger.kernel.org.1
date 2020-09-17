Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2765426D075
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgIQBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:16:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:59622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQBQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:16:30 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:16:30 EDT
IronPort-SDR: m3l7vfWtAffhSbjCEPJFDGIg+TbXBbL0hTr44HSB4ufQd2jomzRhbFd54y24FCHatYRFDjVPi0
 Wz3nFCGLvUSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="156982019"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="156982019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 18:09:21 -0700
IronPort-SDR: hmsRNOgsXNVJVvJx0cAQLagijiHwosmnCPveYTnafbybnITSam3345zTiGI1T4zurv0/N7rlRn
 k4jW35BFRO/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="331931692"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2020 18:09:13 -0700
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
To:     chris hyser <chris.hyser@oracle.com>,
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
 <b7bfdba2-b1db-2acd-5f50-e6eb0008c817@oracle.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <600ffdab-472b-0190-481c-a4042f3ee833@linux.intel.com>
Date:   Thu, 17 Sep 2020 09:09:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b7bfdba2-b1db-2acd-5f50-e6eb0008c817@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/17 4:53, chris hyser wrote:
> On 9/16/20 10:24 AM, chris hyser wrote:
>> On 9/16/20 8:57 AM, Li, Aubrey wrote:
>>>> Here are the uperf results of the various patchsets. Note, that disabling smt is better for these tests and that that presumably reflects the overall overhead of core scheduling which went from bad to really bad. The primary focus in this email is to start to understand what happened within core sched itself.
>>>>
>>>> patchset          smt=on/cs=off  smt=off    smt=on/cs=on
>>>> --------------------------------------------------------
>>>> v5-v5.6.y      :    1.78Gb/s     1.57Gb/s     1.07Gb/s
>>>> pre-v6-v5.6.y  :    1.75Gb/s     1.55Gb/s    822.16Mb/s
>>>> v6-5.7         :    1.87Gs/s     1.56Gb/s    561.6Mb/s
>>>> v6-5.7-hotplug :    1.75Gb/s     1.58Gb/s    438.21Mb/s
>>>> v7             :    1.80Gb/s     1.61Gb/s    440.44Mb/s
>>>
>>> I haven't had a chance to play with v7, but I got something different.
>>>
>>>    branch        smt=on/cs=on
>>> coresched/v5-v5.6.y    1.09Gb/s
>>> coresched/v6-v5.7.y    1.05Gb/s
>>>
>>> I attached my kernel config in case you want to make a comparison, or you
>>> can send yours, I'll try to see I can replicate your result.
>>
>> I will give this config a try. One of the reports forwarded to me about the drop in uperf perf was an email from you I believe mentioning a 50% perf drop between v5 and v6?? I was actually setting out to duplicate your results. :-)
> 
> The first thing I did was to verify I built and tested the right bits. Presumably as I get same numbers. I'm still trying to tweak your config to get a root disk in my setup. Oh, one thing I missed in reading your first response, I had 24 cores/48 cpus. I think you had half that, though my guess is that that should have actually made the numbers even worse. :-)
> 
> The following was forwarded to me originally sent on Aug 3, by you I believe:
> 
>> We found uperf(in cgroup) throughput drops by ~50% with corescheduling.
>>
>> The problem is, uperf triggered a lot of softirq and offloaded softirq
>> service to *ksoftirqd* thread.
>>
>> - default, ksoftirqd thread can run with uperf on the same core, we saw
>>   100% CPU utilization.
>> - coresched enabled, ksoftirqd's core cookie is different from uperf, so
>>   they can't run concurrently on the same core, we saw ~15% forced idle.
>>
>> I guess this kind of performance drop can be replicated by other similar
>> (a lot of softirq activities) workloads.
>>
>> Currently core scheduler picks cookie-match tasks for all SMT siblings, does
>> it make sense we add a policy to allow cookie-compatible task running together?
>> For example, if a task is trusted(set by admin), it can work with kernel thread.
>> The difference from corescheduling disabled is that we still have user to user
>> isolation.
>>
>> Thanks,
>> -Aubrey
> 
> Would you please elaborate on what this test was? In trying to duplicate this, I just kept adding uperf threads to my setup until I started to see performance losses similar to what is reported above (and a second report about v7). Also, I wasn't looking for absolute numbers per-se, just significant enough differences to try to track where the performance went.
> 

This test was smt-on/cs-on against smt-on/cs-off on the same corescheduling version,
we didn't find such big regression between different versions as you encountered.

Thanks,
-Aubrey
