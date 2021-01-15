Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D12F83BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbhAOSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387720AbhAOSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C11C0617BA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u14so4192485wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVt/rdeEBQJxQhCHaNNlJJAtPDszt4A5bvtFCOyl0bM=;
        b=Sc/GUxuyiRJdn91hjCasO8KQhK49SFIeOpJhYv2lzYtBvkAlPg1J9p06riSFlV52cg
         eqjong14hahD5tYf/SWgSY7FTLqjwLxFVOQjhZ0A+bLdZoOhW2Rj0yBMVKNunVjwC99i
         xCLJjxjHEERinfZ3cVdz25AdxZEv+UgtMEx58Klerqd/p/6PojbafmMNGuwavXsFq3gp
         oJlKuBoiUgKuDAyMrUQCXNfEDG0G/PbqoiELOZ07j1YQtFVQF1VQKS+1m5/THHK3ORhh
         4VnaEpCaBLqdVagjmeOKsx6g5zEOkqRVnilaL3kZpSR6ZuTJuVZQx8HHBuv0Ho6CTIHE
         DG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVt/rdeEBQJxQhCHaNNlJJAtPDszt4A5bvtFCOyl0bM=;
        b=notFu0gcf3EkMEe9l460JOkohtQKBAh0XlYod2njxzQ3qg9ObHEhnEOKUxEKc95BJJ
         3+3YN2s/e/MGB/hEAOVdNGDJbsfjUKGT0wHL6iIxkfXA4rJy4wPIC0mLaV9qB1ETF29u
         fKVL2v8fvnm+KhFXBAhIx6xH1vdKvNw7awBTeMS3kaLoMlPXn32oW5Clum9/6Aa6pRr3
         /TI9GVsTQ66TVqHApvlOP5vzVo7v69nsULHtHvkUH0oxn9wCnOXD8l6gcDK37WWirjIE
         +b10PrNcf4S/jn160cG0cdIwdcaQPsQE+ENGNhh7EOY3iNSiKZw+whqNuglJ4/99zQu/
         YN3g==
X-Gm-Message-State: AOAM533gM9JMfszsIXiMA30VsRE21yFMHQsPSg9y0EnJfmpOGd7Hx2oe
        TJ/ZP4Jd3tPG6DorTFxAJYPmNQ==
X-Google-Smtp-Source: ABdhPJzNu8NawRYjrPv3ZUrXYULqlHq3ph+lO3U+klIyj/QTDgnxMgxhqUqT5ChkSfSse1V3ZfphXA==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr9708669wmk.103.1610734436402;
        Fri, 15 Jan 2021 10:13:56 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Jesse Barnes <jesse.barnes@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/40] drm/gma500/psb_intel_lvds: Supply description for 'mode_dev'
Date:   Fri, 15 Jan 2021 18:12:58 +0000
Message-Id: <20210115181313.3431493-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/psb_intel_lvds.c:635: warning: Function parameter or member 'mode_dev' not described in 'psb_intel_lvds_init'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: Jesse Barnes <jesse.barnes@intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/psb_intel_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index f65a6f386caed..ace95d4bdb6f8 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -626,6 +626,7 @@ const struct drm_connector_funcs psb_intel_lvds_connector_funcs = {
 /**
  * psb_intel_lvds_init - setup LVDS connectors on this device
  * @dev: drm device
+ * @mode_dev: mode device
  *
  * Create the connector, register the LVDS DDC bus, and try to figure out what
  * modes we can display on the LVDS panel (if present).
-- 
2.25.1

