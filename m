Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580E12A8CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgKFC2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKFC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:50 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1F8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so2927635pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDmwkRD+UA5ayoqGYK3EsxTb55Sx0WhA4UycUKaMD+I=;
        b=BoWLj6elN2gXAg6vC2/mnOXxqytzjS1jtO5QZbnGwwXx4D/Ce/FnQYU/o0rM9doHaQ
         jBFUSnz63qtU+BsEdPe/cWoVilUU/zFPdu1jHIDNpYJpREW/6wqIRTvtFaFHHE0F3b52
         2JBtYoa5YCeivxI4Q0J89Z7LWtxUZ1wuDvi8truLbMAQGSWHlJ7KnfpZVn66mQtRK3xV
         /kCmRNBdq2KtI8N0VqNRHIBRjnIX0B/ZqH18Jb+nZtd8C9BXxL3ri9UOLBy3pfkpujn6
         V2/BKu4BI6tHLi/iOLZkZD2lxptmJIg5sTJEI9vpLr+TF2o5wzZn/WmkTnwJIZicnzKW
         3dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDmwkRD+UA5ayoqGYK3EsxTb55Sx0WhA4UycUKaMD+I=;
        b=bu0F7+pfEhjVBATIkve4HXJKaFnMPE8AtUxgUWFGpBmaKJKaT3JRpwbg4/Kj6d0VLI
         edFdPNMKcrPelMRxHXuhYYm2gr5AbtHmx9ja1521r943NyGIJB9ZLcrXnCitgPNmvunQ
         8spZZ5dHvVAkyG902NXFp/rUYTqZa/ol55mDWoCyvYok6tciZvHpfR7kftAhwKMNNW8h
         bKkJhSfweR4nGwMmL1JECKqhEMlth8YQKq4KTAjkxJKVFdTEIAL3sQTrxWrkeFXDEAno
         y9ZHexFNxAJsmjcOI3EyJuoHRjgLbfczPYRIqbmQQr6qwEFZmRFYrKWFzM085yjQsiP6
         6usw==
X-Gm-Message-State: AOAM5300pMHV9rW81RC7DEKoAsinW05QykZ78zoQY/zvb9Rpk9D29VDO
        0MCEUhiR2KSeRod0ayM0Q2H99UHb75hd6w==
X-Google-Smtp-Source: ABdhPJwGPS5IsrXFxy8zVjHqq/zaLM+m2dCLklhIssbT0VjhV4v8Ki9yLLy0Y5H+Ffnii5f1XnaZfg==
X-Received: by 2002:aa7:83c9:0:b029:158:11ce:4672 with SMTP id j9-20020aa783c90000b029015811ce4672mr5207467pfn.23.1604629729392;
        Thu, 05 Nov 2020 18:28:49 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:48 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 17/27] mmc: sdhci-uhs2: add detect_init() to detect the interface
Date:   Fri,  6 Nov 2020 11:27:16 +0900
Message-Id: <20201106022726.19831-18-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
operation. After detected, the host's UHS-II capabilities will be set up
here and interrupts will also be enabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 160 ++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 637464748cc4..994dff967e85 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -391,12 +391,172 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
  *                                                                           *
 \*****************************************************************************/
 
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	int timeout = 100;
+
+	udelay(200); /* wait for 200us before check */
+
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_IF_DETECT)) {
+		if (timeout == 0) {
+			pr_warn("%s: not detect UHS2 interface in 200us.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
+
+	timeout = 150;
+	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		SDHCI_UHS2_LANE_SYNC)) {
+		if (timeout == 0) {
+			pr_warn("%s: UHS2 Lane sync fail in 150ms.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return -EIO;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
+	    mmc_hostname(host->mmc));
+	return 0;
+}
+
+static int sdhci_uhs2_init(struct sdhci_host *host)
+{
+	u16 caps_ptr = 0;
+	u32 caps_gen = 0;
+	u32 caps_phy = 0;
+	u32 caps_tran[2] = {0, 0};
+	struct mmc_host *mmc = host->mmc;
+
+	/*
+	 * TODO: may add corresponding members in sdhci_host to
+	 * keep these caps.
+	 */
+	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
+	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
+		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
+		       mmc_hostname(mmc), caps_ptr);
+		return -ENODEV;
+	}
+	caps_gen = sdhci_readl(host,
+			       caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
+	caps_phy = sdhci_readl(host,
+			       caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
+	caps_tran[0] = sdhci_readl(host,
+				   caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
+	caps_tran[1] = sdhci_readl(host,
+				   caps_ptr
+					+ SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
+
+	/* General Caps */
+	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
+	mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
+			     SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
+	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
+			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
+	mmc->uhs2_caps.addr64 =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
+	mmc->uhs2_caps.card_type =
+		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
+		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
+
+	/* PHY Caps */
+	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
+	mmc->uhs2_caps.speed_range =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
+	mmc->uhs2_caps.n_lss_sync =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
+	mmc->uhs2_caps.n_lss_dir =
+		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
+	if (mmc->uhs2_caps.n_lss_sync == 0)
+		mmc->uhs2_caps.n_lss_sync = 16 << 2;
+	else
+		mmc->uhs2_caps.n_lss_sync <<= 2;
+	if (mmc->uhs2_caps.n_lss_dir == 0)
+		mmc->uhs2_caps.n_lss_dir = 16 << 3;
+	else
+		mmc->uhs2_caps.n_lss_dir <<= 3;
+
+	/* LINK/TRAN Caps */
+	mmc->uhs2_caps.link_rev =
+		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
+	mmc->uhs2_caps.n_fcu =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
+	if (mmc->uhs2_caps.n_fcu == 0)
+		mmc->uhs2_caps.n_fcu = 256;
+	mmc->uhs2_caps.host_type =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
+	mmc->uhs2_caps.maxblk_len =
+		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
+		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
+	mmc->uhs2_caps.n_data_gap =
+		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
+
+	return 0;
+}
+
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
+{
+        struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int ret = -EIO;
+
+	DBG("%s: begin UHS2 init.\n", __func__);
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_uhs2_interface_detect(host)) {
+		pr_warn("%s: cannot detect UHS2 interface.\n",
+			mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	if (sdhci_uhs2_init(host)) {
+		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
+		goto out;
+	}
+
+	/* Init complete, do soft reset and enable UHS2 error irqs. */
+	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
+	/*
+	 * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
+	 * by SDHCI_UHS2_SW_RESET_SD
+	 */
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	ret = 0;
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+	return ret;
+}
+
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_uhs2_start_signal_voltage_switch;
 	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
 
+	if (!host->mmc_host_ops.uhs2_detect_init)
+		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
+
 	return 0;
 }
 
-- 
2.28.0

