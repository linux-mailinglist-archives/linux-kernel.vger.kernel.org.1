Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3592C068E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgKWMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:32:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46766 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbgKWMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:31:38 -0500
Received: from [192.168.86.179] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8231420B717A;
        Mon, 23 Nov 2020 04:31:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8231420B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606134697;
        bh=AnLY0dO2FA+3o6DtA4/k5Dy8gSbI6WdqCxQNTo/PGeg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ol3EZTG0iYy+uTvwrQazqr5gw6atBDLa/copkjN3MVYaM6My8pDN85RxPKO5XG48/
         9ODHKxwKpVlt3m7CaNVvJjrK4O2Ll1hzlrcHyFpRTH8myusv3sRs40ErugiV6SyS9d
         Q86ZiZ48wtTw2Z91jnEAsPIJsdRa+iFUz7Bjytbs=
Subject: Re: [PATCH -tip 09/32] sched/fair: Snapshot the min_vruntime of CPUs
 on force idle
To:     Balbir Singh <bsingharora@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-10-joel@joelfernandes.org>
 <20201122114442.GD110669@balbir-desktop>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <2cb42831-5074-e0a9-9e2a-f2a880504026@linux.microsoft.com>
Date:   Mon, 23 Nov 2020 07:31:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201122114442.GD110669@balbir-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

On 11/22/20 6:44 AM, Balbir Singh wrote:
>
> This seems cumbersome, is there no way to track the min_vruntime via
> rq->core->min_vruntime?
Do you mean to have a core wide min_vruntime? We had a
similar approach from v3 to v7 and it had major issues which
broke the assumptions of cfs. There were some lengthy
discussions and Peter explained in-depth about the issues:

https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net/
https://lwn.net/ml/linux-kernel/20200515103844.GG2978@hirez.programming.kicks-ass.net/

Thanks,
Vineeth

