Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6444A2CB97A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbgLBJoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbgLBJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:34 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4704FC08C5F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:43:18 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so679411pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCehJ5/nwTgtth9aagxkj9DlJP9D+xsxv+nF6q0eHjo=;
        b=G7zlsEwLrIeqPDlswh4th2Xiqv2KsB6xMy7RqU+lFTvmaa7N9o5j6lH1G+S4nRiKDd
         K2BvhKrkzV0tlNj55QGRdyZ5khhU0uVBGV//AiJix5s3SWUTREikvE8pXCJgzDPVXKXX
         k3mQq6llGXsD0pOW+MPtcohMLV/JE+HTIx67DYQjbPQm6PAFvrZl9bJPj/V03VL4EVG4
         s5erTQJjKqdKyFqzXjmfbGx9hpmIeriBDYmrvNKmBF8jbx8MQA7h/byN1MwuJw+CmQDM
         nBZWvfVLenek6nDdmBD3Gt0xkSB44LMjrx0lEJld2l2aAPCXR9easvqAmJSh05tQ0FP/
         lsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCehJ5/nwTgtth9aagxkj9DlJP9D+xsxv+nF6q0eHjo=;
        b=tL4t5YObEsVvoEQy7eLVGM5kgnyWqEe2TLQP/K+hx6C+qvv1wOzef0rKK2rMJRs+F3
         QmFjgBYx/YANLvV8wj1h//p/iOvLGOK/WwXvdix6kbUmLfVUMB9Ql39kl5mDzZYvEtJc
         Vejw9doGSj4szB0cwwQ2L5sJVB7QgVtOYz6lGEo/fsU7vWylLDUyKh3bKjQRod/xYwug
         Z50Vj+oslagoMHBwh2ugbvIjO6G3oqPyccQ1qJ1m//CCLSlifCQCy+Zr30bhGtVPQkKP
         YBJIILdge8CVQrMn8XTgeH420sgTH8i/bt+7z6halpwNB4LAXNzBrPvZ8kC6riU/s2Om
         QXwA==
X-Gm-Message-State: AOAM5326e+xI3GgWhCjtRtcoUqqX5euyuvI/HWz/d1zDqlgajFKLylnn
        EKLCLVsr1OuZvIvJAqKuhFDk
X-Google-Smtp-Source: ABdhPJzQlAdbo3iOTDuJc/13fJai6U75vrTYnV3E2ZdqoMYo9xoZtarpIADN59oOMdz9Q//8TFb3rA==
X-Received: by 2002:a17:902:6acc:b029:d8:c6ee:6d6c with SMTP id i12-20020a1709026accb02900d8c6ee6d6cmr1866601plt.7.1606902197790;
        Wed, 02 Dec 2020 01:43:17 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:43:17 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/29] bus: mhi: core: Use appropriate names for firmware load functions
Date:   Wed,  2 Dec 2020 15:11:43 +0530
Message-Id: <20201202094159.107075-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

mhi_fw_load_sbl() function is currently used to transfer SBL or EDL
images over BHI (Boot Host Interface). Same goes with mhi_fw_load_amss()
which uses BHIe. However, the contents of these functions do not
indicate support for a specific set of images. Since these can be used
for any image download over BHI or BHIe, rename them based on the
protocol used.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 6f0cfb9922b4..2d7752cd9ccc 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -176,7 +176,7 @@ int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic)
 }
 EXPORT_SYMBOL_GPL(mhi_download_rddm_image);
 
-static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
+static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
 			    const struct mhi_buf *mhi_buf)
 {
 	void __iomem *base = mhi_cntrl->bhie;
@@ -192,7 +192,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 	}
 
 	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
-	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
+	dev_dbg(dev, "Starting image download via BHIe. Sequence ID: %u\n",
 		sequence_id);
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
 		      upper_32_bits(mhi_buf->dma_addr));
@@ -223,7 +223,7 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 	return (!ret) ? -ETIMEDOUT : 0;
 }
 
-static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
+static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
 			   dma_addr_t dma_addr,
 			   size_t size)
 {
@@ -250,7 +250,7 @@ static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
 	}
 
 	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
-	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
+	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
 		session_id);
 	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
@@ -449,9 +449,9 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 		return;
 	}
 
-	/* Download SBL image */
+	/* Download image using BHI */
 	memcpy(buf, firmware->data, size);
-	ret = mhi_fw_load_sbl(mhi_cntrl, dma_addr, size);
+	ret = mhi_fw_load_bhi(mhi_cntrl, dma_addr, size);
 	mhi_free_coherent(mhi_cntrl, size, buf, dma_addr);
 
 	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
@@ -459,7 +459,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 
 	/* Error or in EDL mode, we're done */
 	if (ret) {
-		dev_err(dev, "MHI did not load SBL, ret:%d\n", ret);
+		dev_err(dev, "MHI did not load image over BHI, ret: %d\n", ret);
 		return;
 	}
 
@@ -509,11 +509,12 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 
 	/* Start full firmware image download */
 	image_info = mhi_cntrl->fbc_image;
-	ret = mhi_fw_load_amss(mhi_cntrl,
+	ret = mhi_fw_load_bhie(mhi_cntrl,
 			       /* Vector table is the last entry */
 			       &image_info->mhi_buf[image_info->entries - 1]);
 	if (ret)
-		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
+		dev_err(dev, "MHI did not load image over BHIe, ret: %d\n",
+			ret);
 
 	release_firmware(firmware);
 
-- 
2.25.1

