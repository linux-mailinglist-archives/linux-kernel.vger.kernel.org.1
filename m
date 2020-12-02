Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7622CC7D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgLBUc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:32:57 -0500
Received: from mailoutvs25.siol.net ([185.57.226.216]:60875 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726467AbgLBUc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:32:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DD473521007;
        Wed,  2 Dec 2020 21:32:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lRLMbYTl87io; Wed,  2 Dec 2020 21:32:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 923B85209DC;
        Wed,  2 Dec 2020 21:32:12 +0100 (CET)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 2E324521007;
        Wed,  2 Dec 2020 21:32:12 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, jernej.skrabec@siol.net,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] clk: sunxi-ng: Make sure divider tables have sentinel
Date:   Wed,  2 Dec 2020 21:38:17 +0100
Message-Id: <20201202203817.438713-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two clock divider tables are missing sentinel at the end. Effect of that
is that clock framework reads past the last entry. Fix that with adding
sentinel at the end.

Issue was discovered with KASan.

Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
index 5f66bf879772..149cfde817cb 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -389,6 +389,7 @@ static struct clk_div_table ths_div_table[] =3D {
 	{ .val =3D 1, .div =3D 2 },
 	{ .val =3D 2, .div =3D 4 },
 	{ .val =3D 3, .div =3D 6 },
+	{ /* Sentinel */ },
 };
 static const char * const ths_parents[] =3D { "osc24M" };
 static struct ccu_div ths_clk =3D {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/c=
cu-sun8i-h3.c
index 6b636362379e..7e629a4493af 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -322,6 +322,7 @@ static struct clk_div_table ths_div_table[] =3D {
 	{ .val =3D 1, .div =3D 2 },
 	{ .val =3D 2, .div =3D 4 },
 	{ .val =3D 3, .div =3D 6 },
+	{ /* Sentinel */ },
 };
 static SUNXI_CCU_DIV_TABLE_WITH_GATE(ths_clk, "ths", "osc24M",
 				     0x074, 0, 2, ths_div_table, BIT(31), 0);
--=20
2.29.2

