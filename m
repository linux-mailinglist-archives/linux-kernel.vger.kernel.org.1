Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8251D2F996F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbhARFmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbhARFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20so3628403pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9gvk7h2s/rwPO/FWdpe5srYBbDpgGmzTCj/vP/cHPo=;
        b=rqcLU1P7BzQ+aKuorS3f/V4LgvondhhgnniByHr7F2J9lD0ryveHmIOBI9FyTbt7S7
         k1Bsj26S+VTmutLpiOQQiJxW8QA5XFOMi8VKJ3pagWaWR9BWZei2TBMvV6reUkp9t+0t
         2QRk1U2AFU2E8zjWQVR1l5TnSYdDVzEdfnKvnBl7kF9JRX0hySaabjeRH809IGIgs74V
         KPGLThqlomc9f+kyahqEPWb1lSbj8XfgLDmW9gpbLY5PmoNglkowB6PEAsZKbPuXScma
         /zjWH8oeRCtubtODkHy4lZOWn9bcz76STqXyUl8/pVva/vRH7hdCkh5Hx85+WbO48kbN
         h7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9gvk7h2s/rwPO/FWdpe5srYBbDpgGmzTCj/vP/cHPo=;
        b=I5M+7XcmJv3N2dhPtjWVU2g/fIDZmLWJInA0ej9q2gLvk4MnlshyOVAda4GsqMsqkL
         ms6mDtRndJFvd+fvSNWdDkx6WODuSbGbT+Wyd+tpbNsG4fnSJpoEIbjorQ6G/HlTVMqE
         qQagmGRi8Ppy8EjC8lsLfwYAQDdteJKwBF2mOhJgtxRQlfCJXtrWbY0ykrnMroEHAW3U
         aN2SyYwWOU9u51CmJ52pFXR5Uo5nRO0tYZ35dAg8uInTRJSGAkw0ZXLCOumkg/BDyXq2
         uY1aBx3O1rf6WoIo18jNJbkE9F7FNkRwrp6dXewLRNTkfF6wORXj48ngzMIdNgYdIwLI
         G6dA==
X-Gm-Message-State: AOAM5331Pqq4PCnSBaZ5cbK5Q+qqlrAHsoE9KuuOHQyHpAaBlEj+UBsS
        Xy53TL/IvSvrAxDoa20nea3M
X-Google-Smtp-Source: ABdhPJxriXeTfNdtMjQ4yp9TR3TR9Q0Rs0L0KE+5d20VL9L11bcygRkATsDj+bYOccvJpBj25kAmeg==
X-Received: by 2002:a17:902:7790:b029:de:74ae:7747 with SMTP id o16-20020a1709027790b02900de74ae7747mr14740957pll.2.1610948367163;
        Sun, 17 Jan 2021 21:39:27 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/13] ARM: configs: qcom_defconfig: Enable ARM SMMU
Date:   Mon, 18 Jan 2021 11:08:48 +0530
Message-Id: <20210118053853.56224-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARM SMMU driver for using with platforms like SDX55.
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 77f234bf84c8..70dd57b110ab 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -228,6 +228,7 @@ CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_SDX_GCC_55=y
 CONFIG_MSM_IOMMU=y
+CONFIG_ARM_SMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_MAILBOX=y
-- 
2.25.1

