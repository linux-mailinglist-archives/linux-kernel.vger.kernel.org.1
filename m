Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230182FDD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbhAUAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:06:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:43370 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbhATWQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:16:56 -0500
IronPort-SDR: 2qkaYvYtuwbd4pLw5AneZqvB8dFwt2sn6iWenK7YGVqq0xhU2+xuCeBe59cF1aXRrbBIQcwsat
 Veuqv5LgLrdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158363897"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="158363897"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 14:15:11 -0800
IronPort-SDR: Wjo0c6C/w/yBCGStuE5kfgMxktdIffdv8ncqct3gjkw5pSnZxF8jMSjl5d1M26u662x43IVT9A
 hy6C84yiQXtQ==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="356216635"
Received: from bmetsx-mobl1.amr.corp.intel.com (HELO [10.209.108.15]) ([10.209.108.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 14:15:10 -0800
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, gregkh@linuxfoundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
 <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fcc1b199-644d-8c7f-5e8b-d12b0d9c9a04@linux.intel.com>
Date:   Wed, 20 Jan 2021 16:15:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120180110.8357-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/21 12:01 PM, Srinivas Kandagatla wrote:
> Some of the soundwire controllers can have static functions assigned
> to each port, like some ports can only do PCM or PDM. This is the situation
> with some of the Qualcomm Controllers.
> 
> In such cases its not correct to assign/map any free port on master
> during streaming.
> 
> So, this patch provides a way to pass mapped port number along
> with the port config, so that master can assign correct ports based
> on the provided static mapping.

I am not sure I understand the problem or what's different between Intel 
and Qualcomm.

On the Intel side we also have fixed-function ports, some for PDM and 
some for PCM. They are not interchangeable, and they are also dedicated 
for each link.

We don't dynamically allocate ports on the master side, the mapping is 
defined by the dai->id and is static. There is a 1:1 relationship 
between dai->id and port_number. See intel_register_dai() and 
intel_hw_params() in drivers/soundwire/intel.c

In the machine driver we make use of specific master DAIs in the dailink 
definitions, just like regular ASoC solutions, so which DAIs you use in 
the machine driver defines what ports end-up being used. There is 
nothing fancy or dynamic here, the dai/port allocation is defined by the 
dailinks. This is a static/worst-case allocation, we don't reassign 
ports depending on use-cases, etc.

The only thing that is dynamic is that the programming of each port is 
handled based on the bandwidth needs of that port, i.e if you play 16 or 
24 bits you'd get fewer or more bitSlots allocated to that dai/port, and 
the DPn registers are updated if you have concurrent streaming on other 
ports. If you only have a fixed set of payloads, as in the existing 
amplifier cases, you can hard-code this allocation as well.

Does this help and can you align on what Intel started with?

