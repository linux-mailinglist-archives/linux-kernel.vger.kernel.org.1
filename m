Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FAB2A818C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgKEOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgKEOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9FEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so2105236wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F0IbdwxDH4j9csyHE4k5O0hxf8H6de2hTqN1yOLzedY=;
        b=N+9AOKvoS24VvDcMunCNgXiSgEzn4l1Am+g6ZNVSMuDooX+deYX5oJWAtDt2A/EY7P
         yu7qk3VrkH4ysHxosDjcQ3bnH0IqqYgA8oDzrmdEZ+6XvcGJB0/FuPE6rBVbsp5AUXgZ
         EWV+I+CJ+vGh87wbE4wS80cTatwtn1fWimWEj0k0qZoc6SlqOr2p4cw4V2A38vfgdee8
         DMLYwv/qszAuBohW0aF12ct7lTy5aVTld1e93cPR1FDuoGp59nKpIasJVfXe21/I/v8D
         cw8wTIwy9TvvdDfQNJP9ewj/6V3gn3mlSaVcOVW5mkKS2NkaVcjq8IDhIDnGR2klyvRJ
         hjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0IbdwxDH4j9csyHE4k5O0hxf8H6de2hTqN1yOLzedY=;
        b=IYakUDJa4tJ3oOYQDuTlJj4dXpc7ixJkeHVwDpVGw5l9uCXBy3xwbTIhYNCov6L3bN
         rCxCl7wzublXAaKsTBq8N5utzR7EpjlEFDhm92RyE0gGOt+0D82JNR97bz+nFH9CcTQG
         T4b1ZiPXUGN52yoFrCNgc4yEaCs5jmIZMazmwQF7ZH5J2WEhDF1SkoNXfOTN1vuPL4cZ
         CzASBacONiioRigH3HwQMPHbrtkOV6Nr5ZA29zMyu5TJeKfOBkqMxxQbQ+QuTR/wZ5ZA
         fIpqSxwmpVQHrgwYLAr+RCNJh+FbolyiufVsp8nvdQCQPDomwwKqvPAjtwN2jLYLi7QS
         xPpQ==
X-Gm-Message-State: AOAM533/r1FjMLSx66JtQ4polm61+WYTgoGu1u6FtezA0TakXHk1UzkX
        Od90YzTh5CAImqESre+B4mC25Rv65A3og/AG
X-Google-Smtp-Source: ABdhPJwAkqDrGU58mpfo9/oDp9kDfWjs3etPOM56QRr6g6b6lprxLixxEpoU8gNb6/mzmV66ghlueA==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr3641178wre.40.1604587950781;
        Thu, 05 Nov 2020 06:52:30 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/19] gpu: drm: ttm: ttm_tt: Demote kernel-doc header format abuses
Date:   Thu,  5 Nov 2020 14:45:11 +0000
Message-Id: <20201105144517.1826692-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/ttm/ttm_tt.c:45: warning: Function parameter or member 'bo' not described in 'ttm_tt_create'
 drivers/gpu/drm/ttm/ttm_tt.c:45: warning: Function parameter or member 'zero_alloc' not described in 'ttm_tt_create'
 drivers/gpu/drm/ttm/ttm_tt.c:83: warning: Function parameter or member 'ttm' not described in 'ttm_tt_alloc_page_directory'

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 8861a74ac3351..3190bafd8b783 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -38,7 +38,7 @@
 #include <drm/drm_cache.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
-/**
+/*
  * Allocates a ttm structure for the given BO.
  */
 int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
@@ -76,7 +76,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 	return 0;
 }
 
-/**
+/*
  * Allocates storage for pointers to the pages that back the ttm.
  */
 static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
-- 
2.25.1

