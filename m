Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21122B8C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKSH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKSH1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:27:34 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAEC061A04
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:27:34 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q34so3414611pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RU7wqKfv+LHgDxaPO29yong1ckKnttrhFl59yq3IpUI=;
        b=IakSS16gwXF63uN3L/x39vp5/9lblBW8F+b0zHPH7e3uOQJRVHkChfagvvQX37XOij
         z9TTJV95j8jUZUAWpZ1ijbL1Ggus5j9Gsv5mG4ksoQz+9EK9UmFkGusvAy2Jc7krt95+
         noRLmeAmKDbDydaqVdEx9U0jOnCp2LaHzG3VD3K5BGXpf4bGEKf2E3W/IR750gHdKWpd
         EmaecTOvHrVMYOMUBXCcOfTq/AdDZ/t0WEcgqfnolx6GQR8Yo/u4cPgZl5uzKfKSKhCB
         2jpb6e+fKItPv8oVYTwahrsaREt/EjaZ48pJmelgU6uiNBrM45U02qB9rLphuuqRvhgH
         yyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RU7wqKfv+LHgDxaPO29yong1ckKnttrhFl59yq3IpUI=;
        b=ddO6+NBeuM0Tr77PqcsL4NpEtpawiQscMtb8VWFQ4M9SCW2+rh9yDTOTbbL83hXC8/
         7yk+HM2jqxlMZXbeMJ7QypHp03W+N3xXNHm3cQNui1Ww+7Lzd2X4HF47oYuOpogJ0zrC
         qLV5YNKM/lxFqhqSUL3CJNPuvuCUba8b5oYKVOb1j9bUtseVN08gxglJLd6iwImRnmZl
         X6NNpuqL/ILaP8h08MXV2uJKLioyrncd78NSF8k7P8YRanTqVnjgIyMpukDDwtB4fyYF
         eoUEYl56t5xlSQHWgWzzhhrs4AtoIWhN3nVfhfOmDBE7djDQZTo1QcVfuiA4p8PPzfc5
         /XaQ==
X-Gm-Message-State: AOAM532O+rF2RhyhYTtWdW5JZaw6GXJsKtcJUzn/Sm/4uDvbelNNdALE
        J7Hh9oYcZYPPm39Yt5OBXoLC
X-Google-Smtp-Source: ABdhPJzDqCIzqK/L4m3tm0v2ROFYN/c2jaZW/pQwsTLEpr7eMivyAIwng7u4MmbNVAaAYgCpFDrtSg==
X-Received: by 2002:a17:90a:6283:: with SMTP id d3mr3029466pjj.96.1605770853467;
        Wed, 18 Nov 2020 23:27:33 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id a8sm26802923pfa.132.2020.11.18.23.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:27:32 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add GCC and RPMh clock support for SDX55
Date:   Thu, 19 Nov 2020 12:57:10 +0530
Message-Id: <20201119072714.14460-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds Global Clock Controller (GCC) and RPMh clock support
for SDX55 SoC from Qualcomm with relevant DT bindings.

This series has been tested on SDX55 MTP board. The dts patches for this
SoC/board will be posted later.

Thanks,
Mani

Changes in v3:

* Documented core_bi_pll_test_se clock in dt binding
* Collected reviews

Changes in v2:

* Modified the GCC Kconfig symbol from GCC_SDX55 to SDX_GCC_55
* Added S-o-b tag to bindings patch
* Incorporated review comments from Stephen on the gcc driver
* Added review tag from Bjorn on RPMh patch

Manivannan Sadhasivam (1):
  clk: qcom: Add support for SDX55 RPMh clocks

Naveen Yadav (1):
  clk: qcom: Add SDX55 GCC support

Vinod Koul (2):
  dt-bindings: clock: Add SDX55 GCC clock bindings
  dt-bindings: clock: Introduce RPMHCC bindings for SDX55

 .../bindings/clock/qcom,gcc-sdx55.yaml        |   73 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   20 +
 drivers/clk/qcom/gcc-sdx55.c                  | 1626 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdx55.h    |  112 ++
 include/dt-bindings/clock/qcom,rpmh.h         |    1 +
 8 files changed, 1841 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
 create mode 100644 drivers/clk/qcom/gcc-sdx55.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx55.h

-- 
2.17.1

