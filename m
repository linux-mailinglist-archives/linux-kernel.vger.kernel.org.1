Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F6F1D453D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEOFcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 01:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgEOFcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:32:13 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7156206F1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520733;
        bh=9ypySO/wfBsX/2+03gtlMMGtTrR7hk38bvnUTsm3VgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xcy9nyiRYQ/A/KbACz18zguBJI5aRVq6AF0RKCVhD4aDh+z6zGEisj6Yx8WFAocVE
         AdNFo/RDv++K2zLQJoTn5dyd0Z8LmwfPa4WJF1TUyQSm7wj8TqtJARokkOI18KyCWL
         l6JIGd1DnJ2cfsutuiDlfxB4Ej6KgRegTLfrsOQY=
Received: by mail-wr1-f48.google.com with SMTP id j5so1977850wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:32:12 -0700 (PDT)
X-Gm-Message-State: AOAM532zgjZz2MtdiMhX29e16E61zOlhzos7VMqqbzkNCO4jA8YK+RC1
        nYp6i5Tu7ru9ff+UOg4pH/fKfDLCwUZdH2JGjS40Og==
X-Google-Smtp-Source: ABdhPJx4CdYlG/hbGxfBgqBISITMskKXUT29fS7b3bMHSyVcREt5rZS+FKalyYYfkBKDpfKU1VF8/7gxucyz/p30K5Q=
X-Received: by 2002:adf:a389:: with SMTP id l9mr2249353wrb.18.1589520731474;
 Thu, 14 May 2020 22:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.177564104@linutronix.de>
In-Reply-To: <20200505135315.177564104@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:32:00 -0700
X-Gmail-Original-Message-ID: <CALCETrU90=dYEzXNoYPcbYAgyBgNy0gudR_6yCfk-R3-1HK5jA@mail.gmail.com>
Message-ID: <CALCETrU90=dYEzXNoYPcbYAgyBgNy0gudR_6yCfk-R3-1HK5jA@mail.gmail.com>
Subject: Re: [patch V4 part 4 19/24] x86/entry: Implement user mode C entry
 points for #DB and #MCE
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The MCE entry point uses the same mechanism as the IST entry point for
> now. For #DB split the inner workings and just keep the ist_enter/exit
> magic in the IST variant. Fixup the ASM code to emit the proper
> noist_##cfunc call.
>


Acked-by: Andy Lutomirski <luto@kernel.org>
