Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D6299AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406960AbgJZXfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:35:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:30095 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406927AbgJZXfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:35:31 -0400
IronPort-SDR: Yu8G0KmSRgnaHzuRXRZ0gACgf4e4lmR4MKeJjIK0/D5DFsRsCS3k0WxT7nUumKDIlP5uRxdxuS
 VKeASfSY4XIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232190073"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="232190073"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:31 -0700
IronPort-SDR: +VKBGwRegupOn/UALLw93ZdglcfO2+/R7lynppCqm3veH3XFZHY6ZY2n2NFex2UEzYY0HBq0aa
 r2syyljeduVg==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="524475075"
Received: from tanguye1-mobl2.amr.corp.intel.com (HELO [10.209.126.195]) ([10.209.126.195])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:30 -0700
Subject: Re: [PATCH v1 2/6] ASoC: codecs: lpass-wsa-macro: Add support to WSA
 Macro
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, plai@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
 <20201026141945.19707-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4eace0ba-34af-ed4c-7d61-4282b7590448@linux.intel.com>
Date:   Mon, 26 Oct 2020 14:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026141945.19707-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int wsa_macro_set_prim_interpolator_rate(struct snd_soc_dai *dai,
> +						u8 int_prim_fs_rate_reg_val,
> +						u32 sample_rate)
> +{
> +	u8 int_1_mix1_inp;
> +	u32 j, port;
> +	u16 int_mux_cfg0, int_mux_cfg1;
> +	u16 int_fs_reg;
> +	u8 int_mux_cfg0_val, int_mux_cfg1_val;
> +	u8 inp0_sel, inp1_sel, inp2_sel;
> +	struct snd_soc_component *component = dai->component;
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
> +
> +	for_each_set_bit(port, &wsa->active_ch_mask[dai->id],
> +			 WSA_MACRO_RX_MAX) {
> +		int_1_mix1_inp = port;
> +		if ((int_1_mix1_inp < WSA_MACRO_RX0) ||
> +			(int_1_mix1_inp > WSA_MACRO_RX_MIX1)) {

nit-pick: alignment seems off, use one line for the test and for_each loop?

[...]

> +static int wsa_macro_set_mix_interpolator_rate(struct snd_soc_dai *dai,
> +					       u8 int_mix_fs_rate_reg_val,
> +					       u32 sample_rate)
> +{
> +	u8 int_2_inp;
> +	u32 j, port;
> +	u16 int_mux_cfg1, int_fs_reg;
> +	u8 int_mux_cfg1_val;
> +	struct snd_soc_component *component = dai->component;
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
> +
> +	for_each_set_bit(port, &wsa->active_ch_mask[dai->id],
> +			 WSA_MACRO_RX_MAX) {
> +		int_2_inp = port;
> +		if ((int_2_inp < WSA_MACRO_RX0) ||
> +			(int_2_inp > WSA_MACRO_RX_MIX1)) {

same weird alignment.

> +static int wsa_macro_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	int ret;
> +
> +	switch (substream->stream) {
> +	case SNDRV_PCM_STREAM_PLAYBACK:
> +		ret = wsa_macro_set_interpolator_rate(dai, params_rate(params));
> +		if (ret) {
> +			dev_err(component->dev,
> +				"%s: cannot set sample rate: %u\n",
> +				__func__, params_rate(params));
> +			return ret;
> +		}
> +		break;
> +	case SNDRV_PCM_STREAM_CAPTURE:

nit-pick: might as well remove the capture or add a comment on why it's 
listed but not used?

> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int wsa_macro_get_channel_map(struct snd_soc_dai *dai,
> +				unsigned int *tx_num, unsigned int *tx_slot,
> +				unsigned int *rx_num, unsigned int *rx_slot)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
> +	u16 val = 0, mask = 0, cnt = 0, temp = 0;

nit-pick: temp does not need to be initialized.

> +
> +	wsa = dev_get_drvdata(component->dev);
> +	if (!wsa)
> +		return -EINVAL;
> +
> +	switch (dai->id) {
> +	case WSA_MACRO_AIF_VI:
> +		*tx_slot = wsa->active_ch_mask[dai->id];
> +		*tx_num = wsa->active_ch_cnt[dai->id];
> +		break;
> +	case WSA_MACRO_AIF1_PB:
> +	case WSA_MACRO_AIF_MIX1_PB:
> +		for_each_set_bit(temp, &wsa->active_ch_mask[dai->id],
> +					WSA_MACRO_RX_MAX) {
> +			mask |= (1 << temp);
> +			if (++cnt == WSA_MACRO_MAX_DMA_CH_PER_PORT)
> +				break;
> +		}
> +		if (mask & 0x0C)
> +			mask = mask >> 0x2;
> +		*rx_slot = mask;
> +		*rx_num = cnt;
> +		break;
> +	case WSA_MACRO_AIF_ECHO:
> +		val = snd_soc_component_read(component,
> +			CDC_WSA_RX_INP_MUX_RX_MIX_CFG0);
> +		if (val & WSA_MACRO_EC_MIX_TX1_MASK) {
> +			mask |= 0x2;
> +			cnt++;
> +		}
> +		if (val & WSA_MACRO_EC_MIX_TX0_MASK) {
> +			mask |= 0x1;
> +			cnt++;
> +		}
> +		*tx_slot = mask;
> +		*tx_num = cnt;
> +		break;
> +	default:
> +		dev_err(component->dev, "%s: Invalid AIF\n", __func__);
> +		break;
> +	}
> +	return 0;

[...]

> +static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
> +{
> +	struct device *dev = wsa->dev;
> +	struct device_node *np = dev->of_node;
> +	const char *parent_clk_name = NULL;

initialization not needed, overriden below

> +	const char *clk_name = "mclk";
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	parent_clk_name = __clk_get_name(wsa->clks[2].clk);
> +
> +	init.name = clk_name;
> +	init.ops = &swclk_gate_ops;
> +	init.flags = 0;
> +	init.parent_names = &parent_clk_name;
> +	init.num_parents = 1;
> +	wsa->hw.init = &init;
> +	hw = &wsa->hw;
> +	ret = clk_hw_register(wsa->dev, hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
> +
> +	return NULL;
> +}

