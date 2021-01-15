Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9043F2F83E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbhAOSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbhAOSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A9CC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id s24so1404338wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pk5+6mRjwwMBA1oTZMeewA7tFyIHWI0+EL96CyzELJ8=;
        b=vXcak5ntquYDz653i1Vs6VN6dq47ysugV+cN1Mcv7e+2SbuXbmiq4gzzxa3qtSfJtP
         iDLpgM9bzc4m2lupyUGfbM3/WzGGvqGS7802m0E3Xa1FxP57gU/VLF/+uN+8qxvLE4ru
         tLDSbod3qxRpck5TB1Na64i43keLb2lC5M+YaOXe57EIqjZE0wnjXfPx5fBXmA7P1/Jg
         eYb5bj5G2/rwj3+MFStbGYvn/gQOKYCgG+NB8gL0m/14PVzYC/n0LaevwZHgvZnBC4uG
         0/AH/tzlOU81Qpl6eBZ+JxqYYsd+wOAkTKfMZ55HzUixFp1CkhRmMBll2wLjnbYy22jC
         dIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pk5+6mRjwwMBA1oTZMeewA7tFyIHWI0+EL96CyzELJ8=;
        b=HO/U423B/MVuXtiu5ZLuN7U3+rY2mI+LdEIt7iq83K/rHA8rJKU2+mUFKgGSo95OXy
         rpKlxT3Vmiof5mXwK48QjqMNDaaUHs65TTQcrjHfdmuAv4oImNlKNwjlZTIJk7S5O4rB
         AhqSBS3HNhL5HTg74q+F1nSV5rT1VXNtqKYS2GXXijyn9j+UQzkhkyVIXhx/2Be4zQO7
         DnaH5+WBJchFpE9SDlqh884k0CcIc9QIfmePF72VueICizYDvAWaYo7n9rfkxSwBS3PN
         rK6Ya9r8yqnflLO2PQkcsUdSsmqlAif8s62I1l4yeRWoiWYxlvIsC6FUHAEWmlg2wMu+
         itCQ==
X-Gm-Message-State: AOAM533GPdoN9/GuB4aqSPBOqC0fUEfT1zyRtghTlNrqn3LAlBDx/E10
        ANUODn1Z+xJDirH/3xSvhp37Eg==
X-Google-Smtp-Source: ABdhPJziSG5JNrmyeD/Cfd4CigulzEBuOBdQ6siz1iWXcp4UaNN7um1FPb2T4SUj0PnvdWvNa90U1g==
X-Received: by 2002:a1c:358a:: with SMTP id c132mr9884433wma.157.1610734581782;
        Fri, 15 Jan 2021 10:16:21 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jesse Barnes <jesse.barnes@intel.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/29] drm/gma500/psb_intel_sdvo: Demote kernel-doc abuses
Date:   Fri, 15 Jan 2021 18:15:43 +0000
Message-Id: <20210115181601.3432599-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/psb_intel_sdvo.c:230: warning: Function parameter or member 'psb_intel_sdvo' not described in 'psb_intel_sdvo_write_sdvox'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:230: warning: Function parameter or member 'val' not described in 'psb_intel_sdvo_write_sdvox'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:598: warning: Function parameter or member 'psb_intel_sdvo' not described in 'psb_intel_sdvo_get_trained_inputs'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:598: warning: Function parameter or member 'input_1' not described in 'psb_intel_sdvo_get_trained_inputs'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:598: warning: Function parameter or member 'input_2' not described in 'psb_intel_sdvo_get_trained_inputs'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:1831: warning: Function parameter or member 'dev_priv' not described in 'psb_intel_sdvo_select_ddc_bus'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:1831: warning: Function parameter or member 'sdvo' not described in 'psb_intel_sdvo_select_ddc_bus'
 drivers/gpu/drm/gma500/psb_intel_sdvo.c:1831: warning: Function parameter or member 'reg' not described in 'psb_intel_sdvo_select_ddc_bus'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jesse Barnes <jesse.barnes@intel.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/psb_intel_sdvo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 2ddf7e41aa5d4..355da28563891 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -221,7 +221,7 @@ static bool
 psb_intel_sdvo_create_enhance_property(struct psb_intel_sdvo *psb_intel_sdvo,
 				   struct psb_intel_sdvo_connector *psb_intel_sdvo_connector);
 
-/**
+/*
  * Writes the SDVOB or SDVOC with the given value, but always writes both
  * SDVOB and SDVOC to work around apparent hardware issues (according to
  * comments in the BIOS).
@@ -588,7 +588,7 @@ static bool psb_intel_sdvo_set_target_input(struct psb_intel_sdvo *psb_intel_sdv
 				    &targets, sizeof(targets));
 }
 
-/**
+/*
  * Return whether each input is trained.
  *
  * This function is making an assumption about the layout of the response,
@@ -1818,7 +1818,7 @@ psb_intel_sdvo_guess_ddc_bus(struct psb_intel_sdvo *sdvo)
 #endif
 }
 
-/**
+/*
  * Choose the appropriate DDC bus for control bus switch command for this
  * SDVO output based on the controlled output.
  *
-- 
2.25.1

