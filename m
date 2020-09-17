Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4981226DCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgIQNaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIQN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:29:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11364C061352
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:28:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so2059228wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLbqqZ/vpJpcdXaFd7VC2pcNFTGY4Iy4LUzor+NVcxg=;
        b=j1Ewtdfm6q53Q0PWp1kjz54MdZK6+8duFS/Rm1nvXupcPFqa5lJGyQfshtwmUPbmpD
         9wrB+PtDcm7gvGgJF9xsckuIV14q5YPCh1LFfSpJVfJjfXZ352DVACm1ZyzWzXKI3l44
         UhbIKHf6FGlCYxLYvTmCXJXzzLVXL3chdpMh1GA3d0wOYgwsPdpL9/P6Nvgo6tHw43ji
         JGqyWSHQ008Zubvbp7XuON2nTFcoIq63W1b5c09bmu3jVsicdkHNOrDVp5IW9hVab9KC
         BU4RjO+eBxzaWf5bAqaU3HqCGiNJbNEslZOlXfQ7QTuoPCssCbFFarFLtJFHT69jbMnX
         dfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLbqqZ/vpJpcdXaFd7VC2pcNFTGY4Iy4LUzor+NVcxg=;
        b=NmGdLc3hAAzjQ2jp4KjnDjgW07mHyUfH4hTvHS/QSNiGM1YoRfQTjJjkEnrDSZm0Hx
         K6FiUs+m+54bJ6W2zsmSCImduuiXfxLEAJYBTdL+XiDRcUis2Tl0fLVqKVFvFTGbIJbO
         lh6YLH3vmgX9cjYNmkXqT2SL1+uli0TSw1KZzPZRHL2e/dIn9J6YV1uNwFT03bly+yTg
         ex8Vh9ln67SD/xRkC0c07lH6YkZ3FV5oucNzsmul2KUBu4LWVbKuM3FMaCd02d5vZze1
         6w0R0lzCdKe3YFnYsgHLlE5Dy8ZCGXJbcc51oQD254h0VMzlqh11EoUZNiMRU3zwUrew
         dzFQ==
X-Gm-Message-State: AOAM532iTucHz4HvE/ZMWUMKx2pJDXs6oL0JGC2ooVnicUTEX4Djvyqd
        1OdClzRRbZCKfbvg/jqrdHFESg==
X-Google-Smtp-Source: ABdhPJxIxoY8/oezHyrHk5clz6STxjXu6oZ+2wLqR+YmY169D2v/URS3C6DnnrbMi+fUKqOGeugFhQ==
X-Received: by 2002:adf:e289:: with SMTP id v9mr32408611wri.14.1600349336204;
        Thu, 17 Sep 2020 06:28:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n10sm11486910wmk.7.2020.09.17.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:28:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] clk: qcom : add sm8250 LPASS GFM drivers
Date:   Thu, 17 Sep 2020 14:28:46 +0100
Message-Id: <20200917132850.7730-1-srinivas.kandagatla@linaro.org>
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
support when required.

Srinivas Kandagatla (4):
  dt-bindings: clock: Add support for LPASS Audio Clock Controller
  dt-bindings: clock: Add support for LPASS Always ON Controller
  clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks
  clk: qcom: Add support to LPASS AON_CC Glitch Free Mux clocks

 .../bindings/clock/qcom,aoncc-sm8250.yaml     |  58 ++++
 .../bindings/clock/qcom,audiocc-sm8250.yaml   |  58 ++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/lpass-gfm-sm8250.c           | 296 ++++++++++++++++++
 .../clock/qcom,sm8250-lpass-aoncc.h           |  11 +
 .../clock/qcom,sm8250-lpass-audiocc.h         |  13 +
 7 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,audiocc-sm8250.yaml
 create mode 100644 drivers/clk/qcom/lpass-gfm-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-audiocc.h

-- 
2.21.0

