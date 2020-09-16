Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6426C525
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgIPQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIPQT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:19:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D510222596;
        Wed, 16 Sep 2020 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600273084;
        bh=rDklET3URHRDBZEvF6OLfVutgrEE+P7xngbDw3ovJPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2qzRyizp/VEct8ssgms7hbJXVwjVImM85Q7xFsmmmORaJJoUfwUgoBGEFqi0by2T
         G5IZj2iDxNypoGC+dc+C7hgmzL2KBMi2fi4175i+oyaRfPHYbrPLSGxuuLOR8gaieR
         ArI/ZIcqrnWAWOtZotaHfvbhZ+dh7bfZdpN9lSwo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] clk: si5341: drop unused 'err' variable
Date:   Wed, 16 Sep 2020 18:17:39 +0200
Message-Id: <20200916161740.14173-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916161740.14173-1-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'err' is assigned but never read:

  /drivers/clk/clk-si5341.c: In function ‘si5341_output_get_parent’:
  drivers/clk/clk-si5341.c:886:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-si5341.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 3d7acab9d280..e0446e66fa64 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -883,11 +883,9 @@ static int si5341_output_set_parent(struct clk_hw *hw, u8 index)
 static u8 si5341_output_get_parent(struct clk_hw *hw)
 {
 	struct clk_si5341_output *output = to_clk_si5341_output(hw);
-	int err;
 	u32 val;
 
-	err = regmap_read(output->data->regmap,
-			SI5341_OUT_MUX_SEL(output), &val);
+	regmap_read(output->data->regmap, SI5341_OUT_MUX_SEL(output), &val);
 
 	return val & 0x7;
 }
-- 
2.17.1

