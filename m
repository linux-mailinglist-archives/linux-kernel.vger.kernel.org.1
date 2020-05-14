Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7531D25EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 06:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgENEiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 00:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:38:46 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C025720728
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431126;
        bh=CQebTErhe0RAplFU5sVKwq3I4MzUr9+QsiAsaJc8YPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pQ0b8bp2jWcirKuSZCQWKNbMYMU3g8L9eob+5YBMYcQYDSb+FwiP+5gY9X5kzeYPE
         HsU5CQtcascHEYMjGAVeGgZphkWivl0Jy+5B69NjP5tpnZoe1AZ1mfp0cxIVajDRrP
         uM+A1123kcqKoy8MRniHwl/Fw2K1+u5Hrfx6OZDQ=
Received: by mail-wr1-f43.google.com with SMTP id e1so2103431wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:38:45 -0700 (PDT)
X-Gm-Message-State: AOAM530M7fFN3F8SoAJkgg+RmDJqzafipLwjg7V6d/U3svMQcjdFc1VY
        IuRuLMTrT3ubRqQQbY3oqH3JES8EjanpXyiJIY8g/Q==
X-Google-Smtp-Source: ABdhPJwa3qj+zTB0YQn0n/VrWkABBARj9A02AfzyX9ebzan2Iwexq1AYUd2li8loUn3rQtPJNIxu/USnXgcveI11kEQ=
X-Received: by 2002:adf:f446:: with SMTP id f6mr2989632wrp.75.1589431124190;
 Wed, 13 May 2020 21:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.663914713@linutronix.de>
In-Reply-To: <20200505134904.663914713@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:38:32 -0700
X-Gmail-Original-Message-ID: <CALCETrV5Xd8od6xGt9Ke4p=ZOn9OHpSYKdtDyqsvhZMtivVaow@mail.gmail.com>
Message-ID: <CALCETrV5Xd8od6xGt9Ke4p=ZOn9OHpSYKdtDyqsvhZMtivVaow@mail.gmail.com>
Subject: Re: [patch V4 part 3 14/29] x86/entry: Convert Divide Error to IDTENTRY
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
> Convert #DE to IDTENTRY:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>
> No functional change.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
