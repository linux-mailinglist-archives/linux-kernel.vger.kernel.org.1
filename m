Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25282FCFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbhATLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388964AbhATLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611141171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pW7S5BR/oz31kBJ4qqUftWtIKqk6Gjd3VXDhM7F8wlk=;
        b=LCfsKf6SQnlENRXim+CSqMcpmwP7H2Xf+s0MB4jRgCvY3gP26uxkPe1XEv60cNulf7BCHM
        Zzg5Lm/ap39H0JdhrVP+uHYp55Z/m7QjYNEdmy5dKP0Zjer7nnFjZNyXY7fIC2i854Zd57
        E5/maR9S5Sy2vIDca99/MfoldoisOaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-BzTxaFA9MfOPVBO_lG72Jg-1; Wed, 20 Jan 2021 06:12:49 -0500
X-MC-Unique: BzTxaFA9MfOPVBO_lG72Jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3BC58018A4;
        Wed, 20 Jan 2021 11:12:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F2F070498;
        Wed, 20 Jan 2021 11:12:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0C3BC180039F; Wed, 20 Jan 2021 12:12:41 +0100 (CET)
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
Subject: [PATCH v3 2/4] drm/qxl: unpin release objects
Date:   Wed, 20 Jan 2021 12:12:38 +0100
Message-Id: <20210120111240.2509679-3-kraxel@redhat.com>
In-Reply-To: <20210120111240.2509679-1-kraxel@redhat.com>
References: <20210120111240.2509679-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balances the qxl_create_bo(..., pinned=true, ...);
call in qxl_release_bo_alloc().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 0fcfc952d5e9..add979cba11b 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -166,6 +166,7 @@ qxl_release_free_list(struct qxl_release *release)
 		entry = container_of(release->bos.next,
 				     struct qxl_bo_list, tv.head);
 		bo = to_qxl_bo(entry->tv.bo);
+		bo->tbo.pin_count = 0; /* ttm_bo_unpin(&bo->tbo); */
 		qxl_bo_unref(&bo);
 		list_del(&entry->tv.head);
 		kfree(entry);
-- 
2.29.2

