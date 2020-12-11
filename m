Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD602D8127
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405795AbgLKVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731564AbgLKV3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:29:30 -0500
Date:   Fri, 11 Dec 2020 22:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607722130;
        bh=E7aZnzcI6aUqGwI/BBgmCqw6W4cuaeg45dSNuK8FXBQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKq0YavG9h4WBHTDHKog9zTbKboE8TCobKBaTYgUDVU9dOPSYqRX9jmlIAba42tbR
         4O9PJHf41JJ7ibODabX62WmRx48cFFTrf/Zdx/Lgklfy+s70xM+o99i5YzyBVcutpB
         DonXaSM7ngM4Amf45UxNwRP0TlaZfWU4N9FZ+RzJXeVMaFQssncwVSSbjeWIOtpMtX
         r4VdeGSLxVWBhDyydySNy9NMUQ0L6NcBAdoFJIFrF6pT29E/FhCeLA9zsAZYNQqs8B
         JwIqmGB3ZOS1X6SM9dgM41a72QUJPInlDE3wT+iSmAWdwNFzEDniol+NXOPo8FFVRp
         6XBuVI0QzwOpQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: tick/sched: Make jiffies update quick check more robust
Message-ID: <20201211212847.GA595642@lothringen>
References: <87czzpc02w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czzpc02w.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:55:19AM +0100, Thomas Gleixner wrote:
> The quick check in tick_do_update_jiffies64() whether jiffies need to be
> updated is not really correct under all circumstances and on all
> architectures, especially not on 32bit systems.
> 
> The quick check does:
> 
>     if (now < READ_ONCE(tick_next_period))
>     	return;
> 
> and the counterpart in the update is:
> 
>     WRITE_ONCE(tick_next_period, next_update_time);
> 
> This has two problems:
> 
>   1) On weakly ordered architectures there is no guarantee that the stores
>      before the WRITE_ONCE() are visible which means that other CPUs can
>      operate on a stale jiffies value.
> 
>   2) On 32bit the store of tick_next_period which is an u64 is split into
>      two 32bit stores. If the first 32bit store advances tick_next_period
>      far out and the second 32bit store is delayed (virt, NMI ...) then
>      jiffies will become stale until the second 32bit store happens.
> 
> Address this by seperating the handling for 32bit and 64bit.
> 
> On 64bit problem #1 is addressed by replacing READ_ONCE() / WRITE_ONCE()
> with smp_load_acquire() / smp_store_release().
> 
> On 32bit problem #2 is addressed by protecting the quick check with the
> jiffies sequence counter. The load and stores can be plain because the
> sequence count mechanics provides the required barriers already.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks very good! Thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
