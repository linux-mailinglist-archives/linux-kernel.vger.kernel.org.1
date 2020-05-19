Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511791DA26A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgESUT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:19:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FBDC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:19:25 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8hv-00012c-0o; Tue, 19 May 2020 22:19:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/8] Introduce local_lock()
Date:   Tue, 19 May 2020 22:19:04 +0200
Message-Id: <20200519201912.1564477-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preempt_disable() and local_irq_disable/save() are in principle per CPU big
kernel locks. This has several downsides:

  - The protection scope is unknown

  - Violation of protection rules is hard to detect by instrumentation

  - For PREEMPT_RT such sections, unless in low level critical code, can
    violate the preemptability constraints.

To address this PREEMPT_RT introduced the concept of local_locks which are
strictly per CPU.

The lock operations map to preempt_disable(), local_irq_disable/save() and
the enabling counterparts on non RT enabled kernels.

If lockdep is enabled local locks gain a lock map which tracks the usage
context. This will catch cases where an area is protected by
preempt_disable() but the access also happens from interrupt context. local
locks have identified quite a few such issues over the years, the most
recent example is:

  b7d5dc21072cd ("random: add a spinlock_t to struct batched_entropy")

Aside of the lockdep coverage this also improves code readability as it
precisely annotates the protection scope.

PREEMPT_RT substitutes these local locks with 'sleeping' spinlocks to
protect such sections while maintaining preemtability and CPU locality.

The following series introduces the infrastructure including
documentation and provides a couple of examples how they are used to
adjust code to be RT ready.

Sebastian


