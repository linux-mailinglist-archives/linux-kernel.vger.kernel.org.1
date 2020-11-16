Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC02B4E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgKPRmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbgKPRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:07 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:06 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m125so40553wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5fAxh5tnngNJF2VB/FxBFEjPf9+WnphDOVk5YyhPg4=;
        b=QGRS8dZaH4fBWVeFr/tutZKDHKcWCbSLtvBJ+9LmydZVFOhD7SoaCJwz/AwgWnKNOI
         BtJRrGzbvgoEtzBAzr3h9RoBz0y8vIror5Qqj3f9+6BQuwYmegEcAX8emgB+5Da1twow
         ct2u0AdI9tex8VkIHsjHo/NAuIACwN9gMqK2km3XnTjhr7hGq66KQwWMIW0WChyVgaIV
         tISXrg5wv0aiYg/ONBv0OQwOix0LQfwBpS8KIBBd03tzn/zC4qOzJwuzTGus7dXT4eL1
         nDYHFF1S8jXG02wW0XX9sfC4vRpPRo13z4F/rQ4322u/7rMXIsZmJwxfd6dAXKDoBLeD
         4Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5fAxh5tnngNJF2VB/FxBFEjPf9+WnphDOVk5YyhPg4=;
        b=IoxnbyLuTQpR6xOdEwymDuWECkbO0WCxzE1UE/OAPQe03kKpXzuk3pQHU/AXAA+fXz
         p6DEbjNefTiW9GL06hxaBMsB8sBSUiVd71aklyKyPiyuWagL0hcrvik7nqmszaKBhw1O
         rqd+8aMo7QRWMYQpgRhJaLqZnSxLi0IISoHNChCOkVj4Fuw29RFvdme6irBQ7EVFBNG4
         D5lzOJ81LRnvLb9XRJDupyyv4/KJHUcIKBrV+gZl7T087SNAtXQP9AS2wZTIaWKg34ij
         KCmI9O/cwbBXwizdnoLIs6ik9NRrJfM95zsb6eqQw45A7WMjFXywopq0k9zkZYbQ3CL5
         t1LQ==
X-Gm-Message-State: AOAM531gBHa1WyMm0sF5HE6fAq6X+9IWKRCbmk0vINTzeWr1fcI4GfRr
        Ovfz3hShmV29131yvFaIIc5EjA==
X-Google-Smtp-Source: ABdhPJyX+vq2jy2gK34lUOqKpajZ7ybNU67R2lMx+cLVP+zfYtJjk9BfCDO9pecgpeu16QDZ3Qry7g==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr16301052wmg.93.1605548525472;
        Mon, 16 Nov 2020 09:42:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 32/42] drm/ttm/ttm_tt: Demote kernel-doc header format abuses
Date:   Mon, 16 Nov 2020 17:41:02 +0000
Message-Id: <20201116174112.1833368-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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
index cfd633c7e7643..da9eeffe0c6d7 100644
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
@@ -73,7 +73,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 	return 0;
 }
 
-/**
+/*
  * Allocates storage for pointers to the pages that back the ttm.
  */
 static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
-- 
2.25.1

