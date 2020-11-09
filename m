Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C332AB10F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 07:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgKIGEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 01:04:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:42433 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgKIGEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:04:30 -0500
IronPort-SDR: VV7xUNGl4MXHrTsIPf137Rl5i0L/PD2GL7684qKq8ooII4kxAR4pOYhhsqWX85bo8sDABbm0PC
 aNzmC6v/KAgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="157537415"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="157537415"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 22:04:29 -0800
IronPort-SDR: CevAJtqNhn6fkNYKP/cmXcMeIvFH4HyBgizUYf5Dr4bU0x+n8oHzeOa2ZTW+cYzNVUtnwmKm/E
 fChLzqLB2oVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="364922360"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2020 22:04:14 -0800
Subject: Re: [PATCH v8 -tip 00/26] Core scheduling
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
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
        chris.hyser@oracle.com, Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <f7fc588b-12cf-95a8-6142-e4d112fb1689@linux.intel.com>
 <bf2ee997-1f53-0eef-40ad-1e98274da587@linux.intel.com>
 <20201106175427.GB2845264@google.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <389de3ef-2e1f-c569-d3c8-eebb4e6b6bd1@linux.intel.com>
Date:   Mon, 9 Nov 2020 14:04:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201106175427.GB2845264@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/7 1:54, Joel Fernandes wrote:
> On Fri, Nov 06, 2020 at 10:58:58AM +0800, Li, Aubrey wrote:
> 
>>>
>>> 	-- workload D, new added syscall workload, performance drop in cs_on:
>>> 	+----------------------+------+-------------------------------+
>>> 	|                      | **   | will-it-scale  * 192          |
>>> 	|                      |      | (pipe based context_switch)   |
>>> 	+======================+======+===============================+
>>> 	| cgroup               | **   | cg_will-it-scale              |
>>> 	+----------------------+------+-------------------------------+
>>> 	| record_item          | **   | threads_avg                   |
>>> 	+----------------------+------+-------------------------------+
>>> 	| coresched_normalized | **   | 0.2                           |
>>> 	+----------------------+------+-------------------------------+
>>> 	| default_normalized   | **   | 1                             |
>>> 	+----------------------+------+-------------------------------+
>>> 	| smtoff_normalized    | **   | 0.89                          |
>>> 	+----------------------+------+-------------------------------+
>>
>> will-it-scale may be a very extreme case. The story here is,
>> - On one sibling reader/writer gets blocked and tries to schedule another reader/writer in.
>> - The other sibling tries to wake up reader/writer.
>>
>> Both CPUs are acquiring rq->__lock,
>>
>> So when coresched off, they are two different locks, lock stat(1 second delta) below:
>>
>> class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>> &rq->__lock:          210            210           0.10           3.04         180.87           0.86            797       79165021           0.03          20.69    60650198.34           0.77
>>
>> But when coresched on, they are actually one same lock, lock stat(1 second delta) below:
>>
>> class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>> &rq->__lock:      6479459        6484857           0.05         216.46    60829776.85           9.38        8346319       15399739           0.03          95.56    81119515.38           5.27
>>
>> This nature of core scheduling may degrade the performance of similar workloads with frequent context switching.
> 
> When core sched is off, is SMT off as well? From the above table, it seems to
> be. So even for core sched off, there will be a single lock per physical CPU
> core (assuming SMT is also off) right? Or did I miss something?
> 

The table includes 3 cases:
- default:	SMT on,  coresched off
- coresched:	SMT on,  coresched on
- smtoff:	SMT off, coresched off

I was comparing the default(coresched off & SMT on) case with (coresched
on & SMT on) case.

If SMT off, then reader and writer on the different cores have different rq->lock,
so the lock contention is not that serious.

class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
&rq->__lock:           60             60           0.11           1.92          41.33           0.69            127       67184172           0.03          22.95    33160428.37           0.49

Does this address your concern?

Thanks,
-Aubrey

