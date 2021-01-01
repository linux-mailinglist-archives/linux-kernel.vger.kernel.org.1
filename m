Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76192E83CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbhAANRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 08:17:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbhAANRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 08:17:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A54F22210;
        Fri,  1 Jan 2021 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609506991;
        bh=o3YjlA9QDV58ABf8woV5pjclSQxq4mjj40VCQ7ihjG4=;
        h=From:To:Cc:Subject:Date:From;
        b=Zymbe1asu9Oaeh21Egweksu1KjopDDtxr18CCzpXSEp7Wsnxvtm2DgGWo4dLdOhY9
         LaTA3r7IOYF54ULPEH/bpxd+5mCeb3K1srSV3whnq80ASknRxuJhS0Oo2gfWX9+lwf
         tRiGfYt44Rjcxw8ojbyrhnHveFGfBfS348eGvV+PFlTIBswjsJsCzMrqptzI9W3Btz
         LpdqLUGhDT3Z+WxSrWjLO/2kN6i1BYlmLl3wFf7QzB7yyVepXOU8VGbMKk/em8r2V/
         Tz6TNiD19b2+FWoYQ6P2kATo54BOvMBaZYNj3iIfHAKgWAU+6AN5DuKdOsOZWUjxIs
         cHIcm3mNheIhA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: report correct dram size in info ioctl
Date:   Fri,  1 Jan 2021 15:16:25 +0200
Message-Id: <20210101131626.4636-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In case MMU is enabled, we must take MMU page size into
consideration when reporting dram size to the user.
This is because the MMU page size can be a value which is NOT
a power-of-2 value. As a result, the total DRAM size (which is always
a power-of-2 value) needed to be rounded-down.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 64a82c966836..b83ee32ae569 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -62,7 +62,13 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 			prop->dmmu.start_addr : prop->dram_user_base_address;
 	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask;
 	hw_ip.sram_size = prop->sram_size - sram_kmd_size;
-	hw_ip.dram_size = prop->dram_size - dram_kmd_size;
+
+	if (hdev->mmu_enable)
+		hw_ip.dram_size = rounddown(prop->dram_size - dram_kmd_size,
+							prop->dram_page_size);
+	else
+		hw_ip.dram_size = prop->dram_size - dram_kmd_size;
+
 	if (hw_ip.dram_size > PAGE_SIZE)
 		hw_ip.dram_enabled = 1;
 	hw_ip.dram_page_size = prop->dram_page_size;
-- 
2.25.1

