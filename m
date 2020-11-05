Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED62A8360
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgKEQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:20:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:19001 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgKEQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:20:04 -0500
IronPort-SDR: zzvBNR0iExwC8tI6MGoHQu9BbLUnAwnry4M+Tewzq8yeRpbREYKN2be91udXmepy7pYpyQqY4m
 69JWcKr4q0+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="165901539"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="165901539"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 08:20:02 -0800
IronPort-SDR: ZUeKpsT88n2eEQDLWRohP3as8XuAKRILY7VEXFRa6wAxHjAow/TenrS0Eacz+7M0E1caHY3EyM
 LcTKxgSuoBXw==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="539465896"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO [10.254.6.114]) ([10.254.6.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 08:20:01 -0800
Subject: Re: [PATCH v3 0/6] ASoC: codecs: add support for LPASS Codec macros
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f4cf1bd6-cf11-60bb-3169-c54d2cf72e19@linux.intel.com>
Date:   Thu, 5 Nov 2020 10:20:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/20 5:34 AM, Srinivas Kandagatla wrote:
> This patchset adds support for two Codec Macro blocks( WSA and VA) available in
> Qualcomm LPASS (Low Power Audio SubSystem).
> 
> There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
> has specific connectivity like WSA Macros are intended to connect
> to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
> and TX/RX for Analog codecs via SoundWire like other WCD Codecs to provide
> headphone/ear/lineout etc ..
> 
> Most of the work is derived from downstream Qualcomm kernels.
> Credits to various Qualcomm authors from Patrick Lai's team who have
> contributed to this code.
> 
> This patchset has been tested on support to Qualcomm Robotics RB5 Development
> Kit based on QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
> with onboard DMIC connected to internal LPASS codec via WSA  and VA macros
> respectively.

For the series,

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

