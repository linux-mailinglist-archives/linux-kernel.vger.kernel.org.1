Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF41DA68B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 02:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgETA2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 20:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETA2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:28:45 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AB820835
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934525;
        bh=tV75JqnXKULmhry35QUj8x5DmwwpbF7hVtJoMgm91X8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IlRZmJblHEQebF3hZksgLWSFQT24pQ9aMaajKBJs5muqCQdLqKHN1AGkOpId5jsVL
         +keCOgZNoKEh7d+G5hPUyLnoZLiQ3HL/8Tfr0AA9NE6fAVIRFkW/Wwigao+PfecWTh
         ecZOtoyuSfMGMUvwV0GKcnsPcQpzSN0v4xnMEpyU=
Received: by mail-wm1-f51.google.com with SMTP id n5so1123157wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:28:44 -0700 (PDT)
X-Gm-Message-State: AOAM530cCGvOXKWunQW+9GBm7dSkd+h/nlmDDIkcWCZSDFp8FuQKXZnP
        qita52U+7vxC9/xJlmfru3sIIB/PPbQkHlM1uvR8Ww==
X-Google-Smtp-Source: ABdhPJym4LAsBzDWDiUFhhTzPfi1ulI7EQIpntKCnphnmUW9fKCRFNP+ofw3vqVHI0x8cjcApDUpO2P+qQdTZiGFFGY=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr1915720wmd.21.1589934523525;
 Tue, 19 May 2020 17:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.912643204@linutronix.de>
In-Reply-To: <20200515235126.912643204@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:28:32 -0700
X-Gmail-Original-Message-ID: <CALCETrXpY9DVfXCOMiqkdt979tT2G5kqCCw2HY22kNJ=z_p6_A@mail.gmail.com>
Message-ID: <CALCETrXpY9DVfXCOMiqkdt979tT2G5kqCCw2HY22kNJ=z_p6_A@mail.gmail.com>
Subject: Re: [patch V6 25/37] x86/entry: Convert SMP system vectors to IDTENTRY_SYSVEC
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
> Convert SMP system vectors to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes

Acked-by: Andy Lutomirski <luto@kernel.org>
