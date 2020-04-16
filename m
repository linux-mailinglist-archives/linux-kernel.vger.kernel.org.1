Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA71AC9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504260AbgDPP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442488AbgDPPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9400C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so5346255wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x74ZNY2Ii0Wq7WqU8UNzlM4qIe5Anz5MtvDWgXAqJ8U=;
        b=Q9sFCx/QxugMEbo/HrWaN7/l9wYvrDBzi+BaORQLde30NDU+pchUv6x2xo4yNFqJcW
         C7a7bKJTD9UtwfKR/BnAmmVHoYgycsF/kf1jx7CZXLkJJdvmLuZwyV4JBs3AXkqFod0M
         xv6XoDI8LhXY2WeJ6sQ+JyFUoxrljmxSmAK74DPbUQ0DNDoRYoxPB78f+pOGzlALSGKa
         psP4tH29K6BIye15yiigPWJW5F9yOpvQC36gvol17c1syMD22b8bMVf3nd0ZnIXa+KhO
         VSUkeR03lEnZd5cj7EsuDZjzUFWToJYoGX7UjSOD+EOpIijnNMkc1r3zIYrPXd3oKar8
         /9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x74ZNY2Ii0Wq7WqU8UNzlM4qIe5Anz5MtvDWgXAqJ8U=;
        b=nMWklj2Et4ACDfhK6OMe9MSBakgjL+DiUPpo9o1xQ3iGNIAk17g1SMinktkqGXMBWM
         u8Oh80xzVKr6ZvpI8AU5ExOMHlMHuUuCKzqKh4g/HR2JuLR51sbrplHfTy2Vx6W9ikJT
         FckYM/p0wIqJLVX9TK13yYG/MHe7iFhZ41fRpf0jWC2rY5VhpsKO/W/kWdOeQvhdbmiy
         8sMzsgpp/DAdyxv5RtM5LnM/i7Ln8b8v8Ja1XiOIfCYfMTeUkI783RaqAfLk3N2HMF/e
         ovuF1MpFSWon6qMIfT5j60PxbpgcK5tL7J+7t5R/PFkfrCUSeOhbWRExMXaJv0wphHHF
         Zh/w==
X-Gm-Message-State: AGi0PubliUWvEw9osekOcCLs537DLlqJ23R7xgZno77O3c7/+s1DDpks
        26SSbwvqwnW1tjeZ3nqu8ToM5w==
X-Google-Smtp-Source: APiQypJD88ybgaDtDKq1U3lq0cPR53Jd+LyWH4BTyYS5P/piMZdjIcsHLVxv0kGThgLlWqtQbsiCcQ==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr35893659wrp.409.1587050718352;
        Thu, 16 Apr 2020 08:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 7/8] drm/fourcc: amlogic: Add modifier definitions for the Scatter layout
Date:   Thu, 16 Apr 2020 17:24:59 +0200
Message-Id: <20200416152500.29429-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416152500.29429-1-narmstrong@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

This introduces the Scatter Memory layout, means the header contains IOMMU
references to the compressed frames content to optimize memory access
and layout.

In this mode, only the header memory address is needed, thus the content
memory organization is tied to the current producer execution and cannot
be saved/dumped neither transferrable between Amlogic SoCs supporting this
modifier.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 664dd238574a..ac2d4753eb6d 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -843,6 +843,19 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)
 
+/*
+ * Amlogic FBC Scatter Memory layout
+ *
+ * Indicates the header contains IOMMU references to the compressed
+ * frames content to optimize memory access and layout.
+ *
+ * In this mode, only the header memory address is needed, thus the
+ * content memory organization is tied to the current producer
+ * execution and cannot be saved/dumped neither transferrable between
+ * Amlogic SoCs supporting this modifier.
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER	(2ULL << 0)
+
 /* Amlogic FBC Layout Options */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_OPTIONS_MASK		(0xf << 8)
 
@@ -854,7 +867,8 @@ extern "C" {
  * memory.
  *
  * This mode reduces body layout to 3072 bytes per 64x32 superblock with
- * the basic layout.
+ * the basic layout and 3200 bytes per 64x32 superblock combined with
+ * the scatter layout.
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING	(1ULL << 8)
 
-- 
2.22.0

