Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CD2B45F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgKPOeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgKPOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:34:48 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4045EC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:34:47 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so18907050wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9AsLr5r10zSP+gdGxgf1aue1g5+LWymISqP1WqQRQg=;
        b=OOFzDx60psyHV2Jdyx2JT1Vuq80hedNzwO4A6PSeUrTzLN82AgdBTFNfYMB00idc5f
         qk73WhV+B6yaDxjk6BWd05lvDYkEvm0AovhOdPOA16vaQCHegClh+vfGabu60Gst5M2Q
         jyHbZKxyGIHtN9GGWbLHJZ7aCmdCSql2e/UBwuOwGZiOWyNrtScaGu4YIM3/bMvxEBSm
         p/ChLfdqsZoP5Y9PPRPKPomzrjvANAtvui5kENUygCSP67A58lNUg1HsJGoXTD8cygC2
         uTXq6uadw2aIk0R1r676+H/DLUpfgH/08lth8cmDJt22jNAqkiZ9Jey3Eb/NVds80efU
         T57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y9AsLr5r10zSP+gdGxgf1aue1g5+LWymISqP1WqQRQg=;
        b=qgCfgpWlyUy0XJCBz4QlGjxO9rVAO5z/tFt4v/UlsXkRAPKtM/mOdwb7W5DOZkq6xo
         qRl4C0twOd4uclcYMhIopfdRconSQ2W9Ma5tTWFKnsUhEnTc/i2dI2mRdNCN/XTJjkv6
         65bbtFTUHOjhNCuLRS0tdQ7GzKFGlemCd1DnE7i3aSJflTDN/DNMobo/17IKXTs+9j2S
         8F9tr6zQK3I3pT0xb7Hn5QbkljE+ciLVemfq7ThxxeYKsVTL5lJ/q2xL4GtFG+QNTViS
         37IJOlLPlR4K9w3BOa7wvtCGG/06O/W6qJOGHYfXNW3hrIKMnz4fJD3zchmhRYW/W/cO
         Hw9g==
X-Gm-Message-State: AOAM532KiE/1cNehlbyJDIAPBmfU4Xu4cNucpUM62KGE+ObTKFIm6DFB
        Y51DKuuSDF4dKzkDlEOzwS8Hiw==
X-Google-Smtp-Source: ABdhPJwxIgvPQ7wGXjm2pSTJYMFsok8uLuxEChR7JEz4aiM6M+B4dw3yqAVKL3WkZbk1VT0s76EX6w==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr19515249wru.362.1605537285971;
        Mon, 16 Nov 2020 06:34:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n10sm24013501wrx.9.2020.11.16.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:34:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/2] pinctrl: qcom: Add sm8250 lpass lpi pinctrl support
Date:   Mon, 16 Nov 2020 14:34:30 +0000
Message-Id: <20201116143432.15809-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for LPASS (Low Power Audio SubSystem)
LPI (Low Power Island) pinctrl on SM8250.

This patch has been tested on support to Qualcomm Robotics RB5 Development
Kit based on QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
with onboard DMIC connected to internal LPASS codec via WSA  and VA macros
respectively.

Most of the work is derived from downstream Qualcomm kernels.
Credits to various Qualcomm authors from Patrick Lai's team who have
contributed to this code.

Am guessing existing qcom folder should cover maintining this driver too!
If not I can send additional patch to consolidate this along with other
Audio related drivers in Maintainer file!

Changes since v3:
 - updated bindings as per Rob's review!

Srinivas Kandagatla (2):
  dt-bindings: pinctrl: qcom: Add sm8250 lpass lpi pinctrl bindings
  pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver

 .../pinctrl/qcom,lpass-lpi-pinctrl.yaml       | 132 ++++
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c      | 734 ++++++++++++++++++
 4 files changed, 875 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c

-- 
2.21.0

