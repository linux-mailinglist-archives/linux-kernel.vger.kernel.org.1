Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4212F77E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhAOLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbhAOLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:44:20 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3055AC061757;
        Fri, 15 Jan 2021 03:43:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id r12so1494148ejb.9;
        Fri, 15 Jan 2021 03:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/9sksIUuZatO+aX8p4iLJ2mKZetuSFmDz0PF+YiOHOI=;
        b=YEJANZ1/9r+EPbKaQQTb3YhWamtM4DH9to+g8PWbIoYfCC2B9io/PF88pVRzv8fh61
         Wapvntn5ABjZ4BADq3kEhzYrfLziVhaprSzQD1mSf1hjsxKCDAxUsCWMtzTpTyJwZ/Ql
         2OKtFYFS//RkJM5MTRb5VHYlKtLi9PAgP2o50L/4C4rwV7bn6D8U0duHKDpPSdNh6r8E
         fybYpMd8V3cr0MKirGnUYPOuP/QV5wYCu0q7b9Pr2IZ35zwJ6tnVquuJfw/sbV7u9O9h
         oxFe7U6FfWf/79W+zxcUMZshS+fHCd56UJ7c8Y63FqlccwNeRBJ3ePAYCGUunR7p5scq
         zUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/9sksIUuZatO+aX8p4iLJ2mKZetuSFmDz0PF+YiOHOI=;
        b=gglOrfA+8I24DrHzvEuG6tbrJE/4edqiRfnuKV92TRYxAVfDCJwn8cTirP1TFn82y6
         xmRuQByCZw5VmlbxcI18DK2Xip3ONmUUoh7xGPA/FU8a3E84lGZ9nwA5QeySGv8YTQtr
         3uRKeEu9le1gJ3e2vPqMvEAS1CeEdFvLO+VWCD4VDo5a3dsgf3AwXeZllGfdE+JRgqtw
         1t56gfFmSJrVfIcXkaRHSPfGIAm/OJEKVBVfyY+tOtkDeKGiuUsp4ricc3DgUF7UiMNn
         +PWh3LlNTtdNIejxTE64Mf8G50NJzEIG1mFvMAj/WO5PA9jhkhB/v8jDdnzHl/zUmz5W
         cy/g==
X-Gm-Message-State: AOAM533Oyl9Qcbs11KD2TLq1soIUl5OwbRm346SE8adn64O0cIAiC52j
        DfudEo7spc8lxxBee0Zn/k8=
X-Google-Smtp-Source: ABdhPJwET0Z8ZFGqMNHwdHfY36RdnFX6xRQgu56Fz+Cxj0NantVxngAd4EdKk1sELCE/DGiWkoU/OQ==
X-Received: by 2002:a17:906:48c:: with SMTP id f12mr3397945eja.431.1610711018663;
        Fri, 15 Jan 2021 03:43:38 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d39:a000:7c85:8e80:b862:a8bf])
        by smtp.gmail.com with ESMTPSA id a2sm3184105ejt.46.2021.01.15.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 03:43:37 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm/dp_helper: tweak kerneldoc to address warning
Date:   Fri, 15 Jan 2021 12:43:29 +0100
Message-Id: <20210115114329.27152-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 07c9b8634fb6 ("drm/dp_helper: Add helpers to configure PCONs
RGB-YCbCr Conversion") introduces a warning with make htmldocs in
./drivers/gpu/drm/drm_dp_helper.c:965 for
drm_dp_downstream_rgb_to_ycbcr_conversion():

  warning: Excess function parameter 'colorspc' description
  warning: Function parameter or member 'color_spc' not described

Tweak the kerneldoc for drm_dp_downstream_rgb_to_ycbcr_conversion().

Fixes: 07c9b8634fb6 ("drm/dp_helper: Add helpers to configure PCONs RGB-YCbCr Conversion")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210115

Jani, please pick this minor doc warning fixup.

 drivers/gpu/drm/drm_dp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 3ecde451f523..d60e94ac6fdd 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -954,7 +954,7 @@ EXPORT_SYMBOL(drm_dp_downstream_444_to_420_conversion);
  *                                               RGB->YCbCr conversion capability
  * @dpcd: DisplayPort configuration data
  * @port_cap: downstream facing port capabilities
- * @colorspc: Colorspace for which conversion cap is sought
+ * @color_spc: Colorspace for which conversion cap is sought
  *
  * Returns: whether the downstream facing port can convert RGB->YCbCr for a given
  * colorspace.
@@ -3134,7 +3134,7 @@ int drm_dp_pcon_pps_override_param(struct drm_dp_aux *aux, u8 pps_param[6])
 }
 EXPORT_SYMBOL(drm_dp_pcon_pps_override_param);
 
-/*
+/**
  * drm_dp_pcon_convert_rgb_to_ycbcr() - Configure the PCon to convert RGB to Ycbcr
  * @aux: displayPort AUX channel
  * @color_spc: Color-space/s for which conversion is to be enabled, 0 for disable.
-- 
2.17.1

