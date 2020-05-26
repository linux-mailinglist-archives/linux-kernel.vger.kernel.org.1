Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FCB1B79F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDXPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:37:28 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:51589 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728806AbgDXPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 239A11461;
        Fri, 24 Apr 2020 11:37:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4gbeJ1neY6PRy
        YOdg83Vrr06ONFPkgKT+hUqnCfpgBE=; b=mdGJxBOifSOZqThxFw3YXh8yGaDd6
        MGEuJAWGCzK/riXQpriKW1fhqkGbgwxtdYoRbA4bRCxRjyKJ7A1hDi2GIWD54GoO
        1Fc2iBufdiO0z8oaNsCz4jcs+G6vZbP360TohdrtPasaEl0/yH3yTCSg2kUFoHeB
        kRJE6wdhCQckWuvzrQPlw4dm2IHsyPTT8n8eQWN9Rqi+9HAtyQxBkm7uptbCc/Y/
        2uZW0n5xg9VSjus5R9qtK9IFs2Krm5E2as8nRFA1jUpOdWWtrQDQjLsNVpxmEJij
        b0inZLsmfbSBiDbBCIbwCBeKL1OkPmdk1hR795+Wp/pkSu/ctz7IOTEmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4gbeJ1neY6PRyYOdg83Vrr06ONFPkgKT+hUqnCfpgBE=; b=mBpc/h/J
        OSXmQXe9kdtItqzbEApSrqmoDo1518f7XUtj53bLqBmACQRA1QQs8MZfJ2IVQE8N
        X2vW3IuzBb3vk92d2n6u0hDdveJ/PDN8lTmuRs36Vv9V/QDYSTuGtmiGT6OefXhV
        fcq1wj7GPSRh3E1sWAUg/J2QuN+Yl27UQ+caG4g7le77RR74awNEiuB178C+yej7
        730P3H+Irewv2peDiaq+cPn55Fka3WtolDBPnS9HVts0rIg01dFxIGUQ6WNkp3Z2
        +q6KtW/YofQcn5Acvsmy0RCBXjqNYZ5kNgWzInMAMt+NNNBsMu2uAZv7u2C1Oweo
        u8n/IGuAGQA5zw==
X-ME-Sender: <xms:qAejXj561ZX2016MkOY8O_Addumprkxr61VZPb0RMl4hyCPGiVbu4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejtdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qAejXvMISqCJYKyU5xw82jpL2h_bOZ86n-2uvPaG9J1lM7v2kekuuw>
    <xmx:qAejXgeXIK8Zhx9LJH7SGIaqAfv6qJ8c1shB3ghbPltUw8UlNlHXaw>
    <xmx:qAejXhc5AYRU6Km3OM_AX_-MgxszADui9pVx1Uu2cmWOYh3D0zMdXw>
    <xmx:qAejXq-qM9Fhob-GzMmJInOwRIvZQ2S3ti7nq0J1a2W7TTeFjovTzG2tdmM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 738C33065D9A;
        Fri, 24 Apr 2020 11:37:12 -0400 (EDT)
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
Subject: [PATCH v2 79/91] drm/vc4: hdmi: Deal with multiple debugfs files
Date:   Fri, 24 Apr 2020 17:35:00 +0200
Message-Id: <4cd617827cc28875ef36f3632122a83cff2ea4a7.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI driver was registering a single debugfs file so far with the name
hdmi_regs.

Obviously, this is not going to work anymore when will have multiple HDMI
controllers since we will end up trying to register two files with the same
name.

Let's use the ID to avoid that name conflict.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 ++++-
 drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index aaf96420d0ec..aae5b10a2d11 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1377,7 +1377,9 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_destroy_encoder;
 
-	vc4_debugfs_add_file(drm, "hdmi_regs", vc4_hdmi_debugfs_regs, vc4_hdmi);
+	vc4_debugfs_add_file(drm, variant->debugfs_name,
+			     vc4_hdmi_debugfs_regs,
+			     vc4_hdmi);
 
 	return 0;
 
@@ -1439,6 +1441,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
 
 static const struct vc4_hdmi_variant bcm2835_variant = {
 	.encoder_type		= VC4_ENCODER_TYPE_HDMI0,
+	.debugfs_name		= "hdmi_regs",
 	.registers		= vc4_hdmi_fields,
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 4240c5ea7fde..22100820c81b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -30,6 +30,9 @@ struct vc4_hdmi_variant {
 	/* Encoder Type for that controller */
 	enum vc4_encoder_type encoder_type;
 
+	/* Filename to expose the registers in debugfs */
+	const char *debugfs_name;
+
 	/* List of the registers available on that variant */
 	const struct vc4_hdmi_register *registers;
 
-- 
git-series 0.9.1
