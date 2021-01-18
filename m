Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678762F995C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbhARFkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbhARFkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:06 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD04C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z21so10260239pgj.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgyQ3ESLU6hnuUiv6HlK4fW59flJxwOMCYSwEpAcOe0=;
        b=XsGZyYqWzLQJgVUY6BBdZMe7ekONVnguf1Z2LA8r3322mZEvwv8zAQZuMGLBB36yew
         zW+syRagr3AgIMm0roOzKf6EA3aGAfBwus1DORZhuzQxjp01wDKiJuY6XSowQXjFFwKT
         q1ctBIrrKaZreZK9474FpU48a04FkrCsOYH8QJn0fBSSLaT5Kc7UvedAT8GH4JPuNjUF
         Rzn6k9+ymW1WbQJt/jPBKuvpuy5yP8Pfha8SxDUrPXXuO6EQWopTM/czZPxoRPw/WVKe
         CgNuU1rpB14HnwDv3yxrgRVR/jfv8dH8Np5/tRHIuB7WjYs7rtalAjSXIIVPRwNZlSmK
         ESVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgyQ3ESLU6hnuUiv6HlK4fW59flJxwOMCYSwEpAcOe0=;
        b=JPSNiFC40lRCP7BN7bObeCobrMjTLV9uC1IrPl9sHk3XtQviOKjpsmpBk7N6WmOBMx
         1xKaUMq9qijTxEs1PqCUvDviXeVmjnzA8ED3OSr/u2OlCtAgej+3U3MdGFo39BLMOkZ5
         WahUp0NQ1rGoKd6vh0rSzyRWvGc+kYI/OBc7M5yD7PhcjuYK2zU35FOTR3MjCKzqLB0V
         gcts9nawIFvHlrYf5alfZWTyx1+9SaIvilNlEUkKbNxiO99gcYFZQjS1DSDzNlr6Vu3T
         6/T+i4Z501fdPfQ3n3aYWEWaxasw7QYMlx/xWIRwMJ02cguKogP8Y80VsDJHrpfaudJP
         hwNQ==
X-Gm-Message-State: AOAM532lmwwYtSHhOHVqUT7f58UXfLPR/gmeU0d0CohIeO0l3mjEe0tV
        STX6Q6TYbVU8Q3QtCE1uCnyhhMMki9ix
X-Google-Smtp-Source: ABdhPJwil8d77UYiiPkAF92HxQI6GLDrAH2DV+5jZfQWo51EIyPAVqdb0i8recrRBatQ68N6Rzyb0Q==
X-Received: by 2002:a63:7503:: with SMTP id q3mr24359734pgc.318.1610948345686;
        Sun, 17 Jan 2021 21:39:05 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/13] ARM: configs: qcom_defconfig: Enable RPMh drivers
Date:   Mon, 18 Jan 2021 11:08:41 +0530
Message-Id: <20210118053853.56224-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qcom RPMh drivers for using it in platforms like SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index d6733e745b80..55318e814798 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -211,6 +211,7 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_RPM=y
+CONFIG_QCOM_CLK_RPMH=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_GCC_4019=y
@@ -237,6 +238,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
+CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
-- 
2.25.1

