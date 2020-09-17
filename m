Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E719826DB04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIQMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIQMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:01:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04030C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:01:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so1774411wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDW/5TUsrxUdneMS88BtzV57xAqG/0FhZp46vJIbMBk=;
        b=Q91wsA08pCF9KPpTfTTu0zX1S3G9KH+OFJG3zCSDTMo5YOm+XADoO1vluy4jhWRoFQ
         +5tPuNZ+3f82ehiFGlI3NB6z+sdyEt/ysYmnC1XhfZOwfkN19+Cj/H2rOSMxhj7rZmwn
         qzGNZjlfn1wtwx8e1UZSSJZ2Meq7dZffNbgNVXILrINJjTDBdyqb7WD5OldWQe1QeBB1
         xdMXQt9xa+HGI7PtBabx1SM3mp+v8TXnzuwK/1xibK1wd75UANqI5eo1A0voc9a8kcdc
         7Dphg9JH81fBG616juKWxi6FTBS7kiyjoluUbiygfuCfaAgC43lIVWnTbPyI4CF4lENt
         tr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDW/5TUsrxUdneMS88BtzV57xAqG/0FhZp46vJIbMBk=;
        b=cFdHRMX3/kRZq5CbzjX8Dvo2w1Tvmii92uxH+50LEKUeVmByhTd44PDOS9DuN1w4E4
         h+Koq2lv5B41+aNfvKE+5kJz/Y4ylo39vnvH2qEOng5vT13krRWp1oYVRaXPcN2apJFF
         wnLlzQP2bbq96RUXA7liefuDVQxNcFSdk8pCyzc+UX66l24HhGxO0crKtd9wr3YdCuTT
         vWSlgkvk+WUK8jMs666EKwDvKOj4dR7KZkNUuIjOI0WKdiI2nkj5s/9xfXg965vESM1l
         J2vPX1a+Owno3ZmYaq86MRkrvowZvR2URFayQkBUXPWTAGqSCnE67+ehTVYl+FrU1ySu
         bKuw==
X-Gm-Message-State: AOAM530ReFqKPxNCLjvY9q6WMK5rXzXPSWEHrgZSgQwpZWKAJ4VjPG+5
        XCgLF2SmVkCemppiypoUu4JlsA==
X-Google-Smtp-Source: ABdhPJznqkCbHmg/ULWibtL1ntpaNlbG1jCTGBGonNSLtbaisrLzXrRHxExh9sdYXczbULTSx61bmg==
X-Received: by 2002:adf:df05:: with SMTP id y5mr34676147wrl.39.1600344103639;
        Thu, 17 Sep 2020 05:01:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q18sm37584860wre.78.2020.09.17.05.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 05:01:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/3] soundwire: qcom: clear BIT FIELDs before value set.
Date:   Thu, 17 Sep 2020 13:01:36 +0100
Message-Id: <20200917120138.11313-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
References: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to usage (bitfields.h) of REG_FIELDS,
Modify is:
  reg &= ~REG_FIELD_C;
  reg |= FIELD_PREP(REG_FIELD_C, c);

Patch ("soundwire: qcom : use FIELD_{GET|PREP}") seems to have
accidentally removed clearing bit field while modifying the register.

Fix this by using u32p_replace_bits() to clear and set the values.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d7aabdaffee3..c1bb35884182 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -311,7 +311,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	/* Configure No pings */
 	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
-	val |= FIELD_PREP(SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK, SWRM_DEF_CMD_NO_PINGS);
+	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
 	/* Configure number of retries of a read/write cmd */
@@ -372,8 +372,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 
 	ctrl->reg_read(ctrl, reg, &val);
 
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
+	u32p_replace_bits(&val, SWRM_MAX_COL_VAL, SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK);
+	u32p_replace_bits(&val, SWRM_MAX_ROW_VAL, SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK);
 
 	return ctrl->reg_write(ctrl, reg, val);
 }
-- 
2.21.0

