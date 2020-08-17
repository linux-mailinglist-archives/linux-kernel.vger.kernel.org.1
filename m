Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE0245CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHQHBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgHQHAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1303D20855;
        Mon, 17 Aug 2020 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647632;
        bh=Q+sqoBe3xnyf5wQXNK/abtblrjDATXeuasSM8jI+6jQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Dy0ZRNqupVexVorZKgIwdTpuhz/pP99dQRygZr8wPoOB7zJQi+rf1B1OMIahmz/go
         LETaf7/IqNrs3rcDoOSlOv2y8NXvBVeJD40WJtOf3/MCDiVo+/fNiTZFmtC3NZDLja
         WhtBJmNgUi5kjfMiTBG3IWTdyeMVpuSQ8omqrhkk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 07/13] extcon: ptn5150: Lower the noisiness of probe
Date:   Mon, 17 Aug 2020 09:00:03 +0200
Message-Id: <20200817070009.4631-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptn5150 driver always prints device type on probe but as raw hex,
without any translation to meaningful description.  This is useful only
for board bring up time so lower the verbosity to debug.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 3b99ad41b06e..a57fef384a29 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -199,8 +199,8 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
 				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
 
-	dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
-			    version_id, vendor_id);
+	dev_dbg(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
+		version_id, vendor_id);
 
 	/* Clear any existing interrupts */
 	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
-- 
2.17.1

