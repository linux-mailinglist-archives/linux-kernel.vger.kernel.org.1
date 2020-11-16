Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274272B4E12
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgKPRl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbgKPRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:52 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC50C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:52 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so29034wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voWmA7JwfKGhDZMYWPZkZRLYOBpcwZ/fXqx90N9cMjo=;
        b=Q/5s24f2J2WYaf1lDVin02W6tDLEn9ETKKVIAlSa3geYU2EDOSCN8AHyxHt4cvgOCh
         zTPfZjuqBYHxS2cnpdwzjJC+ZUVxIi9H4UJwrkv0ytH6ZgGUXx35pl+RRgKBsHxPcfDS
         yHiyh2/prpOiQauOfr6NeOlW8bUML1ksJJex8rye/wHRVQpip2qLEAyWp3kUlXJSK0Er
         sjLFTmYOVG3joUvxSqsetKTtYqtR6t03eAT1M00X3rfX/vlI3+doDpxEz0yyTFG0N8sw
         cqDeBro+6ick1o85xj9vMwMomzZ+imZLDJNd7CFBTPKTPHhQj1HKKY0tE0vry6ZKlEH4
         7B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voWmA7JwfKGhDZMYWPZkZRLYOBpcwZ/fXqx90N9cMjo=;
        b=iP5JXBT5r5uzmw7+hstufVnsvIHk9IEsiDNz2GUXhOFicsF8tWLRZDL1j9lWawQ8rm
         /LzoVtjaaEkVki2OBDwi67OIbULxuDNlakXWprTQsX4xGDK16zAcbE//snsSxn1Z1Jv6
         ltOx3FSoMGCUnP8xs/l0/zZS1iC6HjkaW68Dwy+qMU7xYmXcFoq3k89TbuCurNqs8xo6
         WkwFQ6vnUwOlEJS/f2k281lqfRM/jbxiM7j1XAd+ojUkMkQFNJ1v+JxzyuDy9Nb5Q2Jy
         KjGqt+gWtBV9ZrnJMDo5Y0PV7yJriC/MYMlUikORb4291qGJ5SbwYCLEpn7P6KM1d9BR
         wblw==
X-Gm-Message-State: AOAM531mwx5XNvRVKYdRslj6OV6IhTktOrPaVqUo6WnQbLaQdgL3MFMQ
        JCNT9+B8vRfRN5wJrMVxhPdzIg==
X-Google-Smtp-Source: ABdhPJwuvAgqDWMZ3sjRi0c2yQlbytErPP7kxds1VUQAakjg1WWYvU8tM8e0449EbLG8YOVOAFyozQ==
X-Received: by 2002:a7b:c18e:: with SMTP id y14mr7520926wmi.123.1605548510917;
        Mon, 16 Nov 2020 09:41:50 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 21/42] drm/nouveau/nvkm/core/firmware: Fix formatting, provide missing param description
Date:   Mon, 16 Nov 2020 17:40:51 +0000
Message-Id: <20201116174112.1833368-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

