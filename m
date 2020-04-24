Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2051B79AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgDXPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:35:50 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:37961 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728119AbgDXPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 790AD21A;
        Fri, 24 Apr 2020 11:35:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=oZbHyorDMwxbH
        Trhcz5bQgGX8lBzLk2euuxNjsSWUtU=; b=de+tScs0+fH3Dvipipex7eR5MnhKh
        whu/s+v+bx6eyycWJEpLX2U9rR1LqBKTipXQKVOJAbsvfPpm/kan34eYFxjBvChq
        QWaNt1BVOzgEMdNhGZ9Dgnww1lG4MKmCj5XecBEiqGGe4H0q5txJuum1vxjHheNS
        s2c7JoQ9gbIeWnVFmKWGzuo1zKaMSDTuFFIuZHCZF5R+AoMVD/CcNBVZQ7Q087ee
        aKUWgdiFa4lK1lA704pEhuFQgm1XEv8uYRk8l3JqLsPsCceOfGpWjthr0783ySfL
        ZOEcRFxebYKrq0vXDsjbmKUY70OLV2PGlArTLPh2HFhBxPKpSd1ot6Y0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oZbHyorDMwxbHTrhcz5bQgGX8lBzLk2euuxNjsSWUtU=; b=mSURwmqm
        rc6YByRngmj4OpQsKVqjwqg0DhMBMcIfVPHb0Z26k2MTXZf1LdRiPQQVUlmIWu2K
        5Qu+Mt7a5urUl5zIp5xJD4Ssq5d8pGJCjp7raC2T1tLVHfftkFNieGfXAfIwJWcu
        C9qD+Ep1V4RaSzRDO/UWe/O0nh4/uwVCkk78NLfviZgYMnKS6WMh1ZHz06SWYO+3
        xkBAIiTdimJDbtfMIyHIB7udlkGZZBrkBIzo4STTiNSma/qJEu5QlIbVOjGSu1Rk
        w6gz1A7dNQGpNAJWkXmhV8NGpK3bc5WO3GqKVaRwyPR9HkdBibYF7k6jTUfALwzL
        aE6uRCPuR3ozPg==
X-ME-Sender: <xms:UAejXrRO2JOI4Drncsl8BVXW3EOjiwjlYn_up4i1umjEs6eCjGLUEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduudenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UQejXhUGwQdkOMa4L61hlUmmpFOV9OXeJb2KQ5I4aMwg3KOpC1_EMA>
    <xmx:UQejXmT4sqmTZ8aa_Q8LLMKUrvWqWlsl9qJ0Y5z0oXDJ4nmPa9sGgg>
    <xmx:UQejXtoCfCNzaSDIZZ_eg5iL8lPhR7fxFH3s5PcDDIHakyuE8eMUWw>
    <xmx:UQejXs9Uybv06yOeISYAJ5lvEW8UlMkinjr8HzEnirPe5IKNDaglnwnfYTw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B518B328005A;
        Fri, 24 Apr 2020 11:35:44 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 16/91] clk: bcm: rpi: Rename is_prepared function
Date:   Fri, 24 Apr 2020 17:33:57 +0200
Message-Id: <1ec4bbfd15358c85f076ea3d0670747bfa62796a.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberrypi_fw_pll_is_on function doesn't only apply to PLL
registered in the driver, but any clock exposed by the firmware.

Since we also implement the is_prepared hook, make the function
consistent with the other function names.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 6e8977b70e38..99201f58a609 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -87,7 +87,7 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware,
 	return 0;
 }
 
-static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
+static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
@@ -170,7 +170,7 @@ static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
-	.is_prepared = raspberrypi_fw_pll_is_on,
+	.is_prepared = raspberrypi_fw_is_prepared,
 	.recalc_rate = raspberrypi_fw_pll_get_rate,
 	.set_rate = raspberrypi_fw_pll_set_rate,
 	.determine_rate = raspberrypi_pll_determine_rate,
-- 
git-series 0.9.1
