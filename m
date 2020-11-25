Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0412C4904
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgKYU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729175AbgKYU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606336033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyv7TmTJOo07L0V0MDDH9iBw1ZsQzWrWnebIO9wiR7I=;
        b=idKvmE6JeGaS+IwH1UaEilqG/aLRJ2w3Jp3hzRdPFGel9FjL3sUo+2PncCzNiJ1lMva7Sw
        pLTpifYG7EkLd1C2EKLBmaXu9W4+qPwyU7/WCGVkibzlGN4g4uSjYi9uPWScTr+yQfo8VF
        pwViHHKE1zMt6Nv6LkU6k/DbhnSkKbI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-qyDbXV7KNci47_7KxVU5tg-1; Wed, 25 Nov 2020 15:27:12 -0500
X-MC-Unique: qyDbXV7KNci47_7KxVU5tg-1
Received: by mail-qk1-f197.google.com with SMTP id x196so3288703qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyv7TmTJOo07L0V0MDDH9iBw1ZsQzWrWnebIO9wiR7I=;
        b=TyOOCzfKkmWsOYiBfkcSsyQmhuhZKG5oeHsiFuyzcHZGLJ70BzhnyVh9ddsfrTLeoP
         xAM7WM/BX57Aab1zsdV5gon8VRDgUNv2WwLEOnatuIBcBl2y8qq0ml2WF2NJ2Jjzs32g
         ZeADxxM4hEl0QG0cQXD31N/+Nh+RngsnaK9fdxvzMxVfRpEkwlOYZ9O9CSYd9V6TtWa4
         hLa13iOmi+W5IVJa3Lp53ec21GyVThNI0kcpXl/ROiFrjhTFQE3sbkU9pEU5QM6QLCK9
         oWQnkJJH0SzKLGFBrV/YTHTo/l6oensp9C5Rm3NXmfkHO/0OWaKNYl2oHIaxRwI8rin6
         xLKg==
X-Gm-Message-State: AOAM533tYrzTmhTlv3uOOumUYJe5GcoMjp3Qdc2GesEvjGSZyqQISqXc
        t66ZrlWPcPLiQOB+ohnRIFO8tZ9rJpJ1aqhvJGEFParJb3vrqpirgNKIJiNmncwleRhqbfHnZP2
        MSC6/N7To5QG62kfoN+XyBaX3
X-Received: by 2002:aed:39c2:: with SMTP id m60mr663842qte.206.1606336031654;
        Wed, 25 Nov 2020 12:27:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKH4xIOuYE9iphSs67b2xooUR1MwfVJh1L82U2A+W+f2xs7dI2EaoZEqdNs7n2LbREsN/4Fg==
X-Received: by 2002:aed:39c2:: with SMTP id m60mr663825qte.206.1606336031489;
        Wed, 25 Nov 2020 12:27:11 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a638:b301:9966:d978:493:6a3d])
        by smtp.gmail.com with ESMTPSA id o187sm431772qkb.120.2020.11.25.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:27:10 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/nouveau: use drm_dev_unplug() during device removal
Date:   Wed, 25 Nov 2020 15:26:46 -0500
Message-Id: <20201125202648.5220-2-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125202648.5220-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
 <20201125202648.5220-1-jcline@redhat.com>
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

Cc: stable@vger.kernel.org
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

