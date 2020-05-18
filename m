Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E231D8B71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgERXGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgERXGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:06:45 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1096F2067D
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843205;
        bh=ai7IcApI03u9Nuuwf8BJ667oaS0jAJlQ3YqXSrVleUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G8pfVf+Ov7PZGydSkx1WoRtT7BDz4ZHWXzkXwFbrun+mDpDiimIkptdyx2H/4ozSx
         Vs6/90RVad4qsniSLPo5CgIgCL84ppRBVF1dYwKvJFbacbBYvphgK+BcDvNhNlieEH
         I8hDVecmytLLQcRpEoJNrlbPQ0uJsWNO/p8tV3Ao=
Received: by mail-wm1-f47.google.com with SMTP id n18so1291825wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:06:44 -0700 (PDT)
X-Gm-Message-State: AOAM531q67+K8C5b+Wqm65SffbtrBrJM8GV2TwIuylKOSlrLfL/jNrKo
        HWbw3y5MrbzrLm+mcVQvFen1+Wredc6nRuPvcR/iyQ==
X-Google-Smtp-Source: ABdhPJxKCjC57hSCi3kdQVwecCeryR790UoqEqFHNdtuANmlIdzFiJzGCAI9ADgze0I5OZx1/R8tF51DpYeYnq5Br0o=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr1826527wmf.138.1589843203582;
 Mon, 18 May 2020 16:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235124.891319901@linutronix.de>
In-Reply-To: <20200515235124.891319901@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:06:32 -0700
X-Gmail-Original-Message-ID: <CALCETrUgn3_=w6+bqWcBZPJ7f4=1goTOJDZ3t8wsAgN+V7woaQ@mail.gmail.com>
Message-ID: <CALCETrUgn3_=w6+bqWcBZPJ7f4=1goTOJDZ3t8wsAgN+V7woaQ@mail.gmail.com>
Subject: Re: [patch V6 05/37] genirq: Provide irq_enter/exit_rcu()
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
> irq_enter()/exit() include the RCU handling. To properly separate the RCU
> handling provide variants which contain only the non-RCU related
> functionality.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
