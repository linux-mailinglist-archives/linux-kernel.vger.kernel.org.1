Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873671D4557
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 07:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgEOFkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 01:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgEOFkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:40:21 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38106207C4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521220;
        bh=VB1tS+r1kXo9rxVjAh6YIgsl5Zjl1N13y99p8UsmlvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IJoEC3rI/z7WNyxQY4S8LWYY5ITQowVdAJsr6ZbzSMLDbGlIYUgoZV2S458Oa04UO
         i1HrJ/M3tkUPw89iYQjwL1DTsrmCFZ6r7hJN+jXmbNoWYIo8eaTGfzXQbf7ojYMCmj
         FJTiExbmggz80+66EqMpRjYY3celfzvFGn2w1eSo=
Received: by mail-wm1-f41.google.com with SMTP id m12so970664wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:40:20 -0700 (PDT)
X-Gm-Message-State: AOAM530FuUfasgAKZlIUeMPUXhKLsqI2YLzYGMZzsPZoqRTvOCL/4F1w
        CDRP9TuOk6OU/NkXSSy15XxLvwaEYVN3N+y5DJdAsQ==
X-Google-Smtp-Source: ABdhPJz6gQDsBz51SohnBuXQ4HF0glboxfr11G3fNfDgBEceAqJ6nEclkOAc3BOokCWEUkiHEW5pDOEzjT5+MvWOJGI=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr1080892wmd.21.1589521218750;
 Thu, 14 May 2020 22:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.476734898@linutronix.de>
In-Reply-To: <20200505135315.476734898@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:40:07 -0700
X-Gmail-Original-Message-ID: <CALCETrWszss=vrJ0LMmewMAu8PgBh8ejrMcK4jftjDrqREiPYQ@mail.gmail.com>
Message-ID: <CALCETrWszss=vrJ0LMmewMAu8PgBh8ejrMcK4jftjDrqREiPYQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 22/24] x86/mce: Address objtools noinstr complaints
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
> Mark the relevant functions noinstr, use the plain non-instrumented MSR
> accessors. The only odd part is the instr_begin()/end() pair around the
> indirect machine_check_vector() call as objtool can't figure that out. The
> possible invoked functions are annotated correctly.

Acked-by: Andy Lutomirski <luto@kernel.org>
