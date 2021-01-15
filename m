Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD99F2F83C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbhAOSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbhAOSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A6C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v184so4173106wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4bk6qPXM66REGe7AKVzGIJtGtbIBYeQRfbgzaiwlYw=;
        b=fbb83iZMimVayaujWI7iqzvQdiDkC19anKbQzeQLH9LqVfAVeEbBkPQu4blHEoLKev
         i3i3zIQCkHlJGER+MRp3TWy9xSSMDlpvtIy+T8YazOBmD33GNLsZnl7rNXojiajHELwb
         cfXqzHGIWk5gyOSmMyiNZe/p2nKDoGO67Drb4QHc7MZVy5K6Y05wlwy1LkXtY/7aTZX5
         s6NjqotAtkTBef5VABXoZTQFMfwN/VaHFPoi2Pgt2WgYoCyKJqnPkAehJwXPmsHli5Z+
         6JX3/EkQaeQjxG+o00JgKm8ma0pfZza2tMXHL+iJTR7bI7/yGXY8jSVIv97xynJUvCuo
         xupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4bk6qPXM66REGe7AKVzGIJtGtbIBYeQRfbgzaiwlYw=;
        b=ogGDHABQKnXawLmyK3/nfsb2g9lYtf3eEpRYJUmDSE67cLj+HnK8o+nk1gtpzsBlq9
         3libI5LGFDrOKxXkdeuJxIrEOFXBGTs1nA2T5YrSxmzgU58xvpPHE2IQVMtuAYJcpkQe
         udx9pe0SpPCmKBMiwIQqRWgB/0BkAjfia1FBbr7cwMx/OjnujmDznydjOukA17a6uV6C
         EJXG9/BFiFBsT+RPWGQ3cHGv0cN+vNmdOUwzLYn+58W6nwD6+s7sHvfaFmrRDLTDWrDC
         0N5PaH7XWSV4fyqyAN3Qac1C1osydL7jhUzmzrEgShs+kWusncIxj7fRyuu++mRrLKtF
         WMGw==
X-Gm-Message-State: AOAM532+x93GhA/JS8+lEwLIRxSvAi0omoCCnNAzwTekIEZ8f7ey7fBI
        PPJ++6yvw469TmuX93kEJsztSQ==
X-Google-Smtp-Source: ABdhPJyC90DXJbQi68KM16rzl+PXjOw/34j6vjAGEAnISOreJODFMHF+Ahf6R8hUIqHswTaf/dZF7A==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr10136669wmd.2.1610734447408;
        Fri, 15 Jan 2021 10:14:07 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/40] drm/gma500/mmu: Remove unused function 'psb_get_default_pd_addr'
Date:   Fri, 15 Jan 2021 18:13:07 +0000
Message-Id: <20210115181313.3431493-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/mmu.c:420:10: warning: no previous prototype for ‘psb_get_default_pd_addr’ [-Wmissing-prototypes]

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/mmu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 42b53c01b79f4..014daf0280485 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -416,15 +416,6 @@ struct psb_mmu_pd *psb_mmu_get_default_pd(struct psb_mmu_driver *driver)
 	return pd;
 }
 
-/* Returns the physical address of the PD shared by sgx/msvdx */
-uint32_t psb_get_default_pd_addr(struct psb_mmu_driver *driver)
-{
-	struct psb_mmu_pd *pd;
-
-	pd = psb_mmu_get_default_pd(driver);
-	return page_to_pfn(pd->p) << PAGE_SHIFT;
-}
-
 void psb_mmu_driver_takedown(struct psb_mmu_driver *driver)
 {
 	struct drm_device *dev = driver->dev;
-- 
2.25.1

