Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9A2C25C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgKXMfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:35:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:35:08 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khXXE-0004vU-LI; Tue, 24 Nov 2020 12:35:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        linux-i3c@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] i3c/master: Fix uninitialized variable next_addr
Date:   Tue, 24 Nov 2020 12:35:04 +0000
Message-Id: <20201124123504.396249-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable next_addr is not initialized and is being used in a call
to i3c_master_get_free_addr as a starting point to find the next address.
Fix this by initializing next_addr to 0 to avoid an uninitialized garbage
starting address from being used.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 9ad9a52cce28 ("i3c/master: introduce the mipi-i3c-hci driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index 6dd234a82892..d97c3175e0e2 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -293,7 +293,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 {
 	struct hci_xfer *xfer;
 	int ret, dat_idx = -1;
-	u8 next_addr;
+	u8 next_addr = 0;
 	u64 pid;
 	unsigned int dcr, bcr;
 	DECLARE_COMPLETION_ONSTACK(done);
-- 
2.29.2

