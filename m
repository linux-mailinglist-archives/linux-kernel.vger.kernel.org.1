Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1082B2082
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKMQej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgKMQej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:34:39 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03166C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:34:39 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id n11so9471528ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeHjEdBwujyvptGFaPRXgb7qbeR0MajjTNsJZ6r0AwI=;
        b=y6Q2abrkuHY7SORVLGVtSi9chpFmfGS4kCgoHhlcACBE72aXcO8Q+U84eNqc2XjuRl
         WC7/lHVqIauBLQqf0qrT559UJdTD0oudH6oFcPXw0DEfN3RerI01/C0OxqiTdSO9+OHs
         8R3O6MFgaRvyP2rdXQzNXLYT7wTr9I3FIgwo6Za/i2+uTf1DHV0vrkYriCiAMfJ5RiAk
         Emf5PmFtRtBAEDpIC99O803SydbD7JjomxWh1ENvUxPiL4Wq/ND5ws/MiaynurB8qfN3
         X+xTPOQb6p1kUgMbg0nsYQLdOomSrZTtfAg4j/QnrxGqEVlFjtjDb/4FUzvyApBeyZmp
         46EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeHjEdBwujyvptGFaPRXgb7qbeR0MajjTNsJZ6r0AwI=;
        b=UVm9kW02sejChb4Urf+OeDZOdkJhAE1JdqjUolBSh8yks3eR/7D59fggW1YW9781s/
         z/DMfjFC2knrTRB8tds/+q6Kw8h7yGGbWSN4DLYff0DuW4dJfTZR0dzrG4iHTojIujNR
         oMoutnXGGTInG/O5ZT6J36mUmQwOkqaauo9YRjwXdFECO3Yo/a03Ioiuu2KLdONv9lX2
         bniXAGtsOJwbA4qGDdkxsDzYMkz/7k3miIyCrVLUJJT80lcTG8DJizlDx1DXLf66iKJo
         oVQ0fzkXtKQAub8y7Ui0QizAp2o0hLPA1xpsoguAC44Qzm9rzXpMquyk078t93AcPRHJ
         zmig==
X-Gm-Message-State: AOAM531Gv73YmEVp7MG3714icVcjPq4dRieJm8A+OdILMcttPO+1oeaR
        KkZ/cpDVJmrRMUV4c+4tCGhxzQ==
X-Google-Smtp-Source: ABdhPJw5ymtgZo2jPecNpbI790tRVM9vWhc0GRyo6zgJrBo68tYmw7crULQ/ayo50yDFFTvY8i/crg==
X-Received: by 2002:a9d:1f5:: with SMTP id e108mr2104201ote.309.1605285273332;
        Fri, 13 Nov 2020 08:34:33 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r188sm1957982oia.13.2020.11.13.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:34:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        georgi.djakov@linaro.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm OSM L3 driver
Date:   Fri, 13 Nov 2020 08:34:44 -0800
Message-Id: <20201113163444.3138807-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OSM L3 interconnect driver is used for scaling the bus to the L3
cache on modern Qualcomm platforms, enable it.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8992328174fd..6eecac032825 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1052,6 +1052,7 @@ CONFIG_MUX_MMIO=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
+CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_SDM845=m
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
-- 
2.28.0

