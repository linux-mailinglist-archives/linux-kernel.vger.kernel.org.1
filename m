Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6982E8BDD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 12:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbhACLHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 06:07:51 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:55833 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbhACLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 06:07:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0919D544;
        Sun,  3 Jan 2021 06:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 06:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=WyR8h/jVWSn2P
        IgW0OwRkxU8VaseOEGPaTS0rZRolAU=; b=BIP7jcuLEYLe8CBmY2ptXwkUK/50j
        TzKCZ6IdcQ/lFqQwZ7n/WldWxe6ZObEzwttaz6oiIYmoeVqmtSacYw1+ZKdiwbH9
        sslCTDGLYpaHpHtgFL8H3KMh+3OhLyFiACwdDPjicTlDINppdRoLw831+3GefODK
        YLYnW9F1Tse9rj0X/9/hmJsSg7KTO30ow6b+0FqBmA+DxjdHufsaw9ze/22I82o7
        gvHXG79Sji4rvYNtaDGfNZLuVh84dy0DqnzoVfPZXHtMDqRZ2eB7uRGzy02ndfp/
        JtpYmaun/Tw7513mjgtWdjvq7j13UKpdA/AGaZd3RaGVU0aajL+1ciduA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WyR8h/jVWSn2PIgW0OwRkxU8VaseOEGPaTS0rZRolAU=; b=hQdWEOVc
        WBhfNNYc7D/JxZ5eqvsCLDCup+71pRAALbuEz9nR2MHBhiV8R7ySSfkQE+1SWuXV
        8YX6QSg3H0nzzVfFzIp5giZUVwX9FzQ9i9VbdgMJWbm57oP6jqs5KdDf1DeW1f63
        eT1TjnPM3RIpA+avqcIYSJc6l1FhJTuImiZzSq6qX3Gt0qvy2xBtbOEOMs9w20cK
        BTJwuhT37E1R9Mdf6g7ezBbILrqtJJiU/GUQLawGvmI7dpUeeCaj2sk/32k/twht
        VVwpLJRq2N6l09rCeh1guUf4ebSQRTqTsLj7FLwZo5rhj5+ivlRctiHAyRkRRvur
        KRqVzlx8ZfCJig==
X-ME-Sender: <xms:PKXxX4XxwM01G2mGF9y-PN9K0PityJGJi-fjCWjFbbq4Azn1Mm3XTA>
    <xme:PKXxX8lvtjjwwfYX872VicrY4JKpCnG0FOxtuFMvaK-JP016bLra3qVFCk2NArPbJ
    Aj77WJEjgj8ouXrbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:PKXxX8aGyGAuoax6VVJBOXbpc6g9rU450vlPi4g-tYFcYcfT3pvjlA>
    <xmx:PKXxX3Wy4pXmKhSYYBz5gbFMfnnCw_rvZLhXqw9y9PIXUWT0Yhva0Q>
    <xmx:PKXxXyne-rMBTaey1BlwtWgN1HhiAExVA4J_mGP5KvuDbFTvaIHNfA>
    <xmx:PqXxX5upknzqKqXYtJpxbrXAbrDdPwDx_ccNBbXvF6idzVUxyOrkCg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6181C24005B;
        Sun,  3 Jan 2021 06:06:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/4] bus: sunxi-rsb: Move OF match table
Date:   Sun,  3 Jan 2021 05:06:32 -0600
Message-Id: <20210103110635.34823-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103110635.34823-1-samuel@sholland.org>
References: <20210103110635.34823-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, this driver's OF match table was placed above the
probe/remove functions, far away from the platform_driver definition.
Adding device PM ops would move the table even farther away. Let's move
it to the usual place, right before the platform_driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bus/sunxi-rsb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1bb00a959c67..c13340cab27a 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -614,12 +614,6 @@ static int of_rsb_register_devices(struct sunxi_rsb *rsb)
 	return 0;
 }
 
-static const struct of_device_id sunxi_rsb_of_match_table[] = {
-	{ .compatible = "allwinner,sun8i-a23-rsb" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
-
 static int sunxi_rsb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -747,6 +741,12 @@ static int sunxi_rsb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id sunxi_rsb_of_match_table[] = {
+	{ .compatible = "allwinner,sun8i-a23-rsb" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
+
 static struct platform_driver sunxi_rsb_driver = {
 	.probe = sunxi_rsb_probe,
 	.remove	= sunxi_rsb_remove,
-- 
2.26.2

