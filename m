Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614182717A8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgITTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:51:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITTvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:51:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0242AD1A;
        Sun, 20 Sep 2020 19:52:05 +0000 (UTC)
Date:   Sun, 20 Sep 2020 21:51:20 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v5.9-rc6
Message-ID: <20200920195120.GE13044@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two fixes from the locking/urgent pile.

Thx.

---

The following changes since commit fc3abb53250a90ba2150eebd182137c136f4d25a:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2020-09-02 12:55:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.9_rc6

for you to fetch changes up to e6b1a44eccfcab5e5e280be376f65478c3b2c7a2:

  locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count (2020-09-16 16:26:56 +0200)

----------------------------------------------------------------
* Fix lockdep's detection of "USED" <- "IN-NMI" inversions, from Peter
  Zijlstra.

* Make percpu-rwsem operations on the semaphore's ->read_count IRQ-safe
  because it can be used in an IRQ context, from Hou Tao.

----------------------------------------------------------------
Hou Tao (1):
      locking/percpu-rwsem: Use this_cpu_{inc,dec}() for read_count

peterz@infradead.org (1):
      locking/lockdep: Fix "USED" <- "IN-NMI" inversions

 include/linux/percpu-rwsem.h       |  8 ++++----
 kernel/locking/lockdep.c           | 35 +++++++++++++++++++++++++++++------
 kernel/locking/lockdep_internals.h |  2 ++
 kernel/locking/percpu-rwsem.c      |  4 ++--
 4 files changed, 37 insertions(+), 12 deletions(-)
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
