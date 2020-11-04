Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72392A6986
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgKDQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgKDQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:25:04 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3458C0401C5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:25:01 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g12so22667811wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GHOp4DltKz3i6bOt37UpUN4Df5qKRn7hwYhsGdTpAY=;
        b=lzCQLdZX72DPbrzpyO70KLlIhpN4uMbYtfbPZcWzETXAAxP1k6A+EH/fGbjr6jNaYC
         W9lEPRVXwQOTPZrb0nE9HVkdFt1oDyK2++3HF5hJI7qturNXgt823AurtYoLxyy643sA
         GLCQhg2Swsp6oLa9HY/H6NmgSFq3I61kHfEeVA53mm+f/3Sl7CZ3OtoKpVbJ9/omVpwL
         M38A7P+sEH2utR6YOdQ8chuHvsXFIkiHHcGPBrZr/BwD8QHNDb4MCA/Vgo/N/EG4u/Jn
         TIc3/v0bUHx93B5tcWh5TFBCHAJvg0jbeFLCTH2YbbPSiAfHI1Dv+twed+mbPtEm2ESQ
         nmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GHOp4DltKz3i6bOt37UpUN4Df5qKRn7hwYhsGdTpAY=;
        b=D2fRNNgl5/M9YTU+UUFnG8LbhuJ1ZC0vo9vyjffYoZsrJN6SyNI5zDNLC5SWh+5d2o
         aUa0CMzScd8v6ZgXDWQqJWeRSVNLc+4QZDiB252HFC2PB7TOD+0CPIwjNyK15BUyxQrj
         rRE8PWCWg1NSbr6Q3h8XAWCWEsJq7eBZX+hc8J01AVR28u40LLp4lLonmCPeYbuVRTPT
         Y9V3Bgi5XQmV+TQC4hfkNSvIm7G6859CwV5W5TkOqjQ25TOJk1QVbK+7x7HlM60KwqUg
         uzTxsaWuzI6rAwnvKdmYPQ1teYCRtIayXfja37hL0Lo/zn/XfKNvnNMh8KnPNoik3ozQ
         9oIQ==
X-Gm-Message-State: AOAM532VPG+3vMCXB278zwQZpxGmtz+4eurmjwndLxqF7PRtxRUhSRf9
        bNCdhJt9rUCuvHJy7CK6C6aWjApWEqIo71a5
X-Google-Smtp-Source: ABdhPJxOo2g7lqHbzhI52bbzLERw4aq9EWSwSk1khVNfKk+K0uk2Mo7gSR3oOqhT5Z1sxUWzM7+5NA==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr34047834wrh.205.1604507100645;
        Wed, 04 Nov 2020 08:25:00 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:25:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ferruh Yigit <fery@cypress.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "at www.cypress.com" <ttdrivers@cypress.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 15/20] input: touchscreen: cyttsp4_core:  Move 'cyttsp4_tch_abs_string' to the only file that references it
Date:   Wed,  4 Nov 2020 16:24:22 +0000
Message-Id: <20201104162427.2984742-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

In file included from drivers/input/touchscreen/cyttsp_i2c_common.c:24:
 drivers/input/touchscreen/cyttsp4_core.h:236:27: warning: ‘cyttsp4_tch_abs_string’ defined but not used [-Wunused-const-variable=]
 236 | static const char  const cyttsp4_tch_abs_string[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/input/touchscreen/cyttsp4_i2c.c:17:
 drivers/input/touchscreen/cyttsp4_core.h:236:27: warning: ‘cyttsp4_tch_abs_string’ defined but not used [-Wunused-const-variable=]
 236 | static const char * const cyttsp4_tch_abs_string[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/input/touchscreen/cyttsp4_spi.c:17:
 drivers/input/touchscreen/cyttsp4_core.h:236:27: warning: ‘cyttsp4_tch_abs_string’ defined but not used [-Wunused-const-variable=]
 236 | static const char * const cyttsp4_tch_abs_string[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~

Cc: Ferruh Yigit <fery@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "at www.cypress.com" <ttdrivers@cypress.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/cyttsp4_core.c | 14 ++++++++++++++
 drivers/input/touchscreen/cyttsp4_core.h | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 02a73d9a4defe..dccbcb942fe59 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -30,6 +30,20 @@
 
 #define CY_CORE_STARTUP_RETRY_COUNT		3
 
+static const char * const cyttsp4_tch_abs_string[] = {
+	[CY_TCH_X]	= "X",
+	[CY_TCH_Y]	= "Y",
+	[CY_TCH_P]	= "P",
+	[CY_TCH_T]	= "T",
+	[CY_TCH_E]	= "E",
+	[CY_TCH_O]	= "O",
+	[CY_TCH_W]	= "W",
+	[CY_TCH_MAJ]	= "MAJ",
+	[CY_TCH_MIN]	= "MIN",
+	[CY_TCH_OR]	= "OR",
+	[CY_TCH_NUM_ABS] = "INVALID"
+};
+
 static const u8 ldr_exit[] = {
 	0xFF, 0x01, 0x3B, 0x00, 0x00, 0x4F, 0x6D, 0x17
 };
diff --git a/drivers/input/touchscreen/cyttsp4_core.h b/drivers/input/touchscreen/cyttsp4_core.h
index f3e4443594404..6262f6e450751 100644
--- a/drivers/input/touchscreen/cyttsp4_core.h
+++ b/drivers/input/touchscreen/cyttsp4_core.h
@@ -233,20 +233,6 @@ enum cyttsp4_tch_abs {	/* for ordering within the extracted touch data array */
 	CY_TCH_NUM_ABS
 };
 
-static const char * const cyttsp4_tch_abs_string[] = {
-	[CY_TCH_X]	= "X",
-	[CY_TCH_Y]	= "Y",
-	[CY_TCH_P]	= "P",
-	[CY_TCH_T]	= "T",
-	[CY_TCH_E]	= "E",
-	[CY_TCH_O]	= "O",
-	[CY_TCH_W]	= "W",
-	[CY_TCH_MAJ]	= "MAJ",
-	[CY_TCH_MIN]	= "MIN",
-	[CY_TCH_OR]	= "OR",
-	[CY_TCH_NUM_ABS] = "INVALID"
-};
-
 struct cyttsp4_touch {
 	int abs[CY_TCH_NUM_ABS];
 };
-- 
2.25.1

