Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBA27C1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgI2JvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727634AbgI2JvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:51:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601373082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLBC9c7g+buByVnQKzb2FYeE8IkGsx3HaMgTlvR/Q7I=;
        b=SmiGjxXOyvIpS6lR1gC43a4z65e1enugRYChaAISwbbKCoIVCe0HzOW2B23AbBMtScoI0m
        tRWGctoEcBn1QqVl30Q599Szbz3SHIwDhH04KcpUhoyGZQNu38A+aTzJ1I+jW7kgg1ARl/
        uLnW5cf9GTZn8AKC5TgHBvoBN9cp5uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-5SWsxV-yNTisYFVPaJZCLA-1; Tue, 29 Sep 2020 05:51:20 -0400
X-MC-Unique: 5SWsxV-yNTisYFVPaJZCLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7037B801AE2;
        Tue, 29 Sep 2020 09:51:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5447C10013C0;
        Tue, 29 Sep 2020 09:51:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 917F1358098; Tue, 29 Sep 2020 11:51:15 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] drm/qxl: handle shadow in primary destroy
Date:   Tue, 29 Sep 2020 11:51:14 +0200
Message-Id: <20200929095115.24430-4-kraxel@redhat.com>
In-Reply-To: <20200929095115.24430-1-kraxel@redhat.com>
References: <20200929095115.24430-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl_primary_atomic_disable must check whenever the framebuffer bo has a
shadow surface and in case it has check the shadow primary status.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1d9c51022be4..d133e6c2aaf4 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -561,6 +561,8 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
 	if (old_state->fb) {
 		struct qxl_bo *bo = gem_to_qxl_bo(old_state->fb->obj[0]);
 
+		if (bo->shadow)
+			bo = bo->shadow;
 		if (bo->is_primary) {
 			qxl_io_destroy_primary(qdev);
 			bo->is_primary = false;
-- 
2.27.0

