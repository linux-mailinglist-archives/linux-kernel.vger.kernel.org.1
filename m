Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC643042F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbhAZPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:50:44 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:14396 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392748AbhAZPs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:48:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611676117; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=AIGp3sOSpcvWiZSeRL/t8BvDsbq1gMaRV6JTPMxNUP4=; b=u0wQFuGL6/FkSLDnimB7GdTLipE+xSnFU9K52giG5Jh/eooLOfdxqQ+xo3CysE8ZKpTke3sw
 WygjBAGJQBVPExwc2SpVyzXr9FxvWC7eghPSjIgm5KFxBpWa6tQeQFDc/uvq0SFonSC/r9gP
 vwwQS8fXEP73zToutjMlCs3C2MQ=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 601039ab72b7c29fd5db02d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 15:47:55
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DBBAC43467; Tue, 26 Jan 2021 15:47:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49718C433CA;
        Tue, 26 Jan 2021 15:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49718C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/4] arm64: dts: qcom: Add watchdog bark irq for  SC7180, SDM845, SM8150, SM8250
Date:   Tue, 26 Jan 2021 21:17:28 +0530
Message-Id: <cover.1611466260.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds pre-timeout notification support via bark
interrupt for SC7180, SDM845, SM8150, SM8250 SoCs.

Note: This has a functional dependency on [1] without which
the watchdog functionality would be broken.

[1] https://lore.kernel.org/patchwork/patch/1371266/

Sai Prakash Ranjan (4):
  arm64: dts: qcom: sc7180: Add watchdog bark interrupt
  arm64: dts: qcom: sdm845: Add watchdog bark interrupt
  arm64: dts: qcom: sm8150: Add watchdog bark interrupt
  arm64: dts: qcom: sm8250: Add watchdog bark interrupt

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 +
 4 files changed, 4 insertions(+)


base-commit: 76bb4dc36d0e6bd13c70536a77240f93a0260f7e
prerequisite-patch-id: 46f598da3a2dbddfefa72da5636438142a00babd
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

