Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC21DFE1F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgEXKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 06:04:55 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32231 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728774AbgEXKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 06:04:54 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2020 03:04:54 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 24 May 2020 03:04:50 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 2B9B821791; Sun, 24 May 2020 15:34:49 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V5 0/8] Add APSS clock controller support for IPQ6018
Date:   Sun, 24 May 2020 15:34:38 +0530
Message-Id: <1590314686-11749-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU on Qualcomm's IPQ6018 devices are primarily fed by APSS PLL and XO,
these are connected to a clock mux and enable block.

This patch series adds support for these clocks and inturn enables clocks
required for CPU freq.

[V5]
 * Addressed Bjorn comments on apss clk and dt-bindings
 * Patch 2 depends on a53 pll dt-bindings
   https://www.spinics.net/lists/linux-clk/msg48358.html  
[V4]
 * Re-written PLL found on IPQ platforms as a separate driver
 * Addressed stephen's comments on apss clock controller and pll
 * Addressed Rob's review comments on bindings
 * moved a53 pll binding from this series as it is not applicable, will send
   it separately.
[V3]
 * Fixed dt binding check error in patch2
   dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
[V2]
 * Restructred the patch series as there are two different HW blocks,
   the mux and enable belongs to the apcs block and PLL has a separate HW
   block.
 * Converted qcom mailbox and qcom a53 pll documentation to yaml.
 * Addressed review comments from Stephen, Rob and Sibi where it is applicable.
 * Changed this cover letter to state the purpose of this patch series

Sivaprakash Murugesan (8):
  dt-bindings: mailbox: Add YAML schemas for QCOM APCS global block
  dt-bindings: clock: add ipq6018 a53 pll compatible
  clk: qcom: Add ipq apss pll driver
  clk: qcom: Add DT bindings for ipq6018 apss clock controller
  clk: qcom: Add ipq6018 apss clock controller
  dt-bindings: mailbox: Add dt-bindings for ipq6018 apcs global block
  mailbox: qcom: Add ipq6018 apcs compatible
  arm64: dts: ipq6018: Add a53 pll and apcs clock

 .../devicetree/bindings/clock/qcom,a53pll.yaml     |  18 ++++
 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |  88 -----------------
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  99 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  16 +++-
 drivers/clk/qcom/Kconfig                           |  19 ++++
 drivers/clk/qcom/Makefile                          |   2 +
 drivers/clk/qcom/apss-ipq-pll.c                    |  97 +++++++++++++++++++
 drivers/clk/qcom/apss-ipq6018.c                    | 106 +++++++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  23 +++--
 include/dt-bindings/clock/qcom,apss-ipq.h          |  12 +++
 10 files changed, 380 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq-pll.c
 create mode 100644 drivers/clk/qcom/apss-ipq6018.c
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq.h

-- 
2.7.4

