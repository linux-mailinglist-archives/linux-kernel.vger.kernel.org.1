Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1242A506E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgKCTto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgKCTtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604432981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRgALKeAwL3sx0iS2wQ17fqCri52qNRN6hAIi0XVJ6g=;
        b=aazAQSWc0yT5LBJG1baWSUxw8kzAnKorwU9nhDsRwU23FfX6fBPALUoJ2DyPZIZvVJrmrB
        NMCNpvogYChtP7g3p57hht98UU7Dh5xWaNUSCAJqIRZV7CZ38RFIrkn/ZyrscR2oW7Dmu+
        Stg53TiQeY2wIEMbQOdncqELexfsCCY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-iL4W5xoiOY-9899Ng1yweA-1; Tue, 03 Nov 2020 14:49:39 -0500
X-MC-Unique: iL4W5xoiOY-9899Ng1yweA-1
Received: by mail-qk1-f198.google.com with SMTP id z28so8868265qkj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRgALKeAwL3sx0iS2wQ17fqCri52qNRN6hAIi0XVJ6g=;
        b=UM8qltt3nuLSFvd30j6vNwkRKayhuH8q5cC4jDnmTI1Jny9Ru4qlXiisY12F5C5Uip
         nFifsTtZ7XuzL1uTMjMxNbP69j5lP5tgcpk5AO83dyFR4X+/xYh6W01FJ5hFCeSkuhdZ
         G3bUAgpWrX3xu5l8XBuiix44LucuYlyZB2M/ER/EXYfLXCqglkH2n5RDbLc5BPFTsxrn
         0D8Rs5bvE8zBw0R9fcr1rSurKmm0WNKVV8FgFnTMiCi6vVAG2qdY1AzNfsn5n4g8shar
         UrrM/KyjYM6X86ue7eLUURPlkN2zXo20V1WnUidYk34UMKG6AN14w5B8zqkpCWDkt8Ho
         KHvw==
X-Gm-Message-State: AOAM531J1Fh81hAW57p1Nqkx6WXuY1SJXFM/rGpts+6AEGRfl96AEtKu
        7KaVqr8urRZ4yinhIEdpcppFVWEK+knw/KmxRl3Y1KZ1OJLOVePlI1WjH7KgI8WqSCWomRlxLOY
        iXxUhPYyuoq7+5HBoZruE1RSr
X-Received: by 2002:a0c:8143:: with SMTP id 61mr28273242qvc.6.1604432979408;
        Tue, 03 Nov 2020 11:49:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxe2/eHvm2y4cYBO5/HR+vq0YC4gRRvwFqseWsvRM6ddEbcIT1VL9RyJKhYkXTPnfzfIHbvuA==
X-Received: by 2002:a0c:8143:: with SMTP id 61mr28273226qvc.6.1604432979204;
        Tue, 03 Nov 2020 11:49:39 -0800 (PST)
Received: from xps13.redhat.com ([2605:a601:a639:f01:1ac8:8e0c:f1cc:7a29])
        by smtp.gmail.com with ESMTPSA id w25sm11392532qkj.85.2020.11.03.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 11:49:38 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 1/3] drm/nouveau: use drm_dev_unplug() during device removal
Date:   Tue,  3 Nov 2020 14:49:10 -0500
Message-Id: <20201103194912.184413-2-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103194912.184413-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nouveau does not currently support hot-unplugging, but it still makes
sense to switch from drm_dev_unregister() to drm_dev_unplug().
drm_dev_unplug() calls drm_dev_unregister() after marking the device as
unplugged, but only after any device critical sections are finished.

Since nouveau isn't using drm_dev_enter() and drm_dev_exit(), there are
no critical sections so this is nearly functionally equivalent. However,
the DRM layer does check to see if the device is unplugged, and if it is
returns appropriate error codes.

In the future nouveau can add critical sections in order to truly
support hot-unplugging.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index d141a5f004af..4fe4d664c5f2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -792,7 +792,7 @@ nouveau_drm_device_remove(struct drm_device *dev)
 	struct nvkm_client *client;
 	struct nvkm_device *device;
 
-	drm_dev_unregister(dev);
+	drm_dev_unplug(dev);
 
 	dev->irq_enabled = false;
 	client = nvxx_client(&drm->client.base);
-- 
2.28.0

