Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67E927F55E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgI3Wqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:46:44 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:14012 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbgI3Wqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601506003; x=1633042003;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=F/SbDhmGbWiPKTxysvIcGmIlg1dJ3vja/M6Ue4Qkg+E=;
  b=VZOpjgINOfXzDFOLUznYetC7QT/O9C3jwVrrSzuC0Z41QGE2OUGcnx97
   vyo26+jTSE6G47FOaPOQH9I487/D43xWHLBr/1TKMHlK8SlBz9KVCSckH
   zbYC18jR0pMgIC+GfETcdb/YUaq65pHrYbB4o2dkCkZoCug+Ovq81+mla
   A=;
X-IronPort-AV: E=Sophos;i="5.77,322,1596499200"; 
   d="scan'208";a="58732394"
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars in
 enable_l1d_flush_for_task()
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 30 Sep 2020 22:46:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 7D3A0A1BD0;
        Wed, 30 Sep 2020 22:46:36 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 30 Sep 2020 22:46:35 +0000
Received: from f8ffc2228008.ant.amazon.com (10.43.161.146) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 30 Sep 2020 22:46:32 +0000
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com>
 <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
 <20200929083709.GC2651@hirez.programming.kicks-ass.net>
 <87eemji887.fsf@nanos.tec.linutronix.de>
 <20200930170316.GB2628@hirez.programming.kicks-ass.net>
 <87blhni1pg.fsf@nanos.tec.linutronix.de>
From:   "Singh, Balbir" <sblbir@amazon.com>
Message-ID: <7785b27b-1a88-c7f0-ae47-f4f75876cb83@amazon.com>
Date:   Thu, 1 Oct 2020 08:46:29 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <87blhni1pg.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D46UWB002.ant.amazon.com (10.43.161.70) To
 EX13d01UWB002.ant.amazon.com (10.43.161.136)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 4:00 am, Thomas Gleixner wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Sep 30 2020 at 19:03, Peter Zijlstra wrote:
>> On Wed, Sep 30, 2020 at 05:40:08PM +0200, Thomas Gleixner wrote:
>> Also, that preempt_disable() in there doesn't actually do anything.
>> Worse, preempt_disable(); for_each_cpu(); is an anti-pattern. It mixes
>> static_cpu_has() and boot_cpu_has() in the same bloody condition and has
>> a pointless ret variable.
> 

I was being a bit crazy in mixing the two, considering that there might
be CPUs that do not support L1D flush (others might in the same system,
which is insane)

> I absolutely agree and I really missed it when looking at it before
> merging. cpus_read_lock()/unlock() is the right thing to do if at all.
> 

It seems like the right thing to do, get_cpu() used to be the old method.
The idea is to use cpu_data(i) in a hotplug safe manner.

>> It's shoddy code, that only works if you align the planets right. We
>> really shouldn't provide interfaces that are this bad.
>>
>> It's correct operation is only by accident.



> 
> True :(
> 
> I understand Balbirs problem and it makes some sense to provide a
> solution. We can:
> 
>     1) reject set_affinity() if the task has that flush muck enabled
>        and user space tries to move it to a SMT enabled core

I thought of this and it would be difficult to debug for users, taskset -c
would not work on applications that flush, etc, etc.

> 
>     2) disable the muck if if detects that it is runs on a SMT enabled
>        core suddenly (hotplug says hello)
> 
>        This one is nasty because there is no feedback to user space
>        about the wreckage.

Yes, agreed.

> 

Trying to look at the concerns, I wonder if this can still be saved

-       if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
-                       !static_cpu_has(X86_FEATURE_FLUSH_L1D))
+       if (!static_cpu_has(X86_BUG_L1TF) ||
+               !static_cpu_has(X86_FEATURE_FLUSH_L1D))
                return -EINVAL;

-       cpu = get_cpu();

+       cpus_read_lock();
        for_each_cpu(i, &tsk->cpus_mask) {
                if (cpu_data(i).smt_active == true) {
-                       put_cpu();
+                       cpus_read_unlock();
                        return -EINVAL;
                }
        }
+       cpus_read_unlock();

        set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
-       put_cpu();
        return ret;
 }

I don't like the idea of iterating CPUs in the cpumask to check if they
all have SMT disabled, but that is a requirement for flush

Balbir
