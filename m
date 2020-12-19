Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E671C2DF1C7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgLSVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbgLSVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608412297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dTGtJY+9wNly4hZX1MdxzXhtCkjgVNIWSrDydIXdAMU=;
        b=HVMR4v4MSDKtJpYxYzVYw5E/BHzNZTGVbXHSGsUXDVEYDxjluXun2E3Mt9knFFiQyhIOs6
        9llDlX5jtJXUFHlzD+1U8ciQ0ph6WhM/kZi2FKKPZY7svyt8SF37C99soRlozHCy/bhrfg
        7eFqU2TwSDnz9lyCp4VJ1kmrkRhBepE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-O8TbT4HqM-O4kPtYb3tHPQ-1; Sat, 19 Dec 2020 16:11:35 -0500
X-MC-Unique: O8TbT4HqM-O4kPtYb3tHPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E5EA180A093;
        Sat, 19 Dec 2020 21:11:34 +0000 (UTC)
Received: from max.home.com (ovpn-115-196.ams2.redhat.com [10.36.115.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2E561A7C1;
        Sat, 19 Dec 2020 21:11:29 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for 5.11
Date:   Sat, 19 Dec 2020 22:11:27 +0100
Message-Id: <20201219211127.287454-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 changes for 5.11?

Thanks a lot,
Andreas

The following changes since commit dd0ecf544125639e54056d851e4887dbb94b6d2f:

  gfs2: Fix deadlock between gfs2_{create_inode,inode_lookup} and delete_work_func (2020-12-01 00:21:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.11

for you to fetch changes up to 6e5c4ea37a99e5b97aba227fc43f3682d4bc0496:

  gfs2: in signal_our_withdraw wait for unfreeze of _this_ fs only (2020-12-03 17:04:41 +0100)

----------------------------------------------------------------
Changes in gfs2:
* Don't wait for unfreeze of the wrong filesystems.
* Remove an obsolete delete_work_func hack and an incorrect sb_start_write.
* Minor documentation updates and cosmetic care.

----------------------------------------------------------------
Andreas Gruenbacher (2):
      gfs2: Make inode operations static
      Revert "GFS2: Prevent delete work from occurring on glocks used for create"

Andrew Price (2):
      Documentation: Update filesystems/gfs2.rst
      MAINTAINERS: Add gfs2 bug tracker link

Bob Peterson (2):
      gfs2: Remove sb_start_write from gfs2_statfs_sync
      gfs2: in signal_our_withdraw wait for unfreeze of _this_ fs only

Tom Rix (1):
      gfs2: remove trailing semicolons from macro definitions

 Documentation/filesystems/gfs2.rst | 37 ++++++++++++++++++-------------------
 MAINTAINERS                        |  2 +-
 fs/gfs2/glock.c                    |  8 --------
 fs/gfs2/incore.h                   |  1 -
 fs/gfs2/inode.c                    | 16 ++++++++--------
 fs/gfs2/inode.h                    |  3 ---
 fs/gfs2/super.c                    |  2 --
 fs/gfs2/util.c                     |  2 +-
 fs/gfs2/util.h                     |  6 +++---
 9 files changed, 31 insertions(+), 46 deletions(-)

