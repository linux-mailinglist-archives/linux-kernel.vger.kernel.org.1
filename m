Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C1278522
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgIYKbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgIYKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:31:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2CC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 03:31:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e11so1580193wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxPsmY6xMrudobvS3a5IPxrVhQsTl32KRChwCgeKp24=;
        b=EhBxqM0gxfw+4TaYEZteTYA8hQZkx1kzQfS27bZUIV1ITXvTmaaW+VG0j1STKZLN+6
         PjBtJf1Ej9wsqcJydZkd9nGbEKUlhHBlQOV1YLXzAjEJPmlBRs3cEv+kp7ru8e0kZshM
         RZTMYsOhIjdyQQogx3yyzqaDBqAKNBSYeMrmYq9Grm4n6KfaWkypU37EbpsLas3z1Ug0
         LsJOvd9IZcO2dDVgSSVaf/a6NnaxZdx6N7NVRMwcxKh0ZuK9M24vN2rJ+CgpErv2VOKS
         9UR15xCx2hRn6AQokIUBOQFiLFsKscDA0ywGJ3BKd39I3IrWhEpxtp3vWRvPTNFP3bEL
         RP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxPsmY6xMrudobvS3a5IPxrVhQsTl32KRChwCgeKp24=;
        b=L6GaTOhjUH1WuPmLEvEuCqD7V07+37r+hxqE+sUuSK7IhMvTlZEa/nNI3mASVjvJTR
         XMWPk4azrgk45BCb6YNKDsK0GxkOm/eWynGkORs4zGHFJTlmuS31f9Vj+6mPaBx1xghS
         jq3W3tHb2I/TPdMK4Usitpj5A/gFzxxC/ZADNPa2CG6FIUh3DUpom9VRmfV6uGhTt0w9
         8xTz/+51dRa0coE5goWWnCDiol2OLQpUm1NZFtBH19H43zSjilPF2R19ceiIEgpbmS78
         s1IrmrLFcRXASz4iRY42riH9kLjXkEquh8kpx290pKwygxh+CnaeEAGhNWmGHzIodYLA
         pXQQ==
X-Gm-Message-State: AOAM532aQibAuRGtAMdC4n+2Ra/N5VQaggvf7162eIM0B5PFJ9xOUiGC
        rll/oyb1TfAbAn2LQ13Ug0E7iA==
X-Google-Smtp-Source: ABdhPJzBUn4IPDFlv9ZZH1Oyc5QFu+X0TgWUPsMiHto2i7T7FhUmEeqMXp6Ak6s+6Y6+V8ZTxUDD8g==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr2436342wmh.181.1601029892908;
        Fri, 25 Sep 2020 03:31:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 11sm2354907wmi.14.2020.09.25.03.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 03:31:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] clk: qcom : add sm8250 LPASS GFM drivers
Date:   Fri, 25 Sep 2020 11:31:11 +0100
Message-Id: <20200925103115.15191-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for GFM Muxes found in LPASS
(Low Power Audio SubSystem) IP in Audio Clock Controller
and Always ON clock controller.

Clocks derived from these muxes are consumed by LPASS Digital Codec.
Currently the driver for Audio and Always ON clock controller only
supports GFM Muxes, however it should be easy to add more clock
support when required

Changes since v1:
 -removed unnecessary Kconfig dependencies
 - cleaned up header includes.
 - moved to using pm_clk
 - Moved to right place in Makefile
 - moved to use module_platform_driver instead of builtin_platform_driver
 - add null check for of_device_get_match_data 

verified dt_binding_check to pass on linux next https://paste.ubuntu.com/p/6nVzjRwvsW/


Srinivas Kandagatla (4):
  dt-bindings: clock: Add support for LPASS Audio Clock Controller
  dt-bindings: clock: Add support for LPASS Always ON Controller
  clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks
  clk: qcom: Add support to LPASS AON_CC Glitch Free Mux clocks

 .../bindings/clock/qcom,aoncc-sm8250.yaml     |  58 ++++
 .../bindings/clock/qcom,audiocc-sm8250.yaml   |  58 ++++
 drivers/clk/qcom/Kconfig                      |   6 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/lpass-gfm-sm8250.c           | 323 ++++++++++++++++++
 .../clock/qcom,sm8250-lpass-aoncc.h           |  11 +
 .../clock/qcom,sm8250-lpass-audiocc.h         |  13 +
 7 files changed, 470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,audiocc-sm8250.yaml
 create mode 100644 drivers/clk/qcom/lpass-gfm-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-audiocc.h

-- 
2.21.0

