Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B7B1CBBEB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 02:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgEIAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 20:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEIAkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:40:04 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DC724960
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588984804;
        bh=w3nUvC9bvYIisplN6vIbXMn5UMsbP9i0pd9Ps8wy1k0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4smgdfAj9hbW/O1YVUBZl4b4bPyGBLb/BVajorM9JlwwfR5FlVlv7yeD0cbBMFGa
         +43mfB5yblhYgX5CjKALg5rfU0gSjqJKb/9T5tg5tox8EehkjYfk2lcrq1OEU6NOOo
         SjNnTcc24SE0VNQ51BFMsbjo2ja/0rUnAfMV6KgA=
Received: by mail-wm1-f44.google.com with SMTP id x4so12016009wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:40:03 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ0+aE7LGF82x2kaLt5blYXbN1077dZtIPMhP2Q7k9aTNqv2TqQ
        S0E0aBwj/4espup9cfEDehpeJZNnJkdJF2H9jOYaMw==
X-Google-Smtp-Source: APiQypLWCD3BOjzpXGTtyTqH0RpjnssUp6YnkWGD8OkKK1PsjkXRQNO1Bx/FYCMDNScPGFuUolqn5OZlLm6jduGK7Ik=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr18092974wmk.36.1588984802557;
 Fri, 08 May 2020 17:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134903.439765290@linutronix.de>
In-Reply-To: <20200505134903.439765290@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:39:51 -0700
X-Gmail-Original-Message-ID: <CALCETrVH2XMfgJSLewogCQQZnwDOzz4JYWB+aZdE_Rz_kOPz2w@mail.gmail.com>
Message-ID: <CALCETrVH2XMfgJSLewogCQQZnwDOzz4JYWB+aZdE_Rz_kOPz2w@mail.gmail.com>
Subject: Re: [patch V4 part 3 02/29] x86/traps: Mark sync_regs() noinstr
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
> Replace the notrace and NOKPROBE annotations with noinstr.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Andy Lutomirski <luto@kernel.org>
