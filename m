Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926CB2D7258
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437050AbgLKIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:54:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:60424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392926AbgLKIx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:53:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607676790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=W1if7SktlQyaw0k06QJfTAiDbXDHkI8vZQRt4T89FBQ=;
        b=I64aHuRUrWqVzr2kNc9mF1V9MEivQ/+7hRCyNHqCCt7QbNWKcQc5CHwWJdwu3l19JdHdZ1
        nrqyLMLMHhs4FIO7BZt8lnmKNPRGFQCnJ9pVe7q2aO1vnbuBLtfDiD09z6n1v5+2CkMa2y
        RAGw+7KCkQ5qaLQx8RfMSuTJKyQnnqA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36BC8ACBD;
        Fri, 11 Dec 2020 08:53:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.10-rc8
Date:   Fri, 11 Dec 2020 09:53:09 +0100
Message-Id: <20201211085309.8128-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10c-rc8-tag

xen: branch for v5.10-rc8

It contains a short series fixing a regression introduced in 5.9 for
running as Xen dom0 on a system with NVMe backed storage.

Thanks.

Juergen

 drivers/block/xen-blkback/blkback.c |  89 +++++---------------------
 drivers/block/xen-blkback/common.h  |   4 +-
 drivers/block/xen-blkback/xenbus.c  |   6 +-
 drivers/xen/grant-table.c           | 123 ++++++++++++++++++++++++++++++++++++
 drivers/xen/unpopulated-alloc.c     |  20 +++---
 drivers/xen/xen-scsiback.c          |  60 ++++--------------
 include/xen/grant_table.h           |  17 +++++
 7 files changed, 182 insertions(+), 137 deletions(-)

Juergen Gross (2):
      xen: add helpers for caching grant mapping pages
      xen: don't use page->lru for ZONE_DEVICE memory
