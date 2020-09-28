Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58B27ABA1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1KOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1KOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:14:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F375C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:14:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so427670pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lEjtDbZBdnjwRGg1kcxyC6IQVySSuPpaAq8CQ3uaqk4=;
        b=NXYlJVpUrTv+/1Krlr85vgsRzg8u3U6sgLwkCmvrmaEH9I23hl2tObiY2XLc9OXbem
         gKkpSn5UWnghhX5PVzzmwMFhkZ5UeA9P/O4fImXEoSsEdRAF7YfblRHPyPfMgwTehFQE
         lfEFZWSnEoCtgbCF7cKw7GBGQVhoj3VTt9BIfMEJkPfkEuDbk/D6wZpX8tebrUwHG7HR
         QAIpf9p9ea7/S5pRCYUnKcZ4tr9NQfuZ9Z37yR7+rzQQYkFPBoKKmCdDBZ6U7EN+BN7W
         00EkemutwsO9VSpMfQH8EFBhFeGU5ds37jNt900gfVgHPgsn1wtxMTaePg+vK+xPMoAF
         dsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lEjtDbZBdnjwRGg1kcxyC6IQVySSuPpaAq8CQ3uaqk4=;
        b=pZISJYkasEbyNde/GoWcUiakTciam3JpyiQYvpupnpXwLof59wq2Eh78nyVC0qcBc5
         gaMli+7kPY83yqb9wXojzijP07irFxgeYw2tXzKlPpPqoVj2vVIadnKY3/1yc3sCn8F/
         0fLVzNU6LSPf0LNmTwbdIH4TOSvALhvCC/Z2Xvft3vm3C8Zw2rgOqWTlddLRz95RxjE3
         Jiggf/YMLP0PTRuQ88JTB2oeHj/cygoiNb07VfHSo5yrtb5lIoyMIJzibrwX2hvkpxkj
         Ayxa9FDNGFT3EMHvtcUaHMEnm+1pL+LdxOpiR/9oHoXbJDu9WjmkpDroS3Aw7sTGVTbf
         ZY2w==
X-Gm-Message-State: AOAM53267LMx18am8eJ5v47FHDrNwW4mEuzAMcYxvLXeu2P+tSwglgkG
        aQBTj/FJTlGG4H6aIYf94KGkxFzwU0+8A+U=
X-Google-Smtp-Source: ABdhPJzk5liziJ5Xk81J4WAuyzs16FSdF17XsjQZbPE9e+Qx3QjWmkcc6ex9RnRBasBTwy5ArTcw/w==
X-Received: by 2002:a17:902:8e85:b029:d2:42a6:bb6 with SMTP id bg5-20020a1709028e85b02900d242a60bb6mr874211plb.72.1601288069243;
        Mon, 28 Sep 2020 03:14:29 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id k6sm1045524pfh.92.2020.09.28.03.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:14:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ath11k@lists.infradead.org
Cc:     kvalo@codeaurora.org, davem@davemloft.net, govinds@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] ath11k: remove auto_start from channel config struct
Date:   Mon, 28 Sep 2020 15:44:20 +0530
Message-Id: <20200928101420.18745-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent change in MHI bus removed the option to auto start the channels
during MHI driver probe. The channel will only be started when the MHI
client driver like QRTR gets probed. So, remove the option from ath11k
channel config struct.

Fixes: 1399fb87ea3e ("ath11k: register MHI controller device for QCA6390")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index aded9a719d51..47a1ce1bee4f 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -24,7 +24,6 @@ static struct mhi_channel_config ath11k_mhi_channels[] = {
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
 		.auto_queue = false,
-		.auto_start = false,
 	},
 	{
 		.num = 1,
@@ -39,7 +38,6 @@ static struct mhi_channel_config ath11k_mhi_channels[] = {
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
 		.auto_queue = false,
-		.auto_start = false,
 	},
 	{
 		.num = 20,
@@ -54,7 +52,6 @@ static struct mhi_channel_config ath11k_mhi_channels[] = {
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
 		.auto_queue = false,
-		.auto_start = true,
 	},
 	{
 		.num = 21,
@@ -69,7 +66,6 @@ static struct mhi_channel_config ath11k_mhi_channels[] = {
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
 		.auto_queue = true,
-		.auto_start = true,
 	},
 };
 
-- 
2.17.1

