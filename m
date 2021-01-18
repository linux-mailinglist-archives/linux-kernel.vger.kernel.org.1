Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD66E2FA962
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407878AbhARSy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407537AbhARSxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:53:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 656DD22C9E;
        Mon, 18 Jan 2021 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610995942;
        bh=meXioWvRXrAEKQ2QmCDlsJQW56f6gV4B3JiBQN7nfJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=EABP8zsnWObPQHQ2O115DQyqQGStFOBzIJpAy+VabOFv03C70zPa/xifzldsR6wPu
         212200q9HMrAgvlnP9JTps7ZJGbF8g/FeFIOJeQ8aU9JKVj9DOwr0ng8crt3fCPlFN
         +7vxlH3rHC9ooK5+0AvM8DTJ3UYjXBT/34RSbM2DSpIdqQnqcIE8sAKJMi/P9bLUfm
         xd+HXpBWA34PL8zc6rtmziDqphmF0rEFCKaqIou2gSI9eZGfIrsealAQQ6vb7JZv2v
         9nJ7bPV+PkhJTmuaXfdskbKPxMoikNQnz7afi2p7YqGearv5bcTyb7YdOqgkIPvlvp
         svMtR8ebrJ77A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs: zero pci counters packet before submit to FW
Date:   Mon, 18 Jan 2021 20:52:15 +0200
Message-Id: <20210118185217.4389-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver does not zero some pci counters packets before sending
to FW. This causes an out of sync PI/CI between driver and FW.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 20f77f58edef..c9a12980218a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -402,6 +402,10 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 	}
 	counters->rx_throughput = result;
 
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PCIE_THROUGHPUT_GET <<
+			CPUCP_PKT_CTL_OPCODE_SHIFT);
+
 	/* Fetch PCI tx counter */
 	pkt.index = cpu_to_le32(cpucp_pcie_throughput_tx);
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -414,6 +418,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 	counters->tx_throughput = result;
 
 	/* Fetch PCI replay counter */
+	memset(&pkt, 0, sizeof(pkt));
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PCIE_REPLAY_CNT_GET <<
 			CPUCP_PKT_CTL_OPCODE_SHIFT);
 
-- 
2.25.1

