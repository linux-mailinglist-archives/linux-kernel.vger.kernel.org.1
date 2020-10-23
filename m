Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A392972CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbgJWPqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S463664AbgJWPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603468010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TX4XQedEN+Ywa9WiNtmyeg6X9eUbMHcgElC578+OtLs=;
        b=NANpI7/Uxb63n8pHMbnLZgBylrcczW4BEJKl/jiqHAMtWqiy305V+31zg548sgsTqBya8b
        /30bkpw0iPM/D0XOzJ+YtUdLpnn/zBiD9FMXn3ClirnMih/EkEWrvhARxiloaEMG/Z2Zex
        QiE/YNfUfrnX5r77IEV/TjJTNTa8vv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-sYnoJ2D_PkmEf7-0f3ougg-1; Fri, 23 Oct 2020 11:46:49 -0400
X-MC-Unique: sYnoJ2D_PkmEf7-0f3ougg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF3B418B9F00;
        Fri, 23 Oct 2020 15:46:47 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC6BF277DF;
        Fri, 23 Oct 2020 15:46:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for 5.10
Date:   Fri, 23 Oct 2020 17:46:41 +0200
Message-Id: <20201023154642.1309908-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 changes for 5.10?

Thanks a lot,
Andreas

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.10

for you to fetch changes up to bedb0f056faa94e953e7b3da5a77d25e0008364b:

  gfs2: Recover statfs info in journal head (2020-10-23 15:47:38 +0200)

----------------------------------------------------------------
Changes in gfs2:
* Use iomap for non-journaled buffered I/O.  This largely eliminates buffer
  heads on filesystems where the block size matches the page size.  Many thanks
  to Christoph Hellwig for this patch!
* Fixes for some more journaled data filesystem bugs, found by running xfstests
  with data journaling on for all files (chattr +j $MNT) (Bob Peterson).
* gfs2_evict_inode refactoring (Bob Peterson).
* Use the statfs data in the journal during recovery instead of reading it in
  from the local statfs inodes (Abhi Das).
* Several other minor fixes by various people.

----------------------------------------------------------------
Abhi Das (3):
      gfs2: Add fields for statfs info in struct gfs2_log_header_host
      gfs2: lookup local statfs inodes prior to journal recovery
      gfs2: Recover statfs info in journal head

Anant Thazhemadam (1):
      gfs2: add validation checks for size of superblock

Andreas Gruenbacher (2):
      gfs2: Make sure we don't miss any delayed withdraws
      gfs2: Ignore subsequent errors after withdraw in rgrp_go_sync

Andrew Price (1):
      gfs2: Fix NULL pointer dereference in gfs2_rgrp_dump

Bob Peterson (20):
      gfs2: Fix bad comment for trans_drain
      gfs2: rename variable error to ret in gfs2_evict_inode
      gfs2: factor evict_unlinked_inode out of gfs2_evict_inode
      gfs2: further simplify gfs2_evict_inode with new func evict_should_delete
      gfs2: factor evict_linked_inode out of gfs2_evict_inode
      gfs2: simplify the logic in gfs2_evict_inode
      gfs2: call truncate_inode_pages_final for address space glocks
      gfs2: rename gfs2_write_full_page to gfs2_write_jdata_page, remove parm
      gfs2: add missing log_blocks trace points in gfs2_write_revokes
      gfs2: enhance log_blocks trace point to show log blocks free
      gfs2: Wipe jdata and ail1 in gfs2_journal_wipe, formerly gfs2_meta_wipe
      gfs2: make gfs2_ail1_empty_one return the count of active items
      gfs2: don't lock sd_ail_lock in gfs2_releasepage
      gfs2: Only set PageChecked if we have a transaction
      gfs2: simplify gfs2_block_map
      gfs2: Ignore journal log writes for jdata holes
      gfs2: eliminate GLF_QUEUED flag in favor of list_empty(gl_holders)
      gfs2: Fix comments to glock_hash_walk
      gfs2: Only access gl_delete for iopen glocks
      gfs2: Eliminate gl_vm

Christoph Hellwig (1):
      gfs2: use iomap for buffered I/O in ordered and writeback mode

Jamie Iles (1):
      gfs2: use-after-free in sysfs deregistration

Liu Shixin (1):
      gfs2: convert to use DEFINE_SEQ_ATTRIBUTE macro

 fs/gfs2/aops.c       |  68 ++++++++--------
 fs/gfs2/bmap.c       |  62 ++++++++++-----
 fs/gfs2/bmap.h       |   1 +
 fs/gfs2/glock.c      |  52 +++++-------
 fs/gfs2/glops.c      |  36 +++++----
 fs/gfs2/incore.h     |  29 ++++---
 fs/gfs2/log.c        |  89 ++++++++++++---------
 fs/gfs2/log.h        |   2 +-
 fs/gfs2/lops.c       |   2 +-
 fs/gfs2/lops.h       |   1 +
 fs/gfs2/meta_io.c    |  81 +++++++++++++++++--
 fs/gfs2/meta_io.h    |   2 +-
 fs/gfs2/ops_fstype.c | 173 ++++++++++++++++++++++++++--------------
 fs/gfs2/recovery.c   | 108 +++++++++++++++++++++++++
 fs/gfs2/rgrp.c       |  19 ++---
 fs/gfs2/rgrp.h       |   2 +-
 fs/gfs2/super.c      | 220 +++++++++++++++++++++++++++++++++++----------------
 fs/gfs2/super.h      |   5 ++
 fs/gfs2/sys.c        |   5 +-
 fs/gfs2/trace_gfs2.h |   7 +-
 fs/gfs2/util.c       |   2 +-
 fs/gfs2/util.h       |  10 +++
 22 files changed, 675 insertions(+), 301 deletions(-)

