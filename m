Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECC28634E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgJGQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:11:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:51206 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgJGQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:11:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1A58D2B8651;
        Wed,  7 Oct 2020 12:11:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tBzGdLgqvcCu; Wed,  7 Oct 2020 12:11:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D21952B85E4;
        Wed,  7 Oct 2020 12:11:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D21952B85E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1602087117;
        bh=hfE8xoMzk2rZlGNiZfezrG3s6wNnQmV27IkPLpxJX+o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Df92b7JbHZYlYzoF5l73loGU4v0wQv9ewtE8xQ0RnxNcJNuaFdd7GCUuTtFQ9Z7g2
         tT1Hb1QZp+OtmMlGvyCtqSot03hNrWbJ8C5VZYNbrOs6gF0y5WGixezKMN8ZyVBGeu
         y9c1Q5VpH0LTwUAYLaf+tDRkVvLNXvQKXMJpijDofsi1Wiw2ehIFn+idrRXUVbdiBC
         jMUHsg8dQsbx+CZjqyX+CkFx/T8LqE7rWB0s8bH5dTfjq4EJrFiRieaL6e70BmuSVl
         UrGGqioz1gZooHBpEp8Xj7Daf81FX4loh7S9fugnP0vgyqpzzxoEnC0QTV7MgtmpJx
         eRrv5wLeVylpQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qBWwDoFmoCjl; Wed,  7 Oct 2020 12:11:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C398A2B8374;
        Wed,  7 Oct 2020 12:11:57 -0400 (EDT)
Date:   Wed, 7 Oct 2020 12:11:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <1870892799.11183.1602087117694.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201007160820.GK2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com> <20200924172508.8724-3-mathieu.desnoyers@efficios.com> <20201007150704.GH2628@hirez.programming.kicks-ass.net> <1286784649.11153.1602085170586.JavaMail.zimbra@efficios.com> <20201007160820.GK2628@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v3)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: sched: membarrier: cover kthread_use_mm (v3)
Thread-Index: 2DSJ/AySq6n0r6bebLjBXfA3B0Au8Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 7, 2020, at 12:08 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Oct 07, 2020 at 11:39:30AM -0400, Mathieu Desnoyers wrote:
>> Moving the membarrier_switch_mm to cover kthread cases was to ensure (2), but if
>> we
>> add a p->mm NULL check in the global expedited iteration, I think we would be OK
>> leaving the stale runqueue's membarrier state while in lazy tlb state.
>> 
>> As far as (1) is concerned, I think your idea would work, because as you say we
>> will
>> have the proper barriers in kthread use/unuse mm.
>> 
>> I just wonder whether having this stale membarrier state for lazy tlb is
>> warranted
>> performance-wise, as it adds complexity: the rq membarrier state will therefore
>> not be
>> relevant when we are in lazy tlb mode.
>> 
>> Thoughts ?
> 
> Well, the way I got here was that I considered the membarrier state
> update tied to switch_mm(), and in that regard my proposal is a
> simplification.

Sounds good.

So for the loop check, do we need it to be:

                if ((p->flags & PF_KTHREAD) && !p->mm)
                        continue;

Or can it simply become:

                if (!p->mm)
                        continue;

Because AFAIU only PF_KTHREAD can have NULL p->mm (?)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
