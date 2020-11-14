Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5452B2DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKNPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgKNPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:21:14 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB897C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 07:21:13 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d28so12422562qka.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8trkRjP9UFPyJqjxFvhkrNselLfEoUHaVtNBCoJ4XCk=;
        b=tAvkwqI5UxVZLosgiy2dth1kE1mcObUnNjCIF6g213uhCAWBHnRRh5fpxcrgw4xb3v
         FZ7NpmkKli8Co1oMfBaarPj3K76JK44Ml1lkgtKkBh09QtZQ3+zfv1uswWhXd61y4bQE
         j/X998FoLQ84iWpWlrUVOo/Q3OBuKZs9cqij5UWCtakg6o/hSjfI+DtG0TBdUATP99z1
         gRiqRqcuyqK46TknWsQIXmrU0QiaF+mSHY13qSlOKkOoJQg6DbBkqlrPmB0OQzbY/isO
         +v33fhTuN3YUdRVIzPhPZJQDAlEazj2T3f5zJHglATLeKtFoLgiRU9C+AwUzyYMLEkv2
         EkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8trkRjP9UFPyJqjxFvhkrNselLfEoUHaVtNBCoJ4XCk=;
        b=sw2YP59q2iLjinIx38gy/Yz6OiVAu9cuiB+2808w8UMONBzDBH57teteqM2zDEz8a8
         KGuLkJ4hRYjtoji6nA4RXyqBkFdpG5gJ05njqMQtgDFYapLoet8+lKSVdv0vvPnHg2uJ
         BWU1wZVKph2mW0ZXVzRnzie0UGv+rXgLItrGJiGrY46AGCf5vHe3k6H1G54ejEm3ws8k
         47OMvn0Bg8NPOBdBjcyxlt45ROwQ7YqCHqui5nYfWlbl75isklBIrcX5s+LVapX8jX06
         EReI5RpbbN6MbsT8c99NmzQ2I0zAE51Tz7o0p7UT57Tx4RS9+FRK6HAtuN9D7PGxBpri
         ewbg==
X-Gm-Message-State: AOAM533k/pG9b59r2FYQte8rvCc3MOX8MkkPucI/duSLgXqpffW8Ea4S
        FEuhZ13sHPldNsdavqdecjLMmw==
X-Google-Smtp-Source: ABdhPJwk2smqvgptEJnw46UBkqHH5sjXfXDGxlkv1FFfTWhR+COGK7v2Bg8xIbe+LZRJgTPMlPpQFg==
X-Received: by 2002:a37:de08:: with SMTP id h8mr6941400qkj.0.1605367273113;
        Sat, 14 Nov 2020 07:21:13 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id h125sm8888368qkc.36.2020.11.14.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:21:12 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org, hch@lst.de
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v2 5/5] drm/msm: bump up the uapi version
Date:   Sat, 14 Nov 2020 10:17:13 -0500
Message-Id: <20201114151717.5369-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201114151717.5369-1-jonathan@marek.ca>
References: <20201114151717.5369-1-jonathan@marek.ca>
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
index 3f17acdf6594..7230d3c0eee5 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -39,9 +39,10 @@
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

