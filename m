Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4710C2E740F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL2VEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2VEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:04:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4779421D1B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609275820;
        bh=yxqJytChR7v2mqhoOAWlT/51fYpRnjpXqkTlY1r8r3M=;
        h=From:To:Subject:Date:From;
        b=mVzpA9aW1f0tzYR5LF0MPDoI6eJB0uc3XG3rAqhtl15T8f0HdVMGoHzb7gWjlrJ4n
         wU0b1q8gXK2l4OQaMfRBasPOgeTfBsLUcsaXPee6mzBBpKUvuLzcCYIFeyk+W9I2CR
         JLqUxIwuCc0iL5bCI18faGsqQWxjDypQi2vunEL7HlOsqI2gf8fVtRttqPSNuIC2W5
         7E6pVS4FdjU2/RDbf3VHhHFcnC34a6ggYUZwuFEpp9gxoWdoF0c9UcNXugEMrj9Ir+
         HiL26rfm/PfU7NI37w6NEBg6pOybU1FZAlXoBUQhAXXdAPWBx2ySNBqUai0q6w1tPg
         MugoJoiwJ4BRQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: fix order of status check
Date:   Tue, 29 Dec 2020 23:03:35 +0200
Message-Id: <20201229210337.2082-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device is in reset or needs to be reset, the disabled property
is don't-care.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 5871162a8442..0749c92cbcf6 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -17,12 +17,12 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
 
-	if (hdev->disabled)
-		status = HL_DEVICE_STATUS_MALFUNCTION;
-	else if (atomic_read(&hdev->in_reset))
+	if (atomic_read(&hdev->in_reset))
 		status = HL_DEVICE_STATUS_IN_RESET;
 	else if (hdev->needs_reset)
 		status = HL_DEVICE_STATUS_NEEDS_RESET;
+	else if (hdev->disabled)
+		status = HL_DEVICE_STATUS_MALFUNCTION;
 	else
 		status = HL_DEVICE_STATUS_OPERATIONAL;
 
-- 
2.25.1

