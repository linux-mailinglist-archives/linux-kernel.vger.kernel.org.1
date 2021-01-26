Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AD304E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390937AbhA0Aaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390408AbhAZRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:18:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0879AC061351
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:17:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m13so2864905wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cT55FABjLyu7dYc21lezhM1CvuGo2h6vplhaEe339cE=;
        b=UrYxoL4bOuXbkBcX9ePhc8k8BPcc/yvXG1VfCgvCgAy890BWkO00nH6rgoiwfwQwTX
         DvPRS7YhWByG7S3rA+tICwFjLS+sTSrdTF71wK5Hzfp42cm3EsSXas5ymUZ2uh6lo+8Z
         7TWsp9MWnlBrLaVEg5Q3VkXPm0dVLEmmFgUQFX8jveeaYYh9bdRldgxVOYOarVRY/QVF
         gAl3mU9nCw13QqpFp3zv873OdPXzfBz/Q/HtKcC5KGRVbZXSG5R2AX2aVcuUBRTYeEof
         b2X+sX5uyKAMxDclaXoi/eG2bEN047ah7GFcNwND6tdxmuTeDoyTYftQyLxU3JJvXKpX
         Hpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cT55FABjLyu7dYc21lezhM1CvuGo2h6vplhaEe339cE=;
        b=Y+GNfwmrCmj8STl+tga14WTiwrhwkUwGgdAfaJqFMz5aklklkJTlMi9biyHCmyCJW/
         O1GiRcoyY6QO8kcIMhl1k40a18BIdGBnPTdK6Nob4X25+8pxGGx0zTyRY7OzSXCNRW4S
         yflnLSMXduiGqMgCCo7bTxZG4KY5hkPoRZgl5UpyvbIx9j+AbgM170lrMRz887s7sF2W
         yqG2SptAhQic9d1NgvnaZEMDnrMLvO/0PCrIvKaD0lKIrA/vzn4C86Ur0zr3iPUqW+wD
         sJ/VsKgO/K6d7sSsegVqIPrv7bGrr2Vf0EZ/oOPRuEQFzQWmaw+K7ljDfw2FPVRL3caq
         OiWw==
X-Gm-Message-State: AOAM531hXeLzJ/pZENQeENpVy5rYt5muOl9S7yL148nPnzEGFQr2D8uG
        xw1st5bBHBTxqJkTIr1vcm561Q==
X-Google-Smtp-Source: ABdhPJwJLWztaGlItJcs76IMIRt4n37A8r9MNfHcyLGL/hS8T+o/0x5gVr8KcwSyEzfd2QZ0rXMvxQ==
X-Received: by 2002:a5d:6787:: with SMTP id v7mr7455707wru.286.1611681474840;
        Tue, 26 Jan 2021 09:17:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d85sm5059157wmd.2.2021.01.26.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 09:17:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: codecs: lpass-wsa-macro: make use of snd_soc_component_read_field()
Date:   Tue, 26 Jan 2021 17:17:49 +0000
Message-Id: <20210126171749.1863-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210126171749.1863-1-srinivas.kandagatla@linaro.org>
References: <20210126171749.1863-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of snd_soc_component_read_field() to make the code more readable!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 43 ++++++++++++++----------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 25f1df214ca5..5ebcd935ba89 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -40,9 +40,11 @@
 #define CDC_WSA_TOP_I2S_CLK			(0x00A4)
 #define CDC_WSA_TOP_I2S_RESET			(0x00A8)
 #define CDC_WSA_RX_INP_MUX_RX_INT0_CFG0		(0x0100)
-#define CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK	GENMASK(5, 3)
-#define CDC_WSA_RX_INTX_2_SEL_MASK		GENMASK(2, 0)
+#define CDC_WSA_RX_INTX_1_MIX_INP0_SEL_MASK	GENMASK(2, 0)
+#define CDC_WSA_RX_INTX_1_MIX_INP1_SEL_MASK	GENMASK(5, 3)
 #define CDC_WSA_RX_INP_MUX_RX_INT0_CFG1		(0x0104)
+#define CDC_WSA_RX_INTX_2_SEL_MASK		GENMASK(2, 0)
+#define CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK	GENMASK(5, 3)
 #define CDC_WSA_RX_INP_MUX_RX_INT1_CFG0		(0x0108)
 #define CDC_WSA_RX_INP_MUX_RX_INT1_CFG1		(0x010C)
 #define CDC_WSA_RX_INP_MUX_RX_MIX_CFG0		(0x0110)
@@ -229,8 +231,6 @@
 #define NUM_INTERPOLATORS 2
 #define WSA_NUM_CLKS_MAX	5
 #define WSA_MACRO_MCLK_FREQ 19200000
-#define WSA_MACRO_MUX_INP_SHFT 0x3
-#define WSA_MACRO_MUX_INP_MASK1 0x07
 #define WSA_MACRO_MUX_INP_MASK2 0x38
 #define WSA_MACRO_MUX_CFG_OFFSET 0x8
 #define WSA_MACRO_MUX_CFG1_OFFSET 0x4
@@ -843,7 +843,6 @@ static int wsa_macro_set_prim_interpolator_rate(struct snd_soc_dai *dai,
 	u32 j, port;
 	u16 int_mux_cfg0, int_mux_cfg1;
 	u16 int_fs_reg;
-	u8 int_mux_cfg0_val, int_mux_cfg1_val;
 	u8 inp0_sel, inp1_sel, inp2_sel;
 	struct snd_soc_component *component = dai->component;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
@@ -865,15 +864,13 @@ static int wsa_macro_set_prim_interpolator_rate(struct snd_soc_dai *dai,
 		 */
 		for (j = 0; j < NUM_INTERPOLATORS; j++) {
 			int_mux_cfg1 = int_mux_cfg0 + WSA_MACRO_MUX_CFG1_OFFSET;
-			int_mux_cfg0_val = snd_soc_component_read(component,
-								  int_mux_cfg0);
-			int_mux_cfg1_val = snd_soc_component_read(component,
-								  int_mux_cfg1);
-			inp0_sel = int_mux_cfg0_val & WSA_MACRO_MUX_INP_MASK1;
-			inp1_sel = (int_mux_cfg0_val >> WSA_MACRO_MUX_INP_SHFT) &
-						WSA_MACRO_MUX_INP_MASK1;
-			inp2_sel = (int_mux_cfg1_val >> WSA_MACRO_MUX_INP_SHFT) &
-						WSA_MACRO_MUX_INP_MASK1;
+			inp0_sel = snd_soc_component_read_field(component, int_mux_cfg0, 
+								CDC_WSA_RX_INTX_1_MIX_INP0_SEL_MASK);
+			inp1_sel = snd_soc_component_read_field(component, int_mux_cfg0, 
+								CDC_WSA_RX_INTX_1_MIX_INP1_SEL_MASK);
+			inp2_sel = snd_soc_component_read_field(component, int_mux_cfg1,
+								CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK);
+
 			if ((inp0_sel == int_1_mix1_inp + INTn_1_INP_SEL_RX0) ||
 			    (inp1_sel == int_1_mix1_inp + INTn_1_INP_SEL_RX0) ||
 			    (inp2_sel == int_1_mix1_inp + INTn_1_INP_SEL_RX0)) {
@@ -912,9 +909,9 @@ static int wsa_macro_set_mix_interpolator_rate(struct snd_soc_dai *dai,
 
 		int_mux_cfg1 = CDC_WSA_RX_INP_MUX_RX_INT0_CFG1;
 		for (j = 0; j < NUM_INTERPOLATORS; j++) {
-			int_mux_cfg1_val = snd_soc_component_read(component,
-							int_mux_cfg1) &
-							WSA_MACRO_MUX_INP_MASK1;
+			int_mux_cfg1_val = snd_soc_component_read_field(component, int_mux_cfg1,
+									CDC_WSA_RX_INTX_2_SEL_MASK);
+
 			if (int_mux_cfg1_val == int_2_inp + INTn_2_INP_SEL_RX0) {
 				int_fs_reg = CDC_WSA_RX0_RX_PATH_MIX_CTL +
 					WSA_MACRO_RX_PATH_OFFSET * j;
@@ -1410,25 +1407,25 @@ static bool wsa_macro_adie_lb(struct snd_soc_component *component,
 			      int interp_idx)
 {
 	u16 int_mux_cfg0,  int_mux_cfg1;
-	u8 int_mux_cfg0_val, int_mux_cfg1_val;
 	u8 int_n_inp0, int_n_inp1, int_n_inp2;
 
 	int_mux_cfg0 = CDC_WSA_RX_INP_MUX_RX_INT0_CFG0 + interp_idx * 8;
 	int_mux_cfg1 = int_mux_cfg0 + 4;
-	int_mux_cfg0_val = snd_soc_component_read(component, int_mux_cfg0);
-	int_mux_cfg1_val = snd_soc_component_read(component, int_mux_cfg1);
 
-	int_n_inp0 = int_mux_cfg0_val & 0x0F;
+	int_n_inp0 = snd_soc_component_read_field(component, int_mux_cfg0,
+						  CDC_WSA_RX_INTX_1_MIX_INP0_SEL_MASK);
 	if (int_n_inp0 == INTn_1_INP_SEL_DEC0 ||
 		int_n_inp0 == INTn_1_INP_SEL_DEC1)
 		return true;
 
-	int_n_inp1 = int_mux_cfg0_val >> 4;
+	int_n_inp1 = snd_soc_component_read_field(component, int_mux_cfg0,
+						  CDC_WSA_RX_INTX_1_MIX_INP1_SEL_MASK);
 	if (int_n_inp1 == INTn_1_INP_SEL_DEC0 ||
 		int_n_inp1 == INTn_1_INP_SEL_DEC1)
 		return true;
 
-	int_n_inp2 = int_mux_cfg1_val >> 4;
+	int_n_inp2 = snd_soc_component_read_field(component, int_mux_cfg1,
+						  CDC_WSA_RX_INTX_1_MIX_INP2_SEL_MASK);
 	if (int_n_inp2 == INTn_1_INP_SEL_DEC0 ||
 		int_n_inp2 == INTn_1_INP_SEL_DEC1)
 		return true;
-- 
2.21.0

