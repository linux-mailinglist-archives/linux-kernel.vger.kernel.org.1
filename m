Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368B28265C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgJCTji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgJCTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601753976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1IoI0EkrFuvdFZWNYyFFEEON1f+8fthEHRT5ClyKvFc=;
        b=XTWPcQl2VGKiyVPzobjfPiCrfJnUo5MEj+9T2DnSaj2J87Fy7l4VDYSY+P1gfxV7OQXJkR
        FJ+bcKGeN4MKGN4tuRgOO+w2lMk064Z9S6294edPdo/3kzxUKBMAJi5OZZyN8coErzClML
        kg8doqCb4YdD025fy1U9MCUXTAEXSc4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-1PKujCumPHmrO984cm0rHw-1; Sat, 03 Oct 2020 15:39:35 -0400
X-MC-Unique: 1PKujCumPHmrO984cm0rHw-1
Received: by mail-qk1-f198.google.com with SMTP id j5so3655491qka.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1IoI0EkrFuvdFZWNYyFFEEON1f+8fthEHRT5ClyKvFc=;
        b=Gpl61JiPu/n49VL2lIsu1HaRWi34oV0yRwOUlKrdaNmTA5GBgauqFJhU/hWzbgpYJy
         xODUzI/VPXPQMfPcUH+UsafutiqCu1dQ21skczhBpUfFtwbz0OQrACFKpt9ckGJF2dk9
         b7QyoBybaI8H28zK5Ql043SOc44dV/d8Cxkx8fCYl5NSF81xeKPwpnybS8wjcxsXjO6W
         N3vNCNbzX/hszF1nSUnYYtaE2MMSdQbrzf1m9JzPd1kgDGifuUrt20F6Y+vAR/J3a7me
         8gE9INRTFC2Em+RbYkufsUeiElEOu1qFzegJQLe9i+iCM4kQeQXj5j1c4ZDscysFezdh
         KpTg==
X-Gm-Message-State: AOAM531VEYEAtLCSElUicR7Ke+OfZyNhn8qasiQ2h2JRIQsp2WRf1ygi
        xIBibO7vq3vMKK7SXbwuXvTcczQ3FL1iPzbgBwU6hu0RmBg0ahYyq9KnwyjYxZGh8hOyEMGdvvN
        SOKcHe97mzoONlC3Q+Ug7aHkp
X-Received: by 2002:a0c:a203:: with SMTP id f3mr2723794qva.33.1601753974803;
        Sat, 03 Oct 2020 12:39:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4M/pjCxAlSDw6JNZ0/Bzg4FRDd44Ah4W5DbfR+Md9/Z2wSoRt68Ug7QOcM+nGmpJrw5BOBg==
X-Received: by 2002:a0c:a203:: with SMTP id f3mr2723789qva.33.1601753974628;
        Sat, 03 Oct 2020 12:39:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r187sm3730335qkc.63.2020.10.03.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 12:39:34 -0700 (PDT)
From:   trix@redhat.com
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        natechancellor@gmail.com, ndesaulniers@google.com,
        alan@linux.intel.com, airlied@redhat.com, yakui.zhao@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/gma500: fix double free of gma_connector
Date:   Sat,  3 Oct 2020 12:39:28 -0700
Message-Id: <20201003193928.18869-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem:

cdv_intel_dp.c:2101:2: warning: Attempt to free released memory
        kfree(gma_connector);
        ^~~~~~~~~~~~~~~~~~~~

In cdv_intel_dp_init() when the call to cdv_intel_edp_panel_vdd_off()
fails, the handler calls cdv_intel_dp_destroy(connector) which does
the first free of gma_connector. So adjust the goto label and skip
the second free.

Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 720a767118c9..deb4fd13591d 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -2083,7 +2083,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
 			DRM_INFO("failed to retrieve link info, disabling eDP\n");
 			drm_encoder_cleanup(encoder);
 			cdv_intel_dp_destroy(connector);
-			goto err_priv;
+			goto err_connector;
 		} else {
         		DRM_DEBUG_KMS("DPCD: Rev=%x LN_Rate=%x LN_CNT=%x LN_DOWNSP=%x\n",
 				intel_dp->dpcd[0], intel_dp->dpcd[1], 
-- 
2.18.1

