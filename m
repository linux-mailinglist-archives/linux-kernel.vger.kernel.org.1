Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226DD2D7F83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392465AbgLKTjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387585AbgLKTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:39:08 -0500
From:   Jaegeuk Kim <jaegeuk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, Jaegeuk Kim <jaegeuk@google.com>
Subject: [PATCH] scsi: ufs: fix memory boundary check for UFS 3.0
Date:   Fri, 11 Dec 2020 11:38:14 -0800
Message-Id: <20201211193814.1709484-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@google.com>

If param_offset is greater than what UFS supports, it'll give kernel panic.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
Change-Id: I48ea6f3f3074bd42abf4ecf8be87806732f3e6a3
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d6a3a0ba6960..04687661d0df 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3194,6 +3194,9 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 		return -EINVAL;
 	}
 
+	if (param_offset > buff_len)
+		return -EINVAL;
+
 	/* Check whether we need temp memory */
 	if (param_offset != 0 || param_size < buff_len) {
 		desc_buf = kmalloc(buff_len, GFP_KERNEL);
-- 
2.29.2.576.ga3fc446d84-goog

