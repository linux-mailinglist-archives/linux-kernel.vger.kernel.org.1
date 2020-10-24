Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A9297E39
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764169AbgJXTqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:46:55 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45635 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763904AbgJXTqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:46:55 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09OJkoLo013765;
        Sat, 24 Oct 2020 21:46:50 +0200
From:   Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 0/3] random32: make prandom_u32() less predictable
Date:   Sat, 24 Oct 2020 21:46:18 +0200
Message-Id: <20201024194621.13720-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The code is also available for you to pull at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/prandom.git tags/20201024-v4-5.10

---
v4:
  - access noise using raw_cpu_read() instead of this_cpu_read()
  - fixed build with CONFIG_RANDOM32_SELFTEST
  - added a selftest for the prandom32 code
   
v3:
  This v3 is a rebase on top of 5.9-final, and switches __this_cpu_read()
  for this_cpu_read() to address a crash on i386+SMP+PREEMPT reported by
  LKP. Nothing else was changed.

George Spelvin (1):
  random32: make prandom_u32() output unpredictable

Willy Tarreau (2):
  random32: add noise from network and scheduling activity
  random32: add a selftest for the prandom32 code

 drivers/char/random.c   |   1 -
 include/linux/prandom.h |  55 ++++-
 kernel/time/timer.c     |   9 +-
 lib/random32.c          | 525 ++++++++++++++++++++++++++--------------
 net/core/dev.c          |   4 +
 5 files changed, 404 insertions(+), 190 deletions(-)

-- 
2.28.0

