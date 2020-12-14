Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2862D9ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440783AbgLNSSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502360AbgLNRi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:38:59 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.9 050/105] scsi: ufs: Make sure clk scaling happens only when HBA is runtime ACTIVE
Date:   Mon, 14 Dec 2020 18:28:24 +0100
Message-Id: <20201214172557.687584582@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214172555.280929671@linuxfoundation.org>
References: <20201214172555.280929671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

[ Upstream commit 73cc291c270248567245f084dcdf5078069af6b5 ]

If someone plays with the UFS clk scaling devfreq governor through sysfs,
ufshcd_devfreq_scale may be called even when HBA is not runtime ACTIVE.
This can lead to unexpected error. We cannot just protect it by calling
pm_runtime_get_sync() because that may cause a race condition since HBA
runtime suspend ops need to suspend clk scaling. To fix this call
pm_runtime_get_noresume() and check HBA's runtime status. Only proceed if
HBA is runtime ACTIVE, otherwise just bail.

governor_store
 devfreq_performance_handler
  update_devfreq
   devfreq_set_target
    ufshcd_devfreq_target
     ufshcd_devfreq_scale

Link: https://lore.kernel.org/r/1600758548-28576-1-git-send-email-cang@codeaurora.org
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index cbcdd79a1f76f..18326eb772aeb 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1279,8 +1279,15 @@ static int ufshcd_devfreq_target(struct device *dev,
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
+	pm_runtime_get_noresume(hba->dev);
+	if (!pm_runtime_active(hba->dev)) {
+		pm_runtime_put_noidle(hba->dev);
+		ret = -EAGAIN;
+		goto out;
+	}
 	start = ktime_get();
 	ret = ufshcd_devfreq_scale(hba, scale_up);
+	pm_runtime_put(hba->dev);
 
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 		(scale_up ? "up" : "down"),
-- 
2.27.0



