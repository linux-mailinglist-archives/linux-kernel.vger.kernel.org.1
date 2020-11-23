Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30DA2C0E78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgKWPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:08:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:26410 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgKWPIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:08:15 -0500
IronPort-SDR: KNfySEUXrYAEO9bl1t7Z1gKXMVVz5OIG9IAtmzFGX2EaCkuxPdGdfDmr2NZymQDW7GvwXb9mis
 DxUPnTiM+UhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="233392218"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="233392218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 07:07:42 -0800
IronPort-SDR: cbpRnnDiGC+ADzV6wkpZf+wuU5o4eXn6jQfqQVU1c01mt3iP42dFZH+n7np7TMUlZWGG4q6b6U
 w2FnspVNoUhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="370063566"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2020 07:07:27 -0800
Subject: Re: [PATCH -tip 13/32] sched: Trivial forced-newidle balancer
To:     Balbir Singh <bsingharora@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-14-joel@joelfernandes.org>
 <20201123043836.GG110669@balbir-desktop>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <1de89fd3-fb5f-5aaa-8ea6-7a12d3307fa4@linux.intel.com>
Date:   Mon, 23 Nov 2020 23:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201123043836.GG110669@balbir-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/23 12:38, Balbir Singh wrote:
> On Tue, Nov 17, 2020 at 06:19:43PM -0500, Joel Fernandes (Google) wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> When a sibling is forced-idle to match the core-cookie; search for
>> matching tasks to fill the core.
>>
>> rcu_read_unlock() can incur an infrequent deadlock in
>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
>>
> ...
>> +
>> +		if (p->core_occupation > dst->idle->core_occupation)
>> +			goto next;
>> +
> 
> I am unable to understand this check, a comment or clarification in the
> changelog will help. I presume we are looking at either one or two cpus
> to define the core_occupation and we expect to match it against the
> destination CPU.

IIUC, this check prevents a task from keeping jumping among the cores forever.

For example, on a SMT2 platform:
- core0 runs taskA and taskB, core_occupation is 2
- core1 runs taskC, core_occupation is 1

Without this check, taskB could ping-pong between core0 and core1 by core load
balance.

Thanks,
-Aubrey


