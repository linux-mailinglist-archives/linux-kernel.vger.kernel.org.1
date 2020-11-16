Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686BF2B4E58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgKPRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbgKPRl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so60238wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=451+tFthAljOAh2f/Wv8bktxEJYp2PVcrpZPPSF00gU=;
        b=XGCk6s8gC8Z7wwqz/yakD2Actx1/SDxlJWpn6VZXYaCcZgwFWPIiwikiWrSfoDH1CY
         eoyz/KluCphA/lJ1/dcnuK8uF1wLI4GwD2IuYSvn/QpePKLy80V5b4ResvbhO8AJSa2h
         AuO1DEYoX4OcOKEvamcX7MR2cFDcfgRQZD03tFja5kLg+EDyqI2PN0WelbUbGJdFWcR9
         qsLBgHOvcP5PeWWLWZVF/7/MPWWr0mXikaw7doM1MvCg7vjAv9VGWYC/Q/iK7T7Cp4Kz
         O6mdYmXV4Nt/nd9+89fMr8shFLkuMiT9zKMRumtWDe5SfMO3vzuOjAqn2sriZEQUbxGN
         gsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=451+tFthAljOAh2f/Wv8bktxEJYp2PVcrpZPPSF00gU=;
        b=OaKCMU8crcLlmZqh+aUZR8mS4Ais0ghywKiWq299OU3FEgLzPgj5iQEpDQj3QaDwTG
         jsBQbz3FkQS9eLSuhmEHuBICojcNQgEZ+/hKNDLfh8PVAVPaKWKPLZYXet/3HrEqnPpR
         lN4zHJnU4Yz62l2bkzZeaB6kqt+nE3RdGacFbYXU5Xs7KoIVwgEBqXe/ExTmRRz5fwa1
         6fJ7h20BhlBXO5KS0pKLJpQ2Hr24eVFA3WcmfmPCeEG252ah7NBsI9XUlZ3vwEIZQlQ+
         1wxdfQ9wmd6M6MvDeR2ka4rg0p5P7hnPUOffS3dYeyRsEu+I8XrXPgrvYVYPnTKmQAzi
         +Vnw==
X-Gm-Message-State: AOAM532RpG8PprjIyPhHR8pIULV+2UqroBeQX83ML9ZH5zYuSufFeZSM
        GC7APc5JnCvr5iDTBnZn9nS7OQ==
X-Google-Smtp-Source: ABdhPJwZBZpSzy/6KpIKdwNmgKx3o+w5BcHKVqsUZqBOvYAmzytj7ySLSeOcE9qh+eybQ0AMFCy/Vw==
X-Received: by 2002:a1c:b387:: with SMTP id c129mr37255wmf.58.1605548483095;
        Mon, 16 Nov 2020 09:41:23 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/42] drm/drm_dp_mst_topology: Remove set but never used variable 'len'
Date:   Mon, 16 Nov 2020 17:40:33 +0000
Message-Id: <20201116174112.1833368-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

