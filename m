Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDC291426
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439560AbgJQTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 15:37:44 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38542 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439493AbgJQThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 15:37:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2D2BB60D08E2;
        Sat, 17 Oct 2020 21:37:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Eip9PB_mMbxU; Sat, 17 Oct 2020 21:37:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD75960CEF32;
        Sat, 17 Oct 2020 21:37:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id arRzhrWI9mlK; Sat, 17 Oct 2020 21:37:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 955DE60D08E2;
        Sat, 17 Oct 2020 21:37:40 +0200 (CEST)
Date:   Sat, 17 Oct 2020 21:37:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <725261806.204163.1602963460565.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBIFS updates for 5.10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: h11JVjUYgazpIXZdDEKxuvhAbDCKPQ==
Thread-Topic: UBIFS updates for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.10-rc1

for you to fetch changes up to e2a05cc7f8229e150243cdae40f2af9021d67a4a:

  ubifs: mount_ubifs: Release authentication resource in error handling path (2020-10-11 22:05:50 +0200)

----------------------------------------------------------------
This pull request contains changes for UBIFS

- Kernel-doc fixes
- Fixes for memory leaks in authentication option parsing

----------------------------------------------------------------
Wang Hai (4):
      ubifs: Fix 'hash' kernel-doc warning in auth.c
      ubifs: Fix some kernel-doc warnings in gc.c
      ubifs: Fix some kernel-doc warnings in replay.c
      ubifs: Fix some kernel-doc warnings in tnc.c

Zhihao Cheng (3):
      ubifs: Fix a memleak after dumping authentication mount options
      ubifs: Don't parse authentication mount options in remount process
      ubifs: mount_ubifs: Release authentication resource in error handling path

 fs/ubifs/auth.c   |  2 +-
 fs/ubifs/gc.c     |  4 ----
 fs/ubifs/replay.c |  2 --
 fs/ubifs/super.c  | 44 ++++++++++++++++++++++++++++++++------------
 fs/ubifs/tnc.c    |  3 +--
 5 files changed, 34 insertions(+), 21 deletions(-)
