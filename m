Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FB42F838B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbhAOSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbhAOSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C1C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so6746400wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZXgyLMN5uQO65wHWj6R5etzWm7XSdTARLD88YxZwNc=;
        b=Xu1ET1nmvjXAUY6crjgaR39cbqwSVmVo2ScDDgeSRVpgynPUOLLekfR/OCdafkS4hP
         bfhZawflBkkwYwH2VwzGuWy7DCzAd4ZXKoH/q6aLI5a8/rpVnORkJKn+QZaWpKiLlMre
         9miXu/DVCub/uSXDfBagraPMWIufaRC8UzzkiGX+Z9/fOFXq0TU6jnlEkURMsIBcpd4+
         cQ2RbBCZlLwZp9dPYyyKEg8yKxrNT9cAur22wGnT0TZe5xSCwkEk+9mlbIt1w5G0eexA
         PzPxXN5op6KJ5MhfYL7nfl0Ig7vQzhqQh3mPBU42Ge7Vdg8v6svlDSlCkajtjaeqjW5C
         m+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZXgyLMN5uQO65wHWj6R5etzWm7XSdTARLD88YxZwNc=;
        b=L6m1K9WdL0VuBJiB6+z8yRy/SrfpAM0zdjv4HzheOSa2vPVJsibo2XZ9V+ncXjYf2L
         FYiC7S1l1Tqm+zNz/hmYXYZN+Jy+3051nmqxujut13drZRjM/PFcVi1IOzhyvFSqh81Y
         nlpUhFMb56IrPAxgLgF7P/J2kX5uDz5d6+VmheShrp++uDbAQHarqeYHZFs4qbSgtX9A
         CgD1JH6nTmearB2zCwwClE/WSu0e1Rr1KdpmCVsrQbPSUqzYFqJS6iU6VhRWYZP2KKe1
         a5bfXu3Bc1cjwCKEDpUxmIHni+m2RqaAm5noGyBHmTvlWaMhvIutn3JNEs3E2JZvdDic
         zX8g==
X-Gm-Message-State: AOAM531nD7N0UUs0eaX5DXMSbEnOdxbLCGFglvsMBg66QyMMcmqmaSLR
        fG4fs4plEn4u9zyf7WLF1SUHey9DCE8zHs+u
X-Google-Smtp-Source: ABdhPJwbDsoDCLQH6olNPLchaH7rNB+XAw15Ic2HNzwGJh633jpa3gffPWKcpLeztoyVrz5qULb4Pg==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr14481400wrw.249.1610734399016;
        Fri, 15 Jan 2021 10:13:19 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/40] drm/mga/mga_ioc32: Document headers do not make good kernel-doc candidates
Date:   Fri, 15 Jan 2021 18:12:35 +0000
Message-Id: <20210115181313.3431493-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mga/mga_ioc32.c:2: warning: Cannot understand  * file mga_ioc32.c

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mga/mga_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mga/mga_ioc32.c b/drivers/gpu/drm/mga/mga_ioc32.c
index 6ccd270789c6b..fd2160ea71fe1 100644
--- a/drivers/gpu/drm/mga/mga_ioc32.c
+++ b/drivers/gpu/drm/mga/mga_ioc32.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file mga_ioc32.c
  *
  * 32-bit ioctl compatibility routines for the MGA DRM.
-- 
2.25.1

