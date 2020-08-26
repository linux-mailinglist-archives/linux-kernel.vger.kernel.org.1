Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9488253591
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHZQ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 12:57:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:58772 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgHZQ5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:57:21 -0400
IronPort-SDR: K25zS0gR6g4C4NWWDuyLRJjASoUj7cuz/ddYoO0HRFGomvXvqZXGYcmDERtzBTcqbKvRKdc8Ng
 WbgkwVUi+sRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="156333116"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="156333116"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:57:20 -0700
IronPort-SDR: riyJ8XK6HQxCF87dKaM13QFC5KCh0hRvWCGpTHaRFjfTuS59kns1kMJnj+aqsEJhc364A9fs85
 ff4SjXLYIdqw==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="336884223"
Received: from kberke-mobl1.amr.corp.intel.com (HELO [10.209.43.169]) ([10.209.43.169])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:57:16 -0700
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
 <20200826090542.GZ2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c5119781-bee0-f11b-eb73-cd2da6ab09f5@linux.intel.com>
Date:   Wed, 26 Aug 2020 11:57:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826090542.GZ2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/mod_devicetable.h>
> 
> Curious why do you need this header?

I'll return the question back to you, since you added this header for 
regmap-sdw.c:

7c22ce6e21840 (Vinod Koul           2018-01-08 15:50:59 +0530  6) 
#include <linux/mod_devicetable.h>

so I assumed it was needed here as well.

>> +MODULE_DESCRIPTION("Regmap SoundWire Module");
> 
> This is same of sdw module, pls make this one a bit different.

yes, fixed.
