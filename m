Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F827C1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgI2Jvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727660AbgI2JvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:51:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601373083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7VcobJF6uyWmgL5vmwuoyYLR7D7rwBPhHFHQDDI+jU=;
        b=WvSTpYhmbBOKXQX9qewutzU9/aj+rMPezrax/1XhwKdE0YPBW8WZa+XwVY+PHdzp5WGLUQ
        8Sijo9sAnKFFkWgq2VJJ1Oqtj7ihvfLnHLzo0QG0kH6lToC2AzNuBqKnQlDOwt0MvfysHo
        ++QqXROfMmWxdSVEOIzGWHt/QMHLQpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-vkhqYCmMOjSawZD1UYOkUA-1; Tue, 29 Sep 2020 05:51:21 -0400
X-MC-Unique: vkhqYCmMOjSawZD1UYOkUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4DC8801AE3;
        Tue, 29 Sep 2020 09:51:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EDE47880B;
        Tue, 29 Sep 2020 09:51:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AC8AA358099; Tue, 29 Sep 2020 11:51:15 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/4] drm/qxl: use qxl pin function
Date:   Tue, 29 Sep 2020 11:51:15 +0200
Message-Id: <20200929095115.24430-5-kraxel@redhat.com>
In-Reply-To: <20200929095115.24430-1-kraxel@redhat.com>
References: <20200929095115.24430-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise ttm throws a WARN because we try to pin without a reservation.

Fixes: 9d36d4320462 ("drm/qxl: switch over to the new pin interface")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index d3635e3e3267..eb45267d51db 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -145,7 +145,7 @@ int qxl_bo_create(struct qxl_device *qdev,
 		return r;
 	}
 	if (pinned)
-		ttm_bo_pin(&bo->tbo);
+		qxl_bo_pin(bo);
 	*bo_ptr = bo;
 	return 0;
 }
-- 
2.27.0

