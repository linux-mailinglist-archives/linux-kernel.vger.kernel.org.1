Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661ED1DBE65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgETTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgETTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:51:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFAC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 12:51:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbUkC-0001ev-0Q; Wed, 20 May 2020 21:51:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 659B8100C99; Wed, 20 May 2020 21:51:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 01/37] tracing/hwlat: Use ktime_get_mono_fast_ns()
In-Reply-To: <20200519181802.5c88c557@gandalf.local.home>
References: <20200515234547.710474468@linutronix.de> <20200515235124.466962628@linutronix.de> <20200519172627.7e65669e@gandalf.local.home> <871rnf7g61.fsf@nanos.tec.linutronix.de> <20200519181802.5c88c557@gandalf.local.home>
Date:   Wed, 20 May 2020 21:51:11 +0200
Message-ID: <87lflmv100.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 19 May 2020 23:45:10 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> >> @@ -165,20 +155,22 @@ void trace_hwlat_callback(bool enter)
>> >>   * Used to repeatedly capture the CPU TSC (or similar), looking for potential
>> >>   * hardware-induced latency. Called with interrupts disabled and with
>> >>   * hwlat_data.lock held.
>> >> + *
>> >> + * Use ktime_get_mono_fast() here as well because it does not wait on the
>> >> + * timekeeping seqcount like ktime_get_mono().  
>> >
>> > When doing a "git grep ktime_get_mono" I only find
>> > ktime_get_mono_fast_ns() (and this comment), so I don't know what to compare
>> > that to. Did you mean another function?  
>> 
>> Yeah. I fatfingered the comment. The code uses ktime_get_mono_fast_ns().
>
> Well, I assumed that's what you meant with "ktime_get_mono_fast()" but I
> don't know what function you are comparing it to that waits on the seqcount
> like "ktime_get_mono()" as there is no such function.

Gah. ktime_get_mono_fast_ns() and ktime_get() of course.
