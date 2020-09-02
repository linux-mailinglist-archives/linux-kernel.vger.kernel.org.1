Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBC25A818
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIBIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 04:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgIBIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:55:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B895207EA;
        Wed,  2 Sep 2020 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599036929;
        bh=XSL6G6Qu2uR5HLAFtRocNyj4crqp5skmu2VNvQ7XRR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUOo8gxWvD+LiR0t4vNlt6pHdphs40iKwRlOAPyuFeQKwCB6tpFJHnRZkgkJeeBk9
         aRljgbYCwf9fyPels69KSbJKoMMNmN5Dmtz9zZujA4B2byKnaDGzDJBeOMn+MIcFrA
         ubMEIuOP+8X7+xEKP94hnM//nJmVCOo2R/dhda4A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH rdma-next 4/4] gcov: Don't print out-of-memory print for all failed files
Date:   Wed,  2 Sep 2020 11:55:13 +0300
Message-Id: <20200902085513.748149-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902085513.748149-1-leon@kernel.org>
References: <20200902085513.748149-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Once GCOV fails to duplicate information, the following error is
printed:
 gcov: could not save data for '/home/leonro/src/kernel/drivers/infiniband/hw/mlx5/std_types.gcda' (out of memory)

In the event of out-of-memory such prints are seen for almost every kernel
file, so instead of spamming dmesg, we print the first failure and inform
the user that future prints are suppressed.

Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/gcov/fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 82babf5aa077..b74d426ca99e 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -685,8 +685,9 @@ static void save_info(struct gcov_node *node, struct gcov_info *info)
 	else {
 		node->unloaded_info = gcov_info_dup(info);
 		if (!node->unloaded_info) {
-			pr_warn("could not save data for '%s' "
-				"(out of memory)\n",
+			pr_warn_once(
+				"could not save data for first file '%s' "
+				"(out of memory), other files are suppressed\n",
 				gcov_info_filename(info));
 		}
 	}
--
2.26.2

