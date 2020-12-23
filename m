Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93E2E1360
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 03:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgLWC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 21:29:07 -0500
Received: from ptr.189.cn ([183.61.185.103]:11408 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730584AbgLWC3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:29:03 -0500
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 21:29:02 EST
HMM_SOURCE_IP: 172.27.8.53:27451.1493386966
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [172.27.8.53])
        by 189.cn (HERMES) with SMTP id 122DE101C27;
        Wed, 23 Dec 2020 10:26:15 +0800 (CST)
Received: from  ([123.150.8.42])
        by SZ-WEBMAIL05 with ESMTP id 42c2a5894e1849c3b508e583650a8a20 for greg@kroah.com;
        Wed Dec 23 10:26:16 2020
X-Transaction-ID: 42c2a5894e1849c3b508e583650a8a20
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   chensong <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        chensong@tj.kylinos.cn, chensong <chensong_2000@189.cn>
Subject: [PATCH] staging: comedi: correct spelling mistakes of I/O port base address
Date:   Wed, 23 Dec 2020 10:26:23 +0800
Message-Id: <1608690383-30917-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"base" was double input in comment line "I/O port base
address", remove one of them.

Signed-off-by: chensong <chensong_2000@189.cn>
---
 drivers/staging/comedi/drivers/dt2815.c | 2 +-
 drivers/staging/comedi/drivers/dt2817.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt2815.c b/drivers/staging/comedi/drivers/dt2815.c
index 5906f32..2be2406 100644
--- a/drivers/staging/comedi/drivers/dt2815.c
+++ b/drivers/staging/comedi/drivers/dt2815.c
@@ -17,7 +17,7 @@
  * contrary, please update.
  *
  * Configuration options:
- * [0] - I/O port base base address
+ * [0] - I/O port base address
  * [1] - IRQ (unused)
  * [2] - Voltage unipolar/bipolar configuration
  *	0 == unipolar 5V  (0V -- +5V)
diff --git a/drivers/staging/comedi/drivers/dt2817.c b/drivers/staging/comedi/drivers/dt2817.c
index 7c1463e..a173394 100644
--- a/drivers/staging/comedi/drivers/dt2817.c
+++ b/drivers/staging/comedi/drivers/dt2817.c
@@ -21,7 +21,7 @@
  * with 32 channels, configurable in groups of 8.
  *
  * Configuration options:
- * [0] - I/O port base base address
+ * [0] - I/O port base address
  */
 
 #include <linux/module.h>
-- 
2.7.4

