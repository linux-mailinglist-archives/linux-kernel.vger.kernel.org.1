Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070B029D83E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgJ1Wap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:30:45 -0400
Received: from z5.mailgun.us ([104.130.96.5]:12474 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbgJ1Wam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:30:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603924242; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/ZGUMfp1A0aHVNO/vay/6ICqzhjKvdAharx01TPBxAI=; b=Nd/cI9JcseVZxdVDfZObK4BjlgOlv3LSTC06J+Q9RDY07bx2rY3oJGmOKLW2NoirOK1CBV5e
 CLpbCi0gBL0NS78TvhfT6nddJ6nNzaCI7hP2ciDFJnFf1Mkqx1bYyQhswaqNQCDgm7UEBIus
 kgbbrTCqNLCF8HU+L8rH/Utm5Ig=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f9981a8083018dc096382cc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 14:35:20
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4139FC433FF; Wed, 28 Oct 2020 14:35:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akhilpo-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2770C433CB;
        Wed, 28 Oct 2020 14:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2770C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        mka@chromium.org, robdclark@gmail.com, dianders@chromium.org
Subject: [PATCH v2 1/2] drm/msm: Implement shutdown callback for adreno
Date:   Wed, 28 Oct 2020 20:05:10 +0530
Message-Id: <1603895711-23755-1-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the shutdown callback for adreno gpu platform device
to safely shutdown it before a system reboot. This helps to avoid
futher transactions from gpu after the smmu is moved to bypass mode.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 58e03b2..87c8b03 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -475,6 +475,11 @@ static int adreno_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void adreno_shutdown(struct platform_device *pdev)
+{
+	pm_runtime_force_suspend(&pdev->dev);
+}
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,adreno-3xx" },
@@ -509,6 +514,7 @@ static const struct dev_pm_ops adreno_pm_ops = {
 static struct platform_driver adreno_driver = {
 	.probe = adreno_probe,
 	.remove = adreno_remove,
+	.shutdown = adreno_shutdown,
 	.driver = {
 		.name = "adreno",
 		.of_match_table = dt_match,
-- 
2.7.4

