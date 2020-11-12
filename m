Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5092B0D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKLTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgKLTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:44 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4224C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so6457031wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voWmA7JwfKGhDZMYWPZkZRLYOBpcwZ/fXqx90N9cMjo=;
        b=FOMvItAJ0Md9/XJuA8i3NbOckDk4OyHY1Ktg8z5bTbeyfc0VUbHX3JR6E5RjZjjOLM
         g8zu3Vbo3kidmyTmmILO+V6dNh/L5YGOcUSc1YNvp0u6MHND/MEYT8en0ADTe0yAmeaC
         YZHfPlZQ8MWUb2GiOtxikAMibM+p9fBEBBns6wi6v2IyzstBnvQRx7TOhF4T3DOibaMv
         mxb70HHdB+MFALg6+/9scGOQ2zDf4CkH0FMfqzn2Ihthew/b3VMySshovs1+V2DcsbfZ
         X5cAZmUaEG175AvGHinOFF6+L+O0UAVoTkh3GpCDODnM47mTc94g2g3YpDVwT0vQlqtf
         ZRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voWmA7JwfKGhDZMYWPZkZRLYOBpcwZ/fXqx90N9cMjo=;
        b=jXdSWgsJbZhnIUB8H5Mh5yS0PkV8DWS2Z00gRO5kiKprEgFU7JLQvC9SwqiDCyqlRq
         a4/HqSg1sDEgWfXczX+aaG/vC6mttI+t15UHyW7ZEuufIs1ogSxk1jbFOlDjX+/Nuem6
         nbMu1tztgOFkA4T4hSbNJY6bT91o5yAaRKImdE4QmW/2xJOHF8DuRq2pG2D3MowAzoE8
         2Nt8w0jddOIyA06WtcCCzOOrGdo0JlfSaFDuIddt+IafBISiDc2vQZ4j8R3xNfBXlUzO
         WHs7HDoqrBCtV6UKKE5zKP5fTL5tto+PXxQdNYj9pAOuiiK5tQ7ZzqghC9s/jraGr1Gc
         W1+A==
X-Gm-Message-State: AOAM530GybThl9M3Xae6MoH/a17fukhZKnLlUPu3Fqmv65+9cJA58MtF
        Y3Q8gBjM8NPeG0042atWF4Gdug==
X-Google-Smtp-Source: ABdhPJxgbkTD7w7l2/8P+0kdyuR2XtxgVvHmCxnBUy2gdjJyRwAkK9kAMbwjjejY5ibuuX3ZTC5D0w==
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr1047874wmf.149.1605207702385;
        Thu, 12 Nov 2020 11:01:42 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 24/30] drm/nouveau/nvkm/core/firmware: Fix formatting, provide missing param description
Date:   Thu, 12 Nov 2020 19:00:33 +0000
Message-Id: <20201112190039.2785914-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and demote non-conformant kernel-doc header.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'subdev' not described in 'nvkm_firmware_get'
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'fwname' not described in 'nvkm_firmware_get'
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'ver' not described in 'nvkm_firmware_get'
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'fw' not described in 'nvkm_firmware_get'
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c:106: warning: Function parameter or member 'fw' not described in 'nvkm_firmware_put'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
index 8b25367917ca0..ca1f8463cff51 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
@@ -58,9 +58,10 @@ nvkm_firmware_load_blob(const struct nvkm_subdev *subdev, const char *base,
 
 /**
  * nvkm_firmware_get - load firmware from the official nvidia/chip/ directory
- * @subdev	subdevice that will use that firmware
- * @fwname	name of firmware file to load
- * @fw		firmware structure to load to
+ * @subdev:	subdevice that will use that firmware
+ * @fwname:	name of firmware file to load
+ * @ver:	firmware version to load
+ * @fw:		firmware structure to load to
  *
  * Use this function to load firmware files in the form nvidia/chip/fwname.bin.
  * Firmware files released by NVIDIA will always follow this format.
@@ -98,7 +99,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, const char *fwname, int ver,
 	return -ENOENT;
 }
 
-/**
+/*
  * nvkm_firmware_put - release firmware loaded with nvkm_firmware_get
  */
 void
-- 
2.25.1

