Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCADC2FEDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbhAUO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:59:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:19535 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbhAUO6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:58:25 -0500
IronPort-SDR: erk9+RHnf7L1V3NvdMgWAut193e0/UOA02idcHPGhVYpm40ycx0bRHgvQ/szafFnznY2h4v9eX
 ms/Fnp32JDOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="198016025"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="198016025"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 06:56:26 -0800
IronPort-SDR: W74hvUF2c/5+F/l5fu8K8Cgr6Xq1W49lAZJiJbNOTI+yBnUbs6lb9zduxyvNgGCCfQp6q4Slgx
 bGBmc6RnAwxg==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="427378077"
Received: from rjstacey-mobl2.amr.corp.intel.com (HELO [10.212.160.37]) ([10.212.160.37])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 06:56:25 -0800
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     gregkh@linuxfoundation.org, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
 <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
 <fcc1b199-644d-8c7f-5e8b-d12b0d9c9a04@linux.intel.com>
 <0a2bbbe5-821a-34dd-e893-fef42baaad2b@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
Date:   Thu, 21 Jan 2021 08:56:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0a2bbbe5-821a-34dd-e893-fef42baaad2b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Port allocations are something like this:
> 
> RX: (Simple)
> Port 1 -> HPH L/R
> Port 2 -> CLASS H Amp
> Port 3 -> COMP
> Port 4 -> DSD.
> 
> TX: (This get bit more complicated)
> Port 1: PCM
> Port 2: ADC 1 & 2
> Port 3: ADC 3 & 4
> Port 4: DMIC-0, DMIC-1, DIMC-2 , DMIC-3 and MBHC
> Port 5: DMIC-4, DMIC-5, DMIC-6 and DMIC-7
> 
> We handle the port allocation dynamically based on mixer and dapm 
> widgets in my code! Also channel allocations are different for each 
> function!

Sorry, I am not following here. What is dynamic here and use-case 
dependent? And is this a mapping on the master or the codec sides that 
you want to modify?

>> Does this help and can you align on what Intel started with?
> 
> Firstly, This is where the issue comes, if we go with the 
> suggested(dai->id) solution, we would end up with a long list of 
> dai-links with different combinations of both inputs/output connections 
> and usecases. Again we have to deal with limited DSP resources too!
> 
> Secondly, The check [1] in stream.c will not allow more than one master 
> port config to be added to master runtime. Ex: RX Port 1, 2, 3 is used 
> for Headset Playback.

I am confused here, we do have examples in existing codec drivers where 
we use multiple ports for a single stream, e.g. for IV feedback we use 2 
ports.

In your "RX Port 1, 2, 3" example, are you referring to the codec or the 
master side? If it's for the codec, it's already supported, see e.g. 
https://github.com/thesofproject/linux/pull/2514, we use DP2 and DP4 for 
the same stream. This is done with the port_config capability.


