Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595532BB048
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgKTQUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbgKTQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:59 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F102240B;
        Fri, 20 Nov 2020 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889198;
        bh=YKAPydPIWqqjvFa7UzQnBAAVi+TGKaJPKa4etHyS8xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcUeRzqSLSYOtxViNaugsGF1R38va5qadZ3/yPd3SqOdpmd2C/olttpbb0e3TpAqA
         eaAi2NxBUIkSoZMqPtDYO5lsUcnccytQTElY/uGA9hk0KcrfN/Si/HMWylbXNxxw38
         lvAilkHu86bpdcs/4JiLV60O4ij4CWGAEQLHRYbQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 36/38] ASoC: max98925: drop driver pm=NULL assignment
Date:   Fri, 20 Nov 2020 17:16:50 +0100
Message-Id: <20201120161653.445521-36-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to explicitly set driver .pm field to NULL.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98925.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index e18d0022c3f4..ddaccc24b0cb 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -639,7 +639,6 @@ static struct i2c_driver max98925_i2c_driver = {
 	.driver = {
 		.name = "max98925",
 		.of_match_table = of_match_ptr(max98925_of_match),
-		.pm = NULL,
 	},
 	.probe  = max98925_i2c_probe,
 	.id_table = max98925_i2c_id,
-- 
2.25.1

