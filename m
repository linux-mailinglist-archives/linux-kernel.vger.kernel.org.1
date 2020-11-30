Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4725A2C8CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgK3Sil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:38:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:9139 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgK3Sil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:38:41 -0500
IronPort-SDR: uSvs7q3ZcXTL1g0BYAxyiRf0mg+mJIjPQEZZFlBv18nTiREEpzlR5TuuwL1bjO52sDk3V7cP5d
 G3RKcLS2qXtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="160460923"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="160460923"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:36:59 -0800
IronPort-SDR: BeCpo/cUwVGoBhiIBAXypgNtcU3t8vq+saG2OVL6fZDSArhX9wCNKEGvt9cuOUkNTqVgBsteG0
 wfCQuzxk5kkw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480759994"
Received: from whsiao-mobl.amr.corp.intel.com (HELO [10.209.17.17]) ([10.209.17.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:36:57 -0800
Subject: Re: [PATCH 5/5] ASoC/SoundWire: rt711-sdca: Add RT711 SDCA
 vendor-specific driver
To:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
References: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
 <20201103172226.4278-6-yung-chuan.liao@linux.intel.com>
 <20201130181708.GF4756@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a53c4705-38d8-aa78-ab0a-c484814f2c64@linux.intel.com>
Date:   Mon, 30 Nov 2020 12:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130181708.GF4756@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/20 12:17 PM, Mark Brown wrote:
> On Wed, Nov 04, 2020 at 01:22:26AM +0800, Bard Liao wrote:
>> From: Shuming Fan <shumingf@realtek.com>
>>
>> This is the initial codec driver for rt711 SDCA version.
> 
> This and the rt1316 change are failing to build for me on both the
> regmap tree and a merge of this branch into the ASoC tree in an x86
> allmodconfig with the errors below, I assume this is a dependency on the
> SoundWire tree which I guess I need a pull request for?

Ah yes, the 'is_sdca' member definition was added in Vinod's 
soundwire/next branch

b7cab9be7c161 ('soundwire: SDCA: detect sdca_cascade interrupt')

This should be the only dependency for now, but I should mention we have 
a follow-up series to fix some pm_runtime issues that will also touch 
regmap/soundwire, so wondering if it might be simpler to have all 
SDCA-related changes in the SoundWire tree to avoid another dependency 
handling in the next two weeks.

