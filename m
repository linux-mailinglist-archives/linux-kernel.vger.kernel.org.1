Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375DD279515
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgIYXsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:48:39 -0400
Received: from mail.v3.sk ([167.172.186.51]:37934 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729425AbgIYXsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:48:39 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 19:48:37 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BC267DFA4B;
        Fri, 25 Sep 2020 23:37:49 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OjjPVqzueDuu; Fri, 25 Sep 2020 23:37:49 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 060B6DFA70;
        Fri, 25 Sep 2020 23:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NaARvy3AJsQl; Fri, 25 Sep 2020 23:37:48 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 99329DFA4B;
        Fri, 25 Sep 2020 23:37:48 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] clk: mmp2: Fix the display clock divider base
Date:   Sat, 26 Sep 2020 01:39:14 +0200
Message-Id: <20200925233914.227786-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD clock dividers are apparently based on one. No datasheet,
determined empirically, but seems to be confirmed by line 19 of lcd.fth i=
n
OLPC laptop's Open Firmware [1]:

   h# 00000700 value pmua-disp-clk-sel  \ PLL1 / 7 -> 113.86 MHz

[1] https://raw.githubusercontent.com/quozl/openfirmware/65a08a73b2cac/cp=
u/arm/olpc/lcd.fth

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 67208aea94c5c..0839fb2049e94 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -347,9 +347,9 @@ static struct mmp_param_mux_clk mmp3_apmu_mux_clks[] =
=3D {
 };
=20
 static struct mmp_param_div_clk apmu_div_clks[] =3D {
-	{0, "disp0_div", "disp0_mux", CLK_SET_RATE_PARENT, APMU_DISP0, 8, 4, 0,=
 &disp0_lock},
+	{0, "disp0_div", "disp0_mux", CLK_SET_RATE_PARENT, APMU_DISP0, 8, 4, CL=
K_DIVIDER_ONE_BASED, &disp0_lock},
 	{0, "disp0_sphy_div", "disp0_mux", CLK_SET_RATE_PARENT, APMU_DISP0, 15,=
 5, 0, &disp0_lock},
-	{0, "disp1_div", "disp1_mux", CLK_SET_RATE_PARENT, APMU_DISP1, 8, 4, 0,=
 &disp1_lock},
+	{0, "disp1_div", "disp1_mux", CLK_SET_RATE_PARENT, APMU_DISP1, 8, 4, CL=
K_DIVIDER_ONE_BASED, &disp1_lock},
 	{0, "ccic0_sphy_div", "ccic0_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC0,=
 10, 5, 0, &ccic0_lock},
 	{0, "ccic1_sphy_div", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1,=
 10, 5, 0, &ccic1_lock},
 };
--=20
2.26.2

