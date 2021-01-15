Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74342F83DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbhAOSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732557AbhAOSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4DC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 6so2911567wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0iVILfCe9Q5cRcFeOSW9WvBexCJRHav+Q3xWBDxDaM=;
        b=AVHrSt6WQH1H/WKVov8I+ShF2hDc7oVn8PibmE8jXXlDIrSpdtFjvTaFMYo7yQQh1E
         8siLsj8/YVEJYu3SlMKDds60GTn6kRrDv7Dlna9STM5wkb9OMkYC+MJaHLUosF0P43T/
         zI7Ex9gttZUjKfm64Ziyysc9tuz1dvmU2dLT+rX5YEY8XGJnteos5tn/dDZbva26EIg1
         Fa2SAP1haIrUIn12LGx9p8prbF8HE3nWsmpsYoQcwFROY0QBT2XMfqlg4Z4rfkgLY8bB
         i7BKoGOneo4BauGuDDarqrJ37V6ttc+xTkiXBRsNolZoS7jZTmd4n1kjULeoyKddPwpm
         C6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0iVILfCe9Q5cRcFeOSW9WvBexCJRHav+Q3xWBDxDaM=;
        b=Oz4QNurIMSrnsN2ESx78EXrkoOTiRkqun/4Uudx7tIHb7YlQ5IjpYmtWPCgxBdcpCK
         SEhWK1NiLfpM/RKl2KInF6TxqMXx5ViWg6Xs+KvJk3X6KfNL3ymClj7hqdBuunwDBE9n
         6wv39QwgyXOGmmEh6jHYl2VU5QBN3/5yRpr0+PV4DZym4q3Ak6tpLWkfjV5kRoLvysAh
         pgZb+fhynJVYL0m/D2p72YBXu2d33+prdLM5ozvKoRC9mkaSNxEQ4mqRaP8VBRqCZpSe
         QArtfnVkrZJfH0c6q5U24ZI4p/niig6R+aHFxXpS+b5HKMj3nWLKrIpP+cEbCzn4IoBH
         g6aA==
X-Gm-Message-State: AOAM533tWdcCST7pkNtkeEHgqMRFBlIrjkYFtDGQOEnP1AKURS/Fa7Pg
        nL26qj5qjriLMulVDn9C9+2fNg==
X-Google-Smtp-Source: ABdhPJzhVRxpTey/n7ZbeueuVV4J8bOk7G4YtYdQwoJ9VGq5SQ9VTTnokSb8dyvMnQOTsHVWMChPOg==
X-Received: by 2002:adf:ec92:: with SMTP id z18mr14789883wrn.166.1610734580564;
        Fri, 15 Jan 2021 10:16:20 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/29] drm/vmwgfx/vmwgfx_thp: Add description for 'vmw_thp_manager's member 'manager'
Date:   Fri, 15 Jan 2021 18:15:42 +0000
Message-Id: <20210115181601.3432599-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c:21: warning: Function parameter or member 'manager' not described in 'vmw_thp_manager'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c b/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
index e8e79de255cf7..eb63cbe64909d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
@@ -11,6 +11,7 @@
 /**
  * struct vmw_thp_manager - Range manager implementing huge page alignment
  *
+ * @manager: TTM resource manager.
  * @mm: The underlying range manager. Protected by @lock.
  * @lock: Manager lock.
  */
-- 
2.25.1

