Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E641E47EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbgE0Pp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 11:45:59 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52625 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389834AbgE0Ppp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:45:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F353F581DD8;
        Wed, 27 May 2020 11:45:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=6iQKMxJg9h0BJ
        TznOS0hTu6hgQnCXnqNYbjoQGsXtMs=; b=ZDfPzcs8nzFcoFOScZ8jDFuPQdO/b
        xbS4APJSADkov/UEjNgOJMIJUTAvcfV0d4+cltZgZWM19BVlVSYGf/CZtQqJUrZ4
        LN90e2hp/YK6w+SzSI4w2zm+YM555ggm6EMVOn28ZwK/1At1Viu0LGbj3hi8hDKY
        mS8UhqA8lUZnF7HvY8C7WatDWO3qa9o/Bf7U7K5bZlbsA4RPC2ciDBlp1uNoQ9TS
        STxKARTyfqJIlFNztRbgpe8jB2c8bLu8i0doYMcxFPgep79Kqhlf8LDDiFAWHBHy
        YfSWLHzUlvbmfoE62C++nkhKyjiePW0BSsXgYHoASjOQ+sQYFPcVIebtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6iQKMxJg9h0BJTznOS0hTu6hgQnCXnqNYbjoQGsXtMs=; b=K9Mqm1+B
        81cdZ9+2rSG9w1oyzWJFmhmc862ZAUwxEe0W0rkkiGyK4vZ1ZtJGokPSZTLLukkO
        VAQfUB4eet5CdREDeK03lBk23AZwP5CIm3VoPbdNrie4SvthTbcRi5LqY+iS1FRk
        HOff4XSo5JZbkEwxi9zZzoc7CGt4aSvh767l8iLIkSUpjKBApRq6vuhQppULmWkc
        IBBkB+9DogriXk557CBjGR8RcGbsQKbdNE3OdWmW09LvOmw8gSRadJpJUv3dUFHF
        9ZuwdJOgbhIXWfcrs0GS36rgJLVAAa7Xc6TZpN2UJsagrOGdYetUvQz56v86NU/i
        a8JXu83ipFA4qA==
X-ME-Sender: <xms:J4vOXlru3VydWhggf72F_7LdFZO8vkVByibZqwZApta0mjXC4gFG9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepieenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:J4vOXnp0kf1M0QWj1g13azxpVBz05u4A-OfF6AI6I9x9zO8mDEBKAw>
    <xmx:J4vOXiOMbMl60KA0TkIoFOMkulZYWuJG6Yt2Gd24ZB0dT0TW7QsOTA>
    <xmx:J4vOXg6JRhi4TJjUO2HLxEBcn8VVafl2baTZmadY3OEydo233valTg>
    <xmx:J4vOXmvDMtXibxnmRTNf87CnXtJjygB8JMqNsAkRfNjSPd1VzD2g9g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 927A430618B7;
        Wed, 27 May 2020 11:45:43 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 11/25] clk: bcm: rpi: Make sure the clkdev lookup is removed
Date:   Wed, 27 May 2020 17:45:07 +0200
Message-Id: <ec65846db8f8879a002c3cbe38085d37fc1fe9d3.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clkdev lookup created for the cpufreq device is never removed if
there's an issue later in probe or at module removal time.

Let's convert to the managed variant of the clk_hw_register_clkdev function
to make sure it happens.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 23f06618a356..a20492fade6a 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -245,8 +245,9 @@ static int raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 		return ret;
 	}
 
-	ret = clk_hw_register_clkdev(&raspberrypi_clk_pllb_arm.hw,
-				     NULL, "cpu0");
+	ret = devm_clk_hw_register_clkdev(rpi->dev,
+					  &raspberrypi_clk_pllb_arm.hw,
+					  NULL, "cpu0");
 	if (ret) {
 		dev_err(rpi->dev, "Failed to initialize clkdev\n");
 		return ret;
-- 
git-series 0.9.1
