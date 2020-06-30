Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC420EA41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgF3AcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 20:32:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:57411 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgF3AcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:32:06 -0400
IronPort-SDR: 01cTuFghv437VJa9/12xgvISltvQrUOB9mQ+ScFHy0FrdsJnW4hhajcltdacfvo0iYM14Grv10
 2Zsx/hRBBq7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133549864"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="133549864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 17:32:06 -0700
IronPort-SDR: 7b9KAJk90xWk05QDDBevC/kvVUow9bR9hXUNQcFKIubkuZQxM9cfQmTpBdu3WAgcxZxlcfIgfh
 olA+L5N6l6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="266336939"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2020 17:32:04 -0700
Subject: Re: [kbuild-all] Re: [PATCH] sparse: use static inline for
 __chk_{user,io}_ptr()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <20200628072019.67107-1-luc.vanoostenryck@gmail.com>
 <202006300219.fQMPm3tC%lkp@intel.com>
 <20200629183713.msrfozjvpt6jr6jl@ltop.local>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <cf1c3b97-0088-84db-23fa-90ecc56715ec@intel.com>
Date:   Tue, 30 Jun 2020 08:31:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200629183713.msrfozjvpt6jr6jl@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/20 2:37 AM, Luc Van Oostenryck wrote:
> On Tue, Jun 30, 2020 at 02:08:36AM +0800, kernel test robot wrote:
>> Hi Luc,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on next-20200626]
>> [cannot apply to linux/master linus/master v5.8-rc2 v5.8-rc1 v5.7 v5.8-rc3]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
> This patch should be applied on top of akpm's tree or on top of next.
> I'm not sure hwo I should have specified this, 'git send-mail --base=...'
> is less useful for these trees.

Hi Luc,

Thanks for the feedback, we'll fix the wrong base.

Best Regards,
Rong Chen
