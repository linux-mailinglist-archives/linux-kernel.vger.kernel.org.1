Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A302991E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785018AbgJZQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:08:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39022 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442264AbgJZQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:08:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id a6so8601190edx.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckUeZhQwLLw8NPNXOPfI1l02XH243h4QG0Ah2RdXWjU=;
        b=ZrGeekURs3NEJW8hPKEOtbHBvZIP9dD98uT38emNIk95siFbRlmqpxP1X2AVj03b9i
         p+N4cRhxm5jPWb2kisCVe/genKPUEhu36VyxKJ4Vf4f63Xi1GYaxBBOGjkLCfGwZWe1k
         KQGui//+xi4gifOXaUnjJ4/zOrx9D6fDyi88cO4I5Yng7zYqzvN+EqLmbG8jGU6gWSUE
         bArjfaNnmm2ZWb9mFf0+n0Vee+aiSeOIj+UVnUD081tdjfHF8aJ7Qy8lcy2iqnJG3+zn
         FLNEADHLlnafOsNfjklazpBg60ZfX2+DVh7LQwVEd0+5Spyweudveu8Tm1pcToDvM/vB
         HsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckUeZhQwLLw8NPNXOPfI1l02XH243h4QG0Ah2RdXWjU=;
        b=OvpENDfLZERmMZf1OtUtsSyrYCONmYn8m0bOk9ot12hc/RtAvK/lj3i9Y7ddzRP6nS
         iZO0+H/Vh4kZjFb9fCWDE2ynZgoGh4QwFrTDrDW9t2b9NZNy3Wr2w3zJI0oDNtFd3XjI
         modTujkK5EevBq9RyW2kmIu9w461BYh0HZCF5b7af5nqqQxCzwzFAvqEz79jN0n25tp2
         1V37LDW9ZRrzf667Am6KTGuRbF/EaEpSEBCj/mA/1+gbfFPoqj442dy64LabSRZPwgu/
         jii9swEfHULeIPEwQMRKU2ys3xmLXKI7/Zf8CQCFJ8yMyAOnXXhT7RKKN23V2xDcfxNe
         6DTQ==
X-Gm-Message-State: AOAM53064lIR1+TrBD1rRUSCXx6GwhPaslvS7NGCWhO+1Y4fkCxYUMAB
        ateFISysKBke1scrjeHRLxlXNA5E0X3pooTtwsYcKw==
X-Google-Smtp-Source: ABdhPJwwXeWDoKR7kpK2lvTqb4K+dq0D7LvGX/w5Wtk+8xRgipmNlkQTCwH/vQVy5/ZBaj8YUW2JCjbc3y3xMocsNa4=
X-Received: by 2002:aa7:c90a:: with SMTP id b10mr828311edt.163.1603728530129;
 Mon, 26 Oct 2020 09:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 09:08:38 -0700
Message-ID: <CAP045Aoe2531x+dGcEHHiUyhzfz3GbKOeY0jmktbw6C1UK1Nvw@mail.gmail.com>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 8:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Urgh, now I have to try and remember how all that worked again ...

Sorry.

> I suspect it's either one (or both) of the last two:
>
>   f4956cf83ed1 ("x86/debug: Support negative polarity DR6 bits")
>   d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")

I think it's the latter, particularly the removal of this assignment[0]

> Just to clarify, the sequence is something like:
>
>  - tracer: ptrace(PTRACE_SINGLESTEP)
>  - tracee: #DB, DR6 contains DR_STEP
>  - tracer: ptrace_get_debugreg(6)

Right.

> Also, can you confirm that pthread_set_debugreg(6) should not do
> anything useful?

I don't believe it did anything useful.

- Kyle

[0] https://github.com/torvalds/linux/commit/d53d9bc0cf78#diff-51ce909c2f65ed9cc668bc36cc3c18528541d8a10e84287874cd37a5918abae5L790
