Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274762D868D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 14:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439016AbgLLNBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 08:01:54 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:56853 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438989AbgLLNAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:50 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d19 with ME
        id 3KxH2400D1HrHD103KxJ4V; Sat, 12 Dec 2020 08:57:19 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 08:57:19 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     axboe@kernel.dk, qiang.liu@freescale.com, jgarzik@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sata_fsl: Fix a resource leak in an error handling path in the probe function
Date:   Sat, 12 Dec 2020 08:57:16 +0100
Message-Id: <20201212075716.78986-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'irq_dispose_mapping()' should be called in the error handling path of the
probe function, as already done in the remove function.

Fixes: 6b4b8fc87dc5 ("sata_fsl: add support for interrupt coalsecing feature")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/ata/sata_fsl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d55ee244d693..49ecbc55a804 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1540,6 +1540,9 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	if (host)
 		ata_host_detach(host);
 
+	if (host_priv && host_priv->irq)
+		irq_dispose_mapping(host_priv->irq);
+
 	if (hcr_base)
 		iounmap(hcr_base);
 	kfree(host_priv);
-- 
2.27.0

