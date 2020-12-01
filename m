Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF7E2CA5A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbgLAO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:29:19 -0500
Received: from mail.efficios.com ([167.114.26.124]:46094 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbgLAO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:29:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9745924A048;
        Tue,  1 Dec 2020 09:28:37 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z0KeAYIvZel1; Tue,  1 Dec 2020 09:28:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3BA9B24A047;
        Tue,  1 Dec 2020 09:28:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3BA9B24A047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606832917;
        bh=tUMrEQS+mM+DZAT54GQKjCuKqNvSCt1/DPnHQBBoMR8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MrxMR+nBR/lHpOICZdn8OnN1CrIIpX5NsLubR3i8dueTUT7z9P06WB4NpbZnZFqIa
         uQnxusLQ79qCEXNjX8IEbMyvqIlwo9HHsY87mCgkbjvVO9OJEvoa9539a9BUcg3SS4
         XYqc9zc4oDG6z3IymjiFsNTj/x3PM7ehARedd7D+DsG6i24wlsLGo2rdvNhmBxLo0T
         lcQa8A4lIwILvUha/ygwSSTLQDYK+l1naWwaetW2HKwVE834t7nRvxfxUTyQhB9uS+
         2H+19UWsRbgwVTyrGKmFsoSXmfAWxEYYroCUX6vcAiV+MM92Ra4TZ1ZKCuGoHcELCB
         O2OFuEQrY9nXQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G_nkrCqjr43a; Tue,  1 Dec 2020 09:28:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2F88A24A046;
        Tue,  1 Dec 2020 09:28:37 -0500 (EST)
Date:   Tue, 1 Dec 2020 09:28:37 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Message-ID: <1044280457.69297.1606832917168.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201201101637.GU2414@hirez.programming.kicks-ass.net>
References: <cover.1606758530.git.luto@kernel.org> <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org> <20201201101637.GU2414@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions
 more carefully
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: membarrier: Propagate SYNC_CORE and RSEQ actions more carefully
Thread-Index: ifu8X9gaDbM0bIT/43o5jEK+9Fz38g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 1, 2020, at 5:16 AM, Peter Zijlstra peterz@infradead.org wrote=
:

> On Mon, Nov 30, 2020 at 09:50:35AM -0800, Andy Lutomirski wrote:
>> membarrier() carefully propagates SYNC_CORE and RSEQ actions to all
>> other CPUs, but there are two issues.
>>=20
>>  - membarrier() does not sync_core() or rseq_preempt() the calling
>>    CPU.  Aside from the logic being mind-bending, this also means
>>    that it may not be safe to modify user code through an alias,
>>    call membarrier(), and then jump to a different executable alias
>>    of the same code.
>=20
> I always understood this to be on purpose. The calling CPU can fix up
> itself just fine. The pain point is fixing up the other CPUs, and that's
> where membarrier() helps.

Indeed, as documented in the man page:

       MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE (since Linux 4.16)
              In  addition  to  providing  the  memory ordering guarantees =
de=E2=80=90
              scribed in MEMBARRIER_CMD_PRIVATE_EXPEDITED,  upon  return  f=
rom
              system call the calling thread has a guarantee that all its r=
un=E2=80=90
              ning thread siblings have executed a core  serializing  instr=
uc=E2=80=90
              tion.   This  guarantee is provided only for threads in the s=
ame
              process as the calling thread.

membarrier sync core guarantees a core serializing instruction on the sibli=
ngs,
not on the caller thread. This has been done on purpose given that the call=
er
thread can always issue its core serializing instruction from user-space on
its own.

>=20
> That said, I don't mind including self, these aren't fast calls by any
> means.

I don't mind including self either, but this would require documentation
updates, including man pages, to state that starting from kernel Y this
is the guaranteed behavior. It's then tricky for user-space to query what
the behavior is unless we introduce a new membarrier command for it. So thi=
s
could introduce issues if software written for the newer kernels runs on ol=
der
kernels.

>=20
>>  - membarrier() does not explicitly sync_core() remote CPUs either;
>>    instead, it relies on the assumption that an IPI will result in a
>>    core sync.  On x86, I think this may be true in practice, but
>>    it's not architecturally reliable.  In particular, the SDM and
>>    APM do not appear to guarantee that interrupt delivery is
>>    serializing.
>=20
> Right, I don't think we rely on that, we do rely on interrupt delivery
> providing order though -- as per the previous email.
>=20
>>    On a preemptible kernel, IPI return can schedule,
>>    thereby switching to another task in the same mm that was
>>    sleeping in a syscall.  The new task could then SYSRET back to
>>    usermode without ever executing IRET.
>=20
> This; I think we all overlooked this scenario.

Indeed, this is an issue which needs to be fixed.

>=20
>> This patch simplifies the code to treat the calling CPU just like
>> all other CPUs, and explicitly sync_core() on all target CPUs.  This
>> eliminates the need for the smp_mb() at the end of the function
>> except in the special case of a targeted remote membarrier().  This
>> patch updates that code and the comments accordingly.

I am not confident that removing the smp_mb at the end of membarrier is
an appropriate change, nor that it simplifies the model.

This changes things from a model where we have a barrier at the beginning
and end of the membarrier system call, which nicely orders things happening
before/after the system call with respect to anything that is observed with=
in
the system call (including the scheduler activity updating the runqueue's
current task), to a model where the memory barrier for the current thread
will be conditionally executed after we have sent the IPIs, and uncondition=
ally
when issuing smp_call_function* on self.

About the documentation of the membarrier scenario, I think it is redundant
with a documentation patch I already have sitting in -tip (scenario A):

https://git.kernel.org/tip/25595eb6aaa9fbb31330f1e0b400642694bc6574

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
