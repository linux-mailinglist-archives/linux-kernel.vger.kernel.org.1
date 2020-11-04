Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153032A5CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgKDCqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729745AbgKDCqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604457995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnM3HUtIGwLfRlGLpYStqhjKzTQKX4TDNkJJOmXeLBg=;
        b=XqFrMAZVmBSsODYvyygvYgPtYlkshyLz/u89OiPSDj5XbfFWQPUDhkIfpeJNPyVv66igqk
        pEzqdmR96f8rLDJzfpiZXgpsb09lzCUSpN3LV+u0VV41VqwO8+e1zKUOZssjsA045S3F0R
        JUaU6/DTUQMfFwHMMe/RwtmyQwL9kWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-6xb81yOaNTW1rAbN2NnHSw-1; Tue, 03 Nov 2020 21:46:31 -0500
X-MC-Unique: 6xb81yOaNTW1rAbN2NnHSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E9D3107465A;
        Wed,  4 Nov 2020 02:46:28 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-112.rdu2.redhat.com [10.10.119.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82B4219C4F;
        Wed,  4 Nov 2020 02:46:26 +0000 (UTC)
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a31c7c6c-ea82-b690-3504-2133178efdaa@redhat.com>
Date:   Tue, 3 Nov 2020 21:46:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 8:20 PM, Xing Zhengjun wrote:
>
>
> On 11/2/2020 6:02 PM, Michal Hocko wrote:
>> On Mon 02-11-20 17:53:14, Rong Chen wrote:
>>>
>>>
>>> On 11/2/20 5:27 PM, Michal Hocko wrote:
>>>> On Mon 02-11-20 17:15:43, kernel test robot wrote:
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed a -22.7% regression of 
>>>>> will-it-scale.per_process_ops due to commit:
>>>>>
>>>>>
>>>>> commit: bd0b230fe14554bfffbae54e19038716f96f5a41 ("mm/memcg: unify 
>>>>> swap and memsw page counters")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 
>>>>> master
>>>> I really fail to see how this can be anything else than a data 
>>>> structure
>>>> layout change. There is one counter less.
>>>>
>>>> btw. are cgroups configured at all? What would be the configuration?
>>>
>>> Hi Michal,
>>>
>>> We used the default configure of cgroups, not sure what 
>>> configuration you
>>> want,
>>> could you give me more details? and here is the cgroup info of 
>>> will-it-scale
>>> process:
>>>
>>> $ cat /proc/3042/cgroup
>>> 12:hugetlb:/
>>> 11:memory:/system.slice/lkp-bootstrap.service
>>
>> OK, this means that memory controler is enabled and in use. Btw. do you
>> get the original performance if you add one phony page_counter after the
>> union?
>>
> I add one phony page_counter after the union and re-test, the 
> regression reduced to -1.2%. It looks like the regression caused by 
> the data structure layout change.

So it looks like the regression is caused by false cacheline sharing of 
two or more hot items in mem_cgroup. As the size of the page_counter is 
112 bytes, eliminating one counter will shift down the cacheline 
boundary by 16 bytes. We probably need to use perf to find out what 
those hot items are for this particular benchmark.

Cheers,
Longman

