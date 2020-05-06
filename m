Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951D51C6C94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgEFJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729122AbgEFJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:13:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:13:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWG6W-0008BD-DS; Wed, 06 May 2020 11:12:36 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 845FE1001F5; Wed,  6 May 2020 11:12:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
In-Reply-To: <20200506084019.GB25532@zn.tnic>
References: <20200505131602.633487962@linutronix.de> <20200505134058.361859938@linutronix.de> <20200506084019.GB25532@zn.tnic>
Date:   Wed, 06 May 2020 11:12:35 +0200
Message-ID: <87ftcdo29o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Tue, May 05, 2020 at 03:16:05PM +0200, Thomas Gleixner wrote:
>> The scheduler IPI has grown weird and wonderful over the years, time
>> for spring cleaning.
>> 
>> Move all the non-trivial stuff out of it and into a regular smp function
>> call IPI. This then reduces the schedule_ipi() to most of it's former MOP
>
> s/MOP/NOP/ after clarifying it on IRC. :)

It was NOP long ago. Now it's Minimal OPeration :)
