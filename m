Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AE293D15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407171AbgJTNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:14:25 -0400
Received: from mail.efficios.com ([167.114.26.124]:56014 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406356AbgJTNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:14:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DD10B2D90A9;
        Tue, 20 Oct 2020 09:14:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id btWyCFkNN-w8; Tue, 20 Oct 2020 09:14:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 681AA2D9203;
        Tue, 20 Oct 2020 09:14:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 681AA2D9203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603199662;
        bh=RoS4rPfU2u/tfMg7hbLKT1RRo0ZxH9EU5RKB+8Fbfzo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=h7srYtYZpww321ht16yIrXnqb3MLoN1fNJYbztRAheglOZSNQoOUvBULqjvx2RdMT
         EHpNWkWmU33FqcQ1gyfFH4hzaQkXxveTtC0tfJlNg3eZuILmPO3CVZGNq/XBzkSYea
         WV2TBmAykJ9vhFE3P6ZLnlOp7JHQE0qTi6/86MTZ3loXOq3Y3nvyFDF04Giq7ucyt4
         9AI4TAXrktNEyCx/U8VRMoKaBkOZeAW4S9hYGyNo7g8PjG8K44D5A4JWZFADK04C6d
         DtfH9vyYqgPxmEkChZLrwt4GHTagh8ULte70e9ZxYW1j6JOBnJbl5kfgU/laWk6c+Y
         52f/L/5TufB/A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rtFVh_JWgtH5; Tue, 20 Oct 2020 09:14:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 54CAE2D8EC4;
        Tue, 20 Oct 2020 09:14:22 -0400 (EDT)
Date:   Tue, 20 Oct 2020 09:14:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>, lkp <lkp@lists.01.org>,
        zhengjun xing <zhengjun.xing@intel.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Message-ID: <510309749.29852.1603199662203.JavaMail.zimbra@efficios.com>
In-Reply-To: <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com>
References: <20201002083311.GK393@shao2-debian> <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com> <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com>
Subject: Re: [LKP] Re: [sched] bdfcae1140: will-it-scale.per_thread_ops
 -37.0% regression
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: bdfcae1140: will-it-scale.per_thread_ops -37.0% regression
Thread-Index: A5GaeQYvMp8BfdfxguQDCHYcc/gonQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 19, 2020, at 11:24 PM, Xing Zhengjun zhengjun.xing@linux.intel=
.com wrote:

> On 10/7/2020 10:50 PM, Mathieu Desnoyers wrote:
>> ----- On Oct 2, 2020, at 4:33 AM, Rong Chen rong.a.chen@intel.com wrote:
>>=20
>>> Greeting,
>>>
>>> FYI, we noticed a -37.0% regression of will-it-scale.per_thread_ops due=
 to
>>> commit:
>>>
>>>
>>> commit: bdfcae11403e5099769a7c8dc3262e3c4193edef ("[RFC PATCH 2/3] sche=
d:
>>> membarrier: cover kthread_use_mm (v3)")
>>> url:
>>> https://github.com/0day-ci/linux/commits/Mathieu-Desnoyers/Membarrier-u=
pdates/20200925-012549
>>> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git
>>> 848785df48835eefebe0c4eb5da7690690b0a8b7
>>>
>>> in testcase: will-it-scale
>>> on test machine: 104 threads Skylake with 192G memory
>>> with following parameters:
>>>
>>> =09nr_task: 50%
>>> =09mode: thread
>>> =09test: context_switch1
>>> =09cpufreq_governor: performance
>>> =09ucode: 0x2006906
>>>
>>> test-description: Will It Scale takes a testcase and runs it from 1 thr=
ough to n
>>> parallel copies to see if the testcase will scale. It builds both a pro=
cess and
>>> threads based test in order to see any differences between the two.
>>> test-url: https://github.com/antonblanchard/will-it-scale
>>>
>>=20
>> Hi,
>>=20
>> I would like to report what I suspect is a random thread placement issue=
 in the
>> context_switch1 test used by the 0day bot when running on a machine with
>> hyperthread
>> enabled.
>>=20
>> AFAIU the test code uses hwloc for thread placement which should theoret=
ically
>> ensure
>> that each thread is placed on same processing unit, core and numa node b=
etween
>> runs.
>>=20
>> We can find the test code here:
>>=20
>> https://github.com/antonblanchard/will-it-scale/blob/master/tests/contex=
t_switch1.c
>>=20
>> And the main file containing thread setup is here:
>>=20
>> https://github.com/antonblanchard/will-it-scale/blob/master/main.c
>>=20
>> AFAIU, the test is started without the "-m" switch, which therefore affi=
nitizes
>> tasks on cores rather than on processing units (SMT threads).
>>=20
>> When testcase() creates the child thread with new_task(), it basically i=
ssues:
>>=20
>>    pthread_create(&threads[nr_threads++], NULL, func, arg);
>>=20
>> passing a NULL pthread_attr_t, and not executing any pre_trampoline on t=
he
>> child.
>> The pre_trampoline would have issued hwloc_set_thread_cpubind if it were
>> executed on
>> the child, but it's not. Therefore, we expect the cpu affinity mask of t=
he
>> parent to
>> be copied on clone and used by the child.
>>=20
>> A quick test on a machine with hyperthreading enabled shows that the cpu
>> affinity mask
>> for the parent and child has two bits set:
>>=20
>> taskset -p 1868607
>> pid 1868607's current affinity mask: 10001
>> taskset -p 1868606
>> pid 1868606's current affinity mask: 10001
>>=20
>> So AFAIU the placement of the parent and child will be random on either =
the same
>> processing unit, or on separate processing units within the same core.
>>=20
>> I suspect this randomness can significantly affect the performance numbe=
r
>> between
>> runs, and trigger unwarranted performance regression warnings.
>>=20
>> Thanks,
>>=20
>> Mathieu
>>=20
> Yes, the randomness may happen in some special cases.  But in 0-day, we
> test multi times (>=3D3), the report is the average number.
> For this case, we test 4 times, it is stable, the wave is =C2=B1  2%.
> So I don't think the -37.0% regression is caused by the randomness.
>=20
> 0/stats.json:  "will-it-scale.per_thread_ops": 105228,
> 1/stats.json:  "will-it-scale.per_thread_ops": 100443,
> 2/stats.json:  "will-it-scale.per_thread_ops": 98786,
> 3/stats.json:  "will-it-scale.per_thread_ops": 102821,
>=20
> c2daff748f0ea954 bdfcae11403e5099769a7c8dc32
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     161714 =C2=B1  2%     -37.0%     101819 =C2=B1  2%  will-it-scale.per=
_thread_ops

Arguing whether this specific instance of the test is indeed a performance
regression or not is not relevant to this discussion.

What I am pointing out here is that the test needs fixing because it genera=
tes
noise due to a random thread placement configuration. This issue is about w=
hether
we can trust the results of those tests as kernel maintainers.

So on one hand, you can fix the test. This is simple to do: make sure the t=
hread
affinity does not allow for this randomness on SMT.

But you seem to argue that the test does not need to be fixed, because the =
0day
infrastructure in which it runs will cover for this randomness. I really do=
ubt
about this.

If you indeed choose to argue that the test does not need fixing, then here=
 is the
statistical analysis I am looking for:

- With the 4 runs, what are the odds that the average result for one class =
significantly
  differs from the other class due to this randomness. It may be small, but=
 it is certainly
  not zero,
- Based on those odds, and on the number of performance regression tests pe=
rformed by 0day
  each year, how frequently does 0day end up spamming kernel developers wit=
h random results
  because of this randomness ?

That being said, I would really find more productive that we work together =
on fixing the
test rather than justifying why it can stay broken. Let me know if you have=
 specific
questions on how to fix the test, and I'll be happy to help out.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
