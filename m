Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BB2FEE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbhAUPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:16:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:27545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732529AbhAUPOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:14:05 -0500
IronPort-SDR: 9dD2vh//mUTdsBBpQz5dyeyGsi/lsppRrsTObV3VvSCKk2GJEN+fXuBFgcchwDpXvWX8LzObQ3
 /awxRcRiSyZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="159061543"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="159061543"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 07:12:10 -0800
IronPort-SDR: uvl/vASwHb9vG36fjwe1hn1nUqwvmJlHIMSFo4lPfYi9eoE+QSkFkO5MHuFANedL7NvyO+bejX
 Ku/y+SnOLpXA==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="427390633"
Received: from rjstacey-mobl2.amr.corp.intel.com (HELO [10.212.160.37]) ([10.212.160.37])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 07:12:09 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
Date:   Thu, 21 Jan 2021 09:12:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
> 
> 
> On 19/01/2021 19:09, Pierre-Louis Bossart wrote:
>>
>>> currently we have
>>> /sys/kernel/debug/soundwire/master-*
>>>
>>> Are you suggesting that we have something like this:
>>>
>>> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
>>
>> Yes this is what I was thinking about.
> 
> Vinod/Pierre,
> 
> One Question here,
> 
> Why is link_id part of "struct sdw_bus", should it not be part of 
> "struct sdw_master_device " ?
> 
> Given that "There is one Link per each Master"

it's true that link == master == bus at the concept level.

but we have an existing code base with different structures and we can't 
break too many things at once.

In the existing flow, the 'bus' is created and setup first, the 
sdw_bus_master_add() routine takes a 'bus' argument, and the link_id is 
already set. This routine only creates a device and in the rest of the 
code we keep using the 'bus' pointer, so there's no real short-term 
scope for moving the information into the 'sdw_master_device' structure 
- that would be a lot of surgery when nothing is really broken.
