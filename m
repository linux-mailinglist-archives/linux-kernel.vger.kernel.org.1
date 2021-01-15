Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3DF2F838A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbhAOSOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAOSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:13:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27042C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so2965445wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/V01bC2aUdNKYNoe3MIVez12Kd/PhheE7jFqPPyQbE=;
        b=tdtp5zVrXSZ9xCEWq4wDPWmDszIKiusvcCkT6+xOPlHugBuesmhOgr3x1e4Z1OvImt
         YBwqb6DRNCPOoNnezFV4nQx8TcVWfiHyn1lz8M4xrPH4DJi5oPAofFeKZcXTlbkFMiYC
         uiVEGcGwGl2hIiDmeJ1sB2lVCBzc5Yi12NMoCTclsFDsYOwl3ulgHNosfoEeFZtm4Ept
         TK4A8V+lCzJV4yhbrKF3ikkh+h3v2S370L1myjRFFVbW1/TKrLROLVRXtwlkevNxDDLK
         VonyoP1VxEhoJbflJ3z5jzdRX9JPjqbg5KlCZ0aBbZTT6bSh50NemXefSKW21TW3Fig1
         8leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/V01bC2aUdNKYNoe3MIVez12Kd/PhheE7jFqPPyQbE=;
        b=ZCkbrFmCNGfIZCS/sxycQ8kiwgLGVtvYBP5filba/Z0SqpYeikGaucygqufGB1oM8z
         XRAbIqTwti/8QUgZqOQnaWcOGqQjhmpvfScSIyyT2QzgR0/uc4dmZ0wT0NVyRz2RenxP
         3aVvLA6XscU/M19flvPcXa3XpZrR03fyE8I+I8LHl0vLbryvnpYYattHgRhiIVYYD/vZ
         RHWbg2PnumWzbfPlFqKlNZN1F09dl8kqYfeRV+JJ60f/iiWY5IWral7ozxI5EcFLPtW4
         qeu787uPkfUDECbM51ST4SrwJ0TwYOSDObXGFosAPqjmPaUzC87CjdMEdZPYhWNFzB0f
         e1iQ==
X-Gm-Message-State: AOAM531vB174M3KQsxum2zF8AhHfdhG4krPatu26jSphTkO56Do1kQcU
        togsl8YYNmWCysZEPkwwTUuhdA==
X-Google-Smtp-Source: ABdhPJz8O7H223OuzeVo01mBK9mVPgrtOxBxrFaN8ZeUyDOApOAOrP68CCOYVdTVyzjFpfZ3U0kzcg==
X-Received: by 2002:a5d:4307:: with SMTP id h7mr14649674wrq.353.1610734397874;
        Fri, 15 Jan 2021 10:13:17 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/40] drm/r128/r128_ioc32: Document headers do not make good kernel-doc candidates
Date:   Fri, 15 Jan 2021 18:12:34 +0000
Message-Id: <20210115181313.3431493-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/r128/r128_ioc32.c:2: warning: Cannot understand  * file r128_ioc32.c

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/r128/r128_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/r128/r128_ioc32.c b/drivers/gpu/drm/r128/r128_ioc32.c
index 6ac71755c22dd..187bdc435cb54 100644
--- a/drivers/gpu/drm/r128/r128_ioc32.c
+++ b/drivers/gpu/drm/r128/r128_ioc32.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file r128_ioc32.c
  *
  * 32-bit ioctl compatibility routines for the R128 DRM.
-- 
2.25.1

