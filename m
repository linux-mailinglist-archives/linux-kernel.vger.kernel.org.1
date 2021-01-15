Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7E2F83E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbhAOSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbhAOSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E34C0617A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w5so10180559wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYtw8GzoU8Bqr/iSnXTLs/UzdpcC7+8OaiBwfsZ40Oc=;
        b=U8irOcupICW0AmAfXBUsHfVL2wyDZgSXZaObAH//1x1fRMn1cg1To4KbPNc5oTas1c
         apyd8AV8gA6lEiNxVwlntq8O/K6LORf9JQhFMZ18wqw2aYzxYeHPD69K5vZ7lLX3pWf3
         9KrGDXnG8CKL/7C0pIiBtaML3+s/HHkifHwl3ZCSwnQLeqXuU+k/A6BrZmP7BUWf9iJx
         Gw0bof7iS/mi53tvZmrFuhxB8rPE8DwM3m3P325uwrmUYMF2vXLq+3QZZU5kEN74w9bT
         zL7O8AojKXlr0DS1tU3U5WOy4IU/UJizeFIaJWuvtY0Ls/UrPhlKLFZ13UOquviqGxem
         JuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYtw8GzoU8Bqr/iSnXTLs/UzdpcC7+8OaiBwfsZ40Oc=;
        b=IlbLokmAdRUqWgjkzZ/q9pMX8qwEDkLdQXSLDWDqdiz6t77au2QQ79SXI6MUwnSO18
         xYzVLQzbzGCdkahWzjqSXanZaez1sdECMJzhO1Wz67zjJS0bcQz7Znj4vRblj+LCDNeh
         EhTFSAiDfDyntzQa27OXcTrr/9CB5gpmfyYVEKsNJCDcTY3a5XDS5rkf2J9ApTYahTMC
         xIw7Fa2GqX8rCvLWdoFPYYQnUn2V+k7IvyVNiMOBX5nfxvRPgo/U5aiBSmEwAKNfa6vw
         k8fMBYxSAXtItH+6aVeEH72XVGfSLoBJHsZwjiBraikUYLKktJCH4u97bq5u1B13ieSV
         PM4A==
X-Gm-Message-State: AOAM530Jgxky/v06na7dJAnS6nCLTmgEDTN/RkumK771YhNgaDPHylM5
        SF9ZswCqmQqy1BVc1Z0rVTk/Gw==
X-Google-Smtp-Source: ABdhPJzOfZs8jm74WsjZlxRA+7WSux0MsT67QoSS9lraOoJ6f+Z54JPLseMY3Fajw43W4AUhQrbFDA==
X-Received: by 2002:adf:c444:: with SMTP id a4mr10946428wrg.164.1610734421283;
        Fri, 15 Jan 2021 10:13:41 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/40] drm/gma500/intel_bios: Demote non-conformant kernel-doc header
Date:   Fri, 15 Jan 2021 18:12:49 +0000
Message-Id: <20210115181313.3431493-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/intel_bios.c:581: warning: Function parameter or member 'dev' not described in 'psb_intel_destroy_bios'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/intel_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/intel_bios.c b/drivers/gpu/drm/gma500/intel_bios.c
index a3b843316f4e5..d838369f01194 100644
--- a/drivers/gpu/drm/gma500/intel_bios.c
+++ b/drivers/gpu/drm/gma500/intel_bios.c
@@ -574,7 +574,7 @@ int psb_intel_init_bios(struct drm_device *dev)
 	return 0;
 }
 
-/**
+/*
  * Destroy and free VBT data
  */
 void psb_intel_destroy_bios(struct drm_device *dev)
-- 
2.25.1

