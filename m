Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285BF2948FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501916AbgJUHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:37:39 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:40196 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501907AbgJUHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=p03GQ3/3M5H2l6FbiI
        2Wsg8qkYfOo4GdiyO4pQ0cRiI=; b=DnInzNMqK54g8JOg39d3hXqaGbnwCpyjvY
        JFMufgMvnXKtRe2UKXlCGaE/GAR4cARv1mvfGbOWsUXm5uDYSK/OtyKwxtc7pF1D
        167z+2ZXYAfSUIzzwjGiwZSpjzMxzwxrpDtC1SX5DARj2AooivblnbAgQuSBIAti
        TlFaXGphQ=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp9 (Coremail) with SMTP id NeRpCgBHXxeR3Y9fD5tdMQ--.10747S2;
        Wed, 21 Oct 2020 15:04:49 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     broonie@kernel.org, perex@perex.cz
Cc:     tiwai@suse.com, lgirdwood@gmail.com,
        Vishnuvardhanrao.Ravulapati@amd.com, akshu.agrawal@amd.com,
        weiyongjun1@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH v2] ASoC: amd: move the call to devm_kzalloc below platform_get_resource()
Date:   Wed, 21 Oct 2020 15:04:27 +0800
Message-Id: <1603263867-8754-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <broonie@kernel.org>
References: <broonie@kernel.org>
X-CM-TRANSID: NeRpCgBHXxeR3Y9fD5tdMQ--.10747S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW7try7tr13WryxAr48tFb_yoWfKwb_ta
        yDu34qgryUWr1agry8Cr43Arn5K3ZIkrn5G34agryav348uws3Ca1UZrZruFZruws2kFWU
        Xw1v9rWay343AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUngo2UUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhHE11pEBlwrewAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as the commit <4cb79ef9c6c4>("ASoC: amd: Fix potential NULL pointer dereference"),it makes no sense to allocate any resources if platform_get_resource fails,so move the call to devm_kzalloc() below the mentioned code.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index c9c69eb..04ec603 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -307,9 +307,11 @@ static int acp3x_dai_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
 		return -ENOMEM;
 	}
+
 	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data), GFP_KERNEL);
 	if (!adata)
 		return -ENOMEM;
+
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 						resource_size(res));
 	if (!adata->acp3x_base)
-- 
1.9.1

