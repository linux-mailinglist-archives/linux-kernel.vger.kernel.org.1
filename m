Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BD21EA01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 09:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 03:26:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13527 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNH0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:26:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0d5dc30000>; Tue, 14 Jul 2020 00:24:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 00:26:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jul 2020 00:26:43 -0700
Received: from [10.26.72.103] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 07:26:42 +0000
Subject: Re: [PATCH 1/2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
 <20200713032554.cykywnygxln6ukrl@vireshk-i7>
 <3d6091f2-6b04-185f-6c23-e39a34b87877@nvidia.com>
 <20200714034635.2zdv3wzmftjg2t4a@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <aa941c67-1dec-5363-7bd7-5e9d8d324110@nvidia.com>
Date:   Tue, 14 Jul 2020 08:26:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714034635.2zdv3wzmftjg2t4a@vireshk-i7>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594711491; bh=tZth7Y/1Zt4r7X56D1QfoSroo5wy+uKCt1xfia33abs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cYd9/1x8IOG/7Cbt/2SBVThW3A52KXxB0rGRifWa+q/f1NG4Vl5MRGjv3vcqslarC
         kZ1TvM16r/bLO8bh3vch4uDH2Dq5/GiCzud04FF94egLOdDh5/UyUhwU5c0QwTq11d
         lVc0vK1WeATMF4hKm54eJ572bLOcJjrI0Qna/jpVNlS0l7D5Zg82j4h8km0GZODnep
         w2UNwqhWiEZZjXaps7ldudd+1VjjURM3TT/g3cRjKvQHQZtE+qsWiliG+kMpDiZZ2H
         CztIWOx58saq5uk1XvM+mvpFNnZAYnJklKcVj/tRjuNk9oisIhdwNySDiqB3v4F3Ts
         UpKgmip/O2B6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/07/2020 04:46, Viresh Kumar wrote:
> On 13-07-20, 17:37, Jon Hunter wrote:
>>
>> On 13/07/2020 04:25, Viresh Kumar wrote:
>>> On 12-07-20, 11:06, Jon Hunter wrote:
>>>> Commit 6cc3d0e9a097 ("cpufreq: tegra186: add
>>>> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag") fixed CPUFREQ support for
>>>> Tegra186 but as a consequence the following warnings are now seen on
>>>> boot ...
>>>>
>>>>  cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 0 KHz
>>>>  cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 2035200 KHz
>>>>  cpufreq: cpufreq_online: CPU1: Running at unlisted freq: 0 KHz
>>>>  cpufreq: cpufreq_online: CPU1: Unlisted initial frequency changed to: 2035200 KHz
>>>>  cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 0 KHz
>>>>  cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 2035200 KHz
>>>>  cpufreq: cpufreq_online: CPU3: Running at unlisted freq: 0 KHz
>>>>  cpufreq: cpufreq_online: CPU3: Unlisted initial frequency changed to: 2035200 KHz
>>>>  cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 0 KHz
>>>>  cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 2035200 KHz
>>>>  cpufreq: cpufreq_online: CPU5: Running at unlisted freq: 0 KHz
>>>>  cpufreq: cpufreq_online: CPU5: Unlisted initial frequency changed to: 2035200 KHz
>>>>
>>>> Although we could fix this by adding a 'get' operator for the Tegra186
>>>> CPUFREQ driver, there is really little point because the CPUFREQ on
>>>> Tegra186 is set by writing a value stored in the frequency table to a
>>>> register and we just need to set the initial frequency.
>>>
>>> The hardware still runs at the frequency requested by cpufreq core here, right ?
>>
>> Yes.
>>
>>> It is better to provide the get() callback as it is also used to show the
>>> current frequency in userspace.
>>
>> I looked at that and I saw that if the get() callback is not provided,
>> the current frequency showed by userspace is policy->cur. For this
>> device, policy->cur is accurate and so if we added the get() callback we
>> essentially just going to return policy->cur. Therefore, given that we
>> already know policy->cur, I did not see the point in adding a device
>> specific handler to do the same thing.
> 
> The get() callback is supposed to read the frequency from hardware and
> return it, no cached value here. policy->cur may end up being wrong in
> case there is a bug.

OK, I can add a get callback. However, there are a few other drivers
that set the current frequency in the init() and don't implement a get()
callback ...

drivers/cpufreq/pasemi-cpufreq.c
drivers/cpufreq/ppc_cbe_cpufreq.c
drivers/cpufreq/intel_pstate.c

Jon

-- 
nvpublic
