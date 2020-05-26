Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9501C838C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEGHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 03:36:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50240 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgEGHfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:35:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 46113200F14;
        Thu,  7 May 2020 09:35:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35339200F10;
        Thu,  7 May 2020 09:35:47 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D1793203C5;
        Thu,  7 May 2020 09:35:46 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v2 10/12] bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
Date:   Thu,  7 May 2020 10:34:29 +0300
Message-Id: <20200507073431.2710-11-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
References: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before destroying the mc_io, check first that it was
allocated.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/mc-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 6ae48ad80409..e1dfe4a76519 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -129,7 +129,12 @@ int __must_check fsl_create_mc_io(struct device *dev,
  */
 void fsl_destroy_mc_io(struct fsl_mc_io *mc_io)
 {
-	struct fsl_mc_device *dpmcp_dev = mc_io->dpmcp_dev;
+	struct fsl_mc_device *dpmcp_dev;
+
+	if (!mc_io)
+		return;
+
+	dpmcp_dev = mc_io->dpmcp_dev;
 
 	if (dpmcp_dev)
 		fsl_mc_io_unset_dpmcp(mc_io);
-- 
2.17.1

