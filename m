Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1129275D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgJSMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:33:56 -0400
Received: from m15111.mail.126.com ([220.181.15.111]:46228 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgJSMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hLfIQIHuyLNmd+qchF
        0iMkyztO/7yUc2IbZTbVRiJyI=; b=RpMfgr0mJqGp+g+dat3z/td2OnhOXL6w2a
        plj+lFyWuj1vTLz68O5JaQ3HyvmKoVJhANV2n3uKssPo3lFlD+lwpLNedIsU/cga
        2i032g+is2b2e0XijgprS4/4Xvw1mSF8o64RMYoW1SBUespGHQvKd08m84GejoQg
        UpXTxu3Xs=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp1 (Coremail) with SMTP id C8mowACHgx00h41fyctCKg--.6S2;
        Mon, 19 Oct 2020 20:31:53 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, Vishnuvardhanrao.Ravulapati@amd.com
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH] ASoC: amd: move the call to devm_kzalloc below platform_get_resource()
Date:   Mon, 19 Oct 2020 20:31:29 +0800
Message-Id: <1603110689-5015-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: C8mowACHgx00h41fyctCKg--.6S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFW7try7tr13WryxAr48tFb_yoW8JrW3p3
        93KFZxtrWrJrWUZ3y8GF48ZF1Ygry29a1UKrs8Z3y3Za45GrWkKFs7JFy0kFWSyFWvka1x
        XryDta1FvFn0qrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bFPEfUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbitBDC11pEBvHlDgAAsz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as the commit <4cb79ef9c6c4>("ASoC: amd: Fix potential NULL pointer dereference"),it makes no sense to allocate any resources if res = platform_get_resource(pdev, IORESOURCE_MEM, 0); fails,so move the call to devm_kzalloc() below the mentioned code.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index a532e01..c9c69eb 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -302,16 +302,14 @@ static int acp3x_dai_probe(struct platform_device *pdev)
 	struct i2s_dev_data *adata;
 	int ret;
 
-	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
-			GFP_KERNEL);
-	if (!adata)
-		return -ENOMEM;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
 		return -ENOMEM;
 	}
+	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 						resource_size(res));
 	if (!adata->acp3x_base)
-- 
1.9.1

