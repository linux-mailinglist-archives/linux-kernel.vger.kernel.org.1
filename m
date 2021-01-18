Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD42F997B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbhARFpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbhARFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588A6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w1so8534895pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkTU0ChPwkkZXA2VY3wkaRtyf5UmV+JhF05KqFJd61o=;
        b=Id/C+6buXwOp3s1tdsoTHbFJnS/bToKMZz7Nv5eFH8Waf5yGT8H90COB67focLIAnJ
         Fk32jA/QOtsaeNTyrCtpyh4agp/1y0ly70CgimEoSxrGBgeqpxf01avCNA+ak4a9kH9X
         BORYcaE8rMVnqu/z53WGXe4lI2otp1oy2U5lmtf5o0kBNxaKamW9X4qWWZN/gg/jjL6s
         TQ2U0qMUCCZku6a0QJiYX9jHh6z2QfzIVq8cWglHGvZi6hmcNDrSU2eqjzCgLDiGtSJ+
         LbURlmPwx3xS03IRX2OJNelQgMlT/FyffzcXEWdtq7Oaegr3aYx9zs3eQbLignslusDp
         kNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkTU0ChPwkkZXA2VY3wkaRtyf5UmV+JhF05KqFJd61o=;
        b=al0bhaYeFXOsZjENWz1hkmZ8lFFgByPnu9Hw6/gEow6EFjHW5bRD5/YSHs7R0liAv3
         NOGy4m5H39vf+C/Y5yIlSDOyptIkkXtzRMX932BToLYlHfF+NEMMOXmdvpWb+1PIs1Vg
         WXBybGLU/gE5M/Q0rezIdrg+b40+iTHrDeqUtMhTJPQY6k2TRKXA0Ke5EcM0rANVJZB+
         uE9cAi6XtpviwLlbVxQC4UsJ+8ZraEQzDCxl2ME5t3gi9DYpur0IyT4jn6YhxsjYLvhT
         3XvKsE0XqtnZEHOROYNHTmutP8zvp11Zq+WwthvGQnlSRFkqvjSV6Ru44nRnL7ZQkpYR
         pFYw==
X-Gm-Message-State: AOAM532uxWdpdPspEIHWeGGZvpNYoE9QlP7c5kh9TNZMc1PyIGfK7rKr
        ectkdA+g5jy4rioh0CTS0E4N/9bfHigz
X-Google-Smtp-Source: ABdhPJz2+GkRv65E5JGWhJxP0kmLa5kOkWTtCG0yVnpkd7zTgmrXi8e5DtlkxNwQ5e73jSyPPig4xA==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr24919910pjg.231.1610948382749;
        Sun, 17 Jan 2021 21:39:42 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/13] ARM: configs: qcom_defconfig: Enable Command DB driver
Date:   Mon, 18 Jan 2021 11:08:53 +0530
Message-Id: <20210118053853.56224-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Command DB driver to query the shared system resources on
platforms using RPMh such as SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 32f3988631bf..19d03ea09405 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -239,6 +239,7 @@ CONFIG_QCOM_Q6V5_PIL=y
 CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_QCOM_SMD=y
+CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
-- 
2.25.1

