Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE81E6297
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbgE1Not (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:44:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:23300 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390432AbgE1Nos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:44:48 -0400
IronPort-SDR: 0rc7A3b/AGr90hv+E0/BwUlWVPjF1LxLhH66PSd2drGXgBF+3UqR1ZJtLBTTL8m1CP+rOxMHA7
 uuye5ZXuXk5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 06:44:47 -0700
IronPort-SDR: Mzt4PaJjqkTNatS7MO5azev6oMN7bte9xkue5TCtMR+M2a5PpSK5zjN+phy26Lk3QYqqV3NX5J
 VIZIjN7gDDXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="414602549"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2020 06:44:47 -0700
Received: from [10.251.9.11] (kliang2-mobl.ccr.corp.intel.com [10.251.9.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 09215580100;
        Thu, 28 May 2020 06:44:46 -0700 (PDT)
Subject: Re: [PATCH V2 2/3] perf/x86/intel/uncore: Record the size of mapped
 area
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-2-git-send-email-kan.liang@linux.intel.com>
 <20200528132908.GG611145@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7d593433-0e7d-afb5-0bf3-4ea6cd5ad352@linux.intel.com>
Date:   Thu, 28 May 2020 09:44:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528132908.GG611145@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 9:29 AM, Andi Kleen wrote:
> On Thu, May 28, 2020 at 06:15:26AM -0700, kan.liang@linux.intel.com wrote:
>> -	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
>> +	if (!type->mmio_map_size) {
>> +		pr_warn("perf uncore: Cannot ioremap for %s. Size of map area is 0.\n",
>> +			type->name);
>> +		return;
>> +	}
> 
> Is that likely that the size is 0?

In case someone forgets to set mmio_map_size.

> 
> In any case you have to test the return value of ioremap. So I would rather
> test the address for 0 than the size.

The box->io_addr is checked now, but there is no warning message.
I will remove the check for mmio_map_size, and add a warning message for 
the check of box->io_addr.

Thanks,
Kan

