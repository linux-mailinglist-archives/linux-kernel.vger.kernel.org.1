Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C42F9962
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbhARFkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbhARFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:40:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E7C061793
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so3863131plh.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxXVIw/mLlzlcAZeXje5Wvf6Ocq0HNXtM6W9WGN9F0c=;
        b=Kvn11EFzKoAqBsi9bQciyAJRc5xI1WUJVRTuzfR+9vKGys5l8bBwCjVXtOAzgWkmfW
         Fr3tAwpVR1XE17GYQET4hROGGNaC9eOS/5S8hd+Rp5GLCBxodyqYBDFudQelLk+5kGq4
         LhUEb3pgMl2EqGKtMyaPDKXLix0gYTzKZ0MrOTKvZJKfWn3IlkoX8nf+9jrg4Hh/L/d+
         sWITb9fl159tLyrzgNt6lB/HXVlgiBoFDy9e6jXO8CQf+nqCaNf624WUxnePwv4WDXmT
         N/bPhGpIciFBs014yR3LLvf67PBAuGPgs4Xmq6GvDarrbtV0o0UU76++TGtqdj6ea4pd
         FU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxXVIw/mLlzlcAZeXje5Wvf6Ocq0HNXtM6W9WGN9F0c=;
        b=d6uiy/WrfjQwnD7eYlx2OlaJ2pmfxOAvZlo/VEE/j5O8pJtTLIbGOBnHX3ZvoInZk+
         niPV+x3GUXaIOQK+wrx2ky7HBY087EyKuNsoc7/e03dsglsyVEzhT9rI/x5Lw9onmWmU
         OEZ7IqxsXZBcBcmUQo4v0g1bWedr7r5seZ9BZKLgZO0y8ZFkz2fSFi5uyVD6NpXledFu
         InAk1SVBixqX9VG3RZQfWtaSuRhNOEygn+7tzOdskatK6Ow5ISy/NrOcV1zdqNXfT7zt
         /d/4vVvfKimiMl962kOlat6KxyXvYD4ZwrofQ4wjawpbDTmyke6O6ac2nNYpU7P0Nvbq
         h/3g==
X-Gm-Message-State: AOAM5319A2G9L0PboTG3CuaUx8AmBqC0Hi9S2xnyoSwu7EN/YfjRpa4X
        QVZTOXSgDYDMnc/EzGwJJM8L
X-Google-Smtp-Source: ABdhPJwwCl+8g8+Wlt5N/37qygwqsMuGuHhYKBR1GUmkH/bwOBdlVsYjqStAiWrTGCmQCkRs7hO7uA==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr15412396pjb.77.1610948351828;
        Sun, 17 Jan 2021 21:39:11 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id z6sm14627271pfj.22.2021.01.17.21.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:39:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/13] ARM: configs: qcom_defconfig: Enable SDX55 GCC driver
Date:   Mon, 18 Jan 2021 11:08:43 +0530
Message-Id: <20210118053853.56224-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
References: <20210118053853.56224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qcom SDX55 GCC driver for clock support.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index bd269ade52cf..13b5a906b427 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -223,6 +223,7 @@ CONFIG_MSM_LCC_8960=y
 CONFIG_MDM_LCC_9615=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
+CONFIG_SDX_GCC_55=y
 CONFIG_MSM_IOMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
2.25.1

