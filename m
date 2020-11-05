Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACFD2A7BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKEK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgKEK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604572060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TPYmvw+3BxudAZtmmFx1cRunq0cjnCfZYd5exiTXfPE=;
        b=ghXGpXACZ9Py6vQ4aZsP8/d94DEmMwGLMqW4ZdoacBEPFKf/FuoiSPjn2c94789E9yINil
        E9u1SsskAakzMS/W9UXUa4+0oy69gQqOEtiWR2n2XIJx53RHQv88lhG/ojn2uvjaI31cuC
        8GdwrXhL9verj+dIo2yPfeZKEeMOvbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Th_LxoqFPkyIVNLh0rOyvw-1; Thu, 05 Nov 2020 05:27:38 -0500
X-MC-Unique: Th_LxoqFPkyIVNLh0rOyvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9AC71868411;
        Thu,  5 Nov 2020 10:27:37 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0407E5B4DC;
        Thu,  5 Nov 2020 10:27:32 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 fixes for 5.10-rc1
Date:   Thu,  5 Nov 2020 11:27:31 +0100
Message-Id: <20201105102731.1832011-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes on top of 5.10-rc1 (ish).

Thank you very much,
Andreas

The following changes since commit 4525c8781ec0701ce824e8bd379ae1b129e26568:

  scsi: qla2xxx: remove incorrect sparse #ifdef (2020-10-26 15:45:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc1-fixes

for you to fetch changes up to da7d554f7c62d0c17c1ac3cc2586473c2d99f0bd:

  gfs2: Wake up when sd_glock_disposal becomes zero (2020-11-03 14:39:11 +0100)

----------------------------------------------------------------
Various gfs2 fixes

----------------------------------------------------------------
Alexander Aring (1):
      gfs2: Wake up when sd_glock_disposal becomes zero

Andreas Gruenbacher (1):
      gfs2: Don't call cancel_delayed_work_sync from within delete work function

Bob Peterson (6):
      gfs2: Free rd_bits later in gfs2_clear_rgrpd to fix use-after-free
      gfs2: Add missing truncate_inode_pages_final for sd_aspace
      gfs2: init_journal's undo directive should also undo the statfs inodes
      gfs2: Split up gfs2_meta_sync into inode and rgrp versions
      gfs2: don't initialize statfs_change inodes in spectator mode
      gfs2: check for live vs. read-only file system in gfs2_fitrim

 fs/gfs2/glock.c      |  3 ++-
 fs/gfs2/glops.c      | 56 +++++++++++++++++++++++++++++++++++++++++-----------
 fs/gfs2/glops.h      |  1 +
 fs/gfs2/inode.c      |  3 ++-
 fs/gfs2/lops.c       | 31 +++++------------------------
 fs/gfs2/lops.h       |  2 --
 fs/gfs2/ops_fstype.c | 14 ++++++++-----
 fs/gfs2/recovery.c   |  2 +-
 fs/gfs2/rgrp.c       |  5 ++++-
 fs/gfs2/super.c      |  1 +
 10 files changed, 70 insertions(+), 48 deletions(-)

