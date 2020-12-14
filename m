Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177152D9C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440221AbgLNQVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440133AbgLNQUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:20:52 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: register to pci shutdown callback
Date:   Mon, 14 Dec 2020 18:20:07 +0200
Message-Id: <20201214162007.29651-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure our device is idle when rebooting a virtual
machine. This is done in the driver level.

The firmware will later handle FLR but we want to be extra safe and
stop the devices until the FLR is handled.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 6bbb6bca6860..032d114f01ea 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -544,6 +544,7 @@ static struct pci_driver hl_pci_driver = {
 	.id_table = ids,
 	.probe = hl_pci_probe,
 	.remove = hl_pci_remove,
+	.shutdown = hl_pci_remove,
 	.driver.pm = &hl_pm_ops,
 	.err_handler = &hl_pci_err_handler,
 };
-- 
2.17.1

