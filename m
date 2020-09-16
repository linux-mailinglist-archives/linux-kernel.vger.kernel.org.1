Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952F226CA12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIPTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgIPTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:18:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01EC06178B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id e4so3718748pln.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYd9vsMIvM6W5z8VipRqt8JWUGSGOZvBgZLW0lx/IbU=;
        b=iH9cQ5U4dGRFKXsPt3w+wBosrROiy65k54Hywk8fFXi0rhVWuLOjYURh48SacwT4nr
         GeS+UM+eROmeW3fcAAx7b94mQWRaFyb9LEBqFqY2swbSXdZBAGcZQiDxNDuEzELgzR9y
         wahfNd2kd7DpXN7MUg93g45g2YyC34Q9dCIbtsraSbKKxQ8+5PK4QAJtn5cVm4NNj3rD
         V62iYnUkZ44FMB8kyzAZGbg3pzHUMYRwApN/w9/wH0DE0v+roIYFmftuVjwM6m5+67Ge
         I4apC8B7COaMhJEfMJ2CcXG6wCP61yYRNm9UElWlwWGCUshDQn3x2dcKH6xOzzsOXvO+
         E7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYd9vsMIvM6W5z8VipRqt8JWUGSGOZvBgZLW0lx/IbU=;
        b=fUpw/mOSsqpbGW+7KMnQENkqd8EwwFyqzNr2/Xn1oseJ4XVAaTEhb+LAggmRCp0Smu
         ShPLpuhxIKHfgNGTGkoLSwvlX5TSw+Xd32OWScgdZuuzq9dgpSKJzgCirTbJJSNtGFdF
         WRNfOmy0mdY3kyU+Zfxl5BWjGzpRTNF78IU7EjijXcCwdKiFsYMgOv1yN6eEn5dUhm3I
         DmRmc7elzgr8jtkS4ev5GKyJ5GbYwHeQPPOzYjYEk53V7d3QlJPMiB7LGAu83cvR1kqr
         MURYwPNkKUmYmEOw8WHA+rMKnYSl0gI04mXnlpAyNBMCAouTJUC213P4HCUxSEhP7qC0
         CdDw==
X-Gm-Message-State: AOAM5304aQAcOKAouh0M4zjelZgffiNfNyBPF/ycyl5hXS9sLKheAx0k
        2xHEJEQMaa0JFbLMWnW3gbvRuQ==
X-Google-Smtp-Source: ABdhPJymzfClG8oNPG52tCxmHebQozrzANmAu9DQgH72QUmoWldyvmcLEKwbPXxWKBriQhgns7dUrA==
X-Received: by 2002:a17:902:8545:b029:d1:f2e3:8dd4 with SMTP id d5-20020a1709028545b02900d1f2e38dd4mr2961002plo.65.1600283864060;
        Wed, 16 Sep 2020 12:17:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] coresight: etm4x: Add Support for HiSilicon ETM device
Date:   Wed, 16 Sep 2020 13:17:25 -0600
Message-Id: <20200916191737.4001561-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
contains ETMv4.2 device and Hip09 contains ETMv4.5 device.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Acked-by: Suzuki K Poulose <suzuki.oulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 45d169a2512c..f027ceed9793 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1564,6 +1564,8 @@ static const struct amba_id etm4_ids[] = {
 	CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A55 */
 	CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A76 */
 	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
+	CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
+	CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
 	{},
 };
 
-- 
2.25.1

