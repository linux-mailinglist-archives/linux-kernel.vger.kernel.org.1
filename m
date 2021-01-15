Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3912F8398
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbhAOSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbhAOSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA1FC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so6747905wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aoNCmjio9l+rvMx1zGsBoMkbgJVfYu39oKJNZ/3uls=;
        b=oO4p2Qt7e2zzJjwbtmcEgQslHf38O4Ll5XneLSPcedcp/U955WUp7OBBo6XiOUrCQR
         9bHWdzJcJe3/sydkNSJNTJOreeX4oOTwpUTCktEaWWW8sttfSHXciVTMy22hD9F3+Z7u
         dla+xlHuqn4W6StDx1+0ZvM8+HJevlmInFOs5KwEZ7Rb6VUMPb9aqqL+XHDsjQMlQlMz
         a0CdfQ38BCdPa9Y/pkBO7Wo2o6ZeA4Opq/q7PR2FSheFdYQdiLgVB44MHFLilMYiYVG9
         ZysciPyZ2KEm1ky3FthuachRs994pMprRdfD9QOSZiWP6Eez1kOX5QFHhyk9YwJhmTEl
         acgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aoNCmjio9l+rvMx1zGsBoMkbgJVfYu39oKJNZ/3uls=;
        b=dvo0GjKt/Cx6ogjTdAvsupfnvfuozGxhlY/xorGO3rgrt+whhGsz4w3HY6313lgD/4
         gtdzcB2JvKGbSbHmX1QqAEDGwYoVkJbZaoAHpog8nYTyIi60p2FJYsSULY+k7WK9IObx
         /NenF4XPrqF0zP3mCvm6F0z8fOnSJ1WEeK1r7ZuZWXRTuG0/QpUMPnw3g36YJtTCTm+l
         /GBhllQb78BnInkjDvARET2symDywpkCX6YgcZZcXZy+6O0uGnyDYumX1ixM57ctqsRk
         ZvnfQUjOFKMZK5lMZW1o4PtnVcLTJUf1XB4eVQX6703lzAp36s/rOduRYJU74IaZKMIM
         hM4w==
X-Gm-Message-State: AOAM530nJgDuF944UoO4aEGkPD+VYjxVhOVWgabzTlqXQKyqR+x6pQZJ
        qhw39wlSIhz74f7Ta9Kx2KM/Hw==
X-Google-Smtp-Source: ABdhPJyPDU+rAWr+95CjBqCha9HFpSx3cJkKiSRB/6/qt1lCEMkfnxYyUnFr5HtNk7VsyimbxHcgyw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr14778574wrt.396.1610734431166;
        Fri, 15 Jan 2021 10:13:51 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/40] drm/gma500/gma_device: Include our own header containing prototypes
Date:   Fri, 15 Jan 2021 18:12:55 +0000
Message-Id: <20210115181313.3431493-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/gma500/gma_device.c:10:6: warning: no previous prototype for ‘gma_get_core_freq’ [-Wmissing-prototypes]

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/gma_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/gma_device.c b/drivers/gpu/drm/gma500/gma_device.c
index cfbeb010ede0d..4c91e86f4b142 100644
--- a/drivers/gpu/drm/gma500/gma_device.c
+++ b/drivers/gpu/drm/gma500/gma_device.c
@@ -6,6 +6,7 @@
  **************************************************************************/
 
 #include "psb_drv.h"
+#include "gma_device.h"
 
 void gma_get_core_freq(struct drm_device *dev)
 {
-- 
2.25.1

