Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05232E056B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgLVEho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 23:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgLVEho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 23:37:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3599C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 20:37:03 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i6so10917966otr.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 20:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wy1gz9kjio0vb0pT053cREDywWupFHkrgigfRiFKKQE=;
        b=Ce/+jTfY160zdkiluiCMIOjV8mHy78gD/+8KBpe2uMli99f5zKBfcndNx+K4h8kkF0
         TIPwNbuPELC52D+Nnj3KUjHEeB1y146zjGwC9vhAi+/gbDJNaovuG+dfRwPcW+kjjuBm
         Xk/0BystJw7g5pws2Hx40+iUQ1NZ55hwwTQC334F29YO7qcFGLh654/pI+JYIu0rDOd8
         Ku7+A8/LWse7hgd7aybUVKdsWtmIngUrb+SUNbDiyZHTxYlADrLgvP4VqTvu2RR6Qy4A
         ZiYvnRtLwFzvgRb0qwotRlzoP9FO/sxPiLIirD0ItRTo4MxvEuDCzb3h9HNK8LMogEwd
         2/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wy1gz9kjio0vb0pT053cREDywWupFHkrgigfRiFKKQE=;
        b=Ugq/qNlrbBIGvrEA+kk42TUn0/gyG2u87Nth4HV8deEMivsTasXr8WaDPb4OxDx3z8
         YsCwzBuV+m1sQN+kP2T5SSXM/ue8xc8O0oM004bHq5pPy93o0fFBVQmkhbk3MesXA4t+
         qQ2xVulSbS17FGzftPNe0BeUtGC3OcQBzKwe6jwpGMQuiS3maPpcXO0b8DsKnypUfe7k
         SM6LQUxHWibZ0/tWXjIGn+q7Xzt1oaPJuPzqhijNzEKmVYPLE1PYYyrYSYR4ACoAWwLt
         LTlyEHtys8HrbaxJUpXCFU51TH+OU6hDakZ1m7N9CtZWpWt65XJbW3y4MdWVlvuyEaDF
         8BoA==
X-Gm-Message-State: AOAM530/Cfnc7preWwNkqVyp0vJTN5Lsjdi8HWAufdDjj/kVB/Al8i0P
        PWEGOHTffFxGtGcSim9qUJTuWQ==
X-Google-Smtp-Source: ABdhPJxkya4cEQ67S+i2hFbIDA+YlO4hEFVc2bpRDyn1asP29BOVsI1DPWxptztq7V4atvtvbkBdAw==
X-Received: by 2002:a05:6830:4036:: with SMTP id i22mr14328301ots.127.1608611823396;
        Mon, 21 Dec 2020 20:37:03 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x12sm4066214oic.51.2020.12.21.20.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:37:02 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Make INTERCONNECT_QCOM_SDM845 builtin
Date:   Mon, 21 Dec 2020 20:37:45 -0800
Message-Id: <20201222043745.3420447-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of v5.11-rc1 the QUP nodes of SDM845 has got their interconnect
properties specified, this means that the relevant interconnect provider
needs to be builtin for the UART device to probe and the console to be
registered before userspace needs to access it.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 838301650a79..3848ae99501c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1078,7 +1078,7 @@ CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
-CONFIG_INTERCONNECT_QCOM_SDM845=m
+CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_EXT2_FS=y
-- 
2.29.2

