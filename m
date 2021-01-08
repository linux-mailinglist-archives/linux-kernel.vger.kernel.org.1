Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467312EF1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbhAHMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAHMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:06:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1052C0612FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:04:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u19so11001090edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQWuey667ZZgdSLB64Knsh9ia2lw0H43y5dWY3vhsQM=;
        b=ABTZMAR1VScMXDngO3qAU0NAIhoDL768NdXmVfddzJXLu8xCd8DR6UfLmJCU2vIhWS
         249O2V0e2FjPxb5wuvOWaetklIt7JzVDryrDrAj9wx792eubDEYSqJ4w+zYZ+1ZEI0Kz
         IT5AG3ZekQ3r4ILyLpRKFjb7AJXOOKjBa3wjj5JSJ01QHuOYvaqFg+sG1jAr5K2fMvc/
         WIoILibfpMzOSooUIW+TO5IfEpJQ3OEpXSVuuZ2C1a6ZAySFkX95RaYDJrAJW8r23Pye
         eUZ1j4FqJK8sBfpqxIYXr/M0TJRT/pwoe/XD+7vR6O/arMH1m3tYZbVaag++zYF99ptB
         Z2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQWuey667ZZgdSLB64Knsh9ia2lw0H43y5dWY3vhsQM=;
        b=YwMlt4dDvKUrbn5wjLhTApaFn7shPwFG2kLRCmEptBWcIBopF0C+4dDvYVVwQC5yJp
         zGKV3VVxXikyLr0O63uXeZtPmj6/SymXmZ7B0Xz6EwkS6WhEKW/eWOVeklTvpZ+25h/Y
         32n1pdKPhwItYg4xvtUn/1wseLEm/YG6Grb9+h8dK/bEE6Uw8A3/V18in2O2ZQpAg3Ew
         fAMSx3Zz5IUPpbDlduExIKGzI9kZKcZz+2S5pB9p6crpbBiRLrIzqUmqbaKMq88pY2Rf
         7IRd+c73LKuEMiMn48yGzVfU3K9npd7PC+OTj8eBlhF/hfDfbtmbq3zlDTFTwdaG1e4y
         uqFw==
X-Gm-Message-State: AOAM533Y9HhFQXrlPthszR/Zms5DXhRsP7+ZZ4WuB6DVgQFYeHZGFJ2K
        L9G61qF0C1eTMa7c8rHKL0CGJw==
X-Google-Smtp-Source: ABdhPJxLTEyV4cul9MoJMPUStCY3bjo321jIPcdjxFfkxngfjunO1TdNbFqIrZgzooedOpRNgUBLLQ==
X-Received: by 2002:a05:6402:1102:: with SMTP id u2mr5106799edv.18.1610107491335;
        Fri, 08 Jan 2021 04:04:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:bb2e:8b50:322a:1b9a])
        by smtp.gmail.com with ESMTPSA id i18sm3674498edt.68.2021.01.08.04.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 04:04:50 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        arnd@arndb.de, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v1 01/17] media: camss: Fix comment using wrong function name
Date:   Fri,  8 Jan 2021 13:04:13 +0100
Message-Id: <20210108120429.895046-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210108120429.895046-1-robert.foss@linaro.org>
References: <20210108120429.895046-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function name is comment is wrong, and was changed to be
the same as the actual function name.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index fae2b513b2f9..478be4f0cab5 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1077,7 +1077,7 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
 }
 
 /*
- * vfe_isr_wm_done - Process composite image done interrupt
+ * vfe_isr_comp_done - Process composite image done interrupt
  * @vfe: VFE Device
  * @comp: Composite image id
  */
-- 
2.27.0

