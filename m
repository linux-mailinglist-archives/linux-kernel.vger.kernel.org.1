Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36D41D8BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgERXuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgERXuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:50:14 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815322084C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589845813;
        bh=IyETP8X3w/mh9Z1jwc4sQBuC9afCIRpaML8/1dR2Y8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ybWhcPVuodhjeJ1AdnFSLuYSaeCfjS0M1aWoRnkUsrQvAEzIP4V/N2MklTFZlLixn
         FzGe76dMyZ5Qf54+hFKvzS9D0m3qZg2Sh5tVvwBoUEyOpDAA5DtaYhIeesFgUJczut
         vyiPYdSpV115XHtOmSiQ9gVAEId4xMKSVu/YbA3o=
Received: by mail-wm1-f51.google.com with SMTP id f13so1170133wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:50:13 -0700 (PDT)
X-Gm-Message-State: AOAM5319Owfy356RxSlJq+MrJLl8KaV2APyGvhaXBmOCEh6t585jUr1Z
        E2ShWH/FEl0D7yTFZdTG0z+c1D+lEkleuKldXaEa0Q==
X-Google-Smtp-Source: ABdhPJygoAnKqsralfS9a3XJlv7KFYWEwvA4Fjsmwv3f1/pz/f6DydelvfqN6xpSZ0iHb6ln6p2IKFEksGpTxG7ItEE=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr1985653wmf.138.1589845811978;
 Mon, 18 May 2020 16:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.330961133@linutronix.de>
In-Reply-To: <20200515235125.330961133@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:49:59 -0700
X-Gmail-Original-Message-ID: <CALCETrUj4CRv9Kn-G8WM1yOCAmuarKs=1zPgv0gOyRGTxPJ5+Q@mail.gmail.com>
Message-ID: <CALCETrUj4CRv9Kn-G8WM1yOCAmuarKs=1zPgv0gOyRGTxPJ5+Q@mail.gmail.com>
Subject: Re: [patch V6 09/37] x86/entry: Split idtentry_enter/exit()
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
> Split the implementation of idtentry_enter/exit() out into inline functions
> so that variants of idtentry_enter/exit() can be implemented without
> duplicating code.
>

After reading just this patch,  I don't see how it helps anything.
Maybe it'll make more sense after I read more of the series.
