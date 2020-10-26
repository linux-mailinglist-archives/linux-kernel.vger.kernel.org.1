Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42F4299AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407063AbgJZXfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:35:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:30095 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407035AbgJZXfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:35:36 -0400
IronPort-SDR: vhuByCjrenkefYdUdfWTyhVMiftPoXpNknzZ++KzssUOQA11NXFOVqCzYxNlfDg6mMAgvNl12Y
 agKHkp+mOqVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232190082"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="232190082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:35 -0700
IronPort-SDR: xhntSIvCFsesKXT9kxPtkP1xvtKAiWcb5uP5guYIIjWIEGv4qc3BQyOhlR9kz0IwuJd4xR3WB9
 SlqebZLZZYqg==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="524475083"
Received: from tanguye1-mobl2.amr.corp.intel.com (HELO [10.209.126.195]) ([10.209.126.195])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:34 -0700
Subject: Re: [PATCH v1 6/6] ASoC: codecs: lpass-va-macro: add dapm widgets and
 routes
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, plai@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20201026141945.19707-1-srinivas.kandagatla@linaro.org>
 <20201026141945.19707-7-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55ba8a1a-df67-8451-dedd-49e6c0cf82a6@linux.intel.com>
Date:   Mon, 26 Oct 2020 15:01:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026141945.19707-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int va_dmic_clk_enable(struct snd_soc_component *component,
> +			      u32 dmic, bool enable)
> +{
> +	struct va_macro *va = snd_soc_component_get_drvdata(component);
> +	u8  dmic_clk_en = 0x01;
> +	u16 dmic_clk_reg = 0;
> +	s32 *dmic_clk_cnt = NULL;
> +	u8 *dmic_clk_div = NULL;
> +	u8 freq_change_mask = 0;

the 4 initializations above are ignored, remove?

