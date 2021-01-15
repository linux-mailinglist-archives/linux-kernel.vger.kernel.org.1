Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D52F83EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbhAOSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbhAOSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737EC0617A3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d13so10175849wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEPxdikffcTW2XPBOoX0ED37z3NmpTHI0lnPWz6mmx4=;
        b=elNfSM6dpymdVu7cXnuqL/DyR6BGtAJr1JNqz//XpUL5XJAzQV5/ybGb5qx/p8vqkd
         eDpo+SxY14xZcS3DkqCIoGM/ppMnX50g9C+A0KjCvVHdTJwrUrfpRyUhQCl7rHqqIIv/
         kzFFqsbookfXD72VlfD/4p/ixKXwsrx/l/Z8tVCR1ONjmeCdVMdGOK8LhKhm4tH3bnST
         NKGf5s6rEgwqlqLe3P1DWP9cFKUHn/HfYtkdjsMvkaXqTgaRU+iDWcK9BM33KpKTtOEs
         gk6Zo8Bs9IFT8Kt7v36mznUsmWa6uYU0fjD2nptZf0ThRXkPGfT2zmAn9B4egyZQYRm4
         607A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEPxdikffcTW2XPBOoX0ED37z3NmpTHI0lnPWz6mmx4=;
        b=cnp1DdkY4Zr1cvI1VII0G/kBPDZeACuEctj2696CqD2d8I2ZvFf4VbVvQGBAowthPp
         ngH7W9F7bgIdzZwUl0/33G6nr3zN35+j5XITglslBGPDxuSQoFt8vQfUCuXHMvS+bFQl
         pn/AAVWPnBHbEm/8GHq9slBJaqnI7pdbz+qnYiTz3zGiTNfD2fdWHrqCU7Vy0/N3klcK
         jt4GSTxkfUTDGkcgsWr8PYKM8zwRfgSL9tL7JZzYj9hHV+N4s7Re2sQ8FSFQpj4kGESm
         GTEETYj98xrMvfWSXF2pKFRd754ylY7GRukXCTLk02NWHyIUOIyzeP1WdGjFnlCXVkZo
         9wgQ==
X-Gm-Message-State: AOAM530EVSqqQJ4womwUrOxkca7DnJwPP0/89w6m4C0MXghTfyA8UNTF
        UvfdUqyHERKG1pNqzYaQy+8WDQ==
X-Google-Smtp-Source: ABdhPJx9fUXhSGU2SF0jAgigDyWvaMoz7pHYrsOUFdwXDwpjlpmnzjzCUrVTtzojo8Xb3TAl/uMPIQ==
X-Received: by 2002:a5d:56c3:: with SMTP id m3mr14531708wrw.419.1610734583554;
        Fri, 15 Jan 2021 10:16:23 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/29] drm/gma500/psb_irq: Demote kernel-doc abuse
Date:   Fri, 15 Jan 2021 18:15:44 +0000
Message-Id: <20210115181601.3432599-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/psb_irq.c:134: warning: Function parameter or member 'dev' not described in 'mid_pipe_event_handler'
 drivers/gpu/drm/gma500/psb_irq.c:134: warning: Function parameter or member 'pipe' not described in 'mid_pipe_event_handler'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/psb_irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index 361e3a0c5ab6b..5cceea9be5348 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -126,9 +126,8 @@ static void mid_disable_pipe_event(struct drm_psb_private *dev_priv, int pipe)
 	}
 }
 
-/**
+/*
  * Display controller interrupt handler for pipe event.
- *
  */
 static void mid_pipe_event_handler(struct drm_device *dev, int pipe)
 {
-- 
2.25.1

