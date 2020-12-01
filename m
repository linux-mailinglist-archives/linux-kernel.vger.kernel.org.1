Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711C62CA5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbgLAObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:31:52 -0500
Received: from mail.efficios.com ([167.114.26.124]:46864 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403838AbgLAObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:31:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3EE8B24A05B;
        Tue,  1 Dec 2020 09:31:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zp-zAbuMb8LL; Tue,  1 Dec 2020 09:31:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E5F5624A0E8;
        Tue,  1 Dec 2020 09:31:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E5F5624A0E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606833070;
        bh=w+uCQn+uiG4OM+pnjOLmVNu5uR+sA9gE92dXLy23mHc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZBZveTWArYuxC2SJMqPxOmfjOjslj34TEIpBDGIQWXV4pZR1KSi94oe4hMQCLGqAr
         F77SSgOmMGdyX7YCRPt72uHleHFfkfzi1ZJgv92dfAMmdwuD2y2v0xys6C106UVD2G
         2VtijrIIjd0OhDWxjVYWI+ILCGQyDrKw+NsvXkenvSIfWdjnldjcO6rrDlQGaVifOP
         Y8Cchq+CY4++8N7GIbb/9vRf6I4mPQdAGEh4tEqXt2xcy9LgFB0YUTGQPNK5j4V1Xr
         EAm3KMe/hGEx2lLMtXMSK8ti1tI+NeFp4X4L565tL+iRt2TyDepHPbRZzVIAFCIIl4
         MN4mUbhcm3cOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lLm7LhGwHE0L; Tue,  1 Dec 2020 09:31:10 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D9B6324A0E7;
        Tue,  1 Dec 2020 09:31:10 -0500 (EST)
Date:   Tue, 1 Dec 2020 09:31:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1317667456.69303.1606833070872.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201201100604.GT2414@hirez.programming.kicks-ass.net>
References: <cover.1606758530.git.luto@kernel.org> <c67b85690f9cb42d1e92db30e19c78e872bdd0e4.1606758530.git.luto@kernel.org> <20201201100604.GT2414@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 2/3] membarrier: Add an actual barrier before
 rseq_preempt()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3975)
Thread-Topic: membarrier: Add an actual barrier before rseq_preempt()
Thread-Index: hzWFZRyWKU9/D8FUUep59auxTPoqpg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 1, 2020, at 5:06 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Nov 30, 2020 at 09:50:34AM -0800, Andy Lutomirski wrote:
>> It seems to be that most RSEQ membarrier users will expect any
>> stores done before the membarrier() syscall to be visible to the
>> target task(s).  While this is extremely likely to be true in
>> practice, nothing actually guarantees it by a strict reading of the
>> x86 manuals.  Rather than providing this guarantee by accident and
>> potentially causing a problem down the road, just add an explicit
>> barrier.
> 
> A very long time ago; when Jens introduced smp_call_function(), we had
> this discussion. At the time Linus said that receiving an interrupt had
> better be ordering, and if it is not, then it's up to the architecture
> to handle that before it gets into the common code.
> 
>  https://lkml.kernel.org/r/alpine.LFD.2.00.0902180744520.21686@localhost.localdomain
> 
> Maybe we want to revisit this now, but there might be a fair amount of
> code relying on all this by now.
> 
> Documenting it better might help.

Considering that we already have this in membarrier ipi_mb :

static void ipi_mb(void *info)
{
        smp_mb();       /* IPIs should be serializing but paranoid. */
}

I think it makes sense to add this same smp_mb() in the ipi_rseq if the expected
behavior is to order memory accesses as well, and have the same level of paranoia as
the ipi_mb.

Thanks,

Mathieu


> 
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>>  kernel/sched/membarrier.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>> index e23e74d52db5..7d98ef5d3bcd 100644
>> --- a/kernel/sched/membarrier.c
>> +++ b/kernel/sched/membarrier.c
>> @@ -40,6 +40,14 @@ static void ipi_mb(void *info)
>>  
>>  static void ipi_rseq(void *info)
>>  {
>> +	/*
>> +	 * Ensure that all stores done by the calling thread are visible
>> +	 * to the current task before the current task resumes.  We could
>> +	 * probably optimize this away on most architectures, but by the
>> +	 * time we've already sent an IPI, the cost of the extra smp_mb()
>> +	 * is negligible.
>> +	 */
>> +	smp_mb();
>>  	rseq_preempt(current);
>>  }
> 
> So I think this really isn't right.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
