Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1441F87ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFNJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFNJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 05:00:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AF5C03E969
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:00:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jkOUF-0000CJ-BD; Sun, 14 Jun 2020 10:59:31 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 858D81013DC; Sun, 14 Jun 2020 10:59:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <20200613214123.GC992@lca.pw>
References: <87zh9cnfmg.fsf@nanos.tec.linutronix.de> <87wo4gnetx.fsf@nanos.tec.linutronix.de> <20200610123833.GD954@lca.pw> <87h7vig17z.fsf@nanos.tec.linutronix.de> <20200613135547.GA992@lca.pw> <87a717cbc9.fsf@nanos.tec.linutronix.de> <20200613214123.GC992@lca.pw>
Date:   Sun, 14 Jun 2020 10:59:30 +0200
Message-ID: <874krec9al.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> On Sat, Jun 13, 2020 at 04:03:02PM +0200, Thomas Gleixner wrote:
>> Qian,
>> 
>> Qian Cai <cai@lca.pw> writes:
>> > On Wed, Jun 10, 2020 at 09:38:56PM +0200, Thomas Gleixner wrote:
>> >
>> > Thomas, I get ahold of one of the affected systems now if you want some
>> > testing there.
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
>
> Looks good.
>
> <start>
> # cat /sys/kernel/debug/stackdepot/info
> Unique stacks: 27481
> Depot index:   285
> Depot offset:  3024
>
> <after oom02>
> # cat /sys/kernel/debug/stackdepot/info
> Unique stacks: 29242
> Depot index:   308
> Depot offset:  6608
>
> <after the full testsuite>
> # cat /sys/kernel/debug/stackdepot/info
> Unique stacks: 49221
> Depot index:   530
> Depot offset:  5888

Thanks for confirming!
