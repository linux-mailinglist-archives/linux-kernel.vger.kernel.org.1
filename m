Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34A2747CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600797256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alwBugiUW8xhAC3yh9HKqdv3Lr5JciXw+OErJT8eH5U=;
        b=SYsHHg1rongJPRlFKYcIZmt9oHGNM9qG94BYs7ppAGLL615JyBTbnP6sgdw24vG2NrrLZw
        rsbMBUePQwaidXDk6nGU/pSbwAoX1oPnr4xIIubOWy5EH11tLA/PcHdHqQsXBGsXhpKYdB
        qBUmqHhLmZSyUQ1Q1cfg5v3u1A25tsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-8Soh6L6WOce9OXEe3dfgMw-1; Tue, 22 Sep 2020 13:54:14 -0400
X-MC-Unique: 8Soh6L6WOce9OXEe3dfgMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D3D186DD29;
        Tue, 22 Sep 2020 17:54:12 +0000 (UTC)
Received: from Ruby.redhat.com (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74E8C7368D;
        Tue, 22 Sep 2020 17:54:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH 1/2] drm/dp: fix kernel-doc warnings at drm_dp_helper.c
Date:   Tue, 22 Sep 2020 13:53:56 -0400
Message-Id: <20200922175357.42998-2-lyude@redhat.com>
In-Reply-To: <20200922175357.42998-1-lyude@redhat.com>
References: <20200922175357.42998-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As warned by kernel-doc:

	./drivers/gpu/drm/drm_dp_helper.c:385: warning: Function parameter or member 'type' not described in 'drm_dp_downstream_is_type'
	./drivers/gpu/drm/drm_dp_helper.c:886: warning: Function parameter or member 'dev' not described in 'drm_dp_downstream_mode'

Some function parameters weren't documented.

Fixes: 38784f6f8805 ("drm/dp: Add helpers to identify downstream facing port types")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 90807a6b415c..478dd51f738d 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -374,6 +374,10 @@ static bool is_edid_digital_input_dp(const struct edid *edid)
  * drm_dp_downstream_is_type() - is the downstream facing port of certain type?
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
+ * @type: port type to be checked. Can be:
+ * 	  %DP_DS_PORT_TYPE_DP, %DP_DS_PORT_TYPE_VGA, %DP_DS_PORT_TYPE_DVI,
+ * 	  %DP_DS_PORT_TYPE_HDMI, %DP_DS_PORT_TYPE_NON_EDID,
+ *	  %DP_DS_PORT_TYPE_DP_DUALMODE or %DP_DS_PORT_TYPE_WIRELESS.
  *
  * Caveat: Only works with DPCD 1.1+ port caps.
  *
@@ -870,6 +874,7 @@ EXPORT_SYMBOL(drm_dp_downstream_444_to_420_conversion);
 
 /**
  * drm_dp_downstream_mode() - return a mode for downstream facing port
+ * @dev: DRM device
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
  *
-- 
2.26.2

