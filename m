Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F242FA95F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407856AbhARSy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407662AbhARSxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:53:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2D0822CA2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610995944;
        bh=o/J2255o1vm3OK6qOp+aJ+p2t95B3YOMQcNxuJkULkw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aYbGWSzzAgvUAknaEMMWHODcTZv8HMGE7c93oZeGBsXzr31WGPOyRkoALO427vTr2
         A18Hzp3ND0yGLozcZkfQo/hB0CeD0I275ttW798PEggiNF8Y2cV9BXPjG+Y83zWCVX
         gNU6fGDtU9za/huBEQIiGYp3Z1wDON78NTQKNbCiGUus/+6w08VuvRoXl5gN+61z35
         6pl9Fb2LofCIHlIehrft4eihLrGa1iwJ0PLY1AdXtB7aAycu480Bfbga77QU5bWcDj
         vSSkkl6ygUukF8EvCZxhYuKSSg0yPY/k9d7aDVFKoRZY/NhQiPZOAz+DD2XOkopaX1
         R1ARuISA/E3sA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs: disable FW events on device removal
Date:   Mon, 18 Jan 2021 20:52:17 +0200
Message-Id: <20210118185217.4389-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118185217.4389-1-ogabbay@kernel.org>
References: <20210118185217.4389-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device is removed, we need to make sure the F/W won't send us
any more events because during the remove process we disable the
interrupts.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 1ea57d86caa3..69d04eca767f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1487,6 +1487,15 @@ void hl_device_fini(struct hl_device *hdev)
 		}
 	}
 
+	/* Disable PCI access from device F/W so it won't send us additional
+	 * interrupts. We disable MSI/MSI-X at the halt_engines function and we
+	 * can't have the F/W sending us interrupts after that. We need to
+	 * disable the access here because if the device is marked disable, the
+	 * message won't be send. Also, in case of heartbeat, the device CPU is
+	 * marked as disable so this message won't be sent
+	 */
+	hl_fw_send_pci_access_msg(hdev,	CPUCP_PACKET_DISABLE_PCI_ACCESS);
+
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
-- 
2.25.1

