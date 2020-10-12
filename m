Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D528C272
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgJLUcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:32:52 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43422 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgJLUcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:32:52 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09CKWQkJ011866;
        Mon, 12 Oct 2020 22:32:26 +0200
Date:   Mon, 12 Oct 2020 22:32:26 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     George Spelvin <lkml@sdf.org>, Amit Klein <aksecurity@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, tytso@mit.edu,
        Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] prandom32 changes for v5.10
Message-ID: <20201012203226.GA11861@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Given that nobody objected to this patchset since last update on
prandom32 a month ago, I'm sending you the refreshed one for 5.10.

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/prandom.git tags/20201012-v3-5.10

for you to fetch changes up to 3486a21c7e5bafbdbc0f7ea5d40f3dad39022bf4:

  random32: add noise from network and scheduling activity (2020-10-12 18:11:51 +0200)

Thanks!
Willy

----------------------------------------------------------------
This is the cleanup of the latest series of prandom_u32 experimentations
consisting in using SipHash instead of Tausworthe to produce the randoms
used by the network stack. The changes to the files were kept minimal,
and the controversial commit that used to take noise from the fast_pool
(f227e3ec3b5c) was reverted. Instead, a dedicated "net_rand_noise" per_cpu
variable is fed from various sources of activities (networking, scheduling)
to perturb the SipHash state using fast, non-trivially predictable data,
instead of keeping it fully deterministic. The goal is essentially to make
any occasional memory leakage or brute-force attempt useless.

The resulting code was verified to be very slightly faster on x86_64 than
what is was with the controversial commit above, though this remains barely
above measurement noise. It was also tested on i386 and arm, and build-
tested only on arm64.

This v3 is a rebase on top of 5.9-final, and switches __this_cpu_read()
for this_cpu_read() to address a crash on i386+SMP+PREEMPT reported by
LTP. Nothing else was changed.

----------------------------------------------------------------
George Spelvin (1):
      random32: make prandom_u32() output unpredictable

Willy Tarreau (1):
      random32: add noise from network and scheduling activity

 drivers/char/random.c   |   1 -
 include/linux/prandom.h |  55 +++++-
 kernel/time/timer.c     |   9 +-
 lib/random32.c          | 438 +++++++++++++++++++++++++++++-------------------
 net/core/dev.c          |   4 +
 5 files changed, 326 insertions(+), 181 deletions(-)
