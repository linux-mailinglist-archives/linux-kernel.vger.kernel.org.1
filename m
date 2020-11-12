Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22152B1255
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKLXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgKLXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:01:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F0C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 15:01:39 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so6857231wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 15:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ay3g0WHJ5Z9sUFSsAiMtS3+CU9KxkEqczCaxCW1Xrgs=;
        b=l2Fb6GIrmV3NoRJY2y5tThITGKwdA6NgrUFo7qxhmNyIc+62ajsl9yBM9kBzY4kfI/
         6zrya4RPSp3Q1hopNqi5WabvuhTfkABp1kemsZhUgjmWeMy7KXQqJ5l4yM9ZqoBBn0tB
         y3gbvZ82PsUKTZfbw2zvaAl4WQfdlxYGD8fKkMmMlIxKv2U524dwT3OKIoY4lgkkNx0F
         ZweSwv4u5pdNR3c+tDswKLi/su1xzWR1gbZuzN3WQBCFHbpb6pGSdHJIRP1SImH9CcvK
         AynSSOMnnlOeB5G39R7YrCGg9++bWzW5O5E32YbNXKAt3cVZ6FlF3fQ2iITPdX3GTAH8
         a7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ay3g0WHJ5Z9sUFSsAiMtS3+CU9KxkEqczCaxCW1Xrgs=;
        b=qedV5Sf9/fcIaQyE0miQhWpaUm2QM/+S8fViOKstgm829LKKGfJknDJgWT7UANa6+j
         20dSxQeBOHdqZbtOx2fwPK/qU3jcf77AAxQGU4w1c+kEYQK9qbv2U5ndrfWL3M3TRbCc
         jDRNbRJythgOvoNM+b7LVzNebd0EmxLIpL1VmqNO57IAIB3DbLEYjlm8RCO+70YSIapz
         2a8ay1ko8mtfgWpv0k54UCzbMqXSmx/AM0Myzs2ohUSiVMkw+v8+I1VaOs8FrxL4Fy56
         nMM2E7cbq54LTAY+j7Sni1Ca3AuvN9Zf2daNO13qdssUSybnSx3+6A0bapWhrXk/3KDK
         QC0A==
X-Gm-Message-State: AOAM532+kvwvmMZGUG7HL9xch+XVaQKclQe8mV5fW03nB1kzEOPTyn6Z
        ks5rbGWoQ8QiLiU95l/kHLFnXQ==
X-Google-Smtp-Source: ABdhPJxb0BlqXQvBwyt/FteBmLbQxyaS2N/LIBSC7x1esLzEKogJMph0rp55RJTnahob7LDMp4vhUA==
X-Received: by 2002:a1c:b387:: with SMTP id c129mr124748wmf.66.1605222075499;
        Thu, 12 Nov 2020 15:01:15 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.googlemail.com with ESMTPSA id h4sm8185984wrq.3.2020.11.12.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 15:01:14 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH v2] reset: make shared pulsed reset controls re-triggerable
Date:   Fri, 13 Nov 2020 00:00:43 +0100
Message-Id: <20201112230043.28987-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current reset framework API does not allow to release what is done by
reset_control_reset(), IOW decrement triggered_count. Add the new
reset_control_rearm() call to do so.

When reset_control_reset() has been called once, the counter
triggered_count, in the reset framework, is incremented i.e the resource
under the reset is in-use and the reset should not be done again.
reset_control_rearm() would be the way to state that the resource is
no longer used and, that from the caller's perspective, the reset can be
fired again if necessary.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
Change since v1: [0]
* Renamed the new call from reset_control_(array_)resettable to 
reset_control_(array_)rearm
* Open-coded reset_control_array_rearm to check for errors before
decrementing triggered_count because we cannot roll back in case an
error occurs while decrementing one of the rstc.
* Reworded the new call's description.

[0] https://lore.kernel.org/lkml/20201001132758.12280-1-aouledameur@baylibre.com

 drivers/reset/core.c  | 73 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/reset.h |  1 +
 2 files changed, 74 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index a2df88e90011..34e89aa0fb5e 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -208,6 +208,39 @@ static int reset_control_array_reset(struct reset_control_array *resets)
 	return 0;
 }
 
+static int reset_control_array_rearm(struct reset_control_array *resets)
+{
+	struct reset_control *rstc;
+	int i;
+
+	for (i = 0; i < resets->num_rstcs; i++) {
+		rstc = resets->rstc[i];
+
+		if (!rstc)
+			continue;
+
+		if (WARN_ON(IS_ERR(rstc)))
+			return -EINVAL;
+
+		if (rstc->shared) {
+			if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
+				return -EINVAL;
+		} else {
+			if (!rstc->acquired)
+				return -EPERM;
+		}
+	}
+
+	for (i = 0; i < resets->num_rstcs; i++) {
+		rstc = resets->rstc[i];
+
+		if (rstc && rstc->shared)
+			WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);
+	}
+
+	return 0;
+}
+
 static int reset_control_array_assert(struct reset_control_array *resets)
 {
 	int ret, i;
@@ -325,6 +358,46 @@ int reset_control_reset(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_reset);
 
+/**
+ * reset_control_rearm - allow shared reset line to be re-triggered"
+ * @rstc: reset controller
+ *
+ * On a shared reset line the actual reset pulse is only triggered once for the
+ * lifetime of the reset_control instance, except if this call is used.
+ *
+ * Calls to this function must be balanced with calls to reset_control_reset,
+ * a warning is thrown in case triggered_count ever dips below 0.
+ *
+ * Consumers must not use reset_control_(de)assert on shared reset lines when
+ * reset_control_reset or reset_control_rearm have been used.
+ *
+ * If rstc is NULL the function will just return 0.
+ */
+int reset_control_rearm(struct reset_control *rstc)
+{
+	if (!rstc)
+		return 0;
+
+	if (WARN_ON(IS_ERR(rstc)))
+		return -EINVAL;
+
+	if (reset_control_is_array(rstc))
+		return reset_control_array_rearm(rstc_to_array(rstc));
+
+	if (rstc->shared) {
+		if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
+			return -EINVAL;
+
+		WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);
+	} else {
+		if (!rstc->acquired)
+			return -EPERM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_control_rearm);
+
 /**
  * reset_control_assert - asserts the reset line
  * @rstc: reset controller
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 05aa9f440f48..439fec7112a9 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -13,6 +13,7 @@ struct reset_control;
 #ifdef CONFIG_RESET_CONTROLLER
 
 int reset_control_reset(struct reset_control *rstc);
+int reset_control_rearm(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
 int reset_control_status(struct reset_control *rstc);
-- 
2.17.1

