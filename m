Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18201D4530
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 07:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgEOF1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 01:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgEOF1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:27:12 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29DC2078C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520432;
        bh=NFJ5FuW0KTJO4V1Nl6c2VCKmZtgbv1bWnEPgJEoxZh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F7TNHl9o/OdVpqMkPuI6314BT3LBX6l316JgT2DM86XCM/7BidO6VPDIA2yILpz9p
         LaxpGcrHWmvyqJBS9SlrAto5TRSWMCFF8HpSnCh1IEIX+EWvrltV4kxWCxRKUyr0tJ
         nLGnMaHTXoEBtxqh2jBp6+K1x9QCvlW0C52tHLpI=
Received: by mail-wr1-f49.google.com with SMTP id e1so1936280wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:27:11 -0700 (PDT)
X-Gm-Message-State: AOAM532besbtZunJgtg7rHRy7YSZOEG/igqu6RLGqXOftzNlK06NQoc9
        bVFuzjRN5AU/U5vXbg+i4J8sCfOnHFfnrFE4/stEew==
X-Google-Smtp-Source: ABdhPJwDH30txnQzcth7DNGJxfj//iyThZ+XjWebQjsepbBNS6+xfv5CgeNzNajpyc/6Lu8V0ppz3nFZYqcWZm8qabA=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr2151322wro.70.1589520430301;
 Thu, 14 May 2020 22:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.716186134@linutronix.de>
In-Reply-To: <20200505135314.716186134@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:26:59 -0700
X-Gmail-Original-Message-ID: <CALCETrWtkcVHDpuONyOBwtzU4EsQcK6hCWxozRoKOE2xd638AQ@mail.gmail.com>
Message-ID: <CALCETrWtkcVHDpuONyOBwtzU4EsQcK6hCWxozRoKOE2xd638AQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 14/24] x86/nmi: Protect NMI entry against instrumentation
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Mark all functions in the fragile code parts noinstr or force inlining so
> they can't be instrumented.


Acked-by: Andy Lutomirski <luto@kernel.org>
