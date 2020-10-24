Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7435E297E30
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764073AbgJXTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:35:49 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45629 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761860AbgJXTft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:35:49 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09OJYltX013487;
        Sat, 24 Oct 2020 21:34:47 +0200
Date:   Sat, 24 Oct 2020 21:34:47 +0200
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
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] prandom32 changes for v5.10
Message-ID: <20201024193447.GA13462@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've addressed the build issues when CONFIG_RANDOM32_SELFTEST is enabled,
and also added a self-test for the new code (last patch of the series).
As I previously questionned, I finally replaced this_cpu_read(noise) with
raw_cpu_read(noise) as it it's pointless to deal with interrupts here
since we're just collecting noise.

Last point, I kept George as the author despite not being his real name,
as I saw he already signed-off other commits.

Please let me know if you have any question or comment.

The following changes since commit f11901ed723d1351843771c3a84b03a253bbf8b2:

  Merge tag 'xfs-5.10-merge-7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2020-10-23 17:15:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/prandom.git tags/20201024-v4-5.10

for you to fetch changes up to c6e169bc146a76d5ccbf4d3825f705414352bd03:

  random32: add a selftest for the prandom32 code (2020-10-24 20:21:57 +0200)

----------------------------------------------------------------
random32: make prandom_u32() less predictable

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

The whole discussion around this is archived here:
  https://lore.kernel.org/netdev/20200808152628.GA27941@SDF.ORG/

---
v4:
  - access noise using raw_cpu_read() instead of this_cpu_read()
  - fixed build with CONFIG_RANDOM32_SELFTEST
  - added a selftest for the prandom32 code
   
v3:
  This v3 is a rebase on top of 5.9-final, and switches __this_cpu_read()
  for this_cpu_read() to address a crash on i386+SMP+PREEMPT reported by
  LKP. Nothing else was changed.

----------------------------------------------------------------
George Spelvin (1):
      random32: make prandom_u32() output unpredictable

Willy Tarreau (2):
      random32: add noise from network and scheduling activity
      random32: add a selftest for the prandom32 code

 drivers/char/random.c   |   1 -
 include/linux/prandom.h |  55 ++++-
 kernel/time/timer.c     |   9 +-
 lib/random32.c          | 525 +++++++++++++++++++++++++++++++-----------------
 net/core/dev.c          |   4 +
 5 files changed, 404 insertions(+), 190 deletions(-)
