Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625BE303A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbhAZKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732295AbhAZBfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611624841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkyBCaxpi8H1R0DNiKM+lg2FeT0gkdHb7L2bg0FqRCc=;
        b=Wyvxxg77XD7LwMnh9Mf6MCaIcGVpzMhehcX1qR4OqdVsaTjgZitLYFkGDWpWKdLu5oRwOY
        MJutnEwtjun0Qh1Jy3MrueiIDp2IgPPsIKgOrn3C2WM85ZC25DCMfNEjHiLktCYrxNFszl
        2SMupxaRjyMyQ6rQYLdVhqROkoQosEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-70sqUjxxN8GDLAei5qoH7A-1; Mon, 25 Jan 2021 19:10:42 -0500
X-MC-Unique: 70sqUjxxN8GDLAei5qoH7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE912806674;
        Tue, 26 Jan 2021 00:10:40 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-118-245.rdu2.redhat.com [10.10.118.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F29F6A050;
        Tue, 26 Jan 2021 00:10:39 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@gmail.com>, greg.depoire@gmail.com,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 2/5] drm/nouveau/kms: Don't probe eDP connectors more then once
Date:   Mon, 25 Jan 2021 19:10:28 -0500
Message-Id: <20210126001031.881048-3-lyude@redhat.com>
In-Reply-To: <20210126001031.881048-1-lyude@redhat.com>
References: <20210126001031.881048-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDP doesn't do hotplugging, so there's no reason for us to reprobe it (unless a
connection status change is being forced, of course).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: greg.depoire@gmail.com
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 14c29e68db8f..f4d16576a7da 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -556,6 +556,12 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 	int ret;
 	enum drm_connector_status conn_status = connector_status_disconnected;
 
+	/* eDP doesn't do hotplugging, never probe more then once */
+	if (nv_connector->type == DCB_CONNECTOR_eDP &&
+	    connector->force == DRM_FORCE_UNSPECIFIED &&
+	    connector->status != connector_status_unknown)
+		return connector->status;
+
 	/* Outputs are only polled while runtime active, so resuming the
 	 * device here is unnecessary (and would deadlock upon runtime suspend
 	 * because it waits for polling to finish). We do however, want to
-- 
2.29.2

