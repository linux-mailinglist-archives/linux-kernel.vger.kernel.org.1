Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5226C4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIPP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIPPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F644C02C2AE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so7393254wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QR4X/TKCD+d57b2Ze0jlcbxYS6HqjaoNPSGjtgtVeZ8=;
        b=x96G+S6zKbDmbASlvP7erU7iD+GDKspcvh52WK9lO3bptq4o/JN2t6vGLMOkkB5KOG
         Qc5PuhIaOF4Et5HnoBGWs6yPo2pNJ6//0n37joIqJr9LQ+aqEq+DaPbC29flNyFfasUR
         HxACTxe9CJRbPdlbPFOSEBXE94Py6lsccWUI2TS//pkF1pNnwgZVfa+ZI99aXcgKCvlD
         nSNfrCnoJSrykTuLW/uEyIFR82beHvuaOV1doArQS2pa7/XzLVvZUb7CDbP+3JZ0MLU7
         Y3rJNI5f+jALXdF0UEASyVU/p6v8/1Xunbt9Jyr0XrEhRMBwwKeyf5L81A9pB+4eX8TG
         efJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR4X/TKCD+d57b2Ze0jlcbxYS6HqjaoNPSGjtgtVeZ8=;
        b=Pq5ZNqWBgEcneyXwJMxsdKFkUw+940Z9P4GmcHP3fy3nW0XjIxWsUKggAr8fjRrX2S
         TPm5BsstJNTt49aez9EMjOfOGHLgR07cgn8FZIwt009IHP0OjCnLTkwWNK3hDfsEtIm9
         b+dlnn0GVy2TtgZDlHWm3pus5OxvR7KMC43y6kWtdNmBChn+me01cFPsQ5imvEGMfD4D
         rpGiOq3nR+SA4/BXj8ojhACK9IVYCz3dFe9Y/AOziLC0mdsawRGo6ZFHkXAQ/xwy+HKa
         xnuveYz6lDbNmdgwzrZ3VnDgXqrkUUTClXe/YpYBZwQ9NYqYxI3PF6pq94DoqnPMk8Xd
         MABA==
X-Gm-Message-State: AOAM532aL9EzSm9n/cZFNAI0DIuPAbhtmERHt9xFJR4QxjvEPW7F9PfJ
        21gzmw8SjnRURd0MIAusirTqDQ==
X-Google-Smtp-Source: ABdhPJxvV/oYmxQjdvC/nE1y4Kgb+u9RgTb9KXGP+lXTt6/rlDcYaUJwo3RYwi7k/zRFDaSSopmDiA==
X-Received: by 2002:a05:6000:100c:: with SMTP id a12mr29222491wrx.115.1600270868971;
        Wed, 16 Sep 2020 08:41:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t22sm7223901wmt.1.2020.09.16.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:41:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/3] soundwire: qcom: clear BIT FIELDs before value set.
Date:   Wed, 16 Sep 2020 16:40:59 +0100
Message-Id: <20200916154101.2254-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
References: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
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

Fix this by using u32_replace_bits() to clear and set the values.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d7aabdaffee3..0036d3248fb4 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -311,7 +311,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	/* Configure No pings */
 	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
-	val |= FIELD_PREP(SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK, SWRM_DEF_CMD_NO_PINGS);
+	val = u32_replace_bits(val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
 	/* Configure number of retries of a read/write cmd */
@@ -372,8 +372,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 
 	ctrl->reg_read(ctrl, reg, &val);
 
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
+	val = u32_replace_bits(val, SWRM_MAX_COL_VAL, SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK);
+	val = u32_replace_bits(val, SWRM_MAX_ROW_VAL, SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK);
 
 	return ctrl->reg_write(ctrl, reg, val);
 }
-- 
2.21.0

