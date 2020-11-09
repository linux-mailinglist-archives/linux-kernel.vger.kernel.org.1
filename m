Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162BE2AC4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgKITVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgKITVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:21:50 -0500
Received: from localhost.localdomain (cpe-70-114-140-30.austin.res.rr.com [70.114.140.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B85E206E3;
        Mon,  9 Nov 2020 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604949710;
        bh=TOUAOd/R5eTaHFTLizU4RXRWtH3VPl0iSC0u1G29ujs=;
        h=From:To:Cc:Subject:Date:From;
        b=ToNGRCYPSgQmXP2zE+Oi6OE8sZnuPf+McOq9hEkhe22zsK0sMAHeL2tdAog92nQYF
         exQcB/cm1mS4JGWIAdFves7FPa+HobqmD10cZHKvBDIgTU4eEfTCwAn0ykOzzBKidv
         LZHoMdR+rOdETEgDNcGnBZYO86dqG2ygG1BNDFGI=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] reset: socfpga: add error handling and release mem-region
Date:   Mon,  9 Nov 2020 13:21:41 -0600
Message-Id: <20201109192141.10580-1-dinguyen@kernel.org>
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
v2: return ret value
---
 drivers/reset/reset-socfpga.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index bdd984296196..2a72f861f798 100644
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
+	return ret;
+
+release_region:
+	release_mem_region(res.start, size);
 
 err_alloc:
 	kfree(data);
-- 
2.17.1

