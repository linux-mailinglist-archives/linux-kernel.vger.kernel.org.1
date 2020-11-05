Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348592A7C22
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKEKsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgKEKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:48:32 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448F3C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 02:48:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so1186438pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 02:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6UTxDIKXxyRwcmDvCCD7p0lN1/IZKHgNHQd2xiazqvs=;
        b=z41gi7THOrUs3aQ3BdEIIfV8WUwK5jngqY+PX6LUzKAq3813/qURswMUsO0TtQvugP
         XHw/Jjn3a8MA9qo674YP8AaeqT6JV6zuMvxj+pQVZrlge8r4cypSKryORqVRb0m2Csae
         m6Q0PREA1co9BMbr6E6lUPD4ULAYvVqxmbtQ/WXWqITmoog5cAM1nUx6IQYPZkBrjd8m
         xHb5rb0xpfmIvRchTJQzpL+1yctGy1BwPZkSHdEMnZnkikvdW0DCq/CtxvB/2lEYkEkM
         Ho2XHtBaRZ25xn/6EC/510aMTgFlJz7ovi/5wj0fNrfwpEbe9SVVVsIIiwsT7Ok1CRtv
         fgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6UTxDIKXxyRwcmDvCCD7p0lN1/IZKHgNHQd2xiazqvs=;
        b=iR/BoaDV06BVYMAoaACpo2MSXONJqczvoAjq8B5y+OA7RQuNxKQc30dVQF4NUKyayX
         a5KfE1NCxO/CAjkXd0hRKZop+h4Z8y0OUDxlq2vb4HEgmWWh4ey88HK8Tr428smngT5P
         m4mOaOsCpB61R2AYG7zkrgwT1IWUwTP7fLSe+AfFhrEcow4363Rmvk43mOheFlU2omzp
         CkLoBwQk+f7mKpe5D5oSVk0h0HJKpiI27ZstbK2n8tiIL9ksJrp5XT2ruFGU6JELS7mk
         fd0FHQGlW8Ng0/c+mF39g5zQ2lgXfCopFxSG1hIbrhrGHkbX4O+dKm2w7kLGKPxkQpyU
         J+ow==
X-Gm-Message-State: AOAM531jtBdpTg0lYPni92GQaSm+7ZswDUUJQPe+MhDnW+lKsLSm8t7A
        2HLaJqox+IcAL0yqaQvanIe3
X-Google-Smtp-Source: ABdhPJxg1ieI0h8HHygGrJMeO83B+M9Uo6vJlJsBy0DBqxuLWhCMXtaRCRVT+6irvthNcL2Ajk2fWA==
X-Received: by 2002:a63:34c:: with SMTP id 73mr1830048pgd.172.1604573310690;
        Thu, 05 Nov 2020 02:48:30 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id a84sm2131234pfa.53.2020.11.05.02.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 02:48:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add GCC and RPMh clock support for SDX55
Date:   Thu,  5 Nov 2020 16:18:13 +0530
Message-Id: <20201105104817.15715-1-manivannan.sadhasivam@linaro.org>
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

 .../bindings/clock/qcom,gcc-sdx55.yaml        |   71 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   20 +
 drivers/clk/qcom/gcc-sdx55.c                  | 1626 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdx55.h    |  112 ++
 include/dt-bindings/clock/qcom,rpmh.h         |    1 +
 8 files changed, 1839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
 create mode 100644 drivers/clk/qcom/gcc-sdx55.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx55.h

-- 
2.17.1

