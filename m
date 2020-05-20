Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6991DA68D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 02:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgETA36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 20:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgETA35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:29:57 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93562087D
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934596;
        bh=dFHH4t3ylPjs3pc1IcJfv/L3lTknqDNi2zFrHwpCiN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VbuvxEz0lkx6JN32AyKOKs5i3cAMRjqqOk1BJBAwXW0W1TQm1ElmkwfSsTRuH/FMG
         k9Vuih125H9RLGguT+z9Zv8K6IwilUh4U7XkQq/MfuVG/Fh0pwtihrdyCVpxHuWaPC
         hdj/K6PngVywun/W4Ob+xvg3fyPkHEtsQLwCYcoA=
Received: by mail-wm1-f51.google.com with SMTP id m185so1102945wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:29:56 -0700 (PDT)
X-Gm-Message-State: AOAM530MDuM1sWZ74z9gWgd9yQWm3of4gigRPS88Mj3czz/i4xeTw7PS
        z80Q2Q3eeLllTA4OIwTwEFfG1Uf9JRmaTKqPg4/oEw==
X-Google-Smtp-Source: ABdhPJwun4yxBGtVbah2M4PVTclCKxFkwGKi6aq2I0UN4FumY+vdUiYwHCTSFezLrD9KNVPzS4emJSTy1HMXjePcD9Q=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr1967742wmf.138.1589934595163;
 Tue, 19 May 2020 17:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.724725645@linutronix.de>
In-Reply-To: <20200515235126.724725645@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:29:43 -0700
X-Gmail-Original-Message-ID: <CALCETrUrNq9+k2--OVXyLbTAOoy9hGoPvMh6Ny3y_nU8vVn8gg@mail.gmail.com>
Message-ID: <CALCETrUrNq9+k2--OVXyLbTAOoy9hGoPvMh6Ny3y_nU8vVn8gg@mail.gmail.com>
Subject: Re: [patch V6 23/37] x86/entry: Provide IDTENTRY_SYSVEC
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
> Provide a IDTENTRY variant for system vectors to consolidate the different
> mechanisms to emit the ASM stubs for 32 an 64 bit.
>
> On 64bit this also moves the stack switching from ASM to C code. 32bit will
> excute the system vectors w/o stack switching as before. As some of the
> system vector handlers require access to pt_regs this requires a new stack
> switching macro which can handle an argument.

Is that last sentence obsolete?

Otherwise,

Acked-by: Andy Lutomirski <luto@kernel.org>
