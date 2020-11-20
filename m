Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC42BAFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgKTQSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgKTQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:36 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126B122464;
        Fri, 20 Nov 2020 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889115;
        bh=C3hkFsDb3sE4GUFvIjYxN4SbnZ/Y/EW4EfgcLWyYLN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRD8DSGxZF+07oeRNYrMzRzm+SfF/S0iK7bxL77poIehWZ9NObx/rT9PSOv1VmcnM
         gwIGmYEgXMeJYtCJnFvlVw6pN0uEmGd+Gzqe2Ce9qyVqLGEztof3N/BNlUw5m+s7ep
         ydJtpTlEi+p/AmBaew/nPtRzaI8iHCePjQHoK1Q4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 14/38] ASoC: alc5623: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:28 +0100
Message-Id: <20201120161653.445521-14-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/alc5623.c:1071:34: warning: ‘alc5623_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/alc5623.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 3d1761a531f5..54f489837162 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1068,11 +1068,13 @@ static const struct i2c_device_id alc5623_i2c_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);
 
+#ifdef CONFIG_OF
 static const struct of_device_id alc5623_of_match[] = {
 	{ .compatible = "realtek,alc5623", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, alc5623_of_match);
+#endif
 
 /*  i2c codec control layer */
 static struct i2c_driver alc5623_i2c_driver = {
-- 
2.25.1

