Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F0D2666BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgIKRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:32:05 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37519 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIKRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:31:45 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C9F351BF205;
        Fri, 11 Sep 2020 17:31:42 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/3] ASoC: tlv320aic32x4: Ensure a minimum delay before clock stabilization
Date:   Fri, 11 Sep 2020 19:31:38 +0200
Message-Id: <20200911173140.29984-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911173140.29984-1-miquel.raynal@bootlin.com>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As indicated in the datasheet, a 10ms delay must be observed after
programming the divisors.

The lack of delay prevents the codec to work properly and the playback
appears extremely slow and totally un-audible on a custom sama5 based
board.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 156c153c12ab..2f78e6820c75 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -230,7 +230,14 @@ static int clk_aic32x4_pll_set_rate(struct clk_hw *hw,
 	if (ret < 0)
 		return -EINVAL;
 
-	return clk_aic32x4_pll_set_muldiv(pll, &settings);
+	ret = clk_aic32x4_pll_set_muldiv(pll, &settings);
+	if (ret)
+		return ret;
+
+	/* 10ms is the delay to wait before the clocks are stable */
+	msleep(10);
+
+	return 0;
 }
 
 static int clk_aic32x4_pll_set_parent(struct clk_hw *hw, u8 index)
-- 
2.20.1

