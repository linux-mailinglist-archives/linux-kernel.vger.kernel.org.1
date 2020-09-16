Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894CA26C05E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIPJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIPJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:21:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:21:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so2215467wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAN7y6gmMq3/PD5iIj3RPLoID/sAvRO9lIlKiy0ArFU=;
        b=x/WKrGKlNXI82tMCd+If83qGZ4A5V0aiez3Q4+B/y4E0Ii27Gjq07m6Z3gwi1CG23y
         E24ooW4ovp0kMi0yOQcyXv7z+vkI5TYNGoLhtxjhqXR1005UJQA6IfOBBL0u2SNze86C
         +UpBB3Gz9ifTz7wnsgQoURBYlUCWQT83Sti5onaAGBlWfOrkbf9n7Eci4PFLJ1LppDBK
         oiKJcSU+bNjwayoeta4NHd107xBTta+5YhPBCBp18zPBNZ3DmZLRE/XGW9dQqW5Tf0x7
         L/9c27aVxvMpRr0DewhXER6jKs50HLLrVjSdAXAQ/LCkdhQ6UgibO7ErYRNCu1fqLfqU
         JGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAN7y6gmMq3/PD5iIj3RPLoID/sAvRO9lIlKiy0ArFU=;
        b=BDOdoT0yv8IQM5voGBiBYDpcN/jc3GIwzr0hZjlZcUVozA8ebozhCwa0lMKdXurX6S
         kNiZJLSz+LIxaY5JYBcu3Fx+09A5B/LQV3KbIzpnqJMW6JTxSV7SIrkVUWWA0sGGagIY
         vS435O4/04cM02tU6tXWXAB1FtDPQkrx2LZVvRrZ3HPqjss5B8r5BRQaUIEb/MVlWj2z
         VshYh8trBW8Ya+tA3/HuwVJWJF4hY7NXMQR8TTxEgTCOpVHfz7xkq1SO6kt41cwanXii
         HH7RJXdmXzMPVXmQbM7SLRr73spFZbj8Z5KoYYDnRGHdxpk6m2E/c51t8amZdFr4q/HY
         az+g==
X-Gm-Message-State: AOAM533uCKQPVK52TCzNpluvQqxSGRrh3nQKXKZ7WjJr3klBCnkGXPt+
        j7UbxHQ/nm33dIRTX6U4aQopeQ==
X-Google-Smtp-Source: ABdhPJwuzWJ4qsPKBeZ7Q5Qn1v4IuB+iXGGLmkSzblCo6ZCfthm5bcvzLrZLaYJTBbDvBAJj+277cQ==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr3612728wmf.119.1600248110995;
        Wed, 16 Sep 2020 02:21:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f6sm32181670wro.5.2020.09.16.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 02:21:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value set.
Date:   Wed, 16 Sep 2020 10:21:23 +0100
Message-Id: <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to usage (bitfields.h) of REG_FIELDS,
Modify is:
  reg &= ~REG_FIELD_C;
  reg |= FIELD_PREP(REG_FIELD_C, c);

Patch ("soundwire: qcom : use FIELD_{GET|PREP}") seems to have
accidentally removed clearing bit field while modifying the register.

Fix this by adding back clear register mask before setting it up!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d7aabdaffee3..5d26361ab4f6 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -311,6 +311,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	/* Configure No pings */
 	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
+	val &= ~SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK;
 	val |= FIELD_PREP(SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK, SWRM_DEF_CMD_NO_PINGS);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
@@ -372,6 +373,9 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 
 	ctrl->reg_read(ctrl, reg, &val);
 
+	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
+	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
+
 	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
 	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
 
-- 
2.21.0

