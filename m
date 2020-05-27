Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3031E484F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgE0Pug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 11:50:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51305 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729818AbgE0PuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 32812582074;
        Wed, 27 May 2020 11:50:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=6Oe8Eug7eQDXt
        mN82ebKfvpSmt8HaYdF7dwjSqGj6vE=; b=qESqrgYVNbtJSTD2SVgywHLBwLNgQ
        Fao7SrluL2qTa6kHYjQ7Vb6+mdiWfGBdCxz8rHSIr38yq/ulv5taXugxfxIb22wR
        ZDIMCjO6jVf4Rir3XXvfPBPzTHZeCV+BaQ0OkWCbQ6SdBxiUf6HepzkiwZQRvWjL
        9xLgwB1kZvN6XChu0Bue9yRGTroa5iQHiNmGHKJxDOrYc8k5msoNpq5jKxhfRu7e
        g8ClLC0lyAWuY0Mn36XuwcEg790pmBOCTfz3yYEDtpAU0Lg9hZcGsV+0s74x1eJG
        j+oaAF5zakt1zKnKBiEkAvpR65k21g6LJTRksuusTonvgQ8OJ/6u13VWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6Oe8Eug7eQDXtmN82ebKfvpSmt8HaYdF7dwjSqGj6vE=; b=GdDbO9dO
        ch2NXw6qZeWNE6OcH3HmIR0HzjVnHZup3XqBCuM4HewBM+lHaj+mI8DbpqcCW4KR
        8RasJPfRtQVGSlNwbvY8xgF0lFlDX6N7tH79509qkTVle5D1e31xajwAwd+1Hv07
        ATlkdBSKNV9mdf+SXnhHJTYhWtyAs5c5FJmHgGgmyBnLNb3qAtnwLf0CtfTtO8QW
        CY1agT89hfUB8/uEDFGx8WWQP8rMGUlA/mNMXk49QldnVUTcYWUznF3pyXb1idHP
        J6RtVnhXXBUv490dsSL5h8XVAsoyNoZqogULwnrABTE00PJGMRLJCs/dgXoueMYb
        45J1ECakTzp1xg==
X-ME-Sender: <xms:OozOXhMV1-_CyoXxD8kFU0PvbozWTvfB8Y3Ia2CirdOCkMM6FHFMRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:OozOXj8n_Yppv_wnReMeCexpcsDrsAU1WFvrP1zT6wCxjtH4afo9qQ>
    <xmx:OozOXgSogGZa6E5nVnJOHb5LTXqhZMRgFP5L5ZH_uuiqRjDYsHvpAQ>
    <xmx:OozOXtuNTtzdATgt4SftCOgz4FNL6HOl7C5FDeQiN_0wTqhhF7wSzg>
    <xmx:OozOXjv_ip-OlGo6bw9ng0WR7bNIeSHvyTtOPScd_JvACS95PVVI5Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE47A3280060;
        Wed, 27 May 2020 11:50:17 -0400 (EDT)
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
Subject: [PATCH v3 038/105] drm/vc4: crtc: Remove redundant call to drm_crtc_enable_color_mgmt
Date:   Wed, 27 May 2020 17:48:08 +0200
Message-Id: <e576f64eacbcd2a7e4f8f0aabeb5b7e340561a59.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls the helper to add the color management properties twice,
which is redundant. Remove the first one.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 07e23f76451c..8a3fe4d39847 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1199,7 +1199,6 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 				  &vc4_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &vc4_crtc_helper_funcs);
 	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
-	drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
 
 	/* We support CTM, but only for one CRTC at a time. It's therefore
 	 * implemented as private driver state in vc4_kms, not here.
-- 
git-series 0.9.1
