Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2E2FBBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbhASQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:05:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:45399 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387820AbhASP6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:58:30 -0500
IronPort-SDR: VVOeY0+ylDiQcFldMH0x1PTnCGnWGq2Iw8RLv9klLWd65VdJ8+JyyTuVyol/EdRiAG/W8ye1BZ
 yIuxVgDx+gUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="179034597"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="179034597"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 07:56:29 -0800
IronPort-SDR: +8un7h/G1TOmeEyJrzdSGbntlMjbolD6o8NwPWDZu63WBRIAxEuHQLH7wUhDjm1jSRT5phmmXI
 hyrb7Kg4D5kw==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="500975811"
Received: from kxu2-mobl.amr.corp.intel.com (HELO [10.212.225.199]) ([10.212.225.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 07:56:29 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
Date:   Tue, 19 Jan 2021 09:54:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119145220.GS2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 8:52 AM, Vinod Koul wrote:
> On 15-01-21, 16:25, Srinivas Kandagatla wrote:
>> link_id can be zero and if we have multiple controller instances
>> in a system like Qualcomm debugfs will end-up with duplicate namespace
>> resulting in incorrect debugfs entries.
>>
>> Using id should give a unique debugfs directory entry and should fix below
>> warning too.
>> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"
> 
> Yeah id is guaranteed to be unique so this will work.
> 
> Applied, thanks

This patch is a no-op for Intel, but I am not convinced it's the right 
fix or the definitions are not consistent.

  * @link_id: Link id number, can be 0 to N, unique for each Master
  * @id: bus system-wide unique id

In the MIPI/DisCo definitions, a controller can have multiple masters. 
if you have multiple controllers, each of them should have their own 
debugfs directory IMHO. It's totally fine to have multiple bus/masters 
with a link_id == 0.
