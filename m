Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5882A34AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgKBT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgKBT5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:57:11 -0500
Received: from localhost.localdomain (cpe-70-114-140-30.austin.res.rr.com [70.114.140.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3820E2076E;
        Mon,  2 Nov 2020 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604347030;
        bh=d8i7qIjkeTQr/yZuyeY0/03lXGvwQ7SL9FuL8qbKbGU=;
        h=From:To:Cc:Subject:Date:From;
        b=MacmxI8YkqGngUsnd/SdP4H+a2t89NNG7HB5lVJDHRaSDdHwCp2ANAkzkoA8JCecy
         3Cvp41RNes4hTdfEQbuBsenvtbTVszwX3GcJOMqPgHgjxHPkdDcGTSWIC6GA+pmKEd
         Wo6RR+tGxbi1H1GRGjyUYG3T0HWGl8rFSg3dGYHU=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: socfpga: add error handling and release mem-region
Date:   Mon,  2 Nov 2020 13:57:02 -0600
Message-Id: <20201102195702.14496-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of an error, call release_mem_region when an error happens
during allocation of resources. Also add error handling for the case
that reset_controller_register fails.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/reset/reset-socfpga.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index bdd984296196..af9041ec37c6 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -44,7 +44,7 @@ static int a10_reset_init(struct device_node *np)
 	data->membase = ioremap(res.start, size);
 	if (!data->membase) {
 		ret = -ENOMEM;
-		goto err_alloc;
+		goto release_region;
 	}
 
 	if (of_property_read_u32(np, "altr,modrst-offset", &reg_offset))
@@ -59,7 +59,14 @@ static int a10_reset_init(struct device_node *np)
 	data->rcdev.of_node = np;
 	data->status_active_low = true;
 
-	return reset_controller_register(&data->rcdev);
+	ret = reset_controller_register(&data->rcdev);
+	if (ret)
+		pr_err("unable to register device\n");
+
+	return 0;
+
+release_region:
+	release_mem_region(res.start, size);
 
 err_alloc:
 	kfree(data);
-- 
2.17.1

