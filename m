Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45BC2F996C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbhARFlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbhARFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:49 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC621C06179F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:30 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 11so9534097pfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFVV4OQ39J28+u510atjrUGOLbq7/7laqoU6VJHCvbM=;
        b=MZ+pkpXVUfVHbSHveajmjtCcKUxP/FXRclnOCc3lX0nYV79p4L99Bbu4XpZ8zm4E73
         Y0K26EZjYxv96uxsEEXT4AjJlR360Zb5a7pp3f1pdrJK4hugkOud3ZmpJCxs19vIEX2t
         +r9aNUGNgPD/5ERYTSFVCEUydZddhAE4d9cZLSfghSVvNF20Yol0WX0pSZBj2dlSLP4e
         G77oltHY0AKY5TVcBomufcporoksEU7Ce17CEW+jeVI3XLMMKOF5iAGGPz6xR2BnIP2+
         arUCAsGKthEXeSvP/283OuWA/LrJGczemZ8Q0tGHEPhvxKO62H2cD6W2Js+8l1IeFjqm
         swyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFVV4OQ39J28+u510atjrUGOLbq7/7laqoU6VJHCvbM=;
        b=Q6RNLAorfHrQTK8gZtS5JJLO0YwJpcdnKF6c3KqB/PFl0nqzTntqIJKev1dGy5PxCZ
         0OpYdW7AfCT8bIC4eCiBUlEPdbhpvb2jOT0WOkwmdh8tzmxUZoQmXsywvHKNz8W66gyp
         U+aW/+G88o7wTfFnbltLHbmAL7IfegMpjX5+vONHYKwws1imA4aGLpLweBVxuK2ZvibL
         AUe/Ktp1pzkMYbd2bJHHPI7MjLm689T1KQ5dwS3jiEKJ0ouR0kLQgQgmII/LuM0F6P8d
         1V1l2rP1IEUU+EMTiiNETxKNYVEcG5y2W65u1i/bjCyDrOewD9A04RDOvGVLY5zg79Vk
         CrjQ==
X-Gm-Message-State: AOAM533p+p6ZuCMPNjKmCKnY4Sq82R9zL5OuXO2QaYpoyWugviueX3LE
        qg3VLzQwBEE3rsXpApwyG/ly
X-Google-Smtp-Source: ABdhPJwdjzafNkdtZEKeeD17jXg5vMxMNe5gO6lyYKrJrSLsKbT9IVPcwbes+YnN9jZULSICuGQT8g==
X-Received: by 2002:aa7:82cc:0:b029:19e:1328:d039 with SMTP id f12-20020aa782cc0000b029019e1328d039mr25117426pfn.70.1610948370256;
        Sun, 17 Jan 2021 21:39:30 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/13] ARM: configs: qcom_defconfig: Enable RPMh regulator
Date:   Mon, 18 Jan 2021 11:08:49 +0530
Message-Id: <20210118053853.56224-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable RPMh regulator for using with platforms like SDX55.
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 70dd57b110ab..5627b142d5fb 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -154,6 +154,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
+CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_DRM_MSM=m
-- 
2.25.1

