Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9FA2C0462
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgKWLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgKWLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB2C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so2380319wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XQiSvdHNX/l8zTX1wnsdbanAAcRSnCZFK2InbUgz80=;
        b=ITMcw66kMNj6+a35t560vvLEJp9Qh3wX0OAmVSouJIPLLOsp/LcrYRXMqRiNL1IzWp
         N88RAF/OA4LP2xGceSDMEdHSP4NCSNn2TSIa0J52t70m0+Cd5Jd5qhoE/KLjniNY96Du
         CEvjpeHeTWD7XQHNXEmghRGM3nQKcrWOIa0NHPPChpU0y7QnN4rLW1ESzUI0kG2lNCsk
         L/FNUM/285Cq7SZpdjddlkjFfHPPQV3ZKYnfwp4fh//vsODzAD4+0ePc8TkDFkGMZaPl
         dpKkd1zjRHALp6PHoTEqjG2Nt7KRy4F4csBhN90NqRTLGFbhiEeIGjVPQO9wWpcoy6jh
         eW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XQiSvdHNX/l8zTX1wnsdbanAAcRSnCZFK2InbUgz80=;
        b=VEwzXjxCctws0w57aCTjsNW9gg8uiRGxjzzLmRLwzRB+uqWzsM7kzHIIFTXFAjNPnr
         i4xIcNWOT6axiwNFx+r/lM9hQkhTjnFk4db3sEqA86vNMPYsiN5o/FHAKI/kUVb9sYM9
         x9BV6bp6t854eoZtzmC/hygJR5YIyH9hBwiF8gVJJD0QzJrodDQIR9STzzOwm75fkH1s
         J1CRd5zgDhIM/fzRQLq/qxaU741ZGzOk+5VyKbCseanTssFuM8RNBXogquNwCUGlS7uC
         QMGzyo61sDRysJxe3NllzXV00U3i44Fykl2qAT0K+1Vurvr6+MoiADw3ZpHdzMMulDML
         rwAg==
X-Gm-Message-State: AOAM530YADJw+OJIVo+hFpztHzbmtTdP2a2y8ldLJPRxwMNqR6aeuxSq
        Ifg0Dw5BjToxE0P/l/ZfwsnPCQ==
X-Google-Smtp-Source: ABdhPJxT9cxp1U8EXv22g8t43yc2F9riiqF+zpYFisUPqziMGnHw1PIj+Zfqh0lCo7aiBznqqCCdbw==
X-Received: by 2002:adf:e80b:: with SMTP id o11mr30535225wrm.409.1606130415390;
        Mon, 23 Nov 2020 03:20:15 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 38/40] drm/msm/msm_drv: Make '_msm_ioremap()' static
Date:   Mon, 23 Nov 2020 11:19:17 +0000
Message-Id: <20201123111919.233376-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/msm_drv.c:124:15: warning: no previous prototype for ‘_msm_ioremap’ [-Wmissing-prototypes]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 4d58668b80853..edc99e3b0eca7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -121,8 +121,8 @@ struct clk *msm_clk_get(struct platform_device *pdev, const char *name)
 	return clk;
 }
 
-void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name,
-			   const char *dbgname, bool quiet)
+static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name,
+				  const char *dbgname, bool quiet)
 {
 	struct resource *res;
 	unsigned long size;
-- 
2.25.1

