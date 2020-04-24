Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E21B79AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDXPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:35:58 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:56325 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgDXPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 851B6FE1;
        Fri, 24 Apr 2020 11:35:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=sQLhLPINZs04X
        F9JJfpvEB9DM84Run2R01mEi+9gmm0=; b=Canz5GlqEd2kFfwLb+7lU1k+8YRAr
        IsfYQ/o2XLFzhdSgvPgLaRzXD5Ip1ajSXNZKhTB4rKGiYgqrNPnK+0llYQi3/kDh
        pnGTQ8KakyoybY8zFkkaZS0IVYpZxcbl4cj53Oo42eZf2wIWXkJ4YMm/+CPpqXxT
        jHXnIpoE5ICr9i6vTQBF5N0PhWiJwTu40kfH2GNA85/dZ2p6EetWczKbo4HTEoBd
        xUlTYVyIaZiVjT0RVqSPBClXWS9GZcKoQ3/zSjFKIs5m56jGqdai7vxTgMKG5ujh
        J94SVCCl1CLEF1SMJmr9Q3nzsmgg5d3tH3gMnI5DSB2U/0fRQXrw/QbqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=sQLhLPINZs04XF9JJfpvEB9DM84Run2R01mEi+9gmm0=; b=dW0kAoVo
        +yLAtFWLZSEf9Q2mUirhKXoJ6zKMc1fAzMiL8HxlLBGVfnTm0V3i9aPRVaP6t29b
        xbD/dB5fD/vHsEp1x+DWZ9P9h/hX06hhcqNchlov6nmsjMpp32W754hEHsy/AprF
        xDFmqGgACApQHBtEkKFZ2Zs2GmOgS+3iQlOqLq3j+DMOzTHcARSNfMv45hYzpK11
        pLuRARed+jO5Wh6sdCafxUNPXlm4E7+2dWpiya7fwDVTCDbs7lUQc2E3S0kexaww
        ocz5bd1UwJ/ZlLfgyzDAnlUvFkJaDlyeO2dLyUo5w27LingQW4Ub9o8Ic/0K6+2S
        sMz8QWerp9lFtg==
X-ME-Sender: <xms:WAejXqK2vVrRyu7CAUE-VvHEctaaMqyxMXsiy2ZNfPhUPD4ulfr3ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduleenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WAejXmZEWY9zCJfOxKsPeI8Q0bivnRq0yQSTDwYVWBFpy-7J7SII5Q>
    <xmx:WAejXluwKIBs2O0H4OjTXNWE6rVIGJBHjZfaVN1BrKOqB-PKvhB7Wg>
    <xmx:WAejXjvip6wvCV4nwV9-zpNwRBErGyrrJhA3erIc7yLY7ktiLQjk6w>
    <xmx:WAejXtVOliirI5Ee6Vo0-MQbDTODg-TC3_KxNysd3m0kLxivb7cf_ajleWM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB5053065DA6;
        Fri, 24 Apr 2020 11:35:51 -0400 (EDT)
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
Subject: [PATCH v2 21/91] ARM: dts: bcm2711: Add firmware clocks node
Date:   Fri, 24 Apr 2020 17:34:02 +0200
Message-Id: <41fbb75713ebfe81240156c959bb8f1352a4ca86.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a clock driver for the clocks exposed by the firmware,
let's add the device tree nodes for it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index e26ea9006378..3205d2dfa898 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -59,6 +59,11 @@
 };
 
 &firmware {
+	firmware_clocks: clocks {
+		compatible = "raspberrypi,firmware-clocks";
+		#clock-cells = <1>;
+	};
+
 	expgpio: gpio {
 		compatible = "raspberrypi,firmware-gpio";
 		gpio-controller;
-- 
git-series 0.9.1
