Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707EE2CADC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgLAUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:52:25 -0500
Received: from mail.efficios.com ([167.114.26.124]:44904 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLAUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:52:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3AE2A24D745;
        Tue,  1 Dec 2020 15:51:43 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X-8xt0--RzPR; Tue,  1 Dec 2020 15:51:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B557124D827;
        Tue,  1 Dec 2020 15:51:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B557124D827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606855902;
        bh=z0Vthxi3itmU/YTFu/3BgzBQQ+djft5+q0IiDG3o8ds=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tOGrSiiYey//0Afs6r6l/eiFEcqFVFRug28gcLrsTMopMJobT/t07ZqQ2UToNDDuS
         V5jsiFaOe6e2keNHvFSgNc4+HiRMNTHoAcvN5ksmxi8xFSPzE1A2ZQbmQi0ZhGnyoM
         znKqj9JRMBxeUduCe4iUQS1ahNSYwlMyuYF5QkhF0a84FRLUW0ovLPuPhyQE56NR1t
         rWzk4aIlutDo28P+0lkX4A7mi3WaucSHf1BWarMKd0wGX9F/0jDODlEgoUwjXCBCSk
         08yqnMhmp/iLJW+OI8jD5lF9ndzfZ8ZkU7HAPQlpaFufqFwSiwB+owjNy06aineamy
         wbfl3ZelCY4IA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mEF35TKAlci8; Tue,  1 Dec 2020 15:51:42 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 94A0624D7B4;
        Tue,  1 Dec 2020 15:51:42 -0500 (EST)
Date:   Tue, 1 Dec 2020 15:51:42 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Message-ID: <466812913.70175.1606855902511.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrUPiBOUEwJsLb8n0DJkHpTAYkFXJQuJ7swuRankvCzrRg@mail.gmail.com>
References: <cover.1606758530.git.luto@kernel.org> <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org> <20201201101637.GU2414@hirez.programming.kicks-ass.net> <1044280457.69297.1606832917168.JavaMail.zimbra@efficios.com> <CALCETrVXG0A2NwiPY31G3uQYvVzbwFM80hFbVLWi8tb-_+k1dQ@mail.gmail.com> <763536813.69859.1606847380892.JavaMail.zimbra@efficios.com> <CALCETrUPiBOUEwJsLb8n0DJkHpTAYkFXJQuJ7swuRankvCzrRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions
 more carefully
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
Thread-Index: jjs5eM8xrz4RIu7TlLBMd6QlibfXew==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 1, 2020, at 1:48 PM, Andy Lutomirski luto@kernel.org wrote:

> On Tue, Dec 1, 2020 at 10:29 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Dec 1, 2020, at 1:12 PM, Andy Lutomirski luto@kernel.org wrote:
>>
>> > On Tue, Dec 1, 2020 at 6:28 AM Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >>
>> >> ----- On Dec 1, 2020, at 5:16 AM, Peter Zijlstra peterz@infradead.org=
 wrote:
>> >>
>> >> > On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
>> >> >> membarrier() carefully propagates SYNC_CORE and RSEQ actions to al=
l
>> >> >> other CPUs, but there are two issues.
>> >> >>
>> >> >>  - membarrier() does not sync_core() or rseq_preempt() the calling
>> >> >>    CPU.  Aside from the logic being mind-bending, this also means
>> >> >>    that it may not be safe to modify user code through an alias,
>> >> >>    call membarrier(), and then jump to a different executable alia=
s
>> >> >>    of the same code.
>> >> >
>> >> > I always understood this to be on purpose. The calling CPU can fix =
up
>> >> > itself just fine. The pain point is fixing up the other CPUs, and t=
hat's
>> >> > where membarrier() helps.
>> >>
>> >> Indeed, as documented in the man page:
>> >>
>> >>        MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE (since Linux 4.16)
>> >>               In  addition  to  providing  the  memory ordering guara=
ntees de=E2=80=90
>> >>               scribed in MEMBARRIER_CMD_PRIVATE_EXPEDITED,  upon  ret=
urn  from
>> >>               system call the calling thread has a guarantee that all=
 its run=E2=80=90
>> >>               ning thread siblings have executed a core  serializing =
 instruc=E2=80=90
>> >>               tion.   This  guarantee is provided only for threads in=
 the same
>> >>               process as the calling thread.
>> >>
>> >> membarrier sync core guarantees a core serializing instruction on the=
 siblings,
>> >> not on the caller thread. This has been done on purpose given that th=
e caller
>> >> thread can always issue its core serializing instruction from user-sp=
ace on
>> >> its own.
>> >>
>> >> >
>> >> > That said, I don't mind including self, these aren't fast calls by =
any
>> >> > means.
>> >>
>> >> I don't mind including self either, but this would require documentat=
ion
>> >> updates, including man pages, to state that starting from kernel Y th=
is
>> >> is the guaranteed behavior. It's then tricky for user-space to query =
what
>> >> the behavior is unless we introduce a new membarrier command for it. =
So this
>> >> could introduce issues if software written for the newer kernels runs=
 on older
>> >> kernels.
>> >
>> > For rseq at least, if we do this now we don't have this issue -- I
>> > don't think any released kernel has the rseq mode.
>>
>> But for rseq, there is no core-sync. And considering that it is invalid
>> to issue a system call within an rseq critical section (including membar=
rier),
>> I don't see what we gain by doing a rseq barrier on self ?
>>
>> The only case where it really changes the semantic is for core-sync I th=
ink.
>> And in this case, it would be adding an additional core-sync on self. I
>> am OK with doing that considering that it will simplify use of the syste=
m
>> call. I'm just wondering how we should document this change in the man p=
age.
>>
>> >
>> >>
>> >> >
>> >> >>  - membarrier() does not explicitly sync_core() remote CPUs either=
;
>> >> >>    instead, it relies on the assumption that an IPI will result in=
 a
>> >> >>    core sync.  On x86, I think this may be true in practice, but
>> >> >>    it's not architecturally reliable.  In particular, the SDM and
>> >> >>    APM do not appear to guarantee that interrupt delivery is
>> >> >>    serializing.
>> >> >
>> >> > Right, I don't think we rely on that, we do rely on interrupt deliv=
ery
>> >> > providing order though -- as per the previous email.
>> >> >
>> >> >>    On a preemptible kernel, IPI return can schedule,
>> >> >>    thereby switching to another task in the same mm that was
>> >> >>    sleeping in a syscall.  The new task could then SYSRET back to
>> >> >>    usermode without ever executing IRET.
>> >> >
>> >> > This; I think we all overlooked this scenario.
>> >>
>> >> Indeed, this is an issue which needs to be fixed.
>> >>
>> >> >
>> >> >> This patch simplifies the code to treat the calling CPU just like
>> >> >> all other CPUs, and explicitly sync_core() on all target CPUs.  Th=
is
>> >> >> eliminates the need for the smp_mb() at the end of the function
>> >> >> except in the special case of a targeted remote membarrier().  Thi=
s
>> >> >> patch updates that code and the comments accordingly.
>> >>
>> >> I am not confident that removing the smp_mb at the end of membarrier =
is
>> >> an appropriate change, nor that it simplifies the model.
>> >
>> > Ah, but I didn't remove it.  I carefully made sure that every possible
>> > path through the function does an smp_mb() or stronger after all the
>> > cpu_rq reads.  ipi_func(), on_each_cpu(), and the explicit smp_mb()
>> > cover the three cases.
>> >
>> > That being said, if you prefer, I can make the change to skip the
>> > calling CPU, in which case I'll leave the smp_mb() at the end alone.
>>
>> For the memory barrier commands, I prefer skipping self and leaving the
>> smp_mb at the very beginning/end of the system call. Those are the key
>> before/after points we are synchronizing against, and those are simple
>> to document.
>>
>=20
> Is there a reason that doing the barrier at the very end could make an
> observable difference?  The two models are:
>=20
> membarrier() {
> smp_mb();
> read a bunch of cpu_rq memory and make decisions;
> execute smp_mb() on relevant cpus including self;

you forget the fact that you also add a smp_mb() after each
individual IPI returns, which is why you can get away with removing
the smp_mb at the end of the membarrier syscall without introducing
issues.

> }
>=20
> versus
>=20
> membarrier() {
> smp_mb();
> read a bunch of cpu_rq memory and make decisions;
> execute smp_mb() on relevant non-self cpus;
> wait for that to finish (acquire-style on the local cpu);
> smp_mb();
> }
>=20
> Is the idea that, on a sufficiently weakly ordered architecture, some
> remote CPU could do a store before the IPI and a local load after the
> membarrier() syscall might not observe the load unless the local
> smp_mb() is after the remote smp_mb()?  If so, I'm not entirely
> convinced that this is observably different from the store simply
> occurring after the IPI, but maybe there are some gnarly situations in
> which this could happen.
>=20
> If your concern is something along these lines, I could try to write
> up an appropriate comment, and I'll rework the patch.

This is already documented in the scenarios I added as comments in the
patch sitting in the tip tree:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D25=
595eb6aaa9fbb31330f1e0b400642694bc6574

See "Scenario B Userspace thread execution before IPI vs membarrier's memor=
y barrier after completing the IPI"

I think the change you proposed would be technically still OK:

- The callback on self issuing the smp_mb would take care of ensuring
  that at least one memory barrier is issued after loading rq->curr
  state for each cpu.
- The smp_mb after each ipi return would ensure we have barrier ordering
  between the smp_mb in the ipi handler / before the membarrier system
  call returns to userspace.

But then rather than having one clear spot where the smp_mb needs to be
placed and documented, we have a more complex maze of conditions we need
to consider. Hence my preference for keeping the smp_mb at the beginning/en=
d
of the membarrier system call.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
