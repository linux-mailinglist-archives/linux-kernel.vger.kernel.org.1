Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119E51B7371
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgDXLvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 07:51:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34656 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgDXLvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:51:25 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A27361A03A9;
        Fri, 24 Apr 2020 13:51:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 93DF11A039B;
        Fri, 24 Apr 2020 13:51:23 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3540B205C6;
        Fri, 24 Apr 2020 13:51:23 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     linux-kernel@vger.kernel.org, Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] soc: fsl: dpio: Prefer the CPU affine DPIO
Date:   Fri, 24 Apr 2020 14:51:12 +0300
Message-Id: <20200424115112.22437-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Pledge <roy.pledge@nxp.com>

Use the cpu affine DPIO unless there isn't one which can happen
if less DPIOs than cores are assign to the kernel.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index cd4f6410e8c2..f1080c7a3fe1 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -58,7 +58,7 @@ static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,
 	 * If cpu == -1, choose the current cpu, with no guarantees about
 	 * potentially being migrated away.
 	 */
-	if (unlikely(cpu < 0))
+	if (cpu < 0)
 		cpu = smp_processor_id();
 
 	/* If a specific cpu was requested, pick it up immediately */
@@ -70,6 +70,10 @@ static inline struct dpaa2_io *service_select(struct dpaa2_io *d)
 	if (d)
 		return d;
 
+	d = service_select_by_cpu(d, -1);
+	if (d)
+		return d;
+
 	spin_lock(&dpio_list_lock);
 	d = list_entry(dpio_list.next, struct dpaa2_io, node);
 	list_del(&d->node);
-- 
2.17.1

