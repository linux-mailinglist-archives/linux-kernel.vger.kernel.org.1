Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601471F7DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFLTfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFLTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:35:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCDCC03E96F;
        Fri, 12 Jun 2020 12:35:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjpS5-0003Ai-0w; Fri, 12 Jun 2020 21:34:57 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 71DFB100F5A; Fri, 12 Jun 2020 21:34:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
In-Reply-To: <87r1ukxf1b.fsf@nanos.tec.linutronix.de>
Date:   Fri, 12 Jun 2020 21:34:56 +0200
Message-ID: <87k10ccc2n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> On Fri, Jun 12, 2020 at 10:49:53AM -0700, Paul E. McKenney wrote:
>>> I will therefore address this issue in a follow-on patch.
>>
>> I should add that -your- patch from yesterday did -not- cause this
>> problem, in case that is of interest.
>
> So I still can add it back and amend the changelog and comment:
>
> Change the condition from !rcu_is_watching() to is_idle_task(current) ||
> rcu_is_watching() which enforces that interrupts in the idle task
> unconditionally invoke rcu_irq_enter() independent of the RCU state. For
> most scenarios is_idle_task() would be sufficient but Task RCU needs it
> according to Paul.

After talking to Paul some more we came to the conclusion that the
failure scenario of task rcu is not completely clear and the trigger
scenario is obscure enough. This needs more investigation and the
important part which we were chasing is fixed and agreed on. So I go
with the simple version now and Paul will follow up once it can be
properly explained.

Thanks,

        tglx
