Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946961DA6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 02:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgETAcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 20:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgETAcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:32:00 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB98C2084C
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934720;
        bh=Vj4MoAZThD5PoYBowKDvHhxtY/1LGMsiKWqhJznIkng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2PmFq1vw/FyVhhV7d6ycDo7fq0pEuRLuFkWtSUHTX3x1ey5AParqm+yBzdtELQN1Z
         vN+3ZjlDuKqCtx9O0MqoLiWWnHhHQTCZmZLSojL8lF1SZkiU/RgXqEJrF2UmirvQPc
         Tug2wbVHcQbQMXBdRtrtwiB4oDgepD21E1gvNeCY=
Received: by mail-wm1-f54.google.com with SMTP id h4so968558wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:31:59 -0700 (PDT)
X-Gm-Message-State: AOAM532PKUCemLkBJ8FmXcFVqnhVn4n1DReBVh586bQn1Iy34JIWdMYz
        GicEcFxA+iZUg66qpcj1iyiGLljFIZZtKAu1E5CA+g==
X-Google-Smtp-Source: ABdhPJzzDKUeEaYabpXRpicgoQvKxEfar3no7w9TJB1TEE4osBscRYYshK1gHwo1Y1OxoHLixuVXOunq9vgrz4y8dlg=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr1898692wme.176.1589934718338;
 Tue, 19 May 2020 17:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.311082011@linutronix.de>
In-Reply-To: <20200515235127.311082011@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:31:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXshKD6g1tKUi=qgdhaRSegRbTnbW04kUDUo+3VY6+ynQ@mail.gmail.com>
Message-ID: <CALCETrXshKD6g1tKUi=qgdhaRSegRbTnbW04kUDUo+3VY6+ynQ@mail.gmail.com>
Subject: Re: [patch V6 29/37] x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC
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
> Convert the last oldstyle defined vector to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes

Acked-by: Andy Lutomirski <luto@kernel.org>
