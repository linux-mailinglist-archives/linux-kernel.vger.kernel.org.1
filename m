Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D956242D41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHLQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgHLQaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BBA2076B;
        Wed, 12 Aug 2020 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249817;
        bh=Q+sqoBe3xnyf5wQXNK/abtblrjDATXeuasSM8jI+6jQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p8720e97qpjlsN9P95w2REttpP8YCaD2P1pj9kZlC9XwmGc3Jc84ZmqISS/rSDulG
         yfHHvXRO9s48A0Lms8TIcZvly6IqLfIHVu0k1OR55oI4jtK4VcNcIFwRS1GpT8WMlX
         P3Ml9fjTFPqFJuQQV9P3TkSY9RS7yqz1SfxmMpDw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 07/11] extcon: ptn5150: Lower the noisiness of probe
Date:   Wed, 12 Aug 2020 18:29:54 +0200
Message-Id: <20200812162958.6180-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
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

