Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9F12B29A8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKNAPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgKNAPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605312901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEUE8BEt/HHRBsioHGD0oe9yvnlWjkF4Cv9LZW4QV9w=;
        b=eP3kvHHhSpZlJue5sZ0VXKazCnHTyRjcufWkhjxyi7UTF5kYIqzN7E6+iYT9s1ZSod9Jt/
        UnTC2HrtfTofunrG1bceW+fBWDK4c+mNUO+FM3v5pWO/FeVKCzUUBstTEwbOEXgbAwiV25
        mwmwxM8W9JVPDUgM0l9weRm+khrhMrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-vosWtSBlOlO7ntrw3MStZw-1; Fri, 13 Nov 2020 19:14:59 -0500
X-MC-Unique: vosWtSBlOlO7ntrw3MStZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2FBF85C70F;
        Sat, 14 Nov 2020 00:14:57 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-115-66.rdu2.redhat.com [10.10.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8D6760C15;
        Sat, 14 Nov 2020 00:14:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/8] drm/nouveau/kms/nv50-: Use nouveau_encoder->crtc in get_eld callback
Date:   Fri, 13 Nov 2020 19:14:16 -0500
Message-Id: <20201114001417.155093-8-lyude@redhat.com>
In-Reply-To: <20201114001417.155093-1-lyude@redhat.com>
References: <20201114001417.155093-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_encoder->crtc is deprecated for atomic drivers, but
nouveau_encoder->crtc is safe.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 63fff3988f19..b19d0d7a6de9 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -630,7 +630,7 @@ nv50_audio_component_get_eld(struct device *kdev, int port, int dev_id,
 		if (!nv_connector)
 			continue;
 
-		nv_crtc = nouveau_crtc(encoder->crtc);
+		nv_crtc = nouveau_crtc(nv_encoder->crtc);
 		if (!nv_crtc || nv_encoder->or != port ||
 		    nv_crtc->index != dev_id)
 			continue;
-- 
2.28.0

