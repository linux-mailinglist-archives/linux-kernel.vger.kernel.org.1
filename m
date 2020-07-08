Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0592218A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 16:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgGHOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 10:46:03 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:58345 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729854AbgGHOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:46:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AB1BBDF2;
        Wed,  8 Jul 2020 10:46:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 10:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=4NREBuy0f4ceXTelZ1c05+0MR5
        Jh1oCebiw4dhTmkwo=; b=mrot4VsbtbIj7r651H0GQW8ozK6aAsVAvln1MX6N54
        QVtozd2CTIW9mYGPPKm/Je5lqsm8YKbYhBMuNWglTfKizGwOpXN8iIeKESTVKY1s
        7bp27HpLpRn1K9W/DoKsySCz++H+q20VAeHm3FiQj222DG4R+SXDtOYIXgc5sKfH
        ODTrtiIzRt6GrFKUEjvWCQ5Il8t+jTuSpYHS/A5ZddupCLMKvwI1rknYYGAQH+J5
        qOltWUoI8CH6pAq2vClxvTzQ7lYagIscmL5Rnzni/TD3d9Gim6hLEVh/K2stfA/I
        zxTcasGRdLG8Sdj/iaUwQq9ijk+x6Q15dVW1/0oGJjfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4NREBuy0f4ceXTelZ
        1c05+0MR5Jh1oCebiw4dhTmkwo=; b=AgOptL+0VLoGiDi+SsFyCLLKauc6uq1B0
        an6opM9PmkFNYtzai5noRLpI+37B3e9mCZT7tYDS5kXElctl9n2+Kf/7nXRFJELf
        dfikWSf/8ks3ga8pOJwPNMs3DTGicwOZD72ykDH5NwFl2N0H1sJN7opJ5gwQ6lvQ
        AKgT1+cljjhPvofL0OpiCELOLkiGnql8a157imIcalAefiN+iCJcLnYp48A3AnFW
        grU2zldwFhUNownecpcNWM3zHhxB+YV89e/yI2aJdLjmzMoPP67UhWryRoePLICV
        xxT80fD9hYfHMGcINGU+hlhaKYnuiKHZYIRmaKjeERN0GgnOhfPLw==
X-ME-Sender: <xms:JtwFX97V55PVlIlyO6dbHGZOH_e5AL5nzt3bSUMz4Us28heyXridOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeejffehuddvvddvlefhgeelleffgfeijedvhefgieejtdeiueetjeetfeeukeejgeen
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:JtwFX66feTj8YlZBr2kQuxlIM311HHmjem0qBUY4pxly-IPAkUOC-Q>
    <xmx:JtwFX0epB2H0zg_666qv-MO06-YwUlMwlkyT77m-2byocavX5SYURg>
    <xmx:JtwFX2JJsBYOF-7qKdqFgDp93qCW0fHcEWtTwmRLrKajhqsEbPAIsg>
    <xmx:KdwFX2pxYtegwssixOJgEGszWwlAeIGYVmXFBnuXM8r9y6-FX9PENzPYfDg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30F7D328005D;
        Wed,  8 Jul 2020 10:45:58 -0400 (EDT)
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
Subject: [PATCH] drm/vc4: hdmi: Add a name to the codec DAI component
Date:   Wed,  8 Jul 2020 16:45:55 +0200
Message-Id: <20200708144555.718404-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the components for a given device in ASoC are identified by their
name, it makes sense to add one even though it's not strictly necessary.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 15a11cd4de25..a057db0d9baa 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -983,6 +983,7 @@ static const struct snd_soc_dapm_route vc4_hdmi_audio_routes[] = {
 };
 
 static const struct snd_soc_component_driver vc4_hdmi_audio_component_drv = {
+	.name			= "vc4-hdmi-codec-dai-component",
 	.controls		= vc4_hdmi_audio_controls,
 	.num_controls		= ARRAY_SIZE(vc4_hdmi_audio_controls),
 	.dapm_widgets		= vc4_hdmi_audio_widgets,
-- 
2.26.2

