Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680A319DEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgDCUDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 16:03:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30234 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgDCUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585944228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u8hLZsj2YqQxSgV0Txi9THZdrIA9G0FOv6QX9kTj3Dc=;
        b=Nnzx9I2dA149QEL8+qUq+hzw0BKFEXpv62hwYoaB/mc4QIlJDfPfcc5Kt6LG79hPcvMnZ+
        B+LUnX5Co1jKVGHthlUCpHgoEL52Sal170d8hL5ach/foQBCZC3SXny4EPUWYqxnH9mTeg
        aQbqlowNSbgtBRKf9ZVwFMbo90tBrxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-RaBLvtOdN-WS7Iz132o6gQ-1; Fri, 03 Apr 2020 16:03:46 -0400
X-MC-Unique: RaBLvtOdN-WS7Iz132o6gQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6614E1005516;
        Fri,  3 Apr 2020 20:03:44 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-203.rdu2.redhat.com [10.10.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFE7C96F83;
        Fri,  3 Apr 2020 20:03:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Wayne Lin <Wayne.Lin@amd.com>, Wayne Lin <waynelin@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Don't drop NAKs for down responses
Date:   Fri,  3 Apr 2020 16:03:25 -0400
Message-Id: <20200403200325.885628-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like that when we introduced the ability to handle multiple
down requests at once, we accidentally started dropping NAK replies -
causing sideband messages which got NAK'd to seemingly timeout and cause
all sorts of weirdness.

So, fix this by making sure we don't return from
drm_dp_mst_handle_down_rep() early, but instead treat NAKs like any
other message.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: fbc821c4a506 ("drm/mst: Support simultaneous down replies")
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Wayne Lin <waynelin@amd.com>
Cc: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 10d0315af513..5449ada3e019 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3813,7 +3813,6 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp=
_mst_topology_mgr *mgr)
 			      txmsg->reply.u.nak.reason,
 			      drm_dp_mst_nak_reason_str(txmsg->reply.u.nak.reason),
 			      txmsg->reply.u.nak.nak_data);
-		goto out_clear_reply;
 	}
=20
 	memset(msg, 0, sizeof(struct drm_dp_sideband_msg_rx));
--=20
2.25.1

