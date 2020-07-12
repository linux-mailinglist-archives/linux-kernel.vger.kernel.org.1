Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7556621C867
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 12:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgGLKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 06:01:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4515 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGLKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:01:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0adf450002>; Sun, 12 Jul 2020 03:00:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:01:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 Jul 2020 03:01:33 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:01:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:01:33 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0adf7a0001>; Sun, 12 Jul 2020 03:01:31 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/5] firmware: tegra: add return code checks and increase debugfs size
Date:   Sun, 12 Jul 2020 11:01:14 +0100
Message-ID: <20200712100118.13343-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200712100118.13343-1-jonathanh@nvidia.com>
References: <20200712100118.13343-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594548037; bh=xUzUpGcr+ODAv29x11rYaSfGnqlrAXpzBtnNbmeA7+8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PojqOdHuWX0yPWQMc4zSfSWJyz4hr7pwEv/45gOkpo577Aoi5fsaJkoESG8dJ4BQ9
         O/yHhMlx4nsUQGzXfNHvbfiz2dHHqUe/VNgY3Ekn+LXMYRDa2QSXSFj6x0psYzDQ7W
         klRi7WGVPw8yFF1pP0Qr3imFYZh5ThIrGok2LCfujVCAxMQEFrXisDje7iD3DYxoIB
         pSBVwy33Gn/k0JbZ42W/SqiroHNvgGh8tngV7CxpWpN5a75iaqWCVdIozo16kvCxdi
         gRjFpkvCK3XIu920GaTXBxPJMFYxei9ALZK+3fEW5YSM78Ag70sEM5ltt2PTlbQT+z
         Yn7SPpD9oGB9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Alho <talho@nvidia.com>

Add checking of the BPMP-FW return code values for MRQ_DEBUGFS calls.

Also, development versions of the firmware may have debugfs with
directory structure larger than 256Kb. Hence increase the size of the
memory buffer to accommodate those firmware revisions.

And finally, ensure that no access outside of allocated memory buffer
happens in case BPMP-FW returns an invalid response size (nbytes) from
mrq_debugfs_dumpdir() call.

Signed-off-by: Timo Alho <talho@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 3f0a89ce131a..08e0f05f46c6 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -127,6 +127,8 @@ static int mrq_debugfs_read(struct tegra_bpmp *bpmp,
 	err = tegra_bpmp_transfer(bpmp, &msg);
 	if (err < 0)
 		return err;
+	else if (msg.rx.ret < 0)
+		return -EINVAL;
 
 	*nbytes = (size_t)resp.fop.nbytes;
 
@@ -184,6 +186,8 @@ static int mrq_debugfs_dumpdir(struct tegra_bpmp *bpmp, dma_addr_t addr,
 	err = tegra_bpmp_transfer(bpmp, &msg);
 	if (err < 0)
 		return err;
+	else if (msg.rx.ret < 0)
+		return -EINVAL;
 
 	*nbytes = (size_t)resp.dumpdir.nbytes;
 
@@ -374,7 +378,7 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 {
 	dma_addr_t phys;
 	void *virt;
-	const size_t sz = SZ_256K;
+	const size_t sz = SZ_512K;
 	size_t nbytes;
 	int ret;
 	struct dentry *root;
@@ -394,8 +398,12 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 	}
 
 	ret = mrq_debugfs_dumpdir(bpmp, phys, sz, &nbytes);
-	if (ret < 0)
+	if (ret < 0) {
+		goto free;
+	} else if (nbytes > sz) {
+		ret = -EINVAL;
 		goto free;
+	}
 
 	ret = create_debugfs_mirror(bpmp, virt, nbytes, root);
 free:
-- 
2.17.1

