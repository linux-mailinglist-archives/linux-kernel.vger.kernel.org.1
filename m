Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66540218EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGHRnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 13:43:14 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:57525 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgGHRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 96E702F2;
        Wed,  8 Jul 2020 13:43:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=5v/JxHYRjEm06
        HfWmpOo/iRfMTrkdyUtw3p2YG8NduI=; b=JF1RcpJ+/2MM/6zrgfo/2SWV0t1Z7
        Il0Ea4ReVfsU2GdDp0e+GMyk+vMx7+nl8NS+gQbJT2Wu7wt/6aX7tUJ7YnrC8Z6s
        hbynI6f+B65SuLBDsDIVRBiUpPduyT99SwRB5wJLtiGpw7J92lxGluLdzTPpRSoZ
        rEkR9hAdtaz8jY1NRQFdE8SBAMMtY8TXkraGsh0+Pr399L9J7BtQui+b+3mh4YSo
        0by9rxt4HbVyVlvjS/8mGcmOc3B1/Xai9sIZqujPXhukooDPhop9Zy9hI7S6bCpy
        QBf/voC5ddQqH+80NkET0BpzBGYZkoJNs9iMqXl5mwPLkuucuKAFzt4rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=5v/JxHYRjEm06HfWmpOo/iRfMTrkdyUtw3p2YG8NduI=; b=D3N65toY
        0w2Gi90htQXR6SrKXAYFRHwy4nJl18Xjzh9GHizQlwqevDSl5evd1k3++A5lyiQS
        BEUgdCqsbeGukfdbMqlyWHv7m38GrtfOHvz8hxANOtlRnA+DAGd3y6YCQ8sMTVlz
        tkLl7mw31wfDZtEfK0Vi32GgutGxObVhNNkRexJWlcnplgTaYWJon5fhjq+ahdBw
        U2UuMu+NSjy6IxsyYNEgUfCjPmG6PM7Cgh5YoRTjDKjIJZv1J5VPyjAXgXV6cXll
        lsk3BBENERO+L8uyYfW3G9XXpDRJRIdX1sER2gY8hOai42lGobqiCYBxQTLf9AKY
        3113/Rk54F8WSQ==
X-ME-Sender: <xms:rgUGXwNsHe8nOt_rDVGN_cBIhBR-wIN1Rl0OQHXwXQUA7kdaIBfugA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rgUGX2_LS7MzxqOfQ1JzAXF0hTcL_cuYV00ANAlFYU9ev58FyLvP4Q>
    <xmx:rgUGX3SwvzPTNQrneZPtPZfDvfhohD39Xu_SuSwQXWJL_JaZNbTK2g>
    <xmx:rgUGX4vF-cjVdm0CblRhV5-WBdCidWpyjhVCqv2PIyDXdWjN-_JCng>
    <xmx:rgUGX2sPi97aEBGqugsKeSudhCgWhjFAkJRwCBGmhuMTMsKwv0WU0m-d2c4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D38C430600A6;
        Wed,  8 Jul 2020 13:43:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 27/78] drm/vc4: crtc: Move HVS channel init before the PV initialisation
Date:   Wed,  8 Jul 2020 19:41:35 +0200
Message-Id: <03aa26eb5be1c558e3048a3b4ff3214856d5c490.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid stale pixels getting stuck in an intermediate FIFO
between the HVS and the pixelvalve on BCM2711, we need to configure the HVS
channel before the pixelvalve is reset and configured.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 2c5ff45dc315..b7b0e19e2fe1 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -427,10 +427,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
-	vc4_crtc_config_pv(crtc);
-
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
-
 	/* Enable vblank irq handling before crtc is started otherwise
 	 * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
 	 */
@@ -438,6 +434,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_hvs_atomic_enable(crtc, old_state);
 
+	vc4_crtc_config_pv(crtc);
+
+	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
+
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
-- 
git-series 0.9.1
