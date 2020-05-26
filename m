Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0401DD85E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgEUUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgEUUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24733C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:53 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqT-0000GP-VC; Thu, 21 May 2020 22:31:14 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5C91D100606;
        Thu, 21 May 2020 22:31:13 +0200 (CEST)
Message-Id: <20200521200513.656533920@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

This is V9 of the rework series. V7 and V8 were never posted but I used the
version numbers for tags while fixing up 0day complaints. The last posted
version was V6 which can be found here:

  https://lore.kernel.org/r/20200515234547.710474468@linutronix.de

The V9 leftover series is based on:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

That branch contains the merged part 1-4 of the original 5 part series.

V9 has the following changes vs. V6:

   - Rebase on tip x86/entry

   - Simplified the hardware latency detector changes by moving the
     invocation to the right place in nmi_enter/exit() and annotate it.

   - Reworked the conditional RCU handling so it is now used
     unconditionally everywhere. That simplified the idtentry_enter/exit
     code significantly and also allowed to simplify the XEN hypercall
     voluntary preemption handling.

   - Moved the run on irq stack logic into an inline to avoid having the
     same conditionals all over the place and fixed up the relevant places.

   - Picked up Acked-by and Reviewed-by tags where appropriate.

The full series is available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v9-the-rest

If we agree on the RCU changes, then these will be applied into the core/rcu branch
first so Paul can pick them up to avoid the next conflict horrors.

Thanks,

	tglx
