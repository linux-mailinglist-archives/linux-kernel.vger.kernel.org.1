Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7076426A5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIONBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgIOMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:46:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CDFC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so3151257wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY1f6BPUzB++HrA2WRJHkdA8MgAHqDCMG4dVPqyy2dw=;
        b=maBZ3Vb8DL4XTv3jqb6hlktNtUC+mPnj7ioFAFOv8/3UOIWFfzdKHlgzW2ssBnnwyh
         6fmP4vBycJ71D5tbvixxeSaGBgX4MjlhCVFc9XsncbxLqnRPUaVbDiysZL5+a9ejIm+9
         75VZJtf5AsstRbHXqKc4wATG17L5+BfQzRJzGKZyLw3RXp4MZgRZ9hqYNQ8RIYHYOOzK
         Kh1aSVnWhxbDHFJTA+VTKphT/g3O/5Kt/t+9WPvEv6B0pcUtfIghsiJsx1IvVFn+bvI0
         7FQDHoCY1S3UHFaQsQJ5krZzE0o+eCIgpPdbtdyY93rgmb/1Z164HA2DY5F05D/OPbud
         ILJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY1f6BPUzB++HrA2WRJHkdA8MgAHqDCMG4dVPqyy2dw=;
        b=V/5yfSew3u8Z5zfRLStA/F33pNetVf8+dr8zpzqQNw7JiT3ZALcXxM1DPR7P+q8WHx
         woAemqMTKrPwusOPof9W9nfj0TYUf9PjrWGS7KjncIgHoK0+Fu5YxD2OSSrYSq/4DgbU
         VltP0c8lAH/vzY/ST3PUHIKKxgVeRBjStnj/nycuQRuAgVMsT0VEwhsFgq9t3p56+Uao
         2ojRjFGVbWILvm3TBjakUkmtixl8pvnBVadp5wcfqxiWkVor9mHgfQKPxXIOtTdUwl+j
         d0cz8tTlPHvc3RUsEvuwNhTUVbd19HZwP7nObHbQJKol09tmCpSPBFdkOmpX+mN1hM3c
         U7RA==
X-Gm-Message-State: AOAM531fRiRLMLXZLyExopRlJrSfRLPiefjEgmTRL/lVvk7nrN7+OQHH
        vW7w9vAJBoXTi+VURm0LLa8ZCQ==
X-Google-Smtp-Source: ABdhPJy2eRTWQ+g6UmDXlmlM53iqWF2j0sszPGZYETQLzBt+ugwiGbmbWIu+s6aMP/ZkXhMe28KDEg==
X-Received: by 2002:adf:a35d:: with SMTP id d29mr21433215wrb.307.1600173957934;
        Tue, 15 Sep 2020 05:45:57 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id q8sm26548589wrx.79.2020.09.15.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:45:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/4] dt-bindings: clk: axg-clkc: add Video Clocks
Date:   Tue, 15 Sep 2020 14:45:50 +0200
Message-Id: <20200915124553.8056-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915124553.8056-1-narmstrong@baylibre.com>
References: <20200915124553.8056-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock IDs for the video clocks.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/axg-clkc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clock/axg-clkc.h
index fd1f938c38d1..281df3e0f131 100644
--- a/include/dt-bindings/clock/axg-clkc.h
+++ b/include/dt-bindings/clock/axg-clkc.h
@@ -72,5 +72,29 @@
 #define CLKID_PCIE_CML_EN1			80
 #define CLKID_MIPI_ENABLE			81
 #define CLKID_GEN_CLK				84
+#define CLKID_VPU_0_SEL				92
+#define CLKID_VPU_0				93
+#define CLKID_VPU_1_SEL				95
+#define CLKID_VPU_1				96
+#define CLKID_VPU				97
+#define CLKID_VAPB_0_SEL			99
+#define CLKID_VAPB_0				100
+#define CLKID_VAPB_1_SEL			102
+#define CLKID_VAPB_1				103
+#define CLKID_VAPB_SEL				104
+#define CLKID_VAPB				105
+#define CLKID_VCLK				106
+#define CLKID_VCLK2				107
+#define CLKID_VCLK_DIV1				122
+#define CLKID_VCLK_DIV2				123
+#define CLKID_VCLK_DIV4				124
+#define CLKID_VCLK_DIV6				125
+#define CLKID_VCLK_DIV12			126
+#define CLKID_VCLK2_DIV1			127
+#define CLKID_VCLK2_DIV2			128
+#define CLKID_VCLK2_DIV4			129
+#define CLKID_VCLK2_DIV6			130
+#define CLKID_VCLK2_DIV12			131
+#define CLKID_CTS_ENCL				133
 
 #endif /* __AXG_CLKC_H */
-- 
2.22.0

