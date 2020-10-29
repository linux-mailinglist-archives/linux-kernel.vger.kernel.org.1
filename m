Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D929F1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgJ2QkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:40:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:27959 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgJ2QkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:40:17 -0400
IronPort-SDR: z00jur7YrARTGCU8qmuTCGBWYdJILf4dmhhlm9MDr5zUU77q855VFG4M7MWO+q3evKjaS+klrk
 enDPMrUtlZig==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="232645531"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="232645531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 09:40:16 -0700
IronPort-SDR: ff0QrJ4MtgF2phCB4taCFLTeIZk/DLnPIIRD+XCN5+M+BdmRYYp21ogVdAablqM+r9XWgHBWjK
 XjCTnwzzWYSQ==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="323762885"
Received: from mghaffa-mobl1.amr.corp.intel.com (HELO [10.212.235.9]) ([10.212.235.9])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 09:40:15 -0700
Subject: Re: [PATCH v2 3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets
 and route
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3300f31e-28d1-becf-41e7-814b38082dcb@linux.intel.com>
Date:   Thu, 29 Oct 2020 10:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029110829.16425-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
> +				     struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	u16 gain_reg;
> +	int offset_val = 0;
> +	int val = 0;
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

missed from v1: offset_val is zero so the sequence is reading and 
writing the same thing. Is this intentional or useful?

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
> +

[...]

> +static bool wsa_macro_adie_lb(struct snd_soc_component *component,
> +			      int interp_idx)
> +{
> +	u16 int_mux_cfg0 = 0, int_mux_cfg1 = 0;

these inits are ignored

> +	u8 int_mux_cfg0_val = 0, int_mux_cfg1_val = 0;

these as well

> +	u8 int_n_inp0 = 0, int_n_inp1 = 0, int_n_inp2 = 0;

and these are also ignored.

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

