Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440FF1CFD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgELSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 14:18:48 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:5156 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgELSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:18:46 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 May 2020 23:48:43 +0530
Received: from c-rbokka-linux.qualcomm.com ([10.206.232.238])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 May 2020 23:48:24 +0530
Received: by c-rbokka-linux.qualcomm.com (Postfix, from userid 203305)
        id 49E7B2B7B; Tue, 12 May 2020 23:48:23 +0530 (IST)
From:   Ravi Kumar Bokka <rbokka@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>
Subject: [RFC v1 0/3] Add QTI QFPROM-Efuse driver support
Date:   Tue, 12 May 2020 23:47:57 +0530
Message-Id: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds qfprom-efuse controller driver support.

This driver can access the raw qfprom regions for fuse blowing.

The current existed qfprom driver is only supports for cpufreq, thermal sensors
drivers by read out calibration data, speed bins..etc which is stored by
qfprom efuses. 

Ravi Kumar Bokka (3):
  dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
  drivers: nvmem: Add driver for QTI qfprom-efuse support
  arm64: dts: qcom: sc7180: Add qfprom-efuse

 .../devicetree/bindings/nvmem/qfprom-efuse.yaml    |  40 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   4 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   9 +
 drivers/nvmem/Kconfig                              |  10 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/qfprom-efuse.c                       | 476 +++++++++++++++++++++
 6 files changed, 541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom-efuse.yaml
 create mode 100644 drivers/nvmem/qfprom-efuse.c

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

