Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5743E2B4D21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbgKPReK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733100AbgKPReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:34:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F65C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:34:07 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so19607473wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=451+tFthAljOAh2f/Wv8bktxEJYp2PVcrpZPPSF00gU=;
        b=cqC85SAbvKb4vxP7CxB9dr4lJWpnhLV/bViOX/iYNsOK62UjscaixwfZ+7HpQ6X+Aj
         bQ39omF4/4UFe9u8ru1Uka99/ZD+ipHFxL/krKYjAHVCU3ZxW/IqcAiK2X7GDyH++Dmv
         pK5DSQ7ibKOEx9THmb89wrkmPYiWTLCpogCDuvJQcuawwN8RV7vAbaoJH9hNL+XCx667
         On8f9BmcWcdjvdLMOF2P8QfE2Se3Lm6wENVAqdz3wvEHpUaCSqmd7x4b9oLSkRyYkTXe
         E+8QN62Au5MDWSB3V8KIkvypkCRpK2woa2aY9HG6Je98SQtZAkoWZaKKo2uW0KetB71f
         3/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=451+tFthAljOAh2f/Wv8bktxEJYp2PVcrpZPPSF00gU=;
        b=ZubdrLDvglN+S42vd+Iuxh2NKaXQKVbxF6V5wLeo8o15CcuIQ2zCxLMwD+wE7s0eiG
         hJzkyGOe3OFzsxv+bMQEQLngIqppZYii+TCVro0eM7RQj3fxKTgAA14wSaHj8yfLeJ6p
         ZrBEJQ1jY6+1wsqfYxJyjQHiBqwQG1/KCd5RFaPSAha42IUg7kn4OzwiUyhzw9tecluK
         6E6aKfWkzt7kcNO2QBiwOaif5f2bOfvaoaTbBRnx53RcrzdXRkAa9dOYLxpwH2iMUz9X
         1S628XI3rMSeIa3C3sLITgivYAh4AOvUBwQEKM/b6Vsrpl8ZBIDALmeqqafmrlH6ydej
         X/uQ==
X-Gm-Message-State: AOAM531/cpJsKVeZAm3EbGL+Fkbbh+ch57ITRae/hvkoV1WUZMzzggor
        WuWeqb/bTJbvkggTaaDGDzJH7Q==
X-Google-Smtp-Source: ABdhPJyl+yo4Rcg9YdVIWN89zKVW7RR+cD87UhdD72nTZQCX9fDvi1132hSNPe+g4gHZNLNSZUmFUA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr20225355wrv.120.1605548046015;
        Mon, 16 Nov 2020 09:34:06 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k22sm20178562wmi.34.2020.11.16.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:34:05 -0800 (PST)
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
Date:   Mon, 16 Nov 2020 17:33:17 +0000
Message-Id: <20201116173356.1828478-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173356.1828478-1-lee.jones@linaro.org>
References: <20201116173356.1828478-1-lee.jones@linaro.org>
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

