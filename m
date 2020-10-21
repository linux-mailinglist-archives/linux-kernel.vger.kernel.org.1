Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0129489E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436974AbgJUHHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:07:05 -0400
Received: from m15113.mail.126.com ([220.181.15.113]:37100 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395412AbgJUHHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=p03GQ3/3M5H2l6FbiI
        2Wsg8qkYfOo4GdiyO4pQ0cRiI=; b=eIUAf42wTLiRKva/c40fj2Y6X+FnKy7QtC
        yiVKc0WyU0pD+0LYgVDPrjIhiZQ2KLXIvv9MSvQjldIK5z7YacyYpW4WtOJm4G7S
        x4kEAYSpmvZ++hE6D0yG3OSS7AvGmtjZQvQVg3MeKZgrQIPAL+HJliMUIt459MSW
        DwtZ/X0x0=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowABHfgUy3Y9f6JV4Kw--.7587S2;
        Wed, 21 Oct 2020 15:03:16 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, lgirdwood@gmail.com,
        Vishnuvardhanrao.Ravulapati@amd.com, akshu.agrawal@amd.com,
        weiyongjun1@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH v2] ASoC: amd: move the call to devm_kzalloc below platform_get_resource()
Date:   Wed, 21 Oct 2020 15:03:02 +0800
Message-Id: <1603263782-8711-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <broonie@kernel.org>
References: <broonie@kernel.org>
X-CM-TRANSID: DcmowABHfgUy3Y9f6JV4Kw--.7587S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFW7try7tr13WryxAr48tFb_yoWfKwb_ta
        yDu34qgryUWr1agry8Cr43Arn5K3ZIkrn5G34agryav348uws3Ca1UZrZruFZruws2kFWU
        Xw1v9rWay343AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0GsUtUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbitBzE11pEBwPhpgAAsm
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

