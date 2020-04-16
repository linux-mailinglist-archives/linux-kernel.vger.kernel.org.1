Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B329D1AC9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395191AbgDPPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441774AbgDPPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b11so5317580wrs.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEt0VLaSvhUT7nyu4RhagnuYQaTu9Oo49aJG5CKXEWA=;
        b=JzDdlkCUORk0NTBv/Ifo99sTDlc02xLmzvAPAvLG0Y9cDe+z3AACvUXdYN12WYXH7N
         hiOKj+DketE2u/1eYscKKwgSbzVKk8EsSCMVY/p9MkIx78kMYeUobsVee1XGW+HR2YNH
         cOoUJdlyC4SurTfBiegCTB7F9vfoJWlStxhfSI3VFoRJLQIcORy8GhylK6F0ysBcbVNu
         zi/N83Xrkju/SGKclJO2/rK39z1Dw1dTBncn1SbFA9630l8OWIKZhiBmdedopclv1c0j
         m46jVJ89+UXLMugbDFl3rmuHntzPAvhQ7h4dLyP0nlxKKj1CBg9rhXn2VhldY+z/PNxU
         pzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEt0VLaSvhUT7nyu4RhagnuYQaTu9Oo49aJG5CKXEWA=;
        b=DaERN5DM6zSO4RjtlfN5/V70F7FC30oz6ihEYrGz9I0jbshlUuFs9xUWxpk5gfoMch
         0kwBuK0keu+XEKAbrEFXQLa3/sX3qUVyCWMeyxFcQeB+VFpIoJsjgpD1IH0Np0bx7uma
         hKB9f4tGB6IOXzqU520679UWW79Oovm+ycua44tmqYIYe2HMnmDBeVo5a2P64oeLBQFT
         yhqbLc6UhTkgmmIUBsnlXcha0IbxW2yWvln1Djv8hs6yxu0LszMmMI5pqma528nRB44G
         0wxVzNc2/C8kxMhdGZ2MXyTbVzVCbSnDhqggQjnesABQp4vUSCbU1YCoqAn0kJyv3IxQ
         MoYA==
X-Gm-Message-State: AGi0PuaM5PiKi9hOk3lRmrMcD046OltVJrSDCYjpLL48vgIrfVEv5PQl
        ZqNhxPNv5vRB5Dv67sA4eB5+Dw==
X-Google-Smtp-Source: APiQypJlK1v57zmfKD4PI/fLEMpUftVKbJ4Xl19Jv7+M7lzOArMjv6GqbpxLYoSVG3ru0ycAnNYbkw==
X-Received: by 2002:adf:f8c7:: with SMTP id f7mr12113934wrq.125.1587050708927;
        Thu, 16 Apr 2020 08:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 2/8] drm/meson: add Amlogic Video FBC registers
Date:   Thu, 16 Apr 2020 17:24:54 +0200
Message-Id: <20200416152500.29429-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416152500.29429-1-narmstrong@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers of the VPU VD1 Amlogic FBC decoder module, and routing
register.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 8ea00546cd4e..08631fdfe4b9 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -144,10 +144,15 @@
 #define		VIU_SW_RESET_OSD1               BIT(0)
 #define VIU_MISC_CTRL0 0x1a06
 #define		VIU_CTRL0_VD1_AFBC_MASK         0x170000
+#define		VIU_CTRL0_AFBC_TO_VD1		BIT(20)
 #define VIU_MISC_CTRL1 0x1a07
 #define		MALI_AFBC_MISC			GENMASK(15, 8)
 #define D2D3_INTF_LENGTH 0x1a08
 #define D2D3_INTF_CTRL0 0x1a09
+#define VD1_AFBCD0_MISC_CTRL 0x1a0a
+#define		VD1_AXI_SEL_AFBC		(1 << 12)
+#define		AFBC_VD1_SEL			(1 << 10)
+#define VD2_AFBCD1_MISC_CTRL 0x1a0b
 #define VIU_OSD1_CTRL_STAT 0x1a10
 #define		VIU_OSD1_OSD_BLK_ENABLE         BIT(0)
 #define		VIU_OSD1_OSD_MEM_MODE_LINEAR	BIT(2)
@@ -365,6 +370,23 @@
 #define VIU_OSD1_OETF_LUT_ADDR_PORT 0x1add
 #define VIU_OSD1_OETF_LUT_DATA_PORT 0x1ade
 #define AFBC_ENABLE 0x1ae0
+#define AFBC_MODE 0x1ae1
+#define AFBC_SIZE_IN 0x1ae2
+#define AFBC_DEC_DEF_COLOR 0x1ae3
+#define AFBC_CONV_CTRL 0x1ae4
+#define AFBC_LBUF_DEPTH 0x1ae5
+#define AFBC_HEAD_BADDR 0x1ae6
+#define AFBC_BODY_BADDR 0x1ae7
+#define AFBC_SIZE_OUT 0x1ae8
+#define AFBC_OUT_YSCOPE 0x1ae9
+#define AFBC_STAT 0x1aea
+#define AFBC_VD_CFMT_CTRL 0x1aeb
+#define AFBC_VD_CFMT_W 0x1aec
+#define AFBC_MIF_HOR_SCOPE 0x1aed
+#define AFBC_MIF_VER_SCOPE 0x1aee
+#define AFBC_PIXEL_HOR_SCOPE 0x1aef
+#define AFBC_PIXEL_VER_SCOPE 0x1af0
+#define AFBC_VD_CFMT_H 0x1af1
 
 /* vpp */
 #define VPP_DUMMY_DATA 0x1d00
-- 
2.22.0

