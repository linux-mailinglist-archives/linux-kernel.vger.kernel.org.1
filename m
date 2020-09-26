Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8827964E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 04:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgIZCuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 22:50:39 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:25387 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZCuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 22:50:39 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id AED044E142B;
        Sat, 26 Sep 2020 10:50:35 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform_data: ti: fix a typo
Date:   Sat, 26 Sep 2020 10:49:51 +0800
Message-Id: <1601088620-16070-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTU0aTB9OSUhKTUMZVkpNS0pLQ0NNSE1KS0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6Dio6Lj8iLAEDPkMZDTJP
        IQ4KFBFVSlVKTUtKS0NDTUhNTktLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJSUtCNwY+
X-HM-Tid: 0a74c851c4629376kuwsaed044e142b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the typo: "compliment" -> "complement".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/platform_data/cros_ec_commands.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 1fcfe9e..42203ce
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -261,12 +261,12 @@
 /* Memory space version; set to EC_ACPI_MEM_VERSION_CURRENT */
 #define EC_ACPI_MEM_VERSION            0x00
 /*
- * Test location; writing value here updates test compliment byte to (0xff -
+ * Test location; writing value here updates test complement byte to (0xff -
  * value).
  */
 #define EC_ACPI_MEM_TEST               0x01
-/* Test compliment; writes here are ignored. */
-#define EC_ACPI_MEM_TEST_COMPLIMENT    0x02
+/* Test complement; writes here are ignored. */
+#define EC_ACPI_MEM_TEST_COMPLEMENT    0x02
 
 /* Keyboard backlight brightness percent (0 - 100) */
 #define EC_ACPI_MEM_KEYBOARD_BACKLIGHT 0x03
-- 
2.7.4

