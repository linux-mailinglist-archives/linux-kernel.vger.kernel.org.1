Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7228A300FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbhAVWMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbhAVWMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:12:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025DA23B09;
        Fri, 22 Jan 2021 22:11:26 +0000 (UTC)
Date:   Fri, 22 Jan 2021 17:11:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] tracing: Use in_serving_softirq() to deduct softirq
 status.
Message-ID: <20210122171125.3b18c3bd@gandalf.local.home>
In-Reply-To: <20210112230057.2374308-3-bigeasy@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
        <20210112230057.2374308-3-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 00:00:56 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Use in_serving_softirq() macro which works on PREEMPT_RT. On !PREEMPT_RT
> the compiler (gcc-10 / clang-11) is smart enough to optimize the
> in_serving_softirq() related read of the preemption counter away.
> The only difference I noticed by using in_serving_softirq() on
> !PREEMPT_RT is that gcc-10 implemented tracing_gen_ctx_flags() as
> reading FLAG, jmp _tracing_gen_ctx_flags(). Without in_serving_softirq()
> it inlined _tracing_gen_ctx_flags() into tracing_gen_ctx_flags().

If we inline it normally (as described in my first patch reply), there may
be no difference.

-- Steve
