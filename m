Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90962B6926
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKQPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:55:31 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:48815
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgKQPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:55:30 -0500
X-IronPort-AV: E=Sophos;i="5.77,485,1596492000"; 
   d="scan'208";a="364824567"
Received: from 91-160-5-165.subs.proxad.net (HELO [192.168.44.21]) ([91.160.5.165])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Nov 2020 16:55:26 +0100
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <20201003085345.GA114893@kroah.com>
 <20201006005736.GD6041@ranerica-svr.sc.intel.com>
 <20201006073744.GA6753@kroah.com>
 <20201007031447.GB27938@ranerica-svr.sc.intel.com>
 <20201007051546.GA47583@kroah.com>
 <7233394d-982b-72cd-ceb9-d81161bd826f@gmail.com> <X6zZaKt57Xl9NnuN@kroah.com>
 <d7ac96f2-10e8-209d-2903-1bbe8fc552f4@gmail.com> <X60TJ2u47WK3yY/y@kroah.com>
From:   Brice Goglin <brice.goglin@gmail.com>
Autocrypt: addr=brice.goglin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <33efde37-562f-4c6a-72ba-2277533e3781@gmail.com>
Date:   Tue, 17 Nov 2020 16:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <X60TJ2u47WK3yY/y@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 12/11/2020 à 11:49, Greg Kroah-Hartman a écrit :
> On Thu, Nov 12, 2020 at 10:10:57AM +0100, Brice Goglin wrote:
>> Le 12/11/2020 à 07:42, Greg Kroah-Hartman a écrit :
>>> On Thu, Nov 12, 2020 at 07:19:48AM +0100, Brice Goglin wrote:
>>>>
>>>> Hello
>>>>
>>>> Sorry for the late reply. As the first userspace consumer of this
>>>> interface [1], I can confirm that reading a single file to get the mask
>>>> would be better, at least for performance reason. On large platforms, we
>>>> already have to read thousands of sysfs files to get CPU topology and
>>>> cache information, I'd be happy not to read one more file per cpu.
>>>>
>>>> Reading these sysfs files is slow, and it does not scale well when
>>>> multiple processes read them in parallel.
>>> Really?  Where is the slowdown?  Would something like readfile() work
>>> better for you for that?
>>> 	https://lore.kernel.org/linux-api/20200704140250.423345-1-gregkh@linuxfoundation.org/
>>
>> I guess readfile would improve the sequential case by avoiding syscalls
>> but it would not improve the parallel case since syscalls shouldn't have
>> any parallel issue?
> syscalls should not have parallel issues at all.
>
>> We've been watching the status of readfile() since it was posted on LKML
>> 6 months ago, but we were actually wondering if it would end up being
>> included at some point.
> It needs a solid reason to be merged.  My "test" benchmarks are fun to
> run, but I have yet to find a real need for it anywhere as the
> open/read/close syscall overhead seems to be lost in the noise on any
> real application workload that I can find.
>
> If you have a real need, and it reduces overhead and cpu usage, I'm more
> than willing to update the patchset and resubmit it.
>
>

Hello

I updated hwloc to use readfile instead of open+read+close on all those
small sysfs/procfs files. Unfortunately the improvement is very small,
only a couple percents. On a 40 core server, our library starts in 38ms
instead of 39ms. I can't deploy your patches on larger machines, but I
tested our code on a copy of their sysfs files saved on a local disk :
For a 256-thread KNL, we go from 15ms to 14ms. For a 896-core SGI
machine, from 73ms to 71ms.

I see 200ns improvement for readfile (2300) vs open+read+close (2500) on
my server when reading a single cpu topology file. With several
thousands of sysfs files to read in the above large hwloc tests, it
confirms an overall improvement in the order of 1ms.

So, just like you said, the overhead seems to be pretty much lost in the
noise of hwloc doing its own stuff after reading hundreds of sysfs files :/

Brice


