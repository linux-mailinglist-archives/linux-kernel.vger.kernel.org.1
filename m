Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC782F83C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbhAOSPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbhAOSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D61C0617BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id s24so1401015wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0p9zOjVy0LRiK477P9KUaWrIsEvH1MWK05iKsSjHrQ=;
        b=lmFcqa/mseKa8mnML6PJecGiZ8SxOYeYWnTqqbYBatmO8biGq7K8RpAi7Jz52YFDyx
         KSxyAT5AFEIc3znyzbwr9qVzmkNpw9QTm15wvCS3PtQSz9EbPruetbXiahzjZbFskPE3
         fB2eRAKEX33jhUxXKdnEF4SZOxkUoaRka1IsBxfgLYS4x7aePWvQWE8qWmpFOK0M2oJy
         zIoB8FRwKWh4QU0seZ6LwXxELNznUrvnUhD6a6opaZt0TXRdAmK3aKk7Bg150QoHORU5
         oQ/QCkclp5Pi2InvETySTFtnJR3Cgh5hOu9J4dB5YzmpZj/DTPBMi701y7pfX6h9of0f
         kzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0p9zOjVy0LRiK477P9KUaWrIsEvH1MWK05iKsSjHrQ=;
        b=Gj7PqC4GtCUETCBryuYDkDnyUYBE+r9MNlSzWEDNBNU+45SWNZfqQexY3Dcat9KY/s
         vMC8wk4p/O5ZsRDmQcdEAzk3xXSgehax5Uz1G+7LHbh3g3y+RNaPgdFUJ8Xju9reVO/Y
         2Sy9xhiEFVg7IAaN5oRpMC8wyvhpsHKBLhcoOVOCSzOcCFBsp4k7n2aVkMTBW2qSf7TS
         VtQNbaDuWumtsdJEmExzfO5PCDGZs2Tut4TCZ8p03WCjuGl+5c3gLLqRq6ho3MpW7eVg
         QOtjvbFowAeg9/mdS1wBdMslFV3+SqqeuqVKMXlnL/ZCIUnfR/AlfV3BAycz8NIv3TWg
         YLwA==
X-Gm-Message-State: AOAM5328VKSoDdAKH7rDlZp1pLi2EPKvQUE1EXwnDEuPJGtxJQJQzmMq
        IaoM3kpez4+NYFOp56JnJxubpg==
X-Google-Smtp-Source: ABdhPJxwcEN3TY5oIWcCMU0IpVvqUC2z82+4QsITRQHihwoLctM4iYytSxJx/v5qpT/6dxCkZMwiZQ==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr9766353wmb.140.1610734442619;
        Fri, 15 Jan 2021 10:14:02 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jesse Barnes <jesse.barnes@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/40] drm/gma500/psb_intel_modes: Provide missing descriptions for function param 'adapter'
Date:   Fri, 15 Jan 2021 18:13:03 +0000
Message-Id: <20210115181313.3431493-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/psb_intel_modes.c:17: warning: Function parameter or member 'adapter' not described in 'psb_intel_ddc_probe'
 drivers/gpu/drm/gma500/psb_intel_modes.c:51: warning: Function parameter or member 'adapter' not described in 'psb_intel_ddc_get_modes'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jesse Barnes <jesse.barnes@intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/psb_intel_modes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_intel_modes.c b/drivers/gpu/drm/gma500/psb_intel_modes.c
index 88653a40aeb5c..60306780e16cd 100644
--- a/drivers/gpu/drm/gma500/psb_intel_modes.c
+++ b/drivers/gpu/drm/gma500/psb_intel_modes.c
@@ -11,7 +11,7 @@
 
 /**
  * psb_intel_ddc_probe
- *
+ * @adapter:   Associated I2C adaptor
  */
 bool psb_intel_ddc_probe(struct i2c_adapter *adapter)
 {
@@ -43,6 +43,7 @@ bool psb_intel_ddc_probe(struct i2c_adapter *adapter)
 /**
  * psb_intel_ddc_get_modes - get modelist from monitor
  * @connector: DRM connector device to use
+ * @adapter:   Associated I2C adaptor
  *
  * Fetch the EDID information from @connector using the DDC bus.
  */
-- 
2.25.1

