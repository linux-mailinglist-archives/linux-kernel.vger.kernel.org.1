Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA956298C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774654AbgJZMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:02:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39683 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774638AbgJZMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:02:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id y12so12121843wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzDcAsPcv9VfA3khTArkxlqmE18NNhfd2DKZyq6irZY=;
        b=uZPtgb0tzTa6z7hyIgpYYeiGvN2Lk58Yu7JfKzN5prXR7zq4DIVxngBEFXTIbE4I2H
         hg1HKf2qLDXQ+CpaVf85YEXzB7p+UuQM+G1c0mHhp7TcksAehhrvvra95s0tR9r/bfdg
         XlLspjjirubQjw+r2vhKqx5PfN+kCZHlcJiGvnggxMzagxPDtleeMqVbFdMzgcbVStfp
         IPgTqucPsZ6Poqp5yHmAnGPa6WebVhvE2sBZm7oEpm4Yl0vSd4xIEVVGeM7boDsKdT9r
         aGQNtEt6gECNemFc6EI8ZpefOKB7DmG/+Or25J+vJ78EzpJVnFvJrkNVu5K04KDnv1gW
         GdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzDcAsPcv9VfA3khTArkxlqmE18NNhfd2DKZyq6irZY=;
        b=cd7wTcnss+/dw1MFm9n7JjXB1gCfB6SozsN+RhR4T891KHVsQ01j1zvL7XcFPqOVCH
         i1YxjE18MSP93hBcZ7bjo5FwG6jPs+hjv2O9Gc5YHyqlEGKGpl25fQMICAEClVrePsFg
         GphSwtrG0PxdqFcg0xKKPrZgBOCcLXYjc5WAIhTe9t/I0cLYsbtmQ28hLCeS/ksxY7Hz
         8OEa/3ha4XzO+hvVs/EfaJU4zHpJGT0RGiB0lJ8taPj0c33AibRqB8nKVYhhTUX4Yk0f
         lKK/r/n77FtkePP1MMmsEM+SWQhBSqnI86HrUuJ/RHZJOJFgvwx5XQYKRzZqqYfvACMh
         2zrA==
X-Gm-Message-State: AOAM532cWYKWSUckL/UfH4IEfEQbWabThnXRV3Tvtq3CjRsoEO+PNI4f
        5Q+5Kl/lU3EvuTQ685lIqcjc1Q==
X-Google-Smtp-Source: ABdhPJypvNXJuxmMM7Zf/cRBse301AwywIM5EX/nLsZGHuYZNtWiSXQSa4Qtp2BQvHZqpu18jMUbug==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr17322530wrr.11.1603713744985;
        Mon, 26 Oct 2020 05:02:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id i33sm23659337wri.79.2020.10.26.05.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:02:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v3 0/4] clk: qcom : add sm8250 LPASS GFM drivers
Date:   Mon, 26 Oct 2020 12:02:17 +0000
Message-Id: <20201026120221.18984-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is resend of v3, due to dt_bindings check failure as
rc1 was not out when previous v3 was sent!

This patchset adds support for GFM Muxes found in LPASS
(Low Power Audio SubSystem) IP in Audio Clock Controller
and Always ON clock controller.

Clocks derived from these muxes are consumed by LPASS Digital Codec.
Currently the driver for Audio and Always ON clock controller only
supports GFM Muxes, however it should be easy to add more clock
support when required

Changes since v2:
- updated Kconfig text and help as suggested by Stephen
- removed unnecessary header file include
- use fw_name instead of name for parents
- use devm_platform_ioremap_resource

verified dt_binding_check to pass on rc1,

Srinivas Kandagatla (4):
  dt-bindings: clock: Add support for LPASS Audio Clock Controller
  dt-bindings: clock: Add support for LPASS Always ON Controller
  clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks
  clk: qcom: Add support to LPASS AON_CC Glitch Free Mux clocks

 .../bindings/clock/qcom,aoncc-sm8250.yaml     |  58 ++++
 .../bindings/clock/qcom,audiocc-sm8250.yaml   |  58 ++++
 drivers/clk/qcom/Kconfig                      |   6 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/lpass-gfm-sm8250.c           | 320 ++++++++++++++++++
 .../clock/qcom,sm8250-lpass-aoncc.h           |  11 +
 .../clock/qcom,sm8250-lpass-audiocc.h         |  13 +
 7 files changed, 467 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,audiocc-sm8250.yaml
 create mode 100644 drivers/clk/qcom/lpass-gfm-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-audiocc.h

-- 
2.21.0

