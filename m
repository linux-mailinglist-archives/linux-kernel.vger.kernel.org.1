Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE81DA5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgESX6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 19:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgESX6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:58:11 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5663E20888
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589932690;
        bh=oFqPBLvcZGv5gVg/QK0/s+a8xf4nmwrDT0jqdNOG8zs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QjZik8O/KAFXnGPUT7nE8OwBc2G6KyaildvX7uF2WkxaU97ToAtsAmBJKzzv5erW5
         CwgxMeP+UH57vfchUnH6u4Mm7PpzurWGELdmiLo6bcvC1zIe5sjH1Kr311HuPKQaSX
         p1B8UJbB8RY0zVTzvbnlCBj70oToJnRp370SWOSs=
Received: by mail-wr1-f46.google.com with SMTP id j5so1314188wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:58:10 -0700 (PDT)
X-Gm-Message-State: AOAM531pGjAI3drqhaj7PAcuXrVVC6T9F5cbtjp9L6x510zzdEgoS+XQ
        WYo9YbLcxO26fwmVcsfIJQOZUyuO+r6ftrwFhmGybQ==
X-Google-Smtp-Source: ABdhPJxImMCvUJLIytp0oKwRx9Yz/R2r0Aa48P4wEbG2hzyQeo0U/kaT7Kbhx0mypDjaMYznPwye72O2B6GQiZFZRpU=
X-Received: by 2002:adf:a389:: with SMTP id l9mr1407187wrb.18.1589932688700;
 Tue, 19 May 2020 16:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.404958221@linutronix.de>
In-Reply-To: <20200515235127.404958221@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 16:57:57 -0700
X-Gmail-Original-Message-ID: <CALCETrUYwedYeia=DoS8OXGmHVScdqP6vCoWrbfaAi7j83U-_A@mail.gmail.com>
Message-ID: <CALCETrUYwedYeia=DoS8OXGmHVScdqP6vCoWrbfaAi7j83U-_A@mail.gmail.com>
Subject: Re: [patch V6 30/37] x86/entry: Convert reschedule interrupt to IDTENTRY_RAW
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> The scheduler IPI does not need the full interrupt entry handling logic
> when the entry is from kernel mode.
>
> Even if tracing is enabled the only requirement is that RCU is watching and
> preempt_count has the hardirq bit on.
>
> The NOHZ tick state does not have to be adjusted. If the tick is not
> running then the CPU is in idle and the idle exit will restore the
> tick. Softinterrupts are not raised here, so handling them on return is not
> required either.
>
> User mode entry must go through the regular entry path as it will invoke
> the scheduler on return so context tracking needs to be in the correct
> state.
>
> Use IDTENTRY_RAW and the RCU conditional variants of idtentry_enter/exit()
> to guarantee that RCU is watching even if the IPI hits a RCU idle section.
>
> Remove the tracepoint static key conditional which is incomplete
> vs. tracing anyway because e.g. ack_APIC_irq() calls out into
> instrumentable code.
>
> Avoid the overhead of irq time accounting and introduce variants of
> __irq_enter/exit() so instrumentation observes the correct preempt count
> state.

Leftover text from an old version?

The code is Reviewed-by: Andy Lutomirski <luto@kernel.org>
