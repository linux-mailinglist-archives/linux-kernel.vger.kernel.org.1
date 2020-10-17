Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AB291427
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 21:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439570AbgJQThy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 15:37:54 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38580 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439563AbgJQThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 15:37:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 56E2B60CEF32;
        Sat, 17 Oct 2020 21:37:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m0kJdn8TDqs2; Sat, 17 Oct 2020 21:37:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03C7861BD1BE;
        Sat, 17 Oct 2020 21:37:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4dXnLFEmgykj; Sat, 17 Oct 2020 21:37:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E1C9560CEF32;
        Sat, 17 Oct 2020 21:37:51 +0200 (CEST)
Date:   Sat, 17 Oct 2020 21:37:51 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1486301546.204164.1602963471897.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS fixes for 5.10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: jaq7gxmyAA8IX8Qb9elec8UKhS+vww==
Thread-Topic: UBI and UBIFS fixes for 5.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

sorry for sending you two UBIFS pull requests.
for-linus-5.10-rc1-part2 is material from my fixes branch, the plan
was sending it before the merge window closes but I got badly interrupted.
Therefore I'm sending it parallel to my regular UBIFS pull request.

The following changes since commit e4c26faa426c17274884f759f708bc9ee22fd59a:

  Merge tag 'usb-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2020-09-13 09:23:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.10-rc1-part2

for you to fetch changes up to 78c7d49f55d8631b67c09f9bfbe8155211a9ea06:

  ubifs: journal: Make sure to not dirty twice for auth nodes (2020-09-29 10:43:05 +0200)

----------------------------------------------------------------
This pull request contains fixes for UBI and UBIFS

UBI:
- Correctly use kthread_should_stop in ubi worker

UBIFS:

- Fixes for memory leaks while iterating directory entries
- Fix for a user triggerable error message
- Fix for a space accounting bug in authenticated mode

----------------------------------------------------------------
Richard Weinberger (1):
      ubifs: journal: Make sure to not dirty twice for auth nodes

Zhihao Cheng (5):
      ubifs: xattr: Fix some potential memory leaks while iterating entries
      ubifs: dent: Fix some potential memory leaks while iterating entries
      ubi: check kthread_should_stop() after the setting of task state
      ubifs: ubifs_jnl_change_xattr: Remove assertion 'nlink > 0' for host inode
      ubifs: setflags: Don't show error message when vfs_ioc_setflags_prepare() fails

 drivers/mtd/ubi/wl.c | 13 +++++++++++++
 fs/ubifs/debug.c     |  1 +
 fs/ubifs/ioctl.c     |  1 -
 fs/ubifs/journal.c   |  7 ++++---
 fs/ubifs/orphan.c    |  2 ++
 fs/ubifs/tnc.c       |  3 +++
 fs/ubifs/xattr.c     |  2 ++
 7 files changed, 25 insertions(+), 4 deletions(-)
