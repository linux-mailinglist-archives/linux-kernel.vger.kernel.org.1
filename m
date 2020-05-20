Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5621DA688
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 02:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgETA2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 20:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETA2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:28:06 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2DD20873
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934486;
        bh=7UHveCpdfXMHC57oV2Hc+hDgHd5kA5vSu2isyOQABb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ox+ZvLKNB//e2KJog5T24fH6I6SCf8raDd+42YTCLKHK1ZUVcXjpIe8gYiRs9XVW7
         cUFebQ4FMpW9yPU8ZXTOw5OYejOUeiKjc5XkP4DgF0OB73c4C9iYslZCg+JQNOAtP0
         Hb2+pylgA1HdVtqJZ5llztYMPg4cqjvAl2w/RNHk=
Received: by mail-wm1-f53.google.com with SMTP id f134so977589wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:28:06 -0700 (PDT)
X-Gm-Message-State: AOAM530cB8w1bZuvGAueJ2Fkk+H7wKtbTICUgEocYlxVlo1vMmw5ZZiz
        J6xCVtZVWs8jaeuAfrV+FQmr6AI/Xb54kNo64LyQ1w==
X-Google-Smtp-Source: ABdhPJwgGP8bkGoVEkJonFiFvO8/Mk/2EBWX0tPVvwkLSgEI/K8gpEjdj/ljf1H+9iSoJehD6pxSNPETylXrDBmGwdg=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr2035119wmr.49.1589934484657;
 Tue, 19 May 2020 17:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.818063410@linutronix.de>
In-Reply-To: <20200515235126.818063410@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:27:53 -0700
X-Gmail-Original-Message-ID: <CALCETrVmYn6j+5cYzmKGELHP6ZLW-ZE38HHSRvPMFQs+41_6=A@mail.gmail.com>
Message-ID: <CALCETrVmYn6j+5cYzmKGELHP6ZLW-ZE38HHSRvPMFQs+41_6=A@mail.gmail.com>
Subject: Re: [patch V6 24/37] x86/entry: Convert APIC interrupts to IDTENTRY_SYSVEC
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
> Convert APIC interrupts to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes
>
> No functional change.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
