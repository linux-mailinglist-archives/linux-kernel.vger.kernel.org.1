Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D528A2CE799
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgLDFoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgLDFog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:44:36 -0500
From:   Vinod Koul <vkoul@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add binding and dts for Qualcomm SM8350
Date:   Fri,  4 Dec 2020 11:13:43 +0530
Message-Id: <20201204054347.2877857-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds the compatible for SM8350 SoC, board and aoss compatible.
Then the base DTS for SM8350 SoC which contains clock (gcc, rpmh), pinctrl,
uart, reserved memory and cpu nodes. The board file for MTP enables uart and
adds the rpmh regulators

Vinod Koul (4):
  dt-bindings: arm: qcom: Document SM8350 SoC and boards
  soc: qcom: aoss: Add SM8350 compatible
  arm64: dts: qcom: Add basic devicetree support for SM8350 SoC
  arm64: dts: qcom: Add basic devicetree support for SM8350-MTP board

 .../devicetree/bindings/arm/qcom.yaml         |   6 +
 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts       | 246 +++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 496 ++++++++++++++++++
 drivers/soc/qcom/qcom_aoss.c                  |   1 +
 6 files changed, 751 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8350-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8350.dtsi

Thanks
-- 
2.26.2

