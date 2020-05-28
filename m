Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F11E5C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgE1Jvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgE1Jvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:51:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA77BC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:51:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeFBU-0003Km-En; Thu, 28 May 2020 11:50:44 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E4274100D01; Thu, 28 May 2020 11:50:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     damian <damian.tometzki@familie-tometzki.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V9 20/39] x86/irq: Use generic irq_regs implementation
In-Reply-To: <20200526183934.GA3960@centos.familie-tometzki.de>
References: <20200521200513.656533920@linutronix.de> <20200521202118.704169051@linutronix.de> <20200526183934.GA3960@centos.familie-tometzki.de>
Date:   Thu, 28 May 2020 11:50:43 +0200
Message-ID: <87ftbkpevg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Damian,

damian <damian.tometzki@familie-tometzki.de> writes:
> with this patch i got the following build error:
>
>   LD      .tmp_vmlinux.kallsyms1
> /home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: arch/x86/kernel/irq.o: in function `get_irq_regs':
> /home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:19: undefined reference to `irq_regs'

Can you provide the .config please?

Thanks,

        tglx
