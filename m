Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222CC2EFD14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhAICLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbhAICLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:11:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D56F23AA3;
        Sat,  9 Jan 2021 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610158263;
        bh=t0IHG7i/rG5q0kGjKDEB6BMqF7jMIE84um+5xi949Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcNUrJuDaDmSymaVrfjWxRc6dQbT/apZ7uMQHnllurftkrwnUMfSWCkCEpA3IoeFz
         04mojUPlpllMMbu3qOT5iHQYrKBSmfpgw0tOvdrnWncb6uKN7XR6oVThIeOBEi9PBH
         uVazrZsTCzQ+cKriSdF2BQebHCTmtacSU8H/ljUc75qsabLFM3CE9vA31NNQy8TZF9
         mRSaC3uj/pQc5QraBN5zFVyoeGJyRm/bzthR9v14Ih7tZ8OYH0O28znjsOPfRP5qPn
         /frNb2HaXJKavuZiDAlaCuStAe1lNIwTHW1pjfcjTNwTLyqlyMshYl99UEnPT7Z/+x
         uJg4a0HkHZ8Kw==
From:   matthias.bgg@kernel.org
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Axel Lin <axel.lin@ingics.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 3/3] regulator: mt6323: Add OF match table
Date:   Sat,  9 Jan 2021 03:10:46 +0100
Message-Id: <20210109021046.21907-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109021046.21907-1-matthias.bgg@kernel.org>
References: <20210109021046.21907-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The binding documentation mentions that a compatible is required for the
MT6323 device node. But the driver does not provide a OF match table.
This way auto-loading is broken as the MFD driver that registers the
device has a .of_compatible set which makes the platform .uevent
callback report a OF modalias, but that's not in the module.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 drivers/regulator/mt6323-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index ff9016170db3..b3d84e95f051 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -406,9 +406,16 @@ static const struct platform_device_id mt6323_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, mt6323_platform_ids);
 
+static const struct of_device_id mt6323_of_match[] = {
+	{ .compatible = "mediatek,mt6323-regulator", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6323_of_match);
+
 static struct platform_driver mt6323_regulator_driver = {
 	.driver = {
 		.name = "mt6323-regulator",
+		.of_match_table = of_match_ptr(mt6323_of_match),
 	},
 	.probe = mt6323_regulator_probe,
 	.id_table = mt6323_platform_ids,
-- 
2.29.2

