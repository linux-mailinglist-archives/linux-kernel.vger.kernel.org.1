Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E53270110
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:32:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34994 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:32:14 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id DBFD720B7178;
        Fri, 18 Sep 2020 08:32:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBFD720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600443134;
        bh=vtTb3EJ7mTrVHVijtfqLvW2pXnRFIW6KVA1gLHyzNYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n5Ji1nTaHer+8uHNqErs+DOOYFNYUBJV18go1fqVzWVf69ZPpRkVWFtRsJy6xrlZy
         ln5lhexvwwpgC24hQZSXMv2vzpskJnsdPl818ESSc3A1Y3W4Sa7WdL1+545pj9ifGe
         DIy+FX+NcHYqAXRPwiahqSDl8Ss72GjenuNoqfoc=
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
 <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
 <20200916065306.GB18998@dhcp22.suse.cz>
 <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
 <20200917121213.GC29887@dhcp22.suse.cz>
 <7eddcc58-f65f-0be9-60e8-2de013365909@linux.microsoft.com>
 <20200918054513.GA28827@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <2bd9ebf5-f6b7-1a2a-be61-9d4af8210cce@linux.microsoft.com>
Date:   Fri, 18 Sep 2020 08:32:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200918054513.GA28827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 10:45 PM, Michal Hocko wrote:
> On Thu 17-09-20 11:03:56, Vijay Balakrishna wrote:
> [...]
>>>> The auto tuned value is incorrect post hotplug memory operation, in our use
>>>> case memoy hot add occurs very early during boot.
>>> Define incorrect. What are the actual values? Have you tried to increase
>>> the value manually after the hotplug?
>>
>> In our case SoC with 8GB memory, system tuned min_free_kbytes
>> - first to 22528
>> - we perform memory hot add very early in boot
> 
> What was the original and after-the-hotplug size of memory and layout?
> I suspect that all the hotplugged memory is in Movable zone, right?

Yes, added ~1.92GB as Movable type, booting with 6GB at start.

> 
>> - now min_free_kbytes is 8703
>>
>> Before looking at code, first I manually restored min_free_kbytes soon after
>> boot, reran stress and didn't notice symptoms I mentioned in change log.
> 
> This is really surprising and I strongly suspect that an earlier reclaim
> just changed the timing enough so that workload has spread the memory
> prpessure over a longer time and that might have been enough to recycle
> some of the unreclaimable memory due to its natural life time. But this
> is a pure speculation. Much more data would be needed to analyze this.
> 
> In any case your stress test is oveprovisioning your Normal zone and
> increased min_free_kbytes just papers over the sizing problem.
> 

It is a synthetic workload, likely not sized I need to check.  I feel 
having higher min_free_kbytes made GFP_ATOMIC allocations not to fail. 
I have seen NETDEV WATCHDOG timeout with stacktrace trying to allocate 
memory, looping in net rx receive path.

Thanks,
Vijay
