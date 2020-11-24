Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57D52C1A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgKXAcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:32:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:22890 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgKXAcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:32:14 -0500
IronPort-SDR: 0VmygGDkd/fzXaTrPe90NrF91HRqyPrzyTJCaSRyfghZvYJpoUqCob32ZJZhcgGx8Fo+t9NkkH
 sQml2WGUGChA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168358141"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="168358141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 16:32:12 -0800
IronPort-SDR: aFDIjmEnv5l91rhGRODEcHOmW4Zjzq8UfIEWs3FEMGOjy3Alez342mKSMAv5nqf26VTO46T/Tp
 9KR9a0eLpVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="370232786"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2020 16:32:02 -0800
Subject: Re: [PATCH -tip 13/32] sched: Trivial forced-newidle balancer
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-14-joel@joelfernandes.org>
 <20201123043836.GG110669@balbir-desktop>
 <1de89fd3-fb5f-5aaa-8ea6-7a12d3307fa4@linux.intel.com>
 <20201123233508.GC8893@balbir-desktop>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <2277bfa9-7f67-6b66-b2db-a2130993de53@linux.intel.com>
Date:   Tue, 24 Nov 2020 08:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201123233508.GC8893@balbir-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/24 7:35, Balbir Singh wrote:
> On Mon, Nov 23, 2020 at 11:07:27PM +0800, Li, Aubrey wrote:
>> On 2020/11/23 12:38, Balbir Singh wrote:
>>> On Tue, Nov 17, 2020 at 06:19:43PM -0500, Joel Fernandes (Google) wrote:
>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>
>>>> When a sibling is forced-idle to match the core-cookie; search for
>>>> matching tasks to fill the core.
>>>>
>>>> rcu_read_unlock() can incur an infrequent deadlock in
>>>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
>>>>
>>> ...
>>>> +
>>>> +		if (p->core_occupation > dst->idle->core_occupation)
>>>> +			goto next;
>>>> +
>>>
>>> I am unable to understand this check, a comment or clarification in the
>>> changelog will help. I presume we are looking at either one or two cpus
>>> to define the core_occupation and we expect to match it against the
>>> destination CPU.
>>
>> IIUC, this check prevents a task from keeping jumping among the cores forever.
>>
>> For example, on a SMT2 platform:
>> - core0 runs taskA and taskB, core_occupation is 2
>> - core1 runs taskC, core_occupation is 1
>>
>> Without this check, taskB could ping-pong between core0 and core1 by core load
>> balance.
> 
> But the comparison is p->core_occuption (as in tasks core occuptation,
> not sure what that means, can a task have a core_occupation of > 1?)
>

p->core_occupation is assigned to the core occupation in the last pick_next_task.
(so yes, it can have a > 1 core_occupation).

Thanks,
-Aubrey
