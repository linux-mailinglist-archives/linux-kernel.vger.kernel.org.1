Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD32CDF0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgLCTeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB5C061A54
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i2so3073922wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsQgKFoXKIkWpb36XD2374OgaN7W5ITo4L7P0f7e7Cg=;
        b=uQEqhiuNJUAQHhTJWMZycVK+JrloTnxiG26wbqXmw2B1mB3SgoE5Af2hWE8P7LHxX2
         ovMjnNdaUbm67kqx34+kvhtC66fWiUeiUZXNIMb3Iv/Jx54PjwdmHTG8MB6Ape5n8DzZ
         VkLvV+/u3pPH+BohXUluf2UUeDcug6e5JaBd5KYlLjsA9WdTUfC0PJGwBA0hVhaST7b4
         v2ANgRm0B/ijpnQMs2SvtRBerovZq3CJESxGm8Ku9pQmvvtu8x5X897JMq1TXuvrnwNK
         EW8nubdA20Bj9x7zrpoTEldJMzZ/WBvXmhEmMXZWzFDnQJGpdTlJZYzgnv5W4sJHAQRY
         M6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsQgKFoXKIkWpb36XD2374OgaN7W5ITo4L7P0f7e7Cg=;
        b=aIv8vg+B8xsVTncRIKhlllHVyyvd7B4MUm3Q9TIjn9INvgf9rMphv0a7uk9igNI5hl
         95H/gu/idPAVNM/ID/XKr4AwdoZqCJHtwoFWNGxNCswcKtAyejG4/LnUUHCsXgfh1W6/
         Pk2fbg72Cp1je2ZEQ9ZMld8LNrUHnksrm5KZh6Yd/4PSIR4pdxCs8i5qk7QaxDTWnMlh
         +UF1w+hVvEYeL2zrj7UEsOrjK7feJ1hG2uKgxFCvx5YvUm9JrWMsNFbuQnpBMZIrA9Ev
         UG1qY5wLyDz6G4ulp4P/kKX+XUJVbzu+KzFuvirzjVDJxWmXAzC6rDzU9xwzn/aaBLl9
         9Xew==
X-Gm-Message-State: AOAM533UITZE8ZXwVfNewljEuFo2Q9TDYKjkpOIJMRBw/ocSG2asMNnL
        I7C95I1c0kA8lc1anxQAY6/jEA==
X-Google-Smtp-Source: ABdhPJybSUt6/rZRk2buHRMLvLsTwNXCIeb7ViIIquoNe2xocz7HUKj6/l7bQ5L9edrURpsJX/776w==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr867638wrb.132.1607024009429;
        Thu, 03 Dec 2020 11:33:29 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] dt-bindings: timer: Add new OST support for the upcoming new driver.
Date:   Thu,  3 Dec 2020 20:32:54 +0100
Message-Id: <20201203193301.2405835-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

The new OST has one global timer and two or four percpu timers, so there
will be three combinations in the upcoming new OST driver: the original
GLOBAL_TIMER + PERCPU_TIMER, the new GLOBAL_TIMER + PERCPU_TIMER0/1 and
GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this, add the macro definition
about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that all the
combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER
and OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any
combinations, the clock can be registered (by calling clk_hw_register())
from index 0.

Before this patch, OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER are only
used in two places, one is when using "assigned-clocks" to configure the
clocks in the DTS file; the other is when registering the clocks in the
sysost driver. When the values of these two ABIs are exchanged, the ABI
value used by sysost driver when registering the clock, and the ABI value
used by DTS when configuring the clock using "assigned-clocks" will also
change accordingly. Therefore, there is no situation that causes the wrong
clock to the configured. Therefore, exchanging ABI values will not cause
errors in the existing codes when registering and configuring the clocks.

Currently, in the mainline, only X1000 and X1830 are using sysost driver,
and the upcoming X2000 will also use sysost driver. This patch has been
tested on all three SoCs and all works fine.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201026155842.10196-2-zhouyanjie@wanyeetech.com
---
 include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
index 9ac88e90babf..063791b01ab3 100644
--- a/include/dt-bindings/clock/ingenic,sysost.h
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -1,12 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * This header provides clock numbers for the ingenic,tcu DT binding.
+ * This header provides clock numbers for the Ingenic OST DT binding.
  */
 
 #ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
 #define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
 
-#define OST_CLK_PERCPU_TIMER	0
-#define OST_CLK_GLOBAL_TIMER	1
+#define OST_CLK_PERCPU_TIMER	1
+#define OST_CLK_GLOBAL_TIMER	0
+#define OST_CLK_PERCPU_TIMER0	1
+#define OST_CLK_PERCPU_TIMER1	2
+#define OST_CLK_PERCPU_TIMER2	3
+#define OST_CLK_PERCPU_TIMER3	4
 
 #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
-- 
2.25.1

