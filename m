Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5E223CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGQNbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 09:31:03 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47872 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgGQNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:31:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594992660; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4LXgE/UC9nDaBK7oF+NcTwi3cT/4cGJHu/l0KUMCjTk=; b=h2H+P9n5uG87mN/VrqCMalJHN7AHtihyD7RGW5kExEGtHA2sNAq2N4mqLz49h0+CmKGkZ2YQ
 +43xlGwjyX0r55yh1r8WkEqgzkaZVhAd2L5cOw7QcA0w7g3ksYaWPKkMJ0Teu81dste+jGwY
 YeA4Y0aNgMkym9G4sgcD1QIsZTY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f11a7e6c9bd2efa2ef212f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 13:30:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 066FBC433C6; Fri, 17 Jul 2020 13:30:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akhilpo-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1237DC433AD;
        Fri, 17 Jul 2020 13:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1237DC433AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        smasetty@codeaurora.org, devicetree@vger.kernel.org,
        mka@chromium.org, saravanak@google.com, sibis@codeaurora.org,
        viresh.kumar@linaro.org, jonathan@marek.ca, robdclark@gmail.com,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 5/6] arm64: dts: qcom: sc7180: Add interconnects property for GPU
Date:   Fri, 17 Jul 2020 18:59:38 +0530
Message-Id: <1594992579-20662-6-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594992579-20662-1-git-send-email-akhilpo@codeaurora.org>
References: <1594992579-20662-1-git-send-email-akhilpo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sharat Masetty <smasetty@codeaurora.org>

This patch adds the interconnects property to the GPU node. This enables
the GPU->DDR path bandwidth voting.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 31b9217..80fe54b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1470,6 +1470,9 @@
 			operating-points-v2 = <&gpu_opp_table>;
 			qcom,gmu = <&gmu>;
 
+			interconnects = <&gem_noc MASTER_GFX3D &mc_virt SLAVE_EBI1>;
+			interconnect-names = "gfx-mem";
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
2.7.4

