Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06FE1A180C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDGWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 18:24:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18967 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgDGWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586298280; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dx666URRqJLgHx/92TiYUOVZjVVrAvoOpoacNAgGDDg=; b=sNA4pf8p2OVdU0fQhWxNb2bjjJn0HSHncE5tYThr80klzD8jwiNqG0oPLFQpiUZ//WA4WIzm
 i4iYuOBTrA42U222VBYS6GPZPEB5C7RRrPjETMSSm8EFalzxLDqmlAe1iOsyqnbfGauHBKIt
 B3nOTAZJKBuiONmip/nb4SDymMM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8cfda8.7f235810db90-smtp-out-n01;
 Tue, 07 Apr 2020 22:24:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E882DC43637; Tue,  7 Apr 2020 22:24:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF6BBC433D2;
        Tue,  7 Apr 2020 22:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF6BBC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 0/2] Enable SS/HS USB support on SM8150
Date:   Tue,  7 Apr 2020 15:24:25 -0700
Message-Id: <1586298267-4722-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required device tree nodes to enable the USB SS and HS
paths on the primary USB controller on SM8150.  In addition,
implement missing resources from the SM8150 GCC driver, which
includes the USB GDSC and the USB PIPE clocks.

Changes in v3:
 - Set dr_mode to "peripheral" on the SM8150 MTP DTSI file.

Changes in v2:
 - Combine GDSC and USB PIPE clock changes.
 - Re-order DTS nodes based on address

Jack Pham (1):
  arm64: dts: qcom: sm8150: Add USB and PHY device nodes

Wesley Cheng (1):
  clk: qcom: gcc: Add USB3 PIPE clock and GDSC for SM8150

 arch/arm64/boot/dts/qcom/sm8150-mtp.dts     | 21 +++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi        | 92 +++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-sm8150.c               | 52 ++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sm8150.h |  4 ++
 4 files changed, 169 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
