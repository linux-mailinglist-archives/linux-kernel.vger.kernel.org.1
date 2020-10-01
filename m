Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE9727F6BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbgJAA3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbgJAA2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:28:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:28:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c62so3609416qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHwLeNxlSJ3EARNPo85Hd8uD6D75QyiXLjXUxQ3hUGI=;
        b=h2x0wFzInna9YMHm6P0E45wxhWqOBWVDm/5zBlqYzYT4O+zpDSeC9+usBXBspL62HD
         Wfv7Ck+wGjMx4j8GuFzu9r3pWufd0nNC8QO9JoPCAXUIGkKOGKngUH46ySm8X9sKqB8a
         816F5UVIAD0BKewbdsOW0CInM2tocN4lJ47jE0QBX3SYgFPMKuyV1vMWLYj4KvdohZ6r
         UbfqiADYWHyGsRN8OTHzlsfdwVOdG1jq89HRP6bhewKbDdRqXQqdQpGmCwsLdyghD/gJ
         OuXfQgly0EIrIvfxvBZytgDWZMavQ3L9n3Pq/itHqczsZpsu0mHS4Zvl2+PrEfZv9GV7
         Y38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHwLeNxlSJ3EARNPo85Hd8uD6D75QyiXLjXUxQ3hUGI=;
        b=kW1Fvysw47c+Wuo2qMYiVFFQNdxE3jDnZCeozcHMEi3m7kB5OvH3sYpumBpSAkUkCx
         W/TQyFKZTzBFexSprFcgN39PaC2ZRUUWMaG/dAf9zsFRbhlb0gOjVux+ZjUQgRMB3JyL
         gk0aHOt3YrE/mC5wvDR9Iim+LOVDAgF8Xf+Y0weN2lyU5smRQnYN6kPWEAuVEvrx3FVY
         D6CPnYtqzwqmSuR+3OwymLgqycn+N+/bnhoccnGDS+NaH0nWflYibdL6xTqtXYEh/uGN
         2IUhkm1+MQtiwV0OjbrdgKnoChj7coFDa7aVqqrStMWe8GeMHg2yearsGt/R7PB1MjX7
         dFgQ==
X-Gm-Message-State: AOAM531Mh9tm13EiQWadJAAvn+w5gdw8DhZ9TlewMq8kW5RKJGyq3uOK
        hSHfCsNEkqoe5lHt4CuByRQE0A==
X-Google-Smtp-Source: ABdhPJzLw800gfk1oonIT2sRo5VEKRKUttkzTSShle7j0kaa4WtY3ECvUdcXfd6YrGcyNPASiRd03Q==
X-Received: by 2002:a37:952:: with SMTP id 79mr5223335qkj.57.1601512133978;
        Wed, 30 Sep 2020 17:28:53 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 205sm3850908qki.118.2020.09.30.17.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 17:28:53 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm: bump up the uapi version
Date:   Wed, 30 Sep 2020 20:27:06 -0400
Message-Id: <20201001002709.21361-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201001002709.21361-1-jonathan@marek.ca>
References: <20201001002709.21361-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the minor version to indicate the presence of new features.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 305db1db1064..502aafe7d1e6 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -38,9 +38,10 @@
  *           GEM object's debug name
  * - 1.5.0 - Add SUBMITQUERY_QUERY ioctl
  * - 1.6.0 - Syncobj support
+ * - 1.7.0 - MSM_BO_CACHED_COHERENT and DRM_IOCTL_MSM_GEM_SYNC_CACHE
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	6
+#define MSM_VERSION_MINOR	7
 #define MSM_VERSION_PATCHLEVEL	0
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
-- 
2.26.1

