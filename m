Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93062A302C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgKBQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgKBQon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:44:43 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE74022268;
        Mon,  2 Nov 2020 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604335482;
        bh=IcnJOeNns3ZPgRrXBEWX36trTTizMaEKlQNHmuUP4Lc=;
        h=From:To:Cc:Subject:Date:From;
        b=AS9JhEEBFq4g5GHub5iPgwlVbCqW11uJWHhI9HQIlblxDPQkVUNfMbGupq7K6IEI9
         HmV9dkKpVEff272m1oyMdOLsVsGLrW+QGY1cEWqOFAv6q+PuFWsa5qGXb5RibTc6az
         s8niU4k4QG6bOI97qzGc96yxNlXe8YXtLGmuVZ6Y=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 2/2] habanalabs/gaudi: mask WDT error in QMAN
Date:   Mon,  2 Nov 2020 18:44:38 +0200
Message-Id: <20201102164438.17337-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This interrupt cause is not relevant because of how the user use the
QMAN arbitration mechanism. We must mask it as the log explodes with it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/gaudi/gaudi_masks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index f395721060bd..46aed13f16b1 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -421,7 +421,6 @@ enum axi_id {
 
 #define QM_ARB_ERR_MSG_EN_MASK		(\
 					QM_ARB_ERR_MSG_EN_CHOISE_OVF_MASK |\
-					QM_ARB_ERR_MSG_EN_CHOISE_WDT_MASK |\
 					QM_ARB_ERR_MSG_EN_AXI_LBW_ERR_MASK)
 
 #define PCIE_AUX_FLR_CTRL_HW_CTRL_MASK                               0x1
-- 
2.17.1

