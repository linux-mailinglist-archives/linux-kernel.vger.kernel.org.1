Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66428CE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgJMMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgJMMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:44:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB8C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:44:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so10634798plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1J1FFqE4TaVcT8yK2I3InKcPDjZwlb3XxiGUU1SQgg=;
        b=eDW3vgoS62vHVYJO8n0dz5zs+hzYx5++e5wCZXTPY8p8iKIDgBAfAUEc/l712Uf5Mb
         2LKE2AG9sG/gSvVtVIjwRrkCssw/Nx7cR7snu1hRvKbzDfmKfIIekfgbU7M8ePkz9+44
         AnOEn5Ut2ZmPSSJXCPTRjmEe8YVk0lmOm+u9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1J1FFqE4TaVcT8yK2I3InKcPDjZwlb3XxiGUU1SQgg=;
        b=LrSUERD/NJOVu4IsXDeBZFAqg7/QZBQ42xqNsDLrb9YWyegXpbEGz2xNVEk2CtcosW
         mttL/LO2CvKayhrefyJKc1N1bn/K3N9ev8nPxvA5xA7odKolcc95OPV4t3LteS7WUkIR
         6vhOXs9roqZIZ1zJ9Q0qtMs38iElbPASH9X39nvKZxdPq8nuUbYi+RuzX8qzQKEwJcRI
         GapykGK8EJRZYXgBOZdfNFjWoYmURfyHpsiUD2T7Cd+by2Mx1vqm88he5XoNsk63Yk/Q
         dyuwMe+wIG7SJE+p2lZm9wi5VCCiZ8nj/ttYyapvdUGPzWzOoPl5ohrkAOpwYsxAT3XR
         9eRw==
X-Gm-Message-State: AOAM532FvrFr+GjD9UtYRsO9C7k0VGnIaAvMdt4kf+PdV2HpUs2OeSPT
        BI4zHRxTouCjlZuzagQB0TAYtA==
X-Google-Smtp-Source: ABdhPJx+QHG9+ml+rhwLtC/IlzRba159/wBY8WWuYYP7WtIx1xlGmYeYcCA4j+fGgbnhgD0V/3hAtA==
X-Received: by 2002:a17:902:9347:b029:d3:7c08:86c6 with SMTP id g7-20020a1709029347b02900d37c0886c6mr26862688plp.84.1602593084449;
        Tue, 13 Oct 2020 05:44:44 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id b20sm18914536pjo.37.2020.10.13.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:44:43 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 2/2] media: mtk-vcodec: fix build breakage when one of VPU or SCP is enabled
Date:   Tue, 13 Oct 2020 21:44:28 +0900
Message-Id: <20201013124428.783025-3-acourbot@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201013124428.783025-1-acourbot@chromium.org>
References: <20201013124428.783025-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of MT8183 support added a dependency on the SCP remoteproc
module. However the initial patch used the "select" Kconfig directive,
which may result in the SCP module to not be compiled if remoteproc was
disabled. In such a case, mtk-vcodec would try to link against
non-existent SCP symbols. "select" was clearly misused here as explained
in kconfig-language.txt.

Replace this by a "depends" directive on at least one of the VPU and
SCP modules, to allow the driver to be compiled as long as one of these
is enabled, and adapt the code to support this new scenario.

Also adapt the Kconfig text to explain the extra requirements for MT8173
and MT8183.

Reported-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/Kconfig                | 28 ++++++++++++++-----
 drivers/media/platform/mtk-vcodec/Makefile    | 10 +++++--
 .../platform/mtk-vcodec/mtk_vcodec_fw_priv.h  | 18 ++++++++++++
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a3cb104956d5..7e152bbb4fa6 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -253,17 +253,31 @@ config VIDEO_MEDIATEK_VCODEC
 	depends on MTK_IOMMU || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on VIDEO_MEDIATEK_VPU || MTK_SCP
+	# The two following lines ensure we have the same state ("m" or "y") as
+	# our dependencies, to avoid missing symbols during link.
+	depends on VIDEO_MEDIATEK_VPU || !VIDEO_MEDIATEK_VPU
+	depends on MTK_SCP || !MTK_SCP
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-	select VIDEO_MEDIATEK_VPU
-	select MTK_SCP
+	select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
+	select VIDEO_MEDIATEK_VCODEC_SCP if MTK_SCP
 	help
-	    Mediatek video codec driver provides HW capability to
-	    encode and decode in a range of video formats
-	    This driver rely on VPU driver to communicate with VPU.
+	  Mediatek video codec driver provides HW capability to
+	  encode and decode in a range of video formats on MT8173
+	  and MT8183.
+
+	  Note that support for MT8173 requires VIDEO_MEDIATEK_VPU to
+	  also be selected. Support for MT8183 depends on MTK_SCP.
+
+	  To compile this driver as modules, choose M here: the
+	  modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
+
+config VIDEO_MEDIATEK_VCODEC_VPU
+	bool
 
-	    To compile this driver as modules, choose M here: the
-	    modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
+config VIDEO_MEDIATEK_VCODEC_SCP
+	bool
 
 config VIDEO_MEM2MEM_DEINTERLACE
 	tristate "Deinterlace support"
diff --git a/drivers/media/platform/mtk-vcodec/Makefile b/drivers/media/platform/mtk-vcodec/Makefile
index 6e1ea3a9f052..4618d43dbbc8 100644
--- a/drivers/media/platform/mtk-vcodec/Makefile
+++ b/drivers/media/platform/mtk-vcodec/Makefile
@@ -25,5 +25,11 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
 mtk-vcodec-common-y := mtk_vcodec_intr.o \
 		mtk_vcodec_util.o \
 		mtk_vcodec_fw.o \
-		mtk_vcodec_fw_vpu.o \
-		mtk_vcodec_fw_scp.o
+
+ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU),)
+mtk-vcodec-common-y += mtk_vcodec_fw_vpu.o
+endif
+
+ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP),)
+mtk-vcodec-common-y += mtk_vcodec_fw_scp.o
+endif
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
index 51f1694a7c7d..b41e66185cec 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
@@ -27,8 +27,26 @@ struct mtk_vcodec_fw_ops {
 	void (*release)(struct mtk_vcodec_fw *fw);
 };
 
+#if IS_ENABLED(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU)
 struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
 					     enum mtk_vcodec_fw_use fw_use);
+#else
+static inline struct mtk_vcodec_fw *
+mtk_vcodec_fw_vpu_init(struct mtk_vcodec_dev *dev,
+		       enum mtk_vcodec_fw_use fw_use)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_VIDEO_MEDIATEK_VCODEC_VPU */
+
+#if IS_ENABLED(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP)
 struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev);
+#else
+static inline struct mtk_vcodec_fw *
+mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_VIDEO_MEDIATEK_VCODEC_SCP */
 
 #endif /* _MTK_VCODEC_FW_PRIV_H_ */
-- 
2.29.0.rc1.297.gfa9743e501-goog

