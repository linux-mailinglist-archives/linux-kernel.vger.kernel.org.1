Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD281C6178
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgEET7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:59:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48395 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbgEET7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:59:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588708786; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kvItYongzdU+2DxidH+Naeor8fjYwxIXps7J9ycM/y8=; b=e6NNOj7buDbzpBNfDVs0oeAS/MvZiqTL1eNGEX2+6Nr3yFoyoGFgWK+R2FVtdVYqsHLASryQ
 u8G9g0VbmCTdQZScLQPOuXl1qqcy4IXFFDDw2A4hZwU5Zm35advX9QUsoeEW7n0IYB+n5gbx
 XGe1IWgL4XRLNn2Y2HEWgvM0bDY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1c5b2.7f0f8db1a4c8-smtp-out-n01;
 Tue, 05 May 2020 19:59:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E5EAC44792; Tue,  5 May 2020 19:59:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBDB4C432C2;
        Tue,  5 May 2020 19:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBDB4C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, vkoul@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jackp@codeaurora.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v9 0/5] Add SS/HS-USB changes for Qualcomm SM8150 chipset
Date:   Tue,  5 May 2020 12:59:31 -0700
Message-Id: <1588708776-16774-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Synopsis 7nm HSPHY USB driver being
used in QCOM chipsets.  The HSPHY register map differs compared to 
other PHY revisions.  In addition, modifications and updates are done
to the QMP driver to add new registers/offsets, and to update the
initialization sequence for enabling the SSUSB path on SM8150.

Changes in v9:
 - Fixed missing required regulators in DT bindings file

Reviewed-by: Rob Herring <robh@kernel.org>

Changes in v8:
 - Fix checkpatch warnings about characters per line.
 - Rebase to linux-phy/next branch

Reviewed-by: Vinod Koul <vkoul@kernel.org>

Changes in v7:
 - Use _relaxed() variants for writel/readl calls in
   phy-qcom-snps-femto-v2.c
 - Remove comments in the phy init function
 - Use devm_platform_ioremap_resource instead of devm_ioremap_resource
 - Fix chipset naming in Kconfig
 - Address minor fixups in the YAML file (remove status in example, fix
   "Hi-speed" to "High-speed", add a newline at the end)

Changes in v6:
 - Addressed coding style errors in phy-qcom-snps-femto-v2.c

Changes in v5:
 - Reorganize IF check for when to use the proper PWRDOWN CTRL offset
 - Rename UFS specific offset definitions in the QMP PHY driver to clearly
   denote they are UFS specific
 - Rename the phy-qcom-snps-7nm driver to phy-qcom-snps-femto-v2

Changes in v4:
 - Fix POWERDOWN offset for QMP PHY exit routine, and check for
   has_phy_dp_com_ctrl instead of !has_phy_com_ctrl

Changes in v3:
 - Use devm_reset_control_get_exclusive instead of referencing index for
   reset handle

Changes in v2:
 - Fixed YAML errors caught by dt_binding_check

Jack Pham (1):
  phy: qcom-qmp: Add SM8150 QMP USB3 PHY support

Wesley Cheng (4):
  dt-bindings: phy: Add binding for qcom,usb-snps-femto-v2
  phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
  phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
  phy: qcom-qmp: Rename UFS PCS QMP v4 registers

 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  80 ++++++
 drivers/phy/qualcomm/Kconfig                       |  10 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 196 +++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 238 +++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 287 +++++++++++++++++++++
 6 files changed, 776 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
