Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991BC202F43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 06:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgFVE2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 00:28:40 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:15666 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgFVE2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 00:28:38 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jun 2020 21:28:37 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg01-sd.qualcomm.com with ESMTP; 21 Jun 2020 21:28:33 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id D187021844; Mon, 22 Jun 2020 09:58:31 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        sivaprak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 0/4] Add APSS clock controller support for IPQ6018
Date:   Mon, 22 Jun 2020 09:58:08 +0530
Message-Id: <1592800092-20533-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU on Qualcomm's IPQ6018 devices are primarily fed by APSS PLL and XO,
these are connected to a clock mux and enable block.

This patch series adds support for these clocks and inturn enables clocks
required for CPU freq.

[V8]
 * In patch 1 changed compatible string from const to enum
 * Since this change is minimal retained Review tag from Rob
 * In patch 3 re added Ack from Rob
[V7]
 * Removed dts patch from this series, will send that separately
 * Addressed Rob's minor comment on the binding
 * Patch 1 depends on a53 pll bindings
   https://lkml.org/lkml/2020/5/4/60
[V6]
 * Split mailbox driver from this series, mailbox changes will sent as a
   separate series
 * Addressed review comments from Stephen
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

Sivaprakash Murugesan (4):
  dt-bindings: clock: add ipq6018 a53 pll compatible
  clk: qcom: Add ipq apss pll driver
  clk: qcom: Add DT bindings for ipq6018 apss clock controller
  clk: qcom: Add ipq6018 apss clock controller

 .../devicetree/bindings/clock/qcom,a53pll.yaml     |  18 ++++
 drivers/clk/qcom/Kconfig                           |  19 ++++
 drivers/clk/qcom/Makefile                          |   2 +
 drivers/clk/qcom/apss-ipq-pll.c                    |  95 ++++++++++++++++++
 drivers/clk/qcom/apss-ipq6018.c                    | 106 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,apss-ipq.h          |  12 +++
 6 files changed, 252 insertions(+)
 create mode 100644 drivers/clk/qcom/apss-ipq-pll.c
 create mode 100644 drivers/clk/qcom/apss-ipq6018.c
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq.h

-- 
2.7.4

