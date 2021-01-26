Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90784304FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhA0D0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390819AbhAZVDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:03:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C311122B51
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611694942;
        bh=lAnyzncGOYSPZ0wsMgBrTVp0+NsCu5boXVHrOr7iwqk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GYWdr5AhwxkIjdVj6URa+CdP2WAyHs2XQ+xMVzINQgW3OF5CgVV/xWjqhQRVJ1Pny
         0cSPLRyqldFwVHStLbKAkTrgT7jWFRXhvpB4QGraijGA3f4FuUY0vQTQOHQMLn8jHl
         QQR2ZEMjRjUbyG8EfDCoGHHRi6A3gJYb+yqO/UEkUyjG0bq2jxsgNJmcgBFSzVwwTk
         HQmehgtKjtFHS1jw7SdfHzd4zEueKAV99BKjccz6yQ4ydR0ZePRpUafdMZTZ+Ka5j9
         C6r26+eco5jn4Ksg4YtkezVoTph/FqHONX5YA8z9oaTbvdi15JR5suTiTVJhx9w1DI
         VFvW2jDapkCkA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs: update to latest hl_boot_if.h spec from F/W
Date:   Tue, 26 Jan 2021 23:02:15 +0200
Message-Id: <20210126210215.4892-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126210215.4892-1-ogabbay@kernel.org>
References: <20210126210215.4892-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds the definition for indication that the F/W handles HBM ECC
events.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index e29c77bdea07..57785478a4ef 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -69,8 +69,9 @@
  *					image has failed to match expected
  *					checksum. Trying to program image again
  *					might solve this.
+ *
  * CPU_BOOT_ERR0_PLL_FAIL		PLL settings failed, meaning that one
- *					of the PLLs remained in REF_CLK
+ *					of the PLLs remains in REF_CLK
  *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
@@ -161,6 +162,10 @@
  *					FW initialized Clock Gating.
  *					Initialized in: preboot
  *
+ * CPU_BOOT_DEV_STS0_HBM_ECC_EN		HBM ECC handling Enabled.
+ *					FW handles HBM ECC indications.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -184,6 +189,7 @@
 #define CPU_BOOT_DEV_STS0_PLL_INFO_EN			(1 << 11)
 #define CPU_BOOT_DEV_STS0_SP_SRAM_EN			(1 << 12)
 #define CPU_BOOT_DEV_STS0_CLK_GATE_EN			(1 << 13)
+#define CPU_BOOT_DEV_STS0_HBM_ECC_EN			(1 << 14)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
-- 
2.25.1

