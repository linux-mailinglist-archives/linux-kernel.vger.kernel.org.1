Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4322DAA71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgLOJxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:53:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:43070 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbgLOJxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:53:49 -0500
IronPort-SDR: nBkT5Q6BJZCye6/GDQdkpKvwD+tp8EzPH0lmZzrD2NezgS0y1PzIoekJ0oNdAlDfVs2MK9vwPK
 DSYyXzA7QUqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="161907178"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="161907178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 01:53:05 -0800
IronPort-SDR: /blN8HYVrJOQakmujxo8bCtEQKyDDWI1UAlN4SHf4Y7VEdrA5btq08C0tOfvlPiawZuXEyyKx5
 yzcvQ/dRu/Cg==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="411815770"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 01:53:01 -0800
Date:   Tue, 15 Dec 2020 17:52:59 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v6 06/18] virt: acrn: Introduce VM management interfaces
Message-ID: <20201215095259.GN17702@shuo-intel.sh.intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-7-shuo.a.liu@intel.com>
 <X8YWa8IUCgOARYMS@kroah.com>
 <20201202021429.GL17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201202021429.GL17702@shuo-intel.sh.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed  2.Dec'20 at 10:14:29 +0800, Shuo A Liu wrote:
>On Tue  1.Dec'20 at 11:09:47 +0100, Greg Kroah-Hartman wrote:
>>On Tue, Dec 01, 2020 at 05:38:41PM +0800, shuo.a.liu@intel.com wrote:
>>>+		vm_param->reserved0 = 0;
>>>+		vm_param->reserved1 = 0;
>>
>>NO!
>>
>>This means that userspace can put whatever crud they want in those
>>fields, and you will happily zero it out.  Then, when those reserved
>>fields are wanted to be used in the future, you will take those values
>>from userspace and accept them as a valid value.  But, since userspace
>>was sending crud before, now you will take that crud and do something
>>with it.
>>
>>TEST IT to verify that it is zero, that way userspace gets it right the
>>first time, and you don't get it wrong later, as you can not change it
>>later.
>
>OK. Thanks for the elaboration. I will test it and return -EINVAL if
>it is not zero.
>

Hi Greg,

Would you like to review other patches in this series on this version? 

This version got only this one comment, so doesn't have too much update.
I can send out a new version if you prefer to.

Thanks for review.

shuo
