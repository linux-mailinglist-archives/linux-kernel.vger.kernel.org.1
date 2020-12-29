Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE42E7411
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgL2VEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2VEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:04:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53CF922209
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609275822;
        bh=/aoVQASrf6vaJupWZMY4zUicI/oi5TNmLgDCmBpLfXE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KSh53/0H+NqpjKjNhrGZN3O1tXTP2mrohR/x2GOdswXaU08RBiwcXymRcpb0Hc67W
         4HJI0rPBSrTUxcVzy72DtnOyZ4oGyt36XjVdax3VnSSmSAEC7z1a0qep7TKe8DTXU1
         oMtj/42vmy0X5KnUeEppKTzCgmoCmEtED64zJ+Pw2+K+UXcB6jnSLZ81rA03s3YfUq
         5qDG/hfgMAiaZ2vzwwxu4gFMBNe7QrHrjEwiDhV0VB3kSAtVKN4tMKn2yccGmNLZCh
         uT1YAA1pHkj9yPrhJ3VUnTthL2H/M4vS4w7ibfc689U6OirlrkiEC5WO3Qn7eXbOgB
         yBANpLX+ZPkEQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: register to pci shutdown callback
Date:   Tue, 29 Dec 2020 23:03:37 +0200
Message-Id: <20201229210337.2082-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229210337.2082-1-ogabbay@kernel.org>
References: <20201229210337.2082-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.25.1

