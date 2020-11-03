Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF02A4AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgKCQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:15:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:3252 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCQO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:14:59 -0500
IronPort-SDR: tcd1DVBA6GpzwLkeCqBcXYbf++tR9LPnxZfGAHlAkvaN5ecPEOG1GS+xLjtva1XGs2gllDCKPi
 /coqEmOuVQRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="230709170"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="230709170"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 08:14:58 -0800
IronPort-SDR: O2DhVTMd6e778exoN8PgT9cKVFe6JJwL6CN3YdTAaIhxsJYlVAmSvFH6r9usWVHX086eEYTB2a
 iKok52xZcMAA==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="528532324"
Received: from ctanriov-mobl1.amr.corp.intel.com (HELO [10.212.114.78]) ([10.212.114.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 08:14:58 -0800
Subject: Re: [PATCH v2 3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets
 and route
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-4-srinivas.kandagatla@linaro.org>
 <3300f31e-28d1-becf-41e7-814b38082dcb@linux.intel.com>
 <b21abfab-108e-50f4-f905-5d9d0fc5168b@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <798ac8de-2d04-9966-6104-9a676730f44c@linux.intel.com>
Date:   Tue, 3 Nov 2020 09:51:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b21abfab-108e-50f4-f905-5d9d0fc5168b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> +static bool wsa_macro_adie_lb(struct snd_soc_component *component,
>>> +                  int interp_idx)
>>> +{
>>> +    u16 int_mux_cfg0 = 0, int_mux_cfg1 = 0;
>>
>> these inits are ignored
>>
>>> +    u8 int_mux_cfg0_val = 0, int_mux_cfg1_val = 0;
>>
>> these as well
>>
>>> +    u8 int_n_inp0 = 0, int_n_inp1 = 0, int_n_inp2 = 0;
>>
>> and these are also ignored.
>>
> Yes, these are ignored, I should have removed the unnecessary 
> initialization!
> It would have been nice if sparse could catch such errors!
> 
> are you using tool to catch these?

make W=1 and cppcheck.

"
Run cppcheck on this sort of code:

cppcheck --platform=unix32 --force --max-configs=1024 --inconclusive
--enable=all --suppress=variableScope sound/soc/codecs/lpass-wsa-macro.c
"
