Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B33299AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407033AbgJZXff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:35:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:30095 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406967AbgJZXfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:35:34 -0400
IronPort-SDR: oyE2hIC6b5WovcFvV3HcmBeDNIJiZ3rlSUBGA5u6WoU5ZLliWNSpoBcdcZUhNgndYv5EVVfXXq
 BYmOESkRHo6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232190077"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="232190077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:33 -0700
IronPort-SDR: keeDMUxqBjTiVqha2kvrjyKasMLiCIBMsJTC6u98Qw2iQLuyQ5k9bbsvAO6OPfPhEyeHDs/VF3
 3JDYE2k/maZg==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="524475081"
Received: from tanguye1-mobl2.amr.corp.intel.com (HELO [10.209.126.195]) ([10.209.126.195])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:32 -0700
Subject: Re: [PATCH v1 3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets
 and route
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, plai@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
 <20201026141945.19707-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <98d3f89b-8d71-e652-504b-2bb770532a09@linux.intel.com>
Date:   Mon, 26 Oct 2020 14:58:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026141945.19707-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int wsa_macro_mclk_event(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		wsa_macro_mclk_enable(wsa, true);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		wsa_macro_mclk_enable(wsa, false);
> +		break;
> +	}

wsa_macro_mclk_enable(wsa, event == SND_SOC_DAPM_PRE_PMU) ?

[...]

> +static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
> +				     struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	u16 gain_reg;
> +	int offset_val = 0;

value zero and not useful. remove? or is this a bug?

> +	int val = 0;

initialization not needed?

> +
> +	switch (w->reg) {
> +	case CDC_WSA_RX0_RX_PATH_MIX_CTL:
> +		gain_reg = CDC_WSA_RX0_RX_VOL_MIX_CTL;
> +		break;
> +	case CDC_WSA_RX1_RX_PATH_MIX_CTL:
> +		gain_reg = CDC_WSA_RX1_RX_VOL_MIX_CTL;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		val = snd_soc_component_read(component, gain_reg);
> +		val += offset_val;
> +		snd_soc_component_write(component, gain_reg, val);

if offset_val is zero, this does not seem very useful to read and write 
the same value?

> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		snd_soc_component_update_bits(component, w->reg,
> +					      CDC_WSA_RX_PATH_MIX_CLK_EN_MASK,
> +					      CDC_WSA_RX_PATH_MIX_CLK_DISABLE);
> +		break;
> +	}
> +
> +	return 0;
> +}

[...]

> +static void wsa_macro_enable_softclip_clk(struct snd_soc_component *component,
> +					 struct wsa_macro *wsa,
> +					 int path,
> +					 bool enable)
> +{
> +	u16 softclip_clk_reg = CDC_WSA_SOFTCLIP0_CRC +
> +			(path * WSA_MACRO_RX_SOFTCLIP_OFFSET);
> +	u8 softclip_mux_mask = (1 << path);
> +	u8 softclip_mux_value = (1 << path);

BIT(path) ?

> +
> +	if (enable) {
> +		if (wsa->softclip_clk_users[path] == 0) {
> +			snd_soc_component_update_bits(component,
> +						softclip_clk_reg,
> +						CDC_WSA_SOFTCLIP_CLK_EN_MASK,
> +						CDC_WSA_SOFTCLIP_CLK_ENABLE);
> +			snd_soc_component_update_bits(component,
> +				CDC_WSA_RX_INP_MUX_SOFTCLIP_CFG0,
> +				softclip_mux_mask, softclip_mux_value);
> +		}
> +		wsa->softclip_clk_users[path]++;
> +	} else {
> +		wsa->softclip_clk_users[path]--;
> +		if (wsa->softclip_clk_users[path] == 0) {
> +			snd_soc_component_update_bits(component,
> +						softclip_clk_reg,
> +						CDC_WSA_SOFTCLIP_CLK_EN_MASK,
> +						0);
> +			snd_soc_component_update_bits(component,
> +				CDC_WSA_RX_INP_MUX_SOFTCLIP_CFG0,
> +				softclip_mux_mask, 0x00);
> +		}
> +	}
> +}

[...]

> +static bool wsa_macro_adie_lb(struct snd_soc_component *component,
> +			      int interp_idx)
> +{
> +	u16 int_mux_cfg0 = 0, int_mux_cfg1 = 0;
> +	u8 int_mux_cfg0_val = 0, int_mux_cfg1_val = 0;
> +	u8 int_n_inp0 = 0, int_n_inp1 = 0, int_n_inp2 = 0;

this looks like a lot of unnecessary inits. All of these three variables 
are set unconditionally below.

Run cppcheck on this sort of code:

cppcheck --platform=unix32 --force --max-configs=1024 --inconclusive
--enable=all --suppress=variableScope sound/soc/codecs/lpass-wsa-macro.c


> +
> +	int_mux_cfg0 = CDC_WSA_RX_INP_MUX_RX_INT0_CFG0 + interp_idx * 8;
> +	int_mux_cfg1 = int_mux_cfg0 + 4;
> +	int_mux_cfg0_val = snd_soc_component_read(component, int_mux_cfg0);
> +	int_mux_cfg1_val = snd_soc_component_read(component, int_mux_cfg1);
> +
> +	int_n_inp0 = int_mux_cfg0_val & 0x0F;
> +	if (int_n_inp0 == INTn_1_INP_SEL_DEC0 ||
> +		int_n_inp0 == INTn_1_INP_SEL_DEC1)
> +		return true;
> +
> +	int_n_inp1 = int_mux_cfg0_val >> 4;
> +	if (int_n_inp1 == INTn_1_INP_SEL_DEC0 ||
> +		int_n_inp1 == INTn_1_INP_SEL_DEC1)
> +		return true;
> +
> +	int_n_inp2 = int_mux_cfg1_val >> 4;
> +	if (int_n_inp2 == INTn_1_INP_SEL_DEC0 ||
> +		int_n_inp2 == INTn_1_INP_SEL_DEC1)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int wsa_macro_enable_main_path(struct snd_soc_dapm_widget *w,
> +				      struct snd_kcontrol *kcontrol,
> +				      int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	u16 reg = 0;

unnecessary init.

> +
> +	reg = CDC_WSA_RX0_RX_PATH_CTL + WSA_MACRO_RX_PATH_OFFSET * w->shift;
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (wsa_macro_adie_lb(component, w->shift)) {
> +			snd_soc_component_update_bits(component, reg,
> +					     CDC_WSA_RX_PATH_CLK_EN_MASK,
> +					     CDC_WSA_RX_PATH_CLK_ENABLE);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}

[...]

> +static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
> +					 struct snd_kcontrol *kcontrol,
> +					 int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	u16 gain_reg;
> +	u16 reg;
> +	int val;
> +	int offset_val = 0;
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);

nit-pick: x-mas tree style?

> +
> +	if (w->shift == WSA_MACRO_COMP1) {
> +		reg = CDC_WSA_RX0_RX_PATH_CTL;
> +		gain_reg = CDC_WSA_RX0_RX_VOL_CTL;
> +	} else if (w->shift == WSA_MACRO_COMP2) {
> +		reg = CDC_WSA_RX1_RX_PATH_CTL;
> +		gain_reg = CDC_WSA_RX1_RX_VOL_CTL;
> +	}
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		/* Reset if needed */
> +		wsa_macro_enable_prim_interpolator(component, reg, event);
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		wsa_macro_config_compander(component, w->shift, event);
> +		wsa_macro_config_softclip(component, w->shift, event);
> +		/* apply gain after int clk is enabled */
> +		if ((wsa->spkr_gain_offset == WSA_MACRO_GAIN_OFFSET_M1P5_DB) &&
> +		    (wsa->comp_enabled[WSA_MACRO_COMP1] ||
> +		     wsa->comp_enabled[WSA_MACRO_COMP2])) {
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX0_RX_PATH_SEC1,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX0_RX_PATH_MIX_SEC0,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX1_RX_PATH_SEC1,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> +			offset_val = -2;
> +		}
> +		val = snd_soc_component_read(component, gain_reg);
> +		val += offset_val;
> +		snd_soc_component_write(component, gain_reg, val);
> +		wsa_macro_config_ear_spkr_gain(component, wsa,
> +						event, gain_reg);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		wsa_macro_config_compander(component, w->shift, event);
> +		wsa_macro_config_softclip(component, w->shift, event);
> +		wsa_macro_enable_prim_interpolator(component, reg, event);
> +		if ((wsa->spkr_gain_offset == WSA_MACRO_GAIN_OFFSET_M1P5_DB) &&
> +		    (wsa->comp_enabled[WSA_MACRO_COMP1] ||
> +		     wsa->comp_enabled[WSA_MACRO_COMP2])) {
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX0_RX_PATH_SEC1,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX0_RX_PATH_MIX_SEC0,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX1_RX_PATH_SEC1,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> +			snd_soc_component_update_bits(component,
> +					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
> +					CDC_WSA_RX_PGA_HALF_DB_MASK,
> +					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> +			offset_val = 2;
> +			val = snd_soc_component_read(component, gain_reg);
> +			val += offset_val;
> +			snd_soc_component_write(component, gain_reg, val);
> +		}
> +		wsa_macro_config_ear_spkr_gain(component, wsa,
> +						event, gain_reg);
> +		break;
> +	}
> +
> +	return 0;
> +}

[...]

> +static int wsa_macro_enable_echo(struct snd_soc_dapm_widget *w,
> +				 struct snd_kcontrol *kcontrol,
> +				 int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
> +	u16 val, ec_tx = 0, ec_hq_reg;
> +
> +	val = snd_soc_component_read(component, CDC_WSA_RX_INP_MUX_RX_MIX_CFG0);
> +
> +	switch (w->shift) {
> +	case WSA_MACRO_EC0_MUX:
> +		val = val & CDC_WSA_RX_MIX_TX0_SEL_MASK;
> +		ec_tx = val - 1;
> +		break;
> +	case WSA_MACRO_EC1_MUX:
> +		val = val & CDC_WSA_RX_MIX_TX1_SEL_MASK;
> +		ec_tx = (val >> CDC_WSA_RX_MIX_TX1_SEL_SHFT) - 1;
> +		break;

you should really add comments for reviewers when switch cases don't 
include defaults, not sure if this is intentional or a miss.

> +	}
> +
> +	if (wsa->ec_hq[ec_tx]) {
> +		ec_hq_reg = CDC_WSA_EC_HQ0_EC_REF_HQ_PATH_CTL +	0x40 * ec_tx;
> +		snd_soc_component_update_bits(component, ec_hq_reg,
> +					     CDC_WSA_EC_HQ_EC_CLK_EN_MASK,
> +					     CDC_WSA_EC_HQ_EC_CLK_ENABLE);
> +		ec_hq_reg = CDC_WSA_EC_HQ0_EC_REF_HQ_CFG0 + 0x40 * ec_tx;
> +		/* default set to 48k */
> +		snd_soc_component_update_bits(component, ec_hq_reg,
> +				      CDC_WSA_EC_HQ_EC_REF_PCM_RATE_MASK,
> +				      CDC_WSA_EC_HQ_EC_REF_PCM_RATE_48K);
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_widget *widget =
> +		snd_soc_dapm_kcontrol_widget(kcontrol);
> +	struct snd_soc_component *component =
> +				snd_soc_dapm_to_component(widget->dapm);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	struct snd_soc_dapm_update *update = NULL;
> +	u32 rx_port_value = ucontrol->value.integer.value[0];
> +	u32 bit_input = 0;

initialization ignored below, remove?

> +	u32 aif_rst;
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
