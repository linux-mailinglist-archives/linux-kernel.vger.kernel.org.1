Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E7263463
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgIIRUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgIIP1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5327E218AC;
        Wed,  9 Sep 2020 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599663697;
        bh=8XeYbxipI9Hd42X8q98raLk+ivYMwR68NVSJRJv6Jn4=;
        h=From:To:Subject:Date:From;
        b=plSSjxOmwUieeu/uUrLHGVhKaYdsqyC4KQf7ey/V4zthqMrunfeN7gdGp48CE5OC6
         6VBAaaamk7qGrzPsy/BT8sPIHClCQF8VXaaM5q2OGoPX0kffLhv5Z0fFW0cjCWyJK+
         /pa2S1+aJ8YpYv31RkNAqQJrwxle1Tb5TfOZL7po=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] extcon: ptn5150: Use defines for registers
Date:   Wed,  9 Sep 2020 17:01:28 +0200
Message-Id: <20200909150129.12476-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register addresses are not continuous, so use simple defines for
them.  This also makes it easier to find the address for register.

No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index dda5b3a3a908..1b68f56d8372 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -19,18 +19,16 @@
 #include <linux/gpio/consumer.h>
 
 /* PTN5150 registers */
-enum ptn5150_reg {
-	PTN5150_REG_DEVICE_ID = 0x01,
-	PTN5150_REG_CONTROL,
-	PTN5150_REG_INT_STATUS,
-	PTN5150_REG_CC_STATUS,
-	PTN5150_REG_CON_DET = 0x09,
-	PTN5150_REG_VCONN_STATUS,
-	PTN5150_REG_RESET,
-	PTN5150_REG_INT_MASK = 0x18,
-	PTN5150_REG_INT_REG_STATUS,
-	PTN5150_REG_END,
-};
+#define PTN5150_REG_DEVICE_ID			0x01
+#define PTN5150_REG_CONTROL			0x02
+#define PTN5150_REG_INT_STATUS			0x03
+#define PTN5150_REG_CC_STATUS			0x04
+#define PTN5150_REG_CON_DET			0x09
+#define PTN5150_REG_VCONN_STATUS		0x0a
+#define PTN5150_REG_RESET			0x0b
+#define PTN5150_REG_INT_MASK			0x18
+#define PTN5150_REG_INT_REG_STATUS		0x19
+#define PTN5150_REG_END				PTN5150_REG_INT_REG_STATUS
 
 #define PTN5150_DFP_ATTACHED			0x1
 #define PTN5150_UFP_ATTACHED			0x2
-- 
2.17.1

