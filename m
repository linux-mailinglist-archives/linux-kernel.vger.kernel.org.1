Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FD2F9977
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbhARFoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbhARFlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:41:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F380BC0617A1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g3so8036521plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAWt6YWJV9rVkyRVRYREZ26SkjQtfm+kwE3f0DptsOE=;
        b=pUg1OukP1ltytWVSIwajGaORRogwFVTOtvudGLK3iquawYRQjP57j6JeO5LfYYM0lt
         GsW3razLBDslHRuc0ibhp1WlEaDvBpM6JjSblIT3soHZXD3X1zyGLQSOHZ2zq0DO/5Qy
         Uw6w7VBxSLOCxKXMmz2EzhJvP7GYFpT6vRdRRrzWKQ5/AnJjadWO8O5lculwJTiE6X81
         mUNeB/z7on1oK3zB4eMQtZMKawqriomXGWot5FXMqrjlCMB+yZWrRuoNMt5TjzkogDAS
         l6EuzOVyq6P3hNY6XSX7x3inoxY/M47pYLPTyqJ6gSQZM9n+L1ls7bxojMk6FGuXag1S
         xcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAWt6YWJV9rVkyRVRYREZ26SkjQtfm+kwE3f0DptsOE=;
        b=gPCR4EQ0d6ia8E9JEmP/SFRAMDh886XC59yuZbvr/4QISotaju/gWZK99xRIrx4kvu
         x6G4BQyhCqdoUlD3S0BawJvc7m9ATGCAQnikZ1q1S7crh16mFA+IJI2hJuXaO4rWyMeW
         GgMMTEJFdEn0svhSZ0KockX2dJlfzjDtH65s9ZkrxDEoFZAOkpwuXHjFVPnZcUxs7HBw
         HQOseqLRHIJhl1vuRjzXlmLrY5R9d0CPKnZhJ62AAXdhAHlvDwRW4Oj6oIA4vBk0e/Ez
         mCEjWOarpQJ9co3OgF7ZZAAnA6gORH3BFPeUMyqX94ueFwLQ84Uk46m5HPpHs/AUktQp
         cdxw==
X-Gm-Message-State: AOAM531xeMGIfVyz9BnuZMwD4ItGEKJUO2utAyLG/W1RoAJZJIO8S8CQ
        uAWACtcGWY47y6U5s4VpyJti
X-Google-Smtp-Source: ABdhPJycXDFdUuYAY16+5RBdV9U7iEwFbD63JOTY4mbMaHBzOkF21LFsgvHZv6TctlEUPQt8MOaCAQ==
X-Received: by 2002:a17:90b:1956:: with SMTP id nk22mr1284533pjb.17.1610948373534;
        Sun, 17 Jan 2021 21:39:33 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/13] ARM: configs: qcom_defconfig: Enable watchdog driver
Date:   Mon, 18 Jan 2021 11:08:50 +0530
Message-Id: <20210118053853.56224-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable watchdog driver for Qualcomm platforms.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5627b142d5fb..9573c0406954 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -295,3 +295,5 @@ CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
+CONFIG_WATCHDOG=y
+CONFIG_QCOM_WDT=y
-- 
2.25.1

