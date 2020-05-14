Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375501D25FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 06:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgENEsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 00:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:48:07 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4209D206D4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431686;
        bh=AvQo2rwJhyXe+91Q6tQoumdX/Eeuz0ZZTa/OV8UAE3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xNspC0YAy+5y1zQ1mCnmdfT5uTINXKVZcc8HIVbHXP4OmBLKYpeRBgv1dhwTUb/1d
         x4o4Z5SqVfHfpWVfHXCyZg94waZPsL27ih/RaAj4PGcLj0NpiQ580vfCSddRV1LPGu
         mk0s2gm4CaTCLZs/8qo1AsDjf6UHfpyVSCwzB4gA=
Received: by mail-wr1-f43.google.com with SMTP id v12so2071525wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:48:06 -0700 (PDT)
X-Gm-Message-State: AOAM530U+qb2t6tBMyZNOgyQGQfSMjfrVIC8Z6KwnaTLraT8fC/lxGY/
        pBK+KXruJIXf5jAForJtmHkySDslIBn8hfZYI2WQeg==
X-Google-Smtp-Source: ABdhPJxfTzt+scA3njRTdIhwP3GXv4zNbM2T5h17fzWlvXAajaHBPDY5vVbclhH3zzzl5nkvAi8iRLsi/jvMAZnMc5k=
X-Received: by 2002:adf:a389:: with SMTP id l9mr3188607wrb.18.1589431684690;
 Wed, 13 May 2020 21:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.728077036@linutronix.de>
In-Reply-To: <20200505134905.728077036@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:47:53 -0700
X-Gmail-Original-Message-ID: <CALCETrUEQ1=2m0jZCwEZ6swVi7+bcjSdL3ud-qO-mU0cfCPQzg@mail.gmail.com>
Message-ID: <CALCETrUEQ1=2m0jZCwEZ6swVi7+bcjSdL3ud-qO-mU0cfCPQzg@mail.gmail.com>
Subject: Re: [patch V4 part 3 25/29] x86/entry: Convert Spurious interrupt bug
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
> Convert #SPURIOUS to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
