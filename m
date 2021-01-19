Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0C2FB8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404909AbhASNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392898AbhASNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:34:47 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F56C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:34:06 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so29042488lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhmjZfICV6YsfFarA1EPYbZwrLbrS/pPpCmbCrynCvk=;
        b=klZ1S7ydb/3S1A8x0kxT4RvJzrw0xZw5jqFGQo9Fp8rxe9m6I3tflj/ulayt1CLezq
         +bslI9qV0uQHpliVWmVhqTvzkNt4xf7u14wECA+dux/dvEa55nB2eLYqDfPxj9A+zpsT
         xGzzYMOrrwygcH82uGeIdmW9CZZweMkEtuIA79X8RbxJXWaFe1kH9X/nCOe8gkug3qoh
         IGs8XYrr0QeCaKfI8lyGYT+VPGOtMbRPF99btcACjBeapqlehPbWrF28Nj3mz+jnaJ/I
         C1vgkJO+iqZjlpM3CDc19Ma6H3R6lgoWXrfCnwDjm44fCwLPt3GBpeyXvqzdkWicYo2g
         4k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhmjZfICV6YsfFarA1EPYbZwrLbrS/pPpCmbCrynCvk=;
        b=MHvZoq0+TQ87m2JX7aaIn9nJHZLN0rVexrhbFraKJItx+4L1/rE6NCXggGGiHbSbmd
         LFYHoEHpLnb6qRr4iLN9QMpbN0Nzkwtlxhz7soFflIYuSeuJrCCfUbhp3PDqAkyYWz4u
         rXwEsMyfLtlC+Emd1em4kmp8T8VzHFdSaqBoLOx5kbldjrCeTAvQCpwqaFJ9kEFkCrQA
         5/YEo/Lh28r8iq/KXGOyAjQQ8qEx9jj2R4qrq5UHQIPCqOiQC//lEslhF+v+C4LV8tPs
         XDEwZDk5uzrgnsswvE2akLTIJ/RlJiXQ9PGIyyO2pfZDer/MLW15XEmbM1+/mrIex1gd
         CViQ==
X-Gm-Message-State: AOAM530Hr5zugQzgsT8pq3GVKjYgsagkkLFZJqUxfhnZXqmY9hP5+8+4
        pXreT+Egkc1qN5Mi9+jrOow=
X-Google-Smtp-Source: ABdhPJzJVJBxNYAD8It37z506/IdupLMHPwH55ZVDxkDi8R8VHENiY6kcIL1EUp9Sa12ZoNIplp/gQ==
X-Received: by 2002:ac2:4571:: with SMTP id k17mr1823782lfm.208.1611063244547;
        Tue, 19 Jan 2021 05:34:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:540:24c3:d200:84d:dd92:d095:3df3])
        by smtp.gmail.com with ESMTPSA id f132sm2274304lfd.252.2021.01.19.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 05:34:04 -0800 (PST)
From:   nikitos.tr@gmail.com
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org, stephan@gerhold.net,
        Nikita Travkin <nikitos.tr@gmail.com>
Subject: [PATCH] extcon: sm5502: Detect OTG when USB_ID is connected to ground
Date:   Tue, 19 Jan 2021 18:33:47 +0500
Message-Id: <20210119133347.42050-1-nikitos.tr@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Travkin <nikitos.tr@gmail.com>

In it's curent state this driver ignores OTG adapters with ID pin
connected to ground. This commit adds a check to set extcon into
host mode when such OTG adapter is connected.

Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>

---

This issue was already reported in [1] and this behaviour appears
for both Samsung Galaxy A5 (2015) mentioned there and A3 that I was
working on. This patch allows OTG detection on A3.

[1]: https://lore.kernel.org/lkml/20191011145015.GA127238@gerhold.net/
---
 drivers/extcon/extcon-sm5502.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 106d4da647bd..db41d1c58efd 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -144,6 +144,7 @@ enum sm5502_muic_acc_type {
 	SM5502_MUIC_ADC_AUDIO_TYPE1_FULL_REMOTE = 0x3e,	/* |      001|11110| */
 	SM5502_MUIC_ADC_AUDIO_TYPE1_SEND_END = 0x5e,	/* |      010|11110| */
 							/* |Dev Type1|--ADC| */
+	SM5502_MUIC_ADC_GROUND_USB_OTG = 0x80,		/* |      100|00000| */
 	SM5502_MUIC_ADC_OPEN_USB = 0x5f,		/* |      010|11111| */
 	SM5502_MUIC_ADC_OPEN_TA = 0xdf,			/* |      110|11111| */
 	SM5502_MUIC_ADC_OPEN_USB_OTG = 0xff,		/* |      111|11111| */
@@ -291,11 +292,27 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 	 * connected with to MUIC device.
 	 */
 	cable_type = adc & SM5502_REG_ADC_MASK;
-	if (cable_type == SM5502_MUIC_ADC_GROUND)
-		return SM5502_MUIC_ADC_GROUND;
 
 	switch (cable_type) {
 	case SM5502_MUIC_ADC_GROUND:
+		ret = regmap_read(info->regmap, SM5502_REG_DEV_TYPE1,
+				  &dev_type1);
+		if (ret) {
+			dev_err(info->dev, "failed to read DEV_TYPE1 reg\n");
+			return ret;
+		}
+
+		switch (dev_type1) {
+		case SM5502_REG_DEV_TYPE1_USB_OTG_MASK:
+			cable_type = SM5502_MUIC_ADC_GROUND_USB_OTG;
+			break;
+		default:
+			dev_dbg(info->dev,
+				"cannot identify the cable type: adc(0x%x), dev_type1(0x%x)\n",
+				adc, dev_type1);
+			return -EINVAL;
+		}
+		break;
 	case SM5502_MUIC_ADC_SEND_END_BUTTON:
 	case SM5502_MUIC_ADC_REMOTE_S1_BUTTON:
 	case SM5502_MUIC_ADC_REMOTE_S2_BUTTON:
@@ -396,6 +413,7 @@ static int sm5502_muic_cable_handler(struct sm5502_muic_info *info,
 		con_sw	= DM_DP_SWITCH_OPEN;
 		vbus_sw	= VBUSIN_SWITCH_VBUSOUT;
 		break;
+	case SM5502_MUIC_ADC_GROUND_USB_OTG:
 	case SM5502_MUIC_ADC_OPEN_USB_OTG:
 		id	= EXTCON_USB_HOST;
 		con_sw	= DM_DP_SWITCH_USB;
-- 
2.25.1

