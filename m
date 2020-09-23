Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60297274EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgIWCOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWCOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:14:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:14:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y1so13410245pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwWFLVcsl8hY0toIAd3WE4dUvBpqlvZYT4x8hQzEp/c=;
        b=ISsDGXn+cWfkSQWsM/dsabiEgxRAik26IWpYhWuxsBEePLy2o3V8KOOsYDi3JcLhz+
         K+bGAmKfDVVtkBkTXeRtPhOsplEGAhuQDKex7V5b1f2Q23444sGFMe5SM7ec3PdHZxea
         Sr9ZNu5PLRxndnKyi+UItnLo36mICgO9D5r7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwWFLVcsl8hY0toIAd3WE4dUvBpqlvZYT4x8hQzEp/c=;
        b=oSSnueYN0qbfRILsdJZwKzrve3t4mDHvUkL44pAQY9DTtjBTzmS9FH/f13k4DaOK9/
         E0YeSJJJz+B3w4010GR1I1wd+UcKbA8y97RXYwtp/srE2BjuA3SkFsTajM1aIOnaMSX4
         za2tv3vGGB/CWdamjeQo34ZlKhrIy0ZS0x7NvTPtzebuVmPJktPhMHVeMcF94VwfJd+2
         iGOLsSc8vCroR/q+SJMngHmDqdnnF45qzFxEnFYCIc08i2rQ0Sz3jk3pawSAQzCHsa6S
         VeKHnswse0mu8FF5z0K5neVvd9TZ/uVVeLhW56Cjh7KZ0sLW2PAzwrad4Py0HnEJHyg2
         gW0g==
X-Gm-Message-State: AOAM533WcNXqaBvqw100/wzDWSRJY7apL6EAGUUkIOIYtL4kd+P7aAFo
        Xt7RhYJB67ASnmAOZx/gYz8JtUvCFDXQZw==
X-Google-Smtp-Source: ABdhPJxLxVTqKyMSoZHyDDric81McwvV6shEQbZIbXA8MW3tWMyMUFMlDcPCq/eEuRaybPTZxTiVsw==
X-Received: by 2002:a62:1902:0:b029:13e:d13d:a12e with SMTP id 2-20020a6219020000b029013ed13da12emr6793083pfz.22.1600827252292;
        Tue, 22 Sep 2020 19:14:12 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id co3sm3298687pjb.31.2020.09.22.19.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 19:14:11 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sam McNally <sammc@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/4] dp/dp_mst: Add support for sink event notify messages
Date:   Wed, 23 Sep 2020 12:13:52 +1000
Message-Id: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sink event notify messages are used for MST CEC IRQs. Add parsing
support for sink event notify messages in preparation for handling MST
CEC IRQs.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/drm_dp_mst_topology.c | 37 ++++++++++++++++++++++++++-
 include/drm/drm_dp_mst_helper.h       | 14 ++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 17dbed0a9800..15b6cc39a754 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1027,6 +1027,30 @@ static bool drm_dp_sideband_parse_resource_status_notify(struct drm_dp_sideband_
 	return false;
 }
 
+static bool drm_dp_sideband_parse_sink_event_notify(
+	struct drm_dp_sideband_msg_rx *raw,
+	struct drm_dp_sideband_msg_req_body *msg)
+{
+	int idx = 1;
+
+	msg->u.sink_event.port_number = (raw->msg[idx] & 0xf0) >> 4;
+	idx++;
+	if (idx > raw->curlen)
+		goto fail_len;
+
+	memcpy(msg->u.sink_event.guid, &raw->msg[idx], 16);
+	idx += 16;
+	if (idx > raw->curlen)
+		goto fail_len;
+
+	msg->u.sink_event.event_id = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
+	idx++;
+	return true;
+fail_len:
+	DRM_DEBUG_KMS("sink event notify parse length fail %d %d\n", idx, raw->curlen);
+	return false;
+}
+
 static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
 				      struct drm_dp_sideband_msg_req_body *msg)
 {
@@ -1038,6 +1062,8 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
 		return drm_dp_sideband_parse_connection_status_notify(raw, msg);
 	case DP_RESOURCE_STATUS_NOTIFY:
 		return drm_dp_sideband_parse_resource_status_notify(raw, msg);
+	case DP_SINK_EVENT_NOTIFY:
+		return drm_dp_sideband_parse_sink_event_notify(raw, msg);
 	default:
 		DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
 			  drm_dp_mst_req_type_str(msg->req_type));
@@ -3875,6 +3901,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 			guid = msg->u.conn_stat.guid;
 		else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
 			guid = msg->u.resource_stat.guid;
+		else if (msg->req_type == DP_SINK_EVENT_NOTIFY)
+			guid = msg->u.sink_event.guid;
 
 		if (guid)
 			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
@@ -3948,7 +3976,8 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
 
 	if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
-	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
+	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY &&
+	    up_req->msg.req_type != DP_SINK_EVENT_NOTIFY) {
 		DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
 			      up_req->msg.req_type);
 		kfree(up_req);
@@ -3976,6 +4005,12 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
 			      res_stat->port_number,
 			      res_stat->available_pbn);
+	} else if (up_req->msg.req_type == DP_SINK_EVENT_NOTIFY) {
+		const struct drm_dp_sink_event_notify *sink_event =
+			&up_req->msg.u.sink_event;
+
+		DRM_DEBUG_KMS("Got SEN: pn: %d event_id %d\n",
+			      sink_event->port_number, sink_event->event_id);
 	}
 
 	up_req->hdr = mgr->up_req_recv.initial_hdr;
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 6ae5860d8644..c7c79e0ced18 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -402,6 +402,19 @@ struct drm_dp_resource_status_notify {
 	u16 available_pbn;
 };
 
+#define DP_SINK_EVENT_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR	BIT(0)
+#define DP_SINK_EVENT_PANEL_REPLAY_RFB_STORAGE_ERROR		BIT(1)
+#define DP_SINK_EVENT_DSC_RC_BUFFER_UNDER_RUN			BIT(2)
+#define DP_SINK_EVENT_DSC_RC_BUFFER_OVERFLOW			BIT(3)
+#define DP_SINK_EVENT_DSC_CHUNK_LENGTH_ERROR			BIT(4)
+#define DP_SINK_EVENT_CEC_IRQ_EVENT				BIT(5)
+
+struct drm_dp_sink_event_notify {
+	u8 port_number;
+	u8 guid[16];
+	u16 event_id;
+};
+
 struct drm_dp_query_payload_ack_reply {
 	u8 port_number;
 	u16 allocated_pbn;
@@ -413,6 +426,7 @@ struct drm_dp_sideband_msg_req_body {
 		struct drm_dp_connection_status_notify conn_stat;
 		struct drm_dp_port_number_req port_num;
 		struct drm_dp_resource_status_notify resource_stat;
+		struct drm_dp_sink_event_notify sink_event;
 
 		struct drm_dp_query_payload query_payload;
 		struct drm_dp_allocate_payload allocate_payload;
-- 
2.28.0.681.g6f77f65b4e-goog

