Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470BB2C630A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgK0KZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgK0KZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:18 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EEBC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:17 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so2297576wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MW0obv0vN7m9now4s6iWiYdYIuGZvm2HGZntQs84WA=;
        b=IDM3R9fBzpZ+Cigblf6iKQ+7b1VX5dxzeU1WiVQmoXhRihoTQeCnBWCfeRTRQcGuLS
         5GLM8P25hkIPK2XdwkTv8IbsCpA2WAXUVjYocY6Io+AXJwshbJ66WsWqLsMgAY7KxOqm
         A+GPRbTy2kneisFfKUsgk9R0igFsoXr0viZcjM/RCzKF0EX8YN7dfUmvkqUsxcW4NdmL
         2jriDwUUEqphM4+V9KdsCO5v8SallPxMBXSGUcInw3zF82XtZLGGlhNAsaj4s+ZmWM38
         YDlrBZRR4Lv/7S1lZ1ko48TRzRNWDQmVH+4UnV41CZVsURBtWT/sPjCkYVYW6spmJNN3
         M7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MW0obv0vN7m9now4s6iWiYdYIuGZvm2HGZntQs84WA=;
        b=A3jwIhBUFRBsL2aD+GBZGS5UlqsuQN+DoAlt1p/dx1GfbZLabRwmRYgNbX0xYFQSh7
         lUhsC9ex+om9OZsEEkNcY7lXZ0sm18HO/ZgjSObNs5DmI2z2hTTtDiYZYdqxlmY1fdVu
         mTYwEfaXhUZPIGCmpVzFK7mpddVzA9Y+fU1bGaWJbEaT90vvTbLsBGoonZ7wZvNCzDp9
         AYsUsZjXqNPfc2ZwufWt04j5AHVo5qfeJxI3AxnlmlJ8x9J9hYab2BLv4r5wPnAFNvlF
         k606JrRCQ7N3lqL2jGWxIa4CZCAlYnj/TYquttcZXGvSklRTmB/f1aXmNYm1Zte2X4+2
         S4HQ==
X-Gm-Message-State: AOAM533yzV/uKW5Lj+et6foi3PmbApPwO25Y0RP4qNAdYxTTCBBb9cJa
        eb/wJfJ++YqnHqLxQ3D5ZprIxQ==
X-Google-Smtp-Source: ABdhPJyQieLqsws1YL6I6yXH1wZkUfn1BlylG4YzYATCt22LD6mNVS0ldWE35hBha1q2VEBov6zZZA==
X-Received: by 2002:a1c:96cb:: with SMTP id y194mr8078835wmd.62.1606472716540;
        Fri, 27 Nov 2020 02:25:16 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/7] slimbus: qcom-ngd-ctrl: Avoid sending power requests without QMI
Date:   Fri, 27 Nov 2020 10:24:50 +0000
Message-Id: <20201127102451.17114-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Attempting to send a power request during PM operations, when the QMI
handle isn't initialized results in a NULL pointer dereference. So check
if the QMI handle has been initialized before attempting to post the
power requests.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 172ddcc2a241..82dad7490588 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1229,6 +1229,9 @@ static int qcom_slim_ngd_runtime_resume(struct device *dev)
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (!ctrl->qmi.handle)
+		return 0;
+
 	if (ctrl->state >= QCOM_SLIM_NGD_CTRL_ASLEEP)
 		ret = qcom_slim_ngd_power_up(ctrl);
 	if (ret) {
@@ -1616,6 +1619,9 @@ static int __maybe_unused qcom_slim_ngd_runtime_suspend(struct device *dev)
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (!ctrl->qmi.handle)
+		return 0;
+
 	ret = qcom_slim_qmi_power_request(ctrl, false);
 	if (ret && ret != -EBUSY)
 		dev_info(ctrl->dev, "slim resource not idle:%d\n", ret);
-- 
2.21.0

