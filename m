Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548B3303CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392616AbhAZMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392608AbhAZMVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:21:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B1C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:21:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u14so2263940wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cT55FABjLyu7dYc21lezhM1CvuGo2h6vplhaEe339cE=;
        b=sQxtrAPDGHx28PS3PrAnLjW3O2df6d9uwXWZIEBDIGzcESNVEOPE1i+zgd7bz7+HFW
         +RJraLD8FsYZxVW3Enf2ePmMMCy+oWrGyz3uKQnWvsflUqX/KHiPbv5VpKXaAWe7qmyr
         RjZOdQiWWyLnLuwvhVN+T15cCq60JjjVz3KDudUNccZR3NF4f8wNcqNJJqGmBKw/4wOM
         zNhgx4fGWVwOZhX5Audny0MNcRjM3Ob4Ehc6G6OGfXki6SoqiVYeSXGYSguoMM2ivPkg
         cyFQxZFonRCYyNL0fxdOExiHNaNS/hQ5lljb4Rrnxj+VbmBAbCuKQlaw1tXuHWYylV61
         iPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cT55FABjLyu7dYc21lezhM1CvuGo2h6vplhaEe339cE=;
        b=s3aYNJqapz7A2QIc8S04IjlxR1NgG/b96OHg/70oFlVdvlx0tdjGc9Dq1Sl7ShEDVC
         j3xHKXURXn5e/1788llZJjTdOk4BiQtBsgRlryC9yUq7XRxxB9EJaXqEerdU5ld8qchw
         slYdY7yFrrMp0YGcmxCGuuq+RukBGj29y4H8D+Z9JBTgTtJ+si30hmVe/b8BgHnYbNTK
         t6WJeFyjIYsSiszUZ1YimkXEYjTG+0PkL8+SAVvl6Yl8OXHcb5PHWHL64k8vNgKZkabM
         yWVnQDDOR3XxjWDZd8a+eozXxIDOp2LD7jyREOfoOeH5lc671CnjDl4wi/yJw9yq9IPP
         GaRQ==
X-Gm-Message-State: AOAM530lVHqcy0oHTJvBwhxErw+YgOXhGsqPyXN6RAbuVYCsGRrEgGZy
        XL/m/+twxV6B79eUv2i3FQAOLg==
X-Google-Smtp-Source: ABdhPJz1Yn21nLtfD6Rp/dnNNMIkgoRGpyYiVEm1W+D0VRqMZ+wmEX21ZV0nZrNocfXjZpIHOgjH6g==
X-Received: by 2002:a1c:1b83:: with SMTP id b125mr4528765wmb.8.1611663661202;
        Tue, 26 Jan 2021 04:21:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o124sm3218908wmb.5.2021.01.26.04.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:21:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 2/2] ASoC: codecs: lpass-wsa-macro: make use of snd_soc_component_read_field()
Date:   Tue, 26 Jan 2021 12:20:20 +0000
Message-Id: <20210126122020.19735-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
References: <20210126122020.19735-1-srinivas.kandagatla@linaro.org>
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

