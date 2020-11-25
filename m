Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539FF2C38D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgKYFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgKYFlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:41:45 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C5C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 21:41:45 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z24so1189471oto.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 21:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrH5HMIZUxZ8p9ZVVV5Tv219hldD8kORSISX8v4WVrU=;
        b=MUFNKhqQDCHQpfptt+YYZBTPRfTVUTXDGFfpo2K3QohChRAmOyh+drOOkBLeNSIYEi
         /4Yl3ksYWaJFBB+6L8/ZFvFTL76G+Ufj6anX93pkeJBzRt8nlHPQRVcXXJOvGY+mf5+0
         FIWPGvw/1phHPgvOn6jKCgCM4seP+1OlfZgMJSnz8niVSQQppkEGaQba96Oy32AdPJFm
         Vs4+WGdCHlK1wwk2ECk3OsbV+2CyK4SDMB9Gs/DsC8CspVJKot8iJ1xYEGNYT1mIw6Ys
         DK2LYih469xzjMLL5Eb+fL/JPadnt8dwuHdCrzm5ujqMxXYs8q7LDxh08vXDkxna4MSY
         Il9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrH5HMIZUxZ8p9ZVVV5Tv219hldD8kORSISX8v4WVrU=;
        b=B+oJhL+JGtqTvdP6xfCndtM5rWnSceQ+/tVRzUpdqJzPWVw5VXITU8Srplr4tlNzAy
         lgStHnW2aJcKb27JiUhsOMevB07kwrmqFiscazoj1s00eS1+YYB2HUr2+Afoyxfk36qi
         vttbaJoUvLON8gpnqWo1kGQblKbv87S8zQonaXHC7iosijx+Vk/RHRzJDHw0T32haOTf
         Bmnn2iHe93c5ZElXA6jUBm4lLb6Thj4BTWC76F+3ItnjYQrx5nvadj4nfjaUY1/asTx6
         /Pph408OOhOT8TTFgnEgNiSN6PToa89SAT1KZG3V9KoqADiY0zUK38oQa9ftqPB45Had
         ceUA==
X-Gm-Message-State: AOAM530tPzWJH+LypfgiNPpGZAxwoAoUXVXVxlZvnZ5oDhrdZI3lItk1
        Nw9cnbN34kfkHpw1emme9VFN+A==
X-Google-Smtp-Source: ABdhPJzzp6dtkH49iCowittR7nB8DAE9MRULxL7pHYpMrTkXIyuxqg5YqkKrKoEV/UUUXBoNAR4/jA==
X-Received: by 2002:a9d:851:: with SMTP id 75mr1731327oty.102.1606282904926;
        Tue, 24 Nov 2020 21:41:44 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l12sm806802ooe.27.2020.11.24.21.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 21:41:43 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Avoid sending power requests without QMI
Date:   Tue, 24 Nov 2020 21:42:55 -0800
Message-Id: <20201125054255.137067-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to send a power request during PM operations, when the QMI
handle isn't initialized results in a NULL pointer dereference. So check
if the QMI handle has been initialized before attempting to post the
power requests.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d8decb345e9d..c502e9e93965 100644
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
2.29.2

