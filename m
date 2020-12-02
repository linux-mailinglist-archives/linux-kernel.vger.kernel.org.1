Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DAB2CB97F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgLBJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388626AbgLBJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:48 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A5C08E85E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:44:24 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o4so774871pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hesBFBojopE7IXyDHX9xv1pvWQunAb7Jbvi4ET2s6mg=;
        b=O+4jPsZtWP+eaoXAjBDW/UBLL8u4+f70p9fgqatvstbeOqHnHsZc5BFM6mXMyR0yqF
         ymxh4DMJnFvOhl+zDYcqj2vA3wkHCl8BlTetoAM5H640i5MAwmaIfnXm8WaFxbvS5S+w
         1YsaCurhV5RhLd0kWQl3V88TtA7Ir0r4NFRVGstbm/svqaI5jJQX/GU7O8mI4GswzhxF
         X23Yra3I+fJ/Dvw3L4h/JZgfJlIDP/fk/VFrg+yRdHSxYBr4V6QrNosF2J/+KnfEkfL/
         Y57uHl/ynIk7g5CjYsPZ0C+o47SRrdhl5nYodHY6In+5Cszu7YdTOjqn2ebfqfDfc+Do
         FW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hesBFBojopE7IXyDHX9xv1pvWQunAb7Jbvi4ET2s6mg=;
        b=s2nF5J//djUG8UFVthqxAOY3BP2y6bv2nPWlcrfiEG98bxsk3Qcbc1VZ1sry5/f+at
         MeJauS+jEcgCx9Pzq4/fzodhO3h7QtnXNIQaf3uRKVwfU6sBay7FU+EoT6IBG8U9O7XZ
         Gl6JS2Au7ucFRiWjxIZGOUPi9tcmxpfOWIT6LSiYdChQugjMIT1sZSzBCK+OdGLy2tWm
         yptHMUGn8M4GY2VjVukU7p/SbvgHYV+2+16QuFdJUxD5iydtMM2DfI87d+/uIVoxeEDY
         8/MJ4TC+B3nWilknveRkMHNwL0WfPyLVKBKeC18ZiCMM/ek+ybPAUdfUpwDaabRiFnKM
         PcSA==
X-Gm-Message-State: AOAM532jMfqSOq1LCxX8Df3cbVU8GAHmTsUWetWmPFV7kbmZUVjWFTzq
        DktkO99rS8ggQUN7ooZN0JeS
X-Google-Smtp-Source: ABdhPJxNFeNbpI/hjcUUAp5oFAZHzrjkJ1EXDmF3Y6UuchNNH0C9DG6qIzO/kz+xXl7uPibe/ZkciQ==
X-Received: by 2002:a63:4b05:: with SMTP id y5mr1895628pga.342.1606902263544;
        Wed, 02 Dec 2020 01:44:23 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:44:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 29/29] mhi: pci_generic: Fix implicit conversion warning
Date:   Wed,  2 Dec 2020 15:11:59 +0530
Message-Id: <20201202094159.107075-30-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

Fix the following warning with explicit cast:

warning: implicit conversion from 'unsigned long long' to
'dma_addr_t' (aka 'unsigned int')
mhi_cntrl->iova_stop = DMA_BIT_MASK(info->dma_data_width);

Fixes: 855a70c12021 ("bus: mhi: Add MHI PCI support for WWAN modems")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index e3df838c3c80..f5bee76ea061 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -273,7 +273,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl_config = info->config;
 	mhi_cntrl->cntrl_dev = &pdev->dev;
 	mhi_cntrl->iova_start = 0;
-	mhi_cntrl->iova_stop = DMA_BIT_MASK(info->dma_data_width);
+	mhi_cntrl->iova_stop = (dma_addr_t)DMA_BIT_MASK(info->dma_data_width);
 	mhi_cntrl->fw_image = info->fw;
 	mhi_cntrl->edl_image = info->edl;
 
-- 
2.25.1

