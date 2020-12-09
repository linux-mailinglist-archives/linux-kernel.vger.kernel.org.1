Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1702D38F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLICqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgLICqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:46:47 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B8C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 18:46:07 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so86471pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 18:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6CXkt7XQRmTS6IAY9O5gfocreD0xWeDQV3rSfuBX9s=;
        b=ZmQLEKebxKoEzpOQ5dtdNbqyYMje7zhUcl4A10rmbCj9PLztJjRVGh1NCkZCEkgTUr
         5oNf4qFvCFAu7IIyLLNE3a90NlHM8l1HLqSo0pnPLzxKYqj9PxJQ6P41mruqRcVP1HTe
         kz2enxAdoqoOS3YG3EMdqlh1YwcjjbUqPDRmlKr6bFSkKhGBgHSPfqjWR2N17JliKQkz
         Bd+gzgzXUQl1rkJRpry3GU/pD9rsBfVCsN1B4hzlxF3k0JHmt1iSRNXgAbQ1+ZVdKAuR
         uoY7ifPnoawTWlmTn+obZqxsexwBpqVA4qrLOVDv101gD67qBEoIdSvlFPD7QUJ/OZR+
         pcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6CXkt7XQRmTS6IAY9O5gfocreD0xWeDQV3rSfuBX9s=;
        b=Hcllo0trGVjZrq6eKiE3Z6CEIvGifB32B9HcGKjzY7KwbZSC3jjQS25h6GlOL/BBnX
         9tuMBWEF+DnSBV63V7dtyDEhQV0brd/xA9dBsDsLhE4wYRNItWlaN3+E49RpwJ8R7gZM
         cO8U7rcVuS1n8gRALEOMH5P36N/X2sBYaJAJHHuto3yRSAIs/Ut5mByXrnAtN2HpdZss
         MHE3GZz0fNmmcOjOZe1ZaF6QN/DmaPtveqKDCmvnLBgeq0k6xy9Gpf+8rzBmmO4mejHu
         Dw8n0TRwemua58qcDd2v3k2ZyGkMI4NlXFkXC7Ic+vKltBAM7nlUOXU7zW+8/ssu9v7U
         uLqA==
X-Gm-Message-State: AOAM531yOGZw3Yb0ncFvWFm6xaYQvuQ2K+ImNl0tnkMwUZCFDrUgufIf
        G/heJsbJsoNmf4t8ahCDBbAE
X-Google-Smtp-Source: ABdhPJzy1SqEGEEhxTxwxsIHKQ3i0BzmQlinwG3xVRlxXN43akFhhVqe3xY9+CTUv3oRrfcwqy3Zrw==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr196846pjr.231.1607481966568;
        Tue, 08 Dec 2020 18:46:06 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id g34sm155678pgb.33.2020.12.08.18.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 18:46:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH] PCI: qcom: Fix using uninitialized smmu_sid_base variable
Date:   Wed,  9 Dec 2020 08:15:55 +0530
Message-Id: <20201209024555.14116-1-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

smmu_sid_base should hold the base of SMMU SID extracted from the first
entry of iommu-map. This value will be used to extract the successive SMMU
SID values. Fix it by assigning the first SMMU SID base before for loop.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8ba3e6b29196..affa2713bf80 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1297,6 +1297,9 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 	/* Registers need to be zero out first */
 	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
 
+	/* Extract the SMMU SID base from the first entry of iommu-map */
+	smmu_sid_base = map[0].smmu_sid;
+
 	/* Look for an available entry to hold the mapping */
 	for (i = 0; i < nr_map; i++) {
 		u16 bdf_be = cpu_to_be16(map[i].bdf);
-- 
2.25.1

