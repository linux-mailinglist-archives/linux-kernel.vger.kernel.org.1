Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE97E2524ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHZBLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 21:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHZBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4658C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:55:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598403317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JU28kGjaRQvW1Ed837Qojnm7nxn1/0z26pXVHRuE+k=;
        b=0VvmVjQ97QHqAUx4P2GUcm4B5bLpKK00IKrzF2G2HQPUZVLviQCD40FM68z4CvmddHNvvA
        NgaYRXwoTa5VcudW8EXR5UT3+LECaqIVqHApcnNcagzqual42xnKY6I1gaeH24feMWGEAp
        pZM+5zIfcQjZvZlxNHN1LLm0cShPdrLuGoAhMCcCavw9pY8dZwCSglmVr5U5V0mjZhqmQd
        comDen5KL36D1Vx0YQqEbiPrcSx7swoI4XFhGrZSVdXR7juwqY5nRBGbmU3guFNVwuswvo
        QXcKhyiju/Yfi8fs9lCKxVxOY1QZSvZyNpOuQnkpRvH7mwr4zLlPyhcEofVNOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598403317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JU28kGjaRQvW1Ed837Qojnm7nxn1/0z26pXVHRuE+k=;
        b=C9yj2YL4UFXfwSwP3fp3zBOHrxV/NZyxeONh4E3rx4xOehX3fOtGROtJmc68Be2ib3xvrv
        TVTsWI0FvWbzPQCQ==
To:     Andy Lutomirski <luto@kernel.org>, Alexander Graf <graf@amazon.com>
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        "Herrenschmidt\, Benjamin" <benh@amazon.com>, robketr@amazon.de,
        amos@scylladb.com
Subject: Re: [patch V9 21/39] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
References: <20200521200513.656533920@linutronix.de> <20200521202118.796915981@linutronix.de> <f0079706-4cb3-b3e3-9a5e-97aaba0aa0eb@amazon.com> <87a6yj58af.fsf@nanos.tec.linutronix.de> <051182cc-6c90-e48b-d191-8ca004385261@amazon.com> <CALCETrXutDjE5Z6WR+47MJvp3xt4n=EGiF_oEYm88vGvCqUgHA@mail.gmail.com>
Date:   Wed, 26 Aug 2020 02:55:17 +0200
Message-ID: <87h7sqw7ii.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25 2020 at 16:41, Andy Lutomirski wrote:
> How about this:
>
> void irq_complete_move(struct irq_cfg *cfg)
> {
>         __irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
> }
>
> in arch/x86/kernel/apic/vector.c.

Duh....
