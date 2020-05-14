Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E641D25F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 06:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgENEpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 00:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:45:15 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C625C20575
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431515;
        bh=LtPFqQjRPKDJYUvUcsyFImgf0124qc1+JjNISUKgkbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eq5eOFj+Etf6Mu2aUm13O6bWOylqegWaS8A4mVXH30kLP+QRqltUWNRMDg7XghiKQ
         PZU/sViBOG+xikAg/y81V1lFvAh7ZLg2zFlZm+ogiaQL1VYFyJqbCatLL3g5a9S5Rv
         gjX7n7FH00hvin2LsVCXYIrekAKOka5rFr2TTwbY=
Received: by mail-wm1-f50.google.com with SMTP id h4so28759355wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:45:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuaKnyYA1VVokac0lSLQmpIiXAysJ94W/KnjbVI0KwQSpPRCv8//
        2LIH1oygwAauFJcBwdr4/c/II/g1p0zlOL7BtyLY0w==
X-Google-Smtp-Source: APiQypI14wPkeZqJKVAa97hoyid9XZ9xarwYI6L3BbbyHWha4Rp2LFXvy2dBMgFwGezpvREBOIaXNHMp9tOSkEkr6lg=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr39164430wmk.21.1589431513225;
 Wed, 13 May 2020 21:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.955511913@linutronix.de>
In-Reply-To: <20200505134904.955511913@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:45:02 -0700
X-Gmail-Original-Message-ID: <CALCETrVkcKvAQgO6uutBOpBYELQ9hYy9mPTXyDzCYkT1we3aTg@mail.gmail.com>
Message-ID: <CALCETrVkcKvAQgO6uutBOpBYELQ9hYy9mPTXyDzCYkT1we3aTg@mail.gmail.com>
Subject: Re: [patch V4 part 3 17/29] x86/entry: Convert Invalid Opcode
 exception to IDTENTRY
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
> Convert #UD to IDTENTRY:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Fixup the FOOF bug call in fault.c
>   - Remove the old prototyoes
>
> No functional change.

I think there *is* a functional change:


> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -567,7 +567,7 @@ static int is_f00f_bug(struct pt_regs *r
>                 nr = (address - idt_descr.address) >> 3;
>
>                 if (nr == 6) {
> -                       do_invalid_op(regs, 0);
> +                       handle_invalid_op(regs);

I suspect the old code was wrong and no one noticed because no one has
a F00F-buggy machine any more.

So maybe document that you fixed up the F00F bug, too.  Otherwise:


Acked-by: Andy Lutomirski <luto@kernel.org>
