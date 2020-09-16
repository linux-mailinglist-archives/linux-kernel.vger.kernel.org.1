Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14A726CE16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgIPVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:09:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:9428 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgIPPzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:32 -0400
IronPort-SDR: zrpRAA5xIi9lUSpLBuv95lvOFORi9oeYGFLlwxIHGJBwzt3A5euCM7bcI5QkIfznnsQpW4//ag
 l9jZCU8aJmOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="244294860"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="244294860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:20:07 -0700
IronPort-SDR: aNmDpg3D6dXOBkv8AOEPQ7Eo0OR4v49dvSZKbbKqki7iDt0H6/qz2nGujWkIt447J/1WN8tda+
 HnS7s6zRbiEg==
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="507165115"
Received: from gopikapa-mobl.amr.corp.intel.com (HELO [10.209.66.210]) ([10.209.66.210])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:20:07 -0700
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value
 set.
To:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
 <20200916124634.GM2968@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
Date:   Wed, 16 Sep 2020 08:18:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916124634.GM2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> According to usage (bitfields.h) of REG_FIELDS,
>> Modify is:
>>    reg &= ~REG_FIELD_C;
>>    reg |= FIELD_PREP(REG_FIELD_C, c);


if this is indeed the case, all the code in cadence_master.c is also 
broken, e.g:

	dpn_config = cdns_readl(cdns, dpn_config_off);

	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);


Gah.

