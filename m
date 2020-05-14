Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0161D3F89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgENVDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 17:03:12 -0400
Received: from [66.170.99.2] ([66.170.99.2]:28072 "EHLO
        sid-build-box.eng.vmware.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgENVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:03:11 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 17:03:10 EDT
Received: by sid-build-box.eng.vmware.com (Postfix, from userid 1000)
        id F3E21BA20C5; Fri, 15 May 2020 02:26:04 +0530 (IST)
From:   Siddharth Chandrasekaran <csiddharth@vmware.com>
To:     gregkh@linuxfoundation.org
Cc:     srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, csiddharth@vmware.com,
        siddharth@embedjournal.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Date:   Fri, 15 May 2020 02:25:20 +0530
Message-Id: <cover.1589486724.git.csiddharth@vmware.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of proper validation that cached inodes are free during allocation,
causes a crash (refer to CVE-2018-13093 for more details). To address this
issue, I'm backporting upstream commit [1] to 4.4 and 4.9 stable trees
(a backport of [1] to 4.14 already exists).

Also, commit [1] references another commit [2] which added checks only to
xfs_iget_cache_miss(). In this patch, those checks have been moved into a
dedicated checker method and both xfs_iget_cache_miss() and
xfs_iget_cache_hit() are made to call that method. This code reorg in commit
[1], makes commit [2] redundant in the history of the 4.9 and 4.4 stable
trees. So commit [2] is not being backported.

-- Sid

[1]: afca6c5b2595f ("xfs: validate cached inodes are free when allocated")
[2]: ee457001ed6c ("xfs: catch inode allocation state mismatch corruption")

[v4.9]
Dave Chinner (1):
  xfs: More robust inode extent count validation

 fs/xfs/libxfs/xfs_format.h    |   3 ++
 fs/xfs/libxfs/xfs_inode_buf.c | 112 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 3 deletions(-)

[v.4.4]
Dave Chinner (1):
  xfs: validate cached inodes are free when allocated

 fs/xfs/xfs_icache.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

-- 
2.7.4

