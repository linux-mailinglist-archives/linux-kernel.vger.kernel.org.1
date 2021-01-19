Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0C2FBFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbhAST0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:26:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:49763 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbhASTLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:11:44 -0500
IronPort-SDR: OTq8socWoxdOGwpOKON+vN+6w/42mA2XkcV3uf0oqYGu1GkUxV55bZmxzdTg9MW4Nti7MKUS2B
 d+KanFrdVv/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158755732"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158755732"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 11:09:43 -0800
IronPort-SDR: 6NwjqznG8OHinEFNfhklW31CU1SQAGfKOYSCbFYUDylpZmFWv1BJhsqAkX1qv0p0vUDEBvAXQC
 yMUK7CYX3uGA==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="384059682"
Received: from lrstallo-mobl.amr.corp.intel.com (HELO [10.212.39.144]) ([10.212.39.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 11:09:43 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
Date:   Tue, 19 Jan 2021 13:09:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> link_id can be zero and if we have multiple controller instances
>>>> in a system like Qualcomm debugfs will end-up with duplicate namespace
>>>> resulting in incorrect debugfs entries.
>>>>
>>>> Using id should give a unique debugfs directory entry and should fix 
>>>> below
>>>> warning too.
>>>> "debugfs: Directory 'master-0' with parent 'soundwire' already 
>>>> present!"
>>>
>>> Yeah id is guaranteed to be unique so this will work.
>>>
>>> Applied, thanks
>>
>> This patch is a no-op for Intel, but I am not convinced it's the right 
>> fix or the definitions are not consistent.
> 
> It depends if the intention is to represent full Hierarchy in debugfs, 
> then I agree. Its was consistent even before!

Indeed, we don't currently have a notion of controller in debugfs.

> currently we have
> /sys/kernel/debug/soundwire/master-*
> 
> Are you suggesting that we have something like this:
> 
> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??

Yes this is what I was thinking about.

> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID>/xyz-slave/master-<LINK-ID> 
> ??

This would be for a bridge which to the best of my knowledge hasn't been 
implemented by anyone (clocking and command/control timing issues).

> Or may be something much simpler like:
> 
> /sys/kernel/debug/soundwire/master-<ID>.<LINK_ID>

the bus->id is an IDA, which is useful for to avoid conflicts, but it's 
not really meaningful for debugfs. I remember seeing a case where we had 
links 2 and 4 enabled, and the bus->id were 0 and 1, a completely 
artificial value that doesn't really help in debugging.
