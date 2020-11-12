Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88882B0A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgKLQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728643AbgKLQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605199439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvJuASutVFvvlokiKoye0dqnyzVMyo7DAgHLXVqrfgQ=;
        b=NaChkoKLRgIplsUVphI1m8gxEp275LdLsnR0T9N1yfwiG48r5cG1xWavjh7vmvYkc8FNX1
        aF/FvvzvyhjE8ZzuuxgegqvePZjxPsiHoLLWOHzTA3WtjRcXLAqdSPtunQKaj2q4sUy5nA
        qBgQ750+EEC8e5dkB/5sx1hApCuhQho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-Kf8_I5NxMeGKTaoncJ3QgA-1; Thu, 12 Nov 2020 11:43:55 -0500
X-MC-Unique: Kf8_I5NxMeGKTaoncJ3QgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C5F61074659;
        Thu, 12 Nov 2020 16:43:53 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-44.rdu2.redhat.com [10.10.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33CFB5B4A3;
        Thu, 12 Nov 2020 16:43:51 +0000 (UTC)
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
To:     Michal Hocko <mhocko@suse.com>, Feng Tang <feng.tang@intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com, ying.huang@intel.com
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
 <20201112141654.GC12240@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7e40849b-f9e0-34d4-4254-c2c99dd71f78@redhat.com>
Date:   Thu, 12 Nov 2020 11:43:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201112141654.GC12240@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 9:16 AM, Michal Hocko wrote:
> On Thu 12-11-20 20:28:44, Feng Tang wrote:
>> Hi Michal,
>>
>> On Wed, Nov 04, 2020 at 09:15:46AM +0100, Michal Hocko wrote:
>>>>>> Hi Michal,
>>>>>>
>>>>>> We used the default configure of cgroups, not sure what configuration you
>>>>>> want,
>>>>>> could you give me more details? and here is the cgroup info of will-it-scale
>>>>>> process:
>>>>>>
>>>>>> $ cat /proc/3042/cgroup
>>>>>> 12:hugetlb:/
>>>>>> 11:memory:/system.slice/lkp-bootstrap.service
>>>>> OK, this means that memory controler is enabled and in use. Btw. do you
>>>>> get the original performance if you add one phony page_counter after the
>>>>> union?
>>>>>
>>>> I add one phony page_counter after the union and re-test, the regression
>>>> reduced to -1.2%. It looks like the regression caused by the data structure
>>>> layout change.
>>> Thanks for double checking. Could you try to cache align the
>>> page_counter struct? If that helps then we should figure which counters
>>> acks against each other by adding the alignement between the respective
>>> counters.
>> We tried below patch to make the 'page_counter' aligned.
>>    
>>    diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
>>    index bab7e57..9efa6f7 100644
>>    --- a/include/linux/page_counter.h
>>    +++ b/include/linux/page_counter.h
>>    @@ -26,7 +26,7 @@ struct page_counter {
>>     	/* legacy */
>>     	unsigned long watermark;
>>     	unsigned long failcnt;
>>    -};
>>    +} ____cacheline_internodealigned_in_smp;
>>     
>> and with it, the -22.7% peformance change turns to a small -1.7%, which
>> confirms the performance bump is caused by the change to data alignment.
>>
>> After the patch, size of 'page_counter' increases from 104 bytes to 128
>> bytes, and the size of 'mem_cgroup' increases from 2880 bytes to 3008
>> bytes(with our kernel config). Another major data structure which
>> contains 'page_counter' is 'hugetlb_cgroup', whose size will change
>> from 912B to 1024B.
>>
>> Should we make these page_counters aligned to reduce cacheline conflict?
> I would rather focus on a more effective mem_cgroup layout. It is very
> likely that we are just stumbling over two counters here.
>
> Could you try to add cache alignment of counters after memory and see
> which one makes the difference? I do not expect memsw to be the one
> because that one is used together with the main counter. But who knows
> maybe the way it crosses the cache line has the exact effect. Hard to
> tell without other numbers.
>
> Btw. it would be great to see what the effect is on cgroup v2 as well.
>
> Thanks for pursuing this!

The contention may be in the page counters themselves or it can be in 
other fields below the page counters. The cacheline alignment will cause 
"high_work" just after the page counters to start at a cacheline 
boundary. I will try removing the cacheline alignment in the page 
counter and add it to high_work to see there is any change in 
performance. If there is no change, the performance problem will not be 
in the page counters.

Cheers,
Longman

