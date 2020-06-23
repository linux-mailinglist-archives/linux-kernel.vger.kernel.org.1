Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF53205430
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgFWOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 10:12:37 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:17641 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732657AbgFWOMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:12:37 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id 8DB09201D0;
        Tue, 23 Jun 2020 17:12:32 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chuhong Yuan <hslester96@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] staging: rts5208: fix memleaks on error handling paths in probe
Date:   Tue, 23 Jun 2020 17:12:30 +0300
Message-Id: <20200623141230.7258-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtsx_probe() allocates host, but does not free it on error handling
paths. The patch adds missed scsi_host_put().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/staging/rts5208/rtsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index be0053c795b7..937f4e732a75 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -972,6 +972,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	kfree(dev->chip);
 chip_alloc_fail:
 	dev_err(&pci->dev, "%s failed\n", __func__);
+	scsi_host_put(host);
 scsi_host_alloc_fail:
 	pci_release_regions(pci);
 	return err;
-- 
2.16.4

