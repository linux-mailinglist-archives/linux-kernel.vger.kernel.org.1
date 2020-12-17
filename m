Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B642DDAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgLQVpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:45:04 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:55216 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgLQVpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:45:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 569D4627AFCE;
        Thu, 17 Dec 2020 22:44:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MUWZ5Ib-p4CA; Thu, 17 Dec 2020 22:44:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AE3CB627AFF0;
        Thu, 17 Dec 2020 22:44:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ho1x2lLklSZJ; Thu, 17 Dec 2020 22:44:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8BD42627AFCE;
        Thu, 17 Dec 2020 22:44:21 +0100 (CET)
Date:   Thu, 17 Dec 2020 22:44:21 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <2026739641.140019.1608241461469.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS updates for 5.11-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: GQILcsYmmMsZqedHlVTLw1jJcSYSlA==
Thread-Topic: JFFS2, UBI and UBIFS updates for 5.11-rc1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.11-rc1

for you to fetch changes up to b80a974b8c58164ed57b0f025a47b8f003198d9e:

  ubifs: ubifs_dump_node: Dump all branches of the index node (2020-12-13 22:12:42 +0100)

----------------------------------------------------------------
This pull request contains changes for JFFS2, UBI and UBIFS:

JFFS2:
- Fix for a remount regression
- Fix for an abnormal GC exit
- Fix for a possible NULL pointer issue while mounting

UBI:
- Add support ECC-ed NOR flash
- Removal of dead code

UBIFS:
- Make node dumping debug code more reliable
- Various cleanups: less ifdefs, less typos
- Fix for an info leak

----------------------------------------------------------------
Chengguang Xu (1):
      ubifs: Code cleanup by removing ifdef macro surrounding

Chengsong Ke (2):
      ubifs: Fix the printing type of c->big_lpt
      ubifs: Remove the redundant return in dbg_check_nondata_nodes_order

Fangping Liang (1):
      ubifs: Fixed print foramt mismatch in ubifs

Jamie Iles (1):
      jffs2: Fix NULL pointer dereference in rp_size fs option parsing

Pratyush Yadav (1):
      ubi: Do not zero out EC and VID on ECC-ed NOR flashes

Randy Dunlap (2):
      ubifs: Delete duplicated words + other fixes
      jffs2: Fix if/else empty body warnings

Richard Weinberger (1):
      ubifs: wbuf: Don't leak kernel memory to flash

Tom Rix (1):
      jffs2: remove trailing semicolon in macro definition

Wang ShaoBo (1):
      ubifs: Fix error return code in ubifs_init_authentication()

Zhe Li (1):
      jffs2: Fix GC exit abnormally

Zhihao Cheng (5):
      ubifs: Limit dumping length by size of memory which is allocated for the node
      Revert "ubifs: Fix out-of-bounds memory access caused by abnormal value of node_len"
      ubifs: Pass node length in all node dumping callers
      ubifs: ubifs_dump_sleb: Remove unused function
      ubifs: ubifs_dump_node: Dump all branches of the index node

k00524021 (1):
      ubi: Remove useless code in bytes_str_to_int

lizhe (2):
      jffs2: Fix ignoring mounting options problem during remounting
      jffs2: Allow setting rp_size to zero during remounting

 drivers/mtd/ubi/build.c |   6 +--
 drivers/mtd/ubi/io.c    |   9 +++-
 fs/jffs2/debug.h        |  23 +++++-----
 fs/jffs2/jffs2_fs_sb.h  |   1 +
 fs/jffs2/nodelist.h     |   4 +-
 fs/jffs2/readinode.c    |  16 +++++++
 fs/jffs2/super.c        |  32 ++++++++++---
 fs/ubifs/auth.c         |   4 +-
 fs/ubifs/commit.c       |   4 +-
 fs/ubifs/debug.c        | 116 ++++++++++++++++++++++++++++--------------------
 fs/ubifs/debug.h        |   5 +--
 fs/ubifs/dir.c          |   4 +-
 fs/ubifs/file.c         |   8 +---
 fs/ubifs/io.c           |  52 ++++++++++------------
 fs/ubifs/journal.c      |   3 +-
 fs/ubifs/lpt.c          |   4 +-
 fs/ubifs/master.c       |   4 +-
 fs/ubifs/orphan.c       |   6 ++-
 fs/ubifs/recovery.c     |   6 +--
 fs/ubifs/replay.c       |   6 +--
 fs/ubifs/sb.c           |   2 +-
 fs/ubifs/scan.c         |   4 +-
 fs/ubifs/super.c        |   6 +--
 fs/ubifs/tnc.c          |  10 ++---
 fs/ubifs/tnc_misc.c     |   7 ++-
 fs/ubifs/ubifs.h        |  10 +++--
 26 files changed, 203 insertions(+), 149 deletions(-)
