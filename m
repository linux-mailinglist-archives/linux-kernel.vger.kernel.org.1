Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EF26CD45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgIPU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:57:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:15913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgIPQwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:37 -0400
IronPort-SDR: v1d6M0q1gqwwmLJR+vXzKtOG73CRRq5T20MHO9cX1jMv5rNSh/UQO87/DWBmnHNs0j4LX93Sgh
 YGBp43QPmtFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="244310150"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="244310150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 07:36:02 -0700
IronPort-SDR: 9vflgM7vQtpr7bUeEoXhYRQcvsmlrp+E3k7y2J5qr5AMndwoBz/ZUYEdvbzo1cxTyEzo1O3Nym
 fteSH2tygVsA==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="483335716"
Received: from abkhadil-mobl.amr.corp.intel.com (HELO [10.209.66.227]) ([10.209.66.227])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 07:36:01 -0700
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value
 set.
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
 <20200916124634.GM2968@vkoul-mobl>
 <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
 <20200916142929.GR2968@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <42bbf464-2bc9-2b13-5f08-a19ad1848277@linux.intel.com>
Date:   Wed, 16 Sep 2020 09:36:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916142929.GR2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/20 9:29 AM, Vinod Koul wrote:
> On 16-09-20, 08:18, Pierre-Louis Bossart wrote:
>>
>>>> According to usage (bitfields.h) of REG_FIELDS,
>>>> Modify is:
>>>>     reg &= ~REG_FIELD_C;
>>>>     reg |= FIELD_PREP(REG_FIELD_C, c);
>>
>>
>> if this is indeed the case, all the code in cadence_master.c is also broken,
>> e.g:
>>
>> 	dpn_config = cdns_readl(cdns, dpn_config_off);
>>
>> 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
>> 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
>> 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);
> 
> This should be replaced with u32_replace_bits(), i am sending the fix

wondering if we should replace all uses of FIELD_PREP with either 
u32_insert_bits() or u32_encode_bits() then?

