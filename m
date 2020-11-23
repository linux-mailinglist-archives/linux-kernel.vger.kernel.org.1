Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91752C13E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgKWSuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgKWSug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:50:36 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653A120657;
        Mon, 23 Nov 2020 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606157436;
        bh=4Te0GY+0HL6NleuQzTJk1xWxop6dhSW6xscOWUrTZjA=;
        h=From:To:Cc:Subject:Date:From;
        b=HNyMxvysNP38YLPoH51dOjjeNpT3MCAOO1U3x00qffNoGbxQ2sukuCSZqQuuFs8zR
         O3s0FxkCwf1wQRF5GOMS0LOL93Gl1czvuAQmKdDm1BrNpANETVc37d9fuVwCTqwOza
         tMoJCoYO1+Jm7uD/ElHamfKaXZvQJhqINYoUp18M=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: print ECC type field
Date:   Mon, 23 Nov 2020 20:50:32 +0200
Message-Id: <20201123185032.18199-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the ECC type field from the firmware but the driver didn't
print it, so we need to add that field to the ECC print message.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c99ad8d65dea..cd18456fa523 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6918,8 +6918,8 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 				le32_to_cpu(hbm_ecc_data->hbm_ecc_info));
 
 		dev_err(hdev->dev,
-			"HBM%d pc%d interrupts info: WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
-			device, ch, wr_par, rd_par, ca_par, serr, derr);
+			"HBM%d pc%d ECC: TYPE=%d, WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
+			device, ch, type, wr_par, rd_par, ca_par, serr, derr);
 
 		err = 1;
 
-- 
2.17.1

