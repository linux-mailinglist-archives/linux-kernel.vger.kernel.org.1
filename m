Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4414298F13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781287AbgJZOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:20:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38255 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781248AbgJZOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:20:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id n18so12793305wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aUgbdr53T1UgR0Yju4pH8dbeug73XZ4DbafrpXWl3k=;
        b=lovqLYAt/OiqWPG/I4Lr2xUjvKjO6hxXpShV437c3It+qClwuPjs7qrN0dE9YxsmRZ
         ksEadV2BATCroOlE2iuS3FEevurQiScr5hkSdNP0XapH3b2ErvkbC2Xht7LzB5InCHXo
         oLntqqxIn0RSApc+F8nes9x4NlTY2vYts2I6PcQ88QlR6pZmtxQjhbZ2lue5vA5QDnNF
         8UJvYlOIRp7ypYedNlHV6EMIHhv7E2y436eKV468/7sXbiXsjD3xoL/1TKNm7cMZiper
         SAP7Aqds2IilYbPBDlGVxpCWI7fYjoTEZeRRWdPvKhlyHrYqgfpnKlSvM5rVMUnhitUF
         1iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aUgbdr53T1UgR0Yju4pH8dbeug73XZ4DbafrpXWl3k=;
        b=VjBkkjyXFZlFKaQVvZR1sE5amvHro7OdCEmaxUsi5D+XbQmOrT/n053E7hMLxm/Isd
         z22CZABLYKVIBP9cQtXkAlRDLL0N4yWAEP+xqMxbGe2Sj7tmHht1cQXZyur4y4CE9htB
         LjoRtl/nqoI5LqboLCK0MhKoYjZ7Nam8A0jcVacxLOxIxW76fo1HWcibuIS26Dzh676W
         pWSA5oHTej5HGsY1xNrCc9mMgzj/7IQhdgaMFLYWZ/UIwR7/YpmXtOSc0IFGs7qreBCp
         PPnT0EdAvTU1HG+12YV5SnyDNwq/Sgbv2SebIh0ba56oJ1dyTlGX0K/cypE5TlISRdGe
         XIeg==
X-Gm-Message-State: AOAM530VjbRZyEaczHOQpUAdFc0D2GHS3AoNWi1IHLCBe4KXVXrdSqai
        +eDxJQNcZRhFFYck0m1R8CYRaQ==
X-Google-Smtp-Source: ABdhPJyjTWlGVKEsitVsN67qw3Z7NkkIgcR0i5Ot1JXvjyw2cACO3iGpG4xqaJIQtukZE8K+Muu/GQ==
X-Received: by 2002:a05:6000:36f:: with SMTP id f15mr18016523wrf.78.1603722001963;
        Mon, 26 Oct 2020 07:20:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g4sm20253333wmh.13.2020.10.26.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:20:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 6/6] ASoC: codecs: lpass-va-macro: add dapm widgets and routes
Date:   Mon, 26 Oct 2020 14:19:45 +0000
Message-Id: <20201026141945.19707-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dapm widgets and routes for this codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 618 ++++++++++++++++++++++++++++++
 1 file changed, 618 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 6f1565cf0d01..40865f2c438b 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -451,6 +451,327 @@ static int va_macro_mclk_enable(struct va_macro *va, bool mclk_enable)
 	return 0;
 }
 
+static int va_macro_mclk_event(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	struct va_macro *va = snd_soc_component_get_drvdata(comp);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return va_macro_mclk_enable(va, true);
+	case SND_SOC_DAPM_POST_PMD:
+		return va_macro_mclk_enable(va, false);
+	}
+
+	return 0;
+}
+
+static int va_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *widget =
+		snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(widget->dapm);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int val;
+	u16 mic_sel_reg;
+
+	val = ucontrol->value.enumerated.item[0];
+
+	switch (e->reg) {
+	case CDC_VA_INP_MUX_ADC_MUX0_CFG0:
+		mic_sel_reg = CDC_VA_TX0_TX_PATH_CFG0;
+		break;
+	case CDC_VA_INP_MUX_ADC_MUX1_CFG0:
+		mic_sel_reg = CDC_VA_TX1_TX_PATH_CFG0;
+		break;
+	case CDC_VA_INP_MUX_ADC_MUX2_CFG0:
+		mic_sel_reg = CDC_VA_TX2_TX_PATH_CFG0;
+		break;
+	case CDC_VA_INP_MUX_ADC_MUX3_CFG0:
+		mic_sel_reg = CDC_VA_TX3_TX_PATH_CFG0;
+		break;
+	default:
+		dev_err(component->dev, "%s: e->reg: 0x%x not expected\n",
+			__func__, e->reg);
+		return -EINVAL;
+	}
+
+	if (val != 0)
+		snd_soc_component_update_bits(component, mic_sel_reg,
+					      CDC_VA_TX_PATH_ADC_DMIC_SEL_MASK,
+					      CDC_VA_TX_PATH_ADC_DMIC_SEL_DMIC);
+
+	return snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+}
+
+static int va_macro_tx_mixer_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *widget =
+		snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct snd_soc_component *component =
+				snd_soc_dapm_to_component(widget->dapm);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	u32 dai_id = widget->shift;
+	u32 dec_id = mc->shift;
+	struct va_macro *va = snd_soc_component_get_drvdata(component);
+
+	if (test_bit(dec_id, &va->active_ch_mask[dai_id]))
+		ucontrol->value.integer.value[0] = 1;
+	else
+		ucontrol->value.integer.value[0] = 0;
+
+	return 0;
+}
+
+static int va_macro_tx_mixer_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget *widget =
+					snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct snd_soc_component *component =
+				snd_soc_dapm_to_component(widget->dapm);
+	struct snd_soc_dapm_update *update = NULL;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	u32 dai_id = widget->shift;
+	u32 dec_id = mc->shift;
+	u32 enable = ucontrol->value.integer.value[0];
+	struct va_macro *va = snd_soc_component_get_drvdata(component);
+
+	if (enable) {
+		set_bit(dec_id, &va->active_ch_mask[dai_id]);
+		va->active_ch_cnt[dai_id]++;
+		va->active_decimator[dai_id] = dec_id;
+	} else {
+		clear_bit(dec_id, &va->active_ch_mask[dai_id]);
+		va->active_ch_cnt[dai_id]--;
+		va->active_decimator[dai_id] = -1;
+	}
+
+	snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol, enable, update);
+
+	return 0;
+}
+
+static int va_dmic_clk_enable(struct snd_soc_component *component,
+			      u32 dmic, bool enable)
+{
+	struct va_macro *va = snd_soc_component_get_drvdata(component);
+	u8  dmic_clk_en = 0x01;
+	u16 dmic_clk_reg = 0;
+	s32 *dmic_clk_cnt = NULL;
+	u8 *dmic_clk_div = NULL;
+	u8 freq_change_mask = 0;
+	u8 clk_div = 0;
+
+	switch (dmic) {
+	case 0:
+	case 1:
+		dmic_clk_cnt = &(va->dmic_0_1_clk_cnt);
+		dmic_clk_div = &(va->dmic_0_1_clk_div);
+		dmic_clk_reg = CDC_VA_TOP_CSR_DMIC0_CTL;
+		freq_change_mask = CDC_VA_DMIC0_FREQ_CHANGE_MASK;
+		break;
+	case 2:
+	case 3:
+		dmic_clk_cnt = &(va->dmic_2_3_clk_cnt);
+		dmic_clk_div = &(va->dmic_2_3_clk_div);
+		dmic_clk_reg = CDC_VA_TOP_CSR_DMIC1_CTL;
+		freq_change_mask = CDC_VA_DMIC1_FREQ_CHANGE_MASK;
+		break;
+	case 4:
+	case 5:
+		dmic_clk_cnt = &(va->dmic_4_5_clk_cnt);
+		dmic_clk_div = &(va->dmic_4_5_clk_div);
+		dmic_clk_reg = CDC_VA_TOP_CSR_DMIC2_CTL;
+		freq_change_mask = CDC_VA_DMIC2_FREQ_CHANGE_MASK;
+		break;
+	case 6:
+	case 7:
+		dmic_clk_cnt = &(va->dmic_6_7_clk_cnt);
+		dmic_clk_div = &(va->dmic_6_7_clk_div);
+		dmic_clk_reg = CDC_VA_TOP_CSR_DMIC3_CTL;
+		freq_change_mask = CDC_VA_DMIC3_FREQ_CHANGE_MASK;
+		break;
+	default:
+		dev_err(component->dev, "%s: Invalid DMIC Selection\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (enable) {
+		clk_div = va->dmic_clk_div;
+		(*dmic_clk_cnt)++;
+		if (*dmic_clk_cnt == 1) {
+			snd_soc_component_update_bits(component,
+					      CDC_VA_TOP_CSR_DMIC_CFG,
+					      CDC_VA_RESET_ALL_DMICS_MASK,
+					      CDC_VA_RESET_ALL_DMICS_DISABLE);
+			snd_soc_component_update_bits(component, dmic_clk_reg,
+					CDC_VA_DMIC_CLK_SEL_MASK,
+					clk_div << CDC_VA_DMIC_CLK_SEL_SHFT);
+			snd_soc_component_update_bits(component, dmic_clk_reg,
+					dmic_clk_en, dmic_clk_en);
+		} else {
+			if (*dmic_clk_div > clk_div) {
+				snd_soc_component_update_bits(component,
+						CDC_VA_TOP_CSR_DMIC_CFG,
+						freq_change_mask,
+						freq_change_mask);
+				snd_soc_component_update_bits(component, dmic_clk_reg,
+						CDC_VA_DMIC_CLK_SEL_MASK,
+						clk_div << CDC_VA_DMIC_CLK_SEL_SHFT);
+				snd_soc_component_update_bits(component,
+					      CDC_VA_TOP_CSR_DMIC_CFG,
+					      freq_change_mask,
+					      CDC_VA_DMIC_FREQ_CHANGE_DISABLE);
+			} else {
+				clk_div = *dmic_clk_div;
+			}
+		}
+		*dmic_clk_div = clk_div;
+	} else {
+		(*dmic_clk_cnt)--;
+		if (*dmic_clk_cnt  == 0) {
+			snd_soc_component_update_bits(component, dmic_clk_reg,
+					dmic_clk_en, 0);
+			clk_div = 0;
+			snd_soc_component_update_bits(component, dmic_clk_reg,
+						CDC_VA_DMIC_CLK_SEL_MASK,
+						clk_div << CDC_VA_DMIC_CLK_SEL_SHFT);
+		} else {
+			clk_div = va->dmic_clk_div;
+			if (*dmic_clk_div > clk_div) {
+				clk_div = va->dmic_clk_div;
+				snd_soc_component_update_bits(component,
+							CDC_VA_TOP_CSR_DMIC_CFG,
+							freq_change_mask,
+							freq_change_mask);
+				snd_soc_component_update_bits(component, dmic_clk_reg,
+						CDC_VA_DMIC_CLK_SEL_MASK,
+						clk_div << CDC_VA_DMIC_CLK_SEL_SHFT);
+				snd_soc_component_update_bits(component,
+						      CDC_VA_TOP_CSR_DMIC_CFG,
+						      freq_change_mask,
+						      CDC_VA_DMIC_FREQ_CHANGE_DISABLE);
+			} else {
+				clk_div = *dmic_clk_div;
+			}
+		}
+		*dmic_clk_div = clk_div;
+	}
+
+	return 0;
+}
+
+static int va_macro_enable_dmic(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	unsigned int dmic = w->shift;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		va_dmic_clk_enable(comp, dmic, true);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		va_dmic_clk_enable(comp, dmic, false);
+		break;
+	}
+
+	return 0;
+}
+
+static int va_macro_enable_dec(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	unsigned int decimator;
+	u16 tx_vol_ctl_reg, dec_cfg_reg, hpf_gate_reg;
+	u16 tx_gain_ctl_reg;
+	u8 hpf_cut_off_freq;
+
+	struct va_macro *va = snd_soc_component_get_drvdata(comp);
+
+	decimator = w->shift;
+
+	tx_vol_ctl_reg = CDC_VA_TX0_TX_PATH_CTL +
+				VA_MACRO_TX_PATH_OFFSET * decimator;
+	hpf_gate_reg = CDC_VA_TX0_TX_PATH_SEC2 +
+				VA_MACRO_TX_PATH_OFFSET * decimator;
+	dec_cfg_reg = CDC_VA_TX0_TX_PATH_CFG0 +
+				VA_MACRO_TX_PATH_OFFSET * decimator;
+	tx_gain_ctl_reg = CDC_VA_TX0_TX_VOL_CTL +
+				VA_MACRO_TX_PATH_OFFSET * decimator;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(comp,
+			dec_cfg_reg, CDC_VA_ADC_MODE_MASK,
+			va->dec_mode[decimator] << CDC_VA_ADC_MODE_SHIFT);
+		/* Enable TX PGA Mute */
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/* Enable TX CLK */
+		snd_soc_component_update_bits(comp, tx_vol_ctl_reg,
+					      CDC_VA_TX_PATH_CLK_EN_MASK,
+					      CDC_VA_TX_PATH_CLK_EN);
+		snd_soc_component_update_bits(comp, hpf_gate_reg,
+					      CDC_VA_TX_HPF_ZERO_GATE_MASK,
+					      CDC_VA_TX_HPF_ZERO_GATE);
+
+		usleep_range(1000, 1010);
+		hpf_cut_off_freq = (snd_soc_component_read(comp, dec_cfg_reg) &
+				    TX_HPF_CUT_OFF_FREQ_MASK) >> 5;
+
+		if (hpf_cut_off_freq != CF_MIN_3DB_150HZ) {
+			snd_soc_component_update_bits(comp, dec_cfg_reg,
+						      TX_HPF_CUT_OFF_FREQ_MASK,
+						      CF_MIN_3DB_150HZ << 5);
+
+			snd_soc_component_update_bits(comp, hpf_gate_reg,
+				      CDC_VA_TX_HPF_CUTOFF_FREQ_CHANGE_MASK,
+				      CDC_VA_TX_HPF_CUTOFF_FREQ_CHANGE_REQ);
+
+			/*
+			 * Minimum 1 clk cycle delay is required as per HW spec
+			 */
+			usleep_range(1000, 1010);
+
+			snd_soc_component_update_bits(comp,
+				hpf_gate_reg,
+				CDC_VA_TX_HPF_CUTOFF_FREQ_CHANGE_MASK,
+				0x0);
+		}
+
+
+		usleep_range(1000, 1010);
+		snd_soc_component_update_bits(comp, hpf_gate_reg,
+					      CDC_VA_TX_HPF_ZERO_GATE_MASK,
+					      CDC_VA_TX_HPF_ZERO_NO_GATE);
+		/*
+		 * 6ms delay is required as per HW spec
+		 */
+		usleep_range(6000, 6010);
+		/* apply gain after decimator is enabled */
+		snd_soc_component_write(comp, tx_gain_ctl_reg,
+			snd_soc_component_read(comp, tx_gain_ctl_reg));
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Disable TX CLK */
+		snd_soc_component_update_bits(comp, tx_vol_ctl_reg,
+						CDC_VA_TX_PATH_CLK_EN_MASK,
+						CDC_VA_TX_PATH_CLK_DISABLE);
+		break;
+	}
+	return 0;
+}
+
 static int va_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
@@ -630,6 +951,299 @@ static struct snd_soc_dai_driver va_macro_dais[] = {
 	},
 };
 
+static const char * const adc_mux_text[] = {
+	"VA_DMIC", "SWR_MIC"
+};
+
+static SOC_ENUM_SINGLE_DECL(va_dec0_enum, CDC_VA_INP_MUX_ADC_MUX0_CFG1,
+		   0, adc_mux_text);
+static SOC_ENUM_SINGLE_DECL(va_dec1_enum, CDC_VA_INP_MUX_ADC_MUX1_CFG1,
+		   0, adc_mux_text);
+static SOC_ENUM_SINGLE_DECL(va_dec2_enum, CDC_VA_INP_MUX_ADC_MUX2_CFG1,
+		   0, adc_mux_text);
+static SOC_ENUM_SINGLE_DECL(va_dec3_enum, CDC_VA_INP_MUX_ADC_MUX3_CFG1,
+		   0, adc_mux_text);
+
+static const struct snd_kcontrol_new va_dec0_mux = SOC_DAPM_ENUM("va_dec0",
+								 va_dec0_enum);
+static const struct snd_kcontrol_new va_dec1_mux = SOC_DAPM_ENUM("va_dec1",
+								 va_dec1_enum);
+static const struct snd_kcontrol_new va_dec2_mux = SOC_DAPM_ENUM("va_dec2",
+								 va_dec2_enum);
+static const struct snd_kcontrol_new va_dec3_mux = SOC_DAPM_ENUM("va_dec3",
+								 va_dec3_enum);
+
+static const char * const dmic_mux_text[] = {
+	"ZERO", "DMIC0", "DMIC1", "DMIC2", "DMIC3",
+	"DMIC4", "DMIC5", "DMIC6", "DMIC7"
+};
+
+static SOC_ENUM_SINGLE_DECL(va_dmic0_enum, CDC_VA_INP_MUX_ADC_MUX0_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(va_dmic1_enum, CDC_VA_INP_MUX_ADC_MUX1_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(va_dmic2_enum, CDC_VA_INP_MUX_ADC_MUX2_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(va_dmic3_enum, CDC_VA_INP_MUX_ADC_MUX3_CFG0,
+			4, dmic_mux_text);
+
+static const struct snd_kcontrol_new va_dmic0_mux = SOC_DAPM_ENUM_EXT("va_dmic0",
+			 va_dmic0_enum, snd_soc_dapm_get_enum_double,
+			 va_macro_put_dec_enum);
+
+static const struct snd_kcontrol_new va_dmic1_mux = SOC_DAPM_ENUM_EXT("va_dmic1",
+			 va_dmic1_enum, snd_soc_dapm_get_enum_double,
+			 va_macro_put_dec_enum);
+
+static const struct snd_kcontrol_new va_dmic2_mux = SOC_DAPM_ENUM_EXT("va_dmic2",
+			 va_dmic2_enum, snd_soc_dapm_get_enum_double,
+			 va_macro_put_dec_enum);
+
+static const struct snd_kcontrol_new va_dmic3_mux = SOC_DAPM_ENUM_EXT("va_dmic3",
+			 va_dmic3_enum, snd_soc_dapm_get_enum_double,
+			 va_macro_put_dec_enum);
+
+static const struct snd_kcontrol_new va_aif1_cap_mixer[] = {
+	SOC_SINGLE_EXT("DEC0", SND_SOC_NOPM, VA_MACRO_DEC0, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC1", SND_SOC_NOPM, VA_MACRO_DEC1, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC2", SND_SOC_NOPM, VA_MACRO_DEC2, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC3", SND_SOC_NOPM, VA_MACRO_DEC3, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC4", SND_SOC_NOPM, VA_MACRO_DEC4, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC5", SND_SOC_NOPM, VA_MACRO_DEC5, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC6", SND_SOC_NOPM, VA_MACRO_DEC6, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC7", SND_SOC_NOPM, VA_MACRO_DEC7, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+};
+
+static const struct snd_kcontrol_new va_aif2_cap_mixer[] = {
+	SOC_SINGLE_EXT("DEC0", SND_SOC_NOPM, VA_MACRO_DEC0, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC1", SND_SOC_NOPM, VA_MACRO_DEC1, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC2", SND_SOC_NOPM, VA_MACRO_DEC2, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC3", SND_SOC_NOPM, VA_MACRO_DEC3, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC4", SND_SOC_NOPM, VA_MACRO_DEC4, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC5", SND_SOC_NOPM, VA_MACRO_DEC5, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC6", SND_SOC_NOPM, VA_MACRO_DEC6, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC7", SND_SOC_NOPM, VA_MACRO_DEC7, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+};
+
+static const struct snd_kcontrol_new va_aif3_cap_mixer[] = {
+	SOC_SINGLE_EXT("DEC0", SND_SOC_NOPM, VA_MACRO_DEC0, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC1", SND_SOC_NOPM, VA_MACRO_DEC1, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC2", SND_SOC_NOPM, VA_MACRO_DEC2, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC3", SND_SOC_NOPM, VA_MACRO_DEC3, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC4", SND_SOC_NOPM, VA_MACRO_DEC4, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC5", SND_SOC_NOPM, VA_MACRO_DEC5, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC6", SND_SOC_NOPM, VA_MACRO_DEC6, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+	SOC_SINGLE_EXT("DEC7", SND_SOC_NOPM, VA_MACRO_DEC7, 1, 0,
+			va_macro_tx_mixer_get, va_macro_tx_mixer_put),
+};
+
+static const struct snd_soc_dapm_widget va_macro_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("VA_AIF1 CAP", "VA_AIF1 Capture", 0,
+		SND_SOC_NOPM, VA_MACRO_AIF1_CAP, 0),
+
+	SND_SOC_DAPM_AIF_OUT("VA_AIF2 CAP", "VA_AIF2 Capture", 0,
+		SND_SOC_NOPM, VA_MACRO_AIF2_CAP, 0),
+
+	SND_SOC_DAPM_AIF_OUT("VA_AIF3 CAP", "VA_AIF3 Capture", 0,
+		SND_SOC_NOPM, VA_MACRO_AIF3_CAP, 0),
+
+	SND_SOC_DAPM_MIXER("VA_AIF1_CAP Mixer", SND_SOC_NOPM,
+		VA_MACRO_AIF1_CAP, 0,
+		va_aif1_cap_mixer, ARRAY_SIZE(va_aif1_cap_mixer)),
+
+	SND_SOC_DAPM_MIXER("VA_AIF2_CAP Mixer", SND_SOC_NOPM,
+		VA_MACRO_AIF2_CAP, 0,
+		va_aif2_cap_mixer, ARRAY_SIZE(va_aif2_cap_mixer)),
+
+	SND_SOC_DAPM_MIXER("VA_AIF3_CAP Mixer", SND_SOC_NOPM,
+		VA_MACRO_AIF3_CAP, 0,
+		va_aif3_cap_mixer, ARRAY_SIZE(va_aif3_cap_mixer)),
+
+	SND_SOC_DAPM_MUX("VA DMIC MUX0", SND_SOC_NOPM, 0, 0, &va_dmic0_mux),
+	SND_SOC_DAPM_MUX("VA DMIC MUX1", SND_SOC_NOPM, 0, 0, &va_dmic1_mux),
+	SND_SOC_DAPM_MUX("VA DMIC MUX2", SND_SOC_NOPM, 0, 0, &va_dmic2_mux),
+	SND_SOC_DAPM_MUX("VA DMIC MUX3", SND_SOC_NOPM, 0, 0, &va_dmic3_mux),
+
+	SND_SOC_DAPM_REGULATOR_SUPPLY("vdd-micb", 0, 0),
+	SND_SOC_DAPM_INPUT("DMIC0 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC1 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC2 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC3 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC4 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC5 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC6 Pin"),
+	SND_SOC_DAPM_INPUT("DMIC7 Pin"),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC0", NULL, SND_SOC_NOPM, 0, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC1", NULL, SND_SOC_NOPM, 1, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC2", NULL, SND_SOC_NOPM, 2, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC3", NULL, SND_SOC_NOPM, 3, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC4", NULL, SND_SOC_NOPM, 4, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC5", NULL, SND_SOC_NOPM, 5, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC6", NULL, SND_SOC_NOPM, 6, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("VA DMIC7", NULL, SND_SOC_NOPM, 7, 0,
+		va_macro_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_INPUT("VA SWR_ADC0"),
+	SND_SOC_DAPM_INPUT("VA SWR_ADC1"),
+	SND_SOC_DAPM_INPUT("VA SWR_ADC2"),
+	SND_SOC_DAPM_INPUT("VA SWR_ADC3"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC0"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC1"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC2"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC3"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC4"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC5"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC6"),
+	SND_SOC_DAPM_INPUT("VA SWR_MIC7"),
+
+	SND_SOC_DAPM_MUX_E("VA DEC0 MUX", SND_SOC_NOPM, VA_MACRO_DEC0, 0,
+			   &va_dec0_mux, va_macro_enable_dec,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX_E("VA DEC1 MUX", SND_SOC_NOPM, VA_MACRO_DEC1, 0,
+			   &va_dec1_mux, va_macro_enable_dec,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX_E("VA DEC2 MUX", SND_SOC_NOPM, VA_MACRO_DEC2, 0,
+			   &va_dec2_mux, va_macro_enable_dec,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX_E("VA DEC3 MUX", SND_SOC_NOPM, VA_MACRO_DEC3, 0,
+			   &va_dec3_mux, va_macro_enable_dec,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("VA_MCLK", -1, SND_SOC_NOPM, 0, 0,
+			      va_macro_mclk_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route va_audio_map[] = {
+	{"VA_AIF1 CAP", NULL, "VA_MCLK"},
+	{"VA_AIF2 CAP", NULL, "VA_MCLK"},
+	{"VA_AIF3 CAP", NULL, "VA_MCLK"},
+
+	{"VA_AIF1 CAP", NULL, "VA_AIF1_CAP Mixer"},
+	{"VA_AIF2 CAP", NULL, "VA_AIF2_CAP Mixer"},
+	{"VA_AIF3 CAP", NULL, "VA_AIF3_CAP Mixer"},
+
+	{"VA_AIF1_CAP Mixer", "DEC0", "VA DEC0 MUX"},
+	{"VA_AIF1_CAP Mixer", "DEC1", "VA DEC1 MUX"},
+	{"VA_AIF1_CAP Mixer", "DEC2", "VA DEC2 MUX"},
+	{"VA_AIF1_CAP Mixer", "DEC3", "VA DEC3 MUX"},
+
+	{"VA_AIF2_CAP Mixer", "DEC0", "VA DEC0 MUX"},
+	{"VA_AIF2_CAP Mixer", "DEC1", "VA DEC1 MUX"},
+	{"VA_AIF2_CAP Mixer", "DEC2", "VA DEC2 MUX"},
+	{"VA_AIF2_CAP Mixer", "DEC3", "VA DEC3 MUX"},
+
+	{"VA_AIF3_CAP Mixer", "DEC0", "VA DEC0 MUX"},
+	{"VA_AIF3_CAP Mixer", "DEC1", "VA DEC1 MUX"},
+	{"VA_AIF3_CAP Mixer", "DEC2", "VA DEC2 MUX"},
+	{"VA_AIF3_CAP Mixer", "DEC3", "VA DEC3 MUX"},
+
+	{"VA DEC0 MUX", "VA_DMIC", "VA DMIC MUX0"},
+	{"VA DMIC MUX0", "DMIC0", "VA DMIC0"},
+	{"VA DMIC MUX0", "DMIC1", "VA DMIC1"},
+	{"VA DMIC MUX0", "DMIC2", "VA DMIC2"},
+	{"VA DMIC MUX0", "DMIC3", "VA DMIC3"},
+	{"VA DMIC MUX0", "DMIC4", "VA DMIC4"},
+	{"VA DMIC MUX0", "DMIC5", "VA DMIC5"},
+	{"VA DMIC MUX0", "DMIC6", "VA DMIC6"},
+	{"VA DMIC MUX0", "DMIC7", "VA DMIC7"},
+
+	{"VA DEC1 MUX", "VA_DMIC", "VA DMIC MUX1"},
+	{"VA DMIC MUX1", "DMIC0", "VA DMIC0"},
+	{"VA DMIC MUX1", "DMIC1", "VA DMIC1"},
+	{"VA DMIC MUX1", "DMIC2", "VA DMIC2"},
+	{"VA DMIC MUX1", "DMIC3", "VA DMIC3"},
+	{"VA DMIC MUX1", "DMIC4", "VA DMIC4"},
+	{"VA DMIC MUX1", "DMIC5", "VA DMIC5"},
+	{"VA DMIC MUX1", "DMIC6", "VA DMIC6"},
+	{"VA DMIC MUX1", "DMIC7", "VA DMIC7"},
+
+	{"VA DEC2 MUX", "VA_DMIC", "VA DMIC MUX2"},
+	{"VA DMIC MUX2", "DMIC0", "VA DMIC0"},
+	{"VA DMIC MUX2", "DMIC1", "VA DMIC1"},
+	{"VA DMIC MUX2", "DMIC2", "VA DMIC2"},
+	{"VA DMIC MUX2", "DMIC3", "VA DMIC3"},
+	{"VA DMIC MUX2", "DMIC4", "VA DMIC4"},
+	{"VA DMIC MUX2", "DMIC5", "VA DMIC5"},
+	{"VA DMIC MUX2", "DMIC6", "VA DMIC6"},
+	{"VA DMIC MUX2", "DMIC7", "VA DMIC7"},
+
+	{"VA DEC3 MUX", "VA_DMIC", "VA DMIC MUX3"},
+	{"VA DMIC MUX3", "DMIC0", "VA DMIC0"},
+	{"VA DMIC MUX3", "DMIC1", "VA DMIC1"},
+	{"VA DMIC MUX3", "DMIC2", "VA DMIC2"},
+	{"VA DMIC MUX3", "DMIC3", "VA DMIC3"},
+	{"VA DMIC MUX3", "DMIC4", "VA DMIC4"},
+	{"VA DMIC MUX3", "DMIC5", "VA DMIC5"},
+	{"VA DMIC MUX3", "DMIC6", "VA DMIC6"},
+	{"VA DMIC MUX3", "DMIC7", "VA DMIC7"},
+
+	{ "VA DMIC0", NULL, "DMIC0 Pin" },
+	{ "VA DMIC1", NULL, "DMIC1 Pin" },
+	{ "VA DMIC2", NULL, "DMIC2 Pin" },
+	{ "VA DMIC3", NULL, "DMIC3 Pin" },
+	{ "VA DMIC4", NULL, "DMIC4 Pin" },
+	{ "VA DMIC5", NULL, "DMIC5 Pin" },
+	{ "VA DMIC6", NULL, "DMIC6 Pin" },
+	{ "VA DMIC7", NULL, "DMIC7 Pin" },
+};
+
 static const char * const dec_mode_mux_text[] = {
 	"ADC_DEFAULT", "ADC_LOW_PWR", "ADC_HIGH_PERF",
 };
@@ -679,6 +1293,10 @@ static const struct snd_soc_component_driver va_macro_component_drv = {
 	.probe = va_macro_component_probe,
 	.controls = va_macro_snd_controls,
 	.num_controls = ARRAY_SIZE(va_macro_snd_controls),
+	.dapm_widgets = va_macro_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(va_macro_dapm_widgets),
+	.dapm_routes = va_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(va_audio_map),
 };
 
 static int fsgen_gate_enable(struct clk_hw *hw)
-- 
2.21.0

