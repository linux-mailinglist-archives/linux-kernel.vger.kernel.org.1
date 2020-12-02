Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85C2CC88C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgLBVBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 16:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730798AbgLBVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606942782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+vREiEPZRIjTwsNkTSi1a+k2IWXR/FPdIg8I6gi4lcI=;
        b=QibGCLgW+O5sTZBqYFhGeSC9dsRFNmFFTOH9qLNEHljBCKooOBx1tiISfUo0eguU8WJmeX
        0WfJLvzfZvQutFHeP1paqS8ir3Y2wD8grzMhyL1XXRnJ+BcOsI97HvF7kB5ZGPA4LtBio/
        I1zQl1cDnp9h1N3QGa2Jy/YbU1sDCGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-QTsGKSVoPYq-A0NoWPK3Rw-1; Wed, 02 Dec 2020 15:59:41 -0500
X-MC-Unique: QTsGKSVoPYq-A0NoWPK3Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 634B980364B;
        Wed,  2 Dec 2020 20:58:42 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEDF19D7C;
        Wed,  2 Dec 2020 20:58:41 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for 5.10-rc5
Date:   Wed,  2 Dec 2020 21:58:39 +0100
Message-Id: <20201202205839.843476-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following additional gfs2 fixes.

Thanks,
Andreas

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc5-fixes

for you to fetch changes up to dd0ecf544125639e54056d851e4887dbb94b6d2f:

  gfs2: Fix deadlock between gfs2_{create_inode,inode_lookup} and delete_work_func (2020-12-01 00:21:10 +0100)

----------------------------------------------------------------
Various gfs2 fixes

----------------------------------------------------------------
Alexander Aring (2):
      gfs2: Fix deadlock dumping resource group glocks
      gfs2: set lockdep subclass for iopen glocks

Andreas Gruenbacher (2):
      gfs2: Upgrade shared glocks for atime updates
      gfs2: Fix deadlock between gfs2_{create_inode,inode_lookup} and delete_work_func

Bob Peterson (2):
      gfs2: check for empty rgrp tree in gfs2_ri_update
      gfs2: Don't freeze the file system during unmount

 fs/gfs2/glock.c  |  1 +
 fs/gfs2/glops.c  |  6 ++++--
 fs/gfs2/incore.h |  1 +
 fs/gfs2/inode.c  | 42 ++++++++++++++++++++++++++++++++----------
 fs/gfs2/rgrp.c   |  4 ++++
 5 files changed, 42 insertions(+), 12 deletions(-)

