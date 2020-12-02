Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A62CC48C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgLBSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbgLBSIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:08:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE2C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:07:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x22so9738306wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsWlwI2/0ReQscJlT7sv5hrpnQn9P8/QKxp+kd8B4HA=;
        b=ke+qbPwSgkrU1nv6oOE9KLUw43NcLqZDxNlRkgCpeuoumb/KRh7jBz39OAiWn60nii
         Aorb/7kXEG9plrSeSjHe+WCatQYxteX/y7RA7OnYgl0VsGSC/5OIYe/KaAiGn1sRc6wH
         cloAVv4a1NmviBwZjXC3tV3erji1cSESREVPu3kxxRAzT7rnDQUlWfJ3MWZidK3kclfy
         dTlIDgv/SFoZe8J3qBmv8bk5ZYCV/WiwZkJkn0DZJ1fTQmAitWcWStNu7xjqBXPzlD0g
         42SiAoHxE0ISYuG1VHqe29Y2xlwtjD21glFxBZpUS2stfHLGTIMibsF2EzcBy43ZOUGB
         iSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsWlwI2/0ReQscJlT7sv5hrpnQn9P8/QKxp+kd8B4HA=;
        b=bLm+5SxhWOr/8E4KMNqk/m7NQXB1UDR6sY9TERcK4OpQbf4ihZbOgNPkyYeA8limNV
         6kpMWP7RwyAVoKt+nbzBfeUcGieXvX5Lgu+I35wbNy4Nq5xtBNMqknsD99b+GQBdIaZ2
         g2gncKoImc15Mg1gjIvApAO2XtIfGFGofL/WSDcveygathi8Geq6sbRt+277TojjqXNj
         TOP5OG64SPps2RP8p+REuuI2o3FfcH/ZZRj078CXt4gKBiknhY4QC0O9Seby6u4ZVElq
         fvCcWGwsIKptgqLygjsHlR06q4gk09GMTVGhvVQG0gxJYXKtauqBTeX9gR9HiV/maYia
         2F2g==
X-Gm-Message-State: AOAM533vsAlLpoE9tiN3BYloUijg8xogU/hR1YkPzAzhtTXQpu7fzTDh
        cTDcW3Fg0Vio4o7iAbsEV6uEJQ==
X-Google-Smtp-Source: ABdhPJwlmtcWPmRdDokFICh8Ou0AfhCSZyvSV6GfXqU85c/QDiLDlg7K/9FQM6FJEC5VPH4rhf2hzg==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr4338877wmf.142.1606932471819;
        Wed, 02 Dec 2020 10:07:51 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a18sm3004404wrr.20.2020.12.02.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:07:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/6] arm64: dts: qcom: qrb5165-rb5 audio support
Date:   Wed,  2 Dec 2020 18:07:35 +0000
Message-Id: <20201202180741.16386-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to Qualcomm Robotics RB5 Development Kit based on
QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers with onboard
DMIC connected to internal LPASS codec via WSA and VA macros respectively.

All the audio related driver patches are merged via respective maintainer trees
along with bindings. Only LPI pinctrl driver is not merged yet, however the
bindings are acked by Rob, so am guessing that the dt changes should be okay to go!

Thanks,
srini

Changes since v1:
	- updated pinctrl nodes as suggested by Bjorn
	- reordered include files.
	- removed unnecessary spaces
	- used mbn instead of mdt for adsp firmware

Srinivas Kandagatla (6):
  arm64: dts: qcom: sm8250: add apr and its services
  arm64: dts: qcom: sm8250: add audio clock controllers
  arm64: dts: qcom: sm8250: add lpass lpi pin controller node
  arm64: dts: qcom: sm8250: add wsa and va codec macros
  arm64: dts: qcom: sm8250: add mi2s pinconfs
  arm64: dts: qcom: qrb5165-rb5: Add Audio support

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 121 ++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi     | 276 +++++++++++++++++++++++
 2 files changed, 397 insertions(+)

-- 
2.21.0

