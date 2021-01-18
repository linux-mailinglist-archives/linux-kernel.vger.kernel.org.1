Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92B52F997C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbhARFpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732002AbhARFkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DCC0617A2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:37 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so2390437pfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWSz/xv5abtdTaszzL4/q2hKFGcrR7qY3z+l56mm+Q4=;
        b=IecGHmuX4j7xmqNweLahVKJHnsEYZcbSFyq9q8MyxlFvjsJF2f4Jc9Xh185GEQUQzl
         njlRbJud/JcBUQZiV+sUuoH1GLEs0hhFRwYP+n4QPAMRWrj/hjL9diqvqhsrfVvUwxKF
         D5dynL2ZKy75SeEILdBcTadLYyVvMk7dDrz0ieuEiD5XNdteBziyJpgcSEd8GiXtVbUi
         91d4BqneX7cg7cmI34cgpOQ7CT6+3Hy+O1kNkiqkyymdIkzv3AtcebjIqBuUx0Om3Onn
         /m2jSFDDu9CZvx8KfM/J/BzfIrU8D6XUJpJasT9C1qkJTwWvGchyfiwGyMnfmt0EO5Hq
         ICOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWSz/xv5abtdTaszzL4/q2hKFGcrR7qY3z+l56mm+Q4=;
        b=WhlpF2QKenyhQ2t5QcLDM5CC3MdORRTYEQslbXtrqZJ19f/K2qq6u64+1j2a8+ZZRK
         oPZfMvjLYecYGXiCY/P7mHYdFWym1RSROq5QfjH80bVs0BzBER/knkkeN7jqOJz7FlXk
         DKNNAzAVinX3+BCVRBliZ8bdei/dSS6+CzQGXiJs4naPsPuzmkUJhTA7ciMRhwYweZVT
         wLA6k3qth2iv0umaKaN/BrBIW0dDrBgm4omqa8OYp3Qazc8SHF4eRc3lzyF3Ra6DjmFa
         27NYG4I2Fo/2muPXefsgng8rSAvYfciRkB0sYZf6/E5qk3g1APjzHxn8fj9E7saesu4H
         +hAw==
X-Gm-Message-State: AOAM533+2YnbQ6VnmVTgA0Bq/hcVhaSJ+3tcERflk4d8avOdh9/T34l2
        0Bny6WXqrIPrxu1Uimfusj9J
X-Google-Smtp-Source: ABdhPJzqKO3cPK6SLE8sKhwm3/8AGs997GhXvgWlHyjrsqgvUjV7wJvXfE7iczWdI0EtSpXXvTgYbg==
X-Received: by 2002:a63:f456:: with SMTP id p22mr24526081pgk.188.1610948376611;
        Sun, 17 Jan 2021 21:39:36 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/13] ARM: configs: qcom_defconfig: Enable ARM PSCI support
Date:   Mon, 18 Jan 2021 11:08:51 +0530
Message-Id: <20210118053853.56224-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARM Power State Coordination Interface (PSCI) support on Qualcomm
platforms.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 9573c0406954..c9081e5afd43 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -297,3 +297,4 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_WATCHDOG=y
 CONFIG_QCOM_WDT=y
+CONFIG_ARM_PSCI=y
-- 
2.25.1

