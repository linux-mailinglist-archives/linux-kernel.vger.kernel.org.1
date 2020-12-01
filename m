Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9082CAAC1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392212AbgLASas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:30:48 -0500
Received: from mail.efficios.com ([167.114.26.124]:58922 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391625AbgLASaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:30:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8035B24C0D0;
        Tue,  1 Dec 2020 13:29:41 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eiuekbqyRmvJ; Tue,  1 Dec 2020 13:29:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 085C524C587;
        Tue,  1 Dec 2020 13:29:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 085C524C587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606847381;
        bh=9BQJZhFO8tdyg4wdmp7w+inWqo5ORdxMQeYqT4FiCGw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oCHVgpwcrcxpzs8iX6vFkmqh9HqHyNbZXbZAiCQMCiZ1wQiCz+31xquf7roYJIJxi
         lRfjaoZ9mo1UK6Sh4EBMbvhN8xAxyEFnP9sOIplXbBmhasD5zYlSYLiqIPfBKUEw8s
         9WBgyf09ZNdJbzxDGE34T8ynu58bvtwuAOvnaib4A6CdbjWxzyVzuTqfe8JTyEnDJ/
         HPcOzxcXiVVyDwl63mrxNzciZwt8CeFfKhK3tGDKy4uOScPAzc4ZS18Ncx1dTA2xlp
         MqWGTLn4P/kxx+VwutV+FHseMSns6VCavLaSos99yQvhp3r1xmjGlWQ0qoWeX1ZzrV
         24Auh9CibQZDw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xDoQQ6cd3Z9J; Tue,  1 Dec 2020 13:29:40 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id F05F524C398;
        Tue,  1 Dec 2020 13:29:40 -0500 (EST)
Date:   Tue, 1 Dec 2020 13:29:40 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Message-ID: <763536813.69859.1606847380892.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrVXG0A2NwiPY31G3uQYvVzbwFM80hFbVLWi8tb-_+k1dQ@mail.gmail.com>
References: <cover.1606758530.git.luto@kernel.org> <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org> <20201201101637.GU2414@hirez.programming.kicks-ass.net> <1044280457.69297.1606832917168.JavaMail.zimbra@efficios.com> <CALCETrVXG0A2NwiPY31G3uQYvVzbwFM80hFbVLWi8tb-_+k1dQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions
 more carefully
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
Thread-Index: mZ5ofS8BFWPmQNHhZ4PAUmTF9vPVzg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 1, 2020, at 1:12 PM, Andy Lutomirski luto@kernel.org wrote:

> On Tue, Dec 1, 2020 at 6:28 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Dec 1, 2020, at 5:16 AM, Peter Zijlstra peterz@infradead.org wr=
ote:
>>
>> > On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
>> >> membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
>> >> other CPUs, but there are two issues.
>> >>
>> >>  - membarrier() does not sync_core() or rseq_preempt() the calling
>> >>    CPU.  Aside from the logic being mind-bending, this also means
>> >>    that it may not be safe to modify user code through an alias,
>> >>    call membarrier(), and then jump to a different executable alias
>> >>    of the same code.
>> >
>> > I always understood this to be on purpose. The calling CPU can fix up
>> > itself just fine. The pain point is fixing up the other CPUs, and that=
's
>> > where membarrier() helps.
>>
>> Indeed, as documented in the man page:
>>
>>        MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE (since Linux 4.16)
>>               In  addition  to  providing  the  memory ordering guarante=
es de=E2=80=90
>>               scribed in MEMBARRIER_CMD_PRIVATE_EXPEDITED,  upon  return=
  from
>>               system call the calling thread has a guarantee that all it=
s run=E2=80=90
>>               ning thread siblings have executed a core  serializing  in=
struc=E2=80=90
>>               tion.   This  guarantee is provided only for threads in th=
e same
>>               process as the calling thread.
>>
>> membarrier sync core guarantees a core serializing instruction on the si=
blings,
>> not on the caller thread. This has been done on purpose given that the c=
aller
>> thread can always issue its core serializing instruction from user-space=
 on
>> its own.
>>
>> >
>> > That said, I don't mind including self, these aren't fast calls by any
>> > means.
>>
>> I don't mind including self either, but this would require documentation
>> updates, including man pages, to state that starting from kernel Y this
>> is the guaranteed behavior. It's then tricky for user-space to query wha=
t
>> the behavior is unless we introduce a new membarrier command for it. So =
this
>> could introduce issues if software written for the newer kernels runs on=
 older
>> kernels.
>=20
> For rseq at least, if we do this now we don't have this issue -- I
> don't think any released kernel has the rseq mode.

But for rseq, there is no core-sync. And considering that it is invalid
to issue a system call within an rseq critical section (including membarrie=
r),
I don't see what we gain by doing a rseq barrier on self ?

The only case where it really changes the semantic is for core-sync I think=
.
And in this case, it would be adding an additional core-sync on self. I
am OK with doing that considering that it will simplify use of the system
call. I'm just wondering how we should document this change in the man page=
.

>=20
>>
>> >
>> >>  - membarrier() does not explicitly sync_core() remote CPUs either;
>> >>    instead, it relies on the assumption that an IPI will result in a
>> >>    core sync.  On x86, I think this may be true in practice, but
>> >>    it's not architecturally reliable.  In particular, the SDM and
>> >>    APM do not appear to guarantee that interrupt delivery is
>> >>    serializing.
>> >
>> > Right, I don't think we rely on that, we do rely on interrupt delivery
>> > providing order though -- as per the previous email.
>> >
>> >>    On a preemptible kernel, IPI return can schedule,
>> >>    thereby switching to another task in the same mm that was
>> >>    sleeping in a syscall.  The new task could then SYSRET back to
>> >>    usermode without ever executing IRET.
>> >
>> > This; I think we all overlooked this scenario.
>>
>> Indeed, this is an issue which needs to be fixed.
>>
>> >
>> >> This patch simplifies the code to treat the calling CPU just like
>> >> all other CPUs, and explicitly sync_core() on all target CPUs.  This
>> >> eliminates the need for the smp_mb() at the end of the function
>> >> except in the special case of a targeted remote membarrier().  This
>> >> patch updates that code and the comments accordingly.
>>
>> I am not confident that removing the smp_mb at the end of membarrier is
>> an appropriate change, nor that it simplifies the model.
>=20
> Ah, but I didn't remove it.  I carefully made sure that every possible
> path through the function does an smp_mb() or stronger after all the
> cpu_rq reads.  ipi_func(), on_each_cpu(), and the explicit smp_mb()
> cover the three cases.
>=20
> That being said, if you prefer, I can make the change to skip the
> calling CPU, in which case I'll leave the smp_mb() at the end alone.

For the memory barrier commands, I prefer skipping self and leaving the
smp_mb at the very beginning/end of the system call. Those are the key
before/after points we are synchronizing against, and those are simple
to document.

For rseq, I would not mind calling the ipi callback on self, but I don't
see how useful it would be considering that issuing system calls within
rseq c.s. is invalid.

For core-sync, I agree that doing a core-sync on self would be an actual
simplification for users, but we should think about how we plan to update
the man page to convey that behavior change to end users.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
