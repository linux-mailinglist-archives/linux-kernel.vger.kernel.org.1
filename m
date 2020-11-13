Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB52B1C89
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKMNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgKMNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:24 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D6C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:24 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so9966399wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=451+tFthAljOAh2f/Wv8bktxEJYp2PVcrpZPPSF00gU=;
        b=pe6e21nu0qjtMO7L/dhgnVP1pOLq2uLl2Q603f2mIEfsxLZ4RIF5ndrN5ElCTk5gBH
         qQChgdrqm4R3PWyX5mMgOaxx9OkofEfBCcsS2ylOlDJ7yGlIIK5W9xGGJPcsDPMjho8J
         0j2P0H2AQeAsAZf+VeoXuXFXESasVb2kJfTC2fFe3IqwTvNbzmL61XTiAJLVbf//ktvE
         7wgdTtkmRnKSQmwwcqNylRCy7SZdv0M1aolSP2I49SYf0yYufITdguFUZ3pxAGSsFjQ3
         3Wi/1IjSnNLf+E/nmecH+3SNI7gxA8ulpguIdKsungNlVSzRdzgfEjtTVghmCWTbEB79
         ZvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=451+tFthAljOAh2f/Wv8bktxEJYp2PVcrpZPPSF00gU=;
        b=PVBwsGTh5cCpCpWcOx6Oc1LADODp5bbBKBf/Oyg3n6jJ4pCVAGK3/Z6qsG0UDiSeGu
         qXBOG3NFKsDwhk+CoNNTDfAJKAEe+vm/qadWg/SH4VRaMqyniTU9BKZpKn6kTDkO4YYU
         9Y1jRunKB9nJ8RAngB+nkqDcVJ9T+tNm7NwrVsGQhMwcp2u3wfqac3vZrv08M8LBBC0y
         H7FcZTrUrwWvTy6f9l2ixlmLkEvxy7WYjTOd2yMdv9LS+/+OS3EdqDK9kNDpUMRRMe23
         2NHfcfKH3tJ+AmN8gbQuXe5dY9S7ScRyDmrR981Qca6+BUmF65+KGghRno5WytBKZERO
         GcaA==
X-Gm-Message-State: AOAM5338QDJbTyqSKr8fnHEcekSYEEsY8PH193FqGr7f9NTNBDHhQT7X
        fG3oWIDpMTvi1x3e+VMXpiCQBQ==
X-Google-Smtp-Source: ABdhPJyjledgKwa6fPP8UYFTcytP7jLttiwL2vQI0keB72vsOIAUvnnP5rtBVPtFkTM4WWb/v+5bVA==
X-Received: by 2002:adf:f852:: with SMTP id d18mr3466397wrq.232.1605275423174;
        Fri, 13 Nov 2020 05:50:23 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 33/40] drm/drm_dp_mst_topology: Remove set but never used variable 'len'
Date:   Fri, 13 Nov 2020 13:49:31 +0000
Message-Id: <20201113134938.4004947-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/drm_dp_mst_topology.c: In function ‘drm_dp_send_query_stream_enc_status’:
 drivers/gpu/drm/drm_dp_mst_topology.c:3263:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index e875425336406..0401b2f475002 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3260,7 +3260,7 @@ int drm_dp_send_query_stream_enc_status(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
 	u8 nonce[7];
-	int len, ret;
+	int ret;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg)
@@ -3281,7 +3281,7 @@ int drm_dp_send_query_stream_enc_status(struct drm_dp_mst_topology_mgr *mgr,
 	 */
 	txmsg->dst = mgr->mst_primary;
 
-	len = build_query_stream_enc_status(txmsg, port->vcpi.vcpi, nonce);
+	build_query_stream_enc_status(txmsg, port->vcpi.vcpi, nonce);
 
 	drm_dp_queue_down_tx(mgr, txmsg);
 
-- 
2.25.1

