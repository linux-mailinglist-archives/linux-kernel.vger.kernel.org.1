Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3428C6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 03:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgJMBrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 21:47:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:29646 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgJMBre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:47:34 -0400
IronPort-SDR: Y4qO65T6j9DFybAYDbGDQwpyqGbSiQh8tCgyNze/vVyqjcO6wm/O0boZ/d1dajJaMw3nlQ0nWl
 ZdxJ+k5rMyxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152760954"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="152760954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:47:34 -0700
IronPort-SDR: NivaALxhwUwXVU6Tez3xOeY5PWOijR8tdHQf73m+YW/dQS3N39irIv9e50gK4/xVuW3vG23CzI
 ZnrdX1H80+EQ==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="530193113"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 18:47:32 -0700
Subject: Re: [LKP] [fs] b6509f6a8c: will-it-scale.per_thread_ops -12.6%
 regression
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200706012029.GZ3874@shao2-debian>
 <6b301f34-f8fe-c626-e5e5-9af5c257c5c3@linux.intel.com>
 <20201012081825.GR3227@techsingularity.net>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <162fe30c-21cb-4d49-15f2-394d48f4cecd@linux.intel.com>
Date:   Tue, 13 Oct 2020 09:47:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201012081825.GR3227@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 4:18 PM, Mel Gorman wrote:
> On Mon, Oct 12, 2020 at 02:20:26PM +0800, Xing Zhengjun wrote:
>> Hi Mel,
>>
>>     It is a revert commit caused the regression, Do you have a plan to fix
>> it? Thanks. I re-test it in v5.9-rc8, the regression still existed.
>>
> 
> The revert caused a *performance* regression but the original
> performance gain caused a functional failure. The overall performance
> should be unchanged. I have not revisited the topic since.
>
Thanks for the explanation. We will stop tracking it.

-- 
Zhengjun Xing
