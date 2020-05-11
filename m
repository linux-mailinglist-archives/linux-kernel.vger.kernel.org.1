Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C743F1CCEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 02:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgEKAz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 20:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgEKAz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:55:26 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E408E2495B
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589158526;
        bh=aoUZGApnNHdzjKvoHee7osP+3B+0Np7mo+jawIXTt/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0B5kFdyI5zGmJYycA7nt4gwljoDS5Y4t079wGEOtUM4SWUawyAJ2rvkJWyAQt5Odw
         sFbA3lnGJRIsrKnO/Ty5DlLnL2ISMHvK+0HEhwutOjbXlSOBzdrZn0cLOhJXsDJdk/
         xcFThsdG15eFDGA5BVykKF2dz5v8lapBdgzEvxY4=
Received: by mail-wr1-f45.google.com with SMTP id g13so8799088wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 17:55:25 -0700 (PDT)
X-Gm-Message-State: AGi0Pua7OXkFMOYfAPkdZreV47HsyOaytCio6NjFGYGNGV9W2j0GwtEN
        Sv3R/BJ54oiccYfCPf++3MPXETxoTlyl9GC/emqKow==
X-Google-Smtp-Source: APiQypL0jfqRxOFY9tblYrnRg3Cragd5Ch8bGhBw6ZT3Fdt0IZWGOZCQxCxqQHqM0RuEIH7cWMLw9x2MsA0SU/IeCNU=
X-Received: by 2002:adf:f446:: with SMTP id f6mr8119499wrp.75.1589158524320;
 Sun, 10 May 2020 17:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.166735365@linutronix.de>
In-Reply-To: <20200505134904.166735365@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 May 2020 17:55:12 -0700
X-Gmail-Original-Message-ID: <CALCETrXUus+nQk5BmZLnjnPJ2ywuQg6RsNwqFfwCKpiir9o7wg@mail.gmail.com>
Message-ID: <CALCETrXUus+nQk5BmZLnjnPJ2ywuQg6RsNwqFfwCKpiir9o7wg@mail.gmail.com>
Subject: Re: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT
 entry stubs
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> 32 and 64 bit have unnecessary different ways to populate the exception
> entry code. Provide a idtentry macro which allows to consolidate all of
> that.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

Acked-by: Andy Lutomirski <luto@kernel.org>
> +       /* fixup %gs */
> +       GS_TO_REG %ecx
> +       movl    PT_GS(%esp), %edi               # get the function address
> +       REG_TO_PTGS %ecx
> +       SET_KERNEL_GS %ecx

This GS garbage remains an atrocity.  Some day if I'm inspired to
clean up 32-bit stuff, I'll decrapify it.
