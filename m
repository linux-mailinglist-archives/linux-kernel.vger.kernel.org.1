Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010421D8B78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgERXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgERXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:07:58 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32C920849
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843277;
        bh=DCZmzur2bPV4Hz6PkLNj5pvhYjbwbl8ZORymO1zPAKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ml7l3anXHJnwZ0ia2wgQt3qwzzDCjIntcJjJNnp2VjsW1UEmJpUexFzGehAdJ2Ckc
         31OC6N2TJThX0Q6euTY33l8CO6eYm94HFK+QY4BxOss8f9dJnCEM+WOtYfL3SWPSyE
         RJDz6bGHwr7pGe2UfzMu4wCdVUuclJ08KdudG6rg=
Received: by mail-wr1-f41.google.com with SMTP id k13so11636150wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:07:57 -0700 (PDT)
X-Gm-Message-State: AOAM533GkA3R2aA8rRjZ1UuqZ//proXLoTWzjCBVKAEz7WQhhNQ+JRjt
        zGkGh5uYAmvbm2WXZ3sqPuk+RSNXBAY7FbR887ZRyA==
X-Google-Smtp-Source: ABdhPJxfOstdMT/Vfg0HOC328uME8evFxERPtc5s0safnznw36OAklDFAFF3E0GyE8oZ8/9Py3FdL86D9EySk9gRjeY=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr21879980wro.70.1589843276135;
 Mon, 18 May 2020 16:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235128.106581861@linutronix.de>
In-Reply-To: <20200515235128.106581861@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:07:44 -0700
X-Gmail-Original-Message-ID: <CALCETrXx=v-nsrt+FY-orjFD0dhUn6MX6w+whfHPiEFiexAF7g@mail.gmail.com>
Message-ID: <CALCETrXx=v-nsrt+FY-orjFD0dhUn6MX6w+whfHPiEFiexAF7g@mail.gmail.com>
Subject: Re: [patch V6 37/37] x86/entry: Remove the TRACE_IRQS cruft
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

On Fri, May 15, 2020 at 5:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> No more users.

Hallelujah!

Acked-by: Andy Lutomirski <luto@kernel.org>

>
