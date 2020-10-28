Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922C929D5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgJ1WIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgJ1WH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:57 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B19D246C5;
        Wed, 28 Oct 2020 22:07:55 +0000 (UTC)
Date:   Wed, 28 Oct 2020 18:07:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH 0/2] ftrace: Add access to function arguments for
 all callbacks
Message-ID: <20201028180753.238335d1@oasis.local.home>
In-Reply-To: <20201028213303.shosfclmhxkai2ir@ast-mbp.dhcp.thefacebook.com>
References: <20201028131542.963014814@goodmis.org>
        <20201028213303.shosfclmhxkai2ir@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 14:33:03 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> I don't have strong opinion on this feature, but if you want to have it
> please add a giant disclaimer that this is going to be x86-64 and, may be arm64,
> feature _forever_. On x86-32 and other architectures there is no way
> to provide sane regs_get_kernel_argument(regs, n) semantics by blindly
> saving registers. The kernel needs to know types and calling convention
> of the architecture. That's the reason bpf side has btf_func_model concept.
> To make sure that bpf trampoline can support all architectures in the future.

The trampoline is to only provide the information to get the arguments.
Yes, it is up to the callback that registered it that knows how to get them.

What does the bpf trampoline need to get an argument if it already
knows the type. If it has access to a subset of necessary registers and
the stack pointer of when the function was called, is it possible to
figure out the arguments?

This code is not about a "regs_get_kernel_argument(regs, n)", that was
only used to show that *that* could be done. Because currently, there's
*no* way to get those arguments without setting the SAVE_REGS flag,
which saves way more than necessary. I only used that to test the code
in a generic way. Ideally, ftrace could use btf to figure out the
actual arguments of the function if it had a mapping.

I believe the reason you gave up on using ftrace was because of the
overhead of the REGS code. If that wasn't the case, and you didn't see
that overhead, would you have used ftrace?

In fact, did you look at all to see if you could modify the current
infrastructure to make it work for you? Or did you just give up to
write your own from scratch?

-- Steve
