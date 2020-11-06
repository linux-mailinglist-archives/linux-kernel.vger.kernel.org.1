Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B62A97F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKFOyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:54:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2066 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:54:02 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CSNfF5g6pz67JJk;
        Fri,  6 Nov 2020 22:52:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 6 Nov 2020 15:53:54 +0100
Received: from [10.47.7.5] (10.47.7.5) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 6 Nov 2020
 14:53:52 +0000
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot
 fills
From:   John Garry <john.garry@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
 <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
 <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
 <c409594a-0ae1-d8cd-ddee-226d739eed5b@huawei.com>
Message-ID: <66a0c5c7-403d-5257-a189-56d0c995c8fd@huawei.com>
Date:   Fri, 6 Nov 2020 14:53:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c409594a-0ae1-d8cd-ddee-226d739eed5b@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.7.5]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

>>> Something similar can happen in normal use, where the scheduler 
>>> relocates processes all over the CPUs in the system as time goes by, 
>>> which causes the total rcache size to continue to grow. And in 
>>> addition to this, the global depot continues to grow very slowly as 
>>> well. But when it does fill (the global depot, that is), and we start 
>>> to free magazines to make space – as is current policy - that's very 
>>> slow and causes the performance drop.
>>
>> Sure, but how does it then consistently *remain* in that state? And 
>> *why* does the depot slowly and steadily grow in the first place if 
>> alloc and free are ultimately balanced? 
> 
> So some key info I missed sharing was that we only see this issue for 
> non-strict mode. For strict mode, the rcache occupancy stays quite 
> compact, and does not grow like we see for non-strict mode.
> 
> I have some (very large) kernel logs in which all the CPU and depot 
> rcache occupancy levels are periodically dumped, and where you can get 
> an idea of the trend.
> 
> I'm on vacation today, so I can share them tomorrow.

I have put the existing logs here:

https://raw.githubusercontent.com/hisilicon/kernel-dev/private-topic-smmu-5.10-longterm-issue/batch1_iova.txt
https://raw.githubusercontent.com/hisilicon/kernel-dev/private-topic-smmu-5.10-longterm-issue/batch2_iova.txt

As you can see, they are a mess as the fio tool output is interspersed. 
I was trying to get new, clean logs, but there is something wrong with 
the board setup. I'm working on that.

In the meantime, some extracts from those logs are below. These are 
dumps of the IOVA CPU rcache sizes per CPU, per granule, including the 
loaded and previous sizes. Also there is the equivalent for the depot.

2x totals are here:
[13237.424243] print_iova1 cpu_total=40796 depot_total=3943 total=44739
[56653.029116] print_iova1 cpu_total=59227 depot_total=5915 total=65142

So we grow from 44739 -> 65142 over about 12 hours in this test.

Early in the test:

[13235.977877] print_cpu_iova cpu0 i=0 l=109 p=128 i=1 l=97 p=128 i=2 
l=93 p=128 i=3 l=50 p=0 i=4 l=79 p=0 i=5 l=40 p=0  total=852
[13235.989313] print_cpu_iova cpu1 i=0 l=81 p=0 i=1 l=45 p=0 i=2 l=123 
p=0 i=3 l=106 p=0 i=4 l=109 p=0 i=5 l=41 p=0  total=505
[13236.000404] print_cpu_iova cpu2 i=0 l=44 p=0 i=1 l=120 p=0 i=2 l=106 
p=0 i=3 l=90 p=0 i=4 l=85 p=0 i=5 l=88 p=0  total=533
[13236.012785] print_cpu_iova cpu3 i=0 l=56 p=0 i=1 l=126 p=0 i=2 l=119 
p=0 i=3 l=115 p=0 i=4 l=111 p=0 i=5 l=113 p=0  total=640
[13236.025416] print_cpu_iova cpu4 i=0 l=52 p=0 i=1 l=127 p=0 i=2 l=0 
p=0 i=3 l=125 p=0 i=4 l=124 p=0 i=5 l=125 p=0  total=553
[13236.037878] print_cpu_iova cpu5 i=0 l=79 p=0 i=1 l=127 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=125 p=0 i=5 l=123 p=0  total=454
[13236.050161] print_cpu_iova cpu6 i=0 l=75 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=75
[13236.061842] print_cpu_iova cpu7 i=0 l=110 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=237
[13236.073868] print_cpu_iova cpu8 i=0 l=59 p=128 i=1 l=75 p=128 i=2 
l=72 p=128 i=3 l=96 p=128 i=4 l=48 p=128 i=5 l=88 p=128  total=1206
[13236.087108] print_cpu_iova cpu9 i=0 l=45 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=126 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=298
[13236.097845] print_cpu_iova cpu10 i=0 l=22 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=22
[13236.108238] print_cpu_iova cpu11 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=254
[13236.118976] print_cpu_iova cpu12 i=0 l=23 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=126 p=0  total=403
[13236.129973] print_cpu_iova cpu13 i=0 l=113 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=126 p=0 i=4 l=126 p=0 i=5 l=0 p=0  total=365
[13236.140885] print_cpu_iova cpu14 i=0 l=110 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=110
[13236.151449] print_cpu_iova cpu15 i=0 l=95 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=222
[13236.162103] print_cpu_iova cpu16 i=0 l=4 p=128 i=1 l=119 p=0 i=2 l=22 
p=0 i=3 l=16 p=128 i=4 l=111 p=0 i=5 l=96 p=0  total=624
[13236.173445] print_cpu_iova cpu17 i=0 l=32 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=32
[13236.183838] print_cpu_iova cpu18 i=0 l=50 p=0 i=1 l=126 p=0 i=2 l=127 
p=0 i=3 l=119 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=549
[13236.195008] print_cpu_iova cpu19 i=0 l=90 p=0 i=1 l=127 p=0 i=2 l=126 
p=0 i=3 l=125 p=0 i=4 l=127 p=0 i=5 l=126 p=0  total=721
[13236.206351] print_cpu_iova cpu20 i=0 l=122 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=122
[13236.216917] print_cpu_iova cpu21 i=0 l=121 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=126 p=0 i=5 l=127 p=0  total=501
[13236.228002] print_cpu_iova cpu22 i=0 l=123 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=377
[13236.238914] print_cpu_iova cpu23 i=0 l=107 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=126 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=233
[13236.249653] print_cpu_iova cpu24 i=0 l=77 p=128 i=1 l=4 p=0 i=2 l=83 
p=0 i=3 l=47 p=0 i=4 l=41 p=0 i=5 l=96 p=0  total=476
[13236.260653] print_cpu_iova cpu25 i=0 l=29 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=126 p=0 i=5 l=0 p=0  total=155
[13236.271305] print_cpu_iova cpu26 i=0 l=6 p=0 i=1 l=0 p=0 i=2 l=124 
p=0 i=3 l=0 p=0 i=4 l=126 p=0 i=5 l=0 p=0  total=256
[13236.282043] print_cpu_iova cpu27 i=0 l=92 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=219
[13236.292699] print_cpu_iova cpu28 i=0 l=61 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=125 p=0  total=186
[13236.303353] print_cpu_iova cpu29 i=0 l=33 p=0 i=1 l=126 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=286
[13236.314180] print_cpu_iova cpu30 i=0 l=121 p=0 i=1 l=127 p=0 i=2 
l=127 p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=756
[13236.325612] print_cpu_iova cpu31 i=0 l=116 p=0 i=1 l=127 p=0 i=2 
l=127 p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=624
[13236.336871] print_cpu_iova cpu32 i=0 l=120 p=128 i=1 l=106 p=0 i=2 
l=74 p=0 i=3 l=100 p=128 i=4 l=115 p=128 i=5 l=100 p=128  total=1127
[13236.348994] print_cpu_iova cpu33 i=0 l=19 p=0 i=1 l=59 p=0 i=2 l=103 
p=0 i=3 l=5 p=0 i=4 l=94 p=0 i=5 l=67 p=0  total=347
[13236.359907] print_cpu_iova cpu34 i=0 l=109 p=0 i=1 l=125 p=0 i=2 
l=122 p=0 i=3 l=105 p=0 i=4 l=99 p=0 i=5 l=105 p=0  total=665
[13236.371252] print_cpu_iova cpu35 i=0 l=35 p=0 i=1 l=126 p=0 i=2 l=125 
p=0 i=3 l=119 p=0 i=4 l=120 p=0 i=5 l=124 p=0  total=649
[13236.382596] print_cpu_iova cpu36 i=0 l=58 p=0 i=1 l=126 p=0 i=2 l=126 
p=0 i=3 l=126 p=0 i=4 l=126 p=0 i=5 l=127 p=0  total=689
[13236.393940] print_cpu_iova cpu37 i=0 l=88 p=0 i=1 l=127 p=0 i=2 l=126 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=595
[13236.405111] print_cpu_iova cpu38 i=0 l=99 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=125 p=0 i=4 l=124 p=0 i=5 l=127 p=0  total=475
[13236.416109] print_cpu_iova cpu39 i=0 l=122 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=249
[13236.426848] print_cpu_iova cpu40 i=0 l=74 p=128 i=1 l=122 p=0 i=2 
l=69 p=0 i=3 l=35 p=0 i=4 l=40 p=0 i=5 l=59 p=0  total=527
[13236.438018] print_cpu_iova cpu41 i=0 l=99 p=0 i=1 l=127 p=0 i=2 l=125 
p=0 i=3 l=124 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=602
[13236.449188] print_cpu_iova cpu42 i=0 l=83 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=122 p=0 i=4 l=124 p=0 i=5 l=127 p=0  total=582
[13236.460359] print_cpu_iova cpu43 i=0 l=55 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=182
[13236.471011] print_cpu_iova cpu44 i=0 l=122 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=126 p=0  total=625
[13236.482271] print_cpu_iova cpu45 i=0 l=25 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=25
[13236.492663] print_cpu_iova cpu46 i=0 l=111 p=0 i=1 l=127 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=238
[13236.503402] print_cpu_iova cpu47 i=0 l=12 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=266
[13236.514230] print_cpu_iova cpu48 i=0 l=111 p=128 i=1 l=49 p=128 i=2 
l=95 p=128 i=3 l=18 p=128 i=4 l=80 p=128 i=5 l=9 p=128  total=1130
[13236.526265] print_cpu_iova cpu49 i=0 l=121 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=127 p=0  total=625
[13236.537524] print_cpu_iova cpu50 i=0 l=16 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=143
[13236.548176] print_cpu_iova cpu51 i=0 l=104 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=104
[13236.558741] print_cpu_iova cpu52 i=0 l=95 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=95
[13236.569135] print_cpu_iova cpu53 i=0 l=67 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=126 p=0  total=320
[13236.579963] print_cpu_iova cpu54 i=0 l=34 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=161
[13236.590616] print_cpu_iova cpu55 i=0 l=58 p=0 i=1 l=125 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=124 p=0 i=5 l=0 p=0  total=434
[13236.601615] print_cpu_iova cpu56 i=0 l=1 p=128 i=1 l=77 p=0 i=2 l=76 
p=0 i=3 l=61 p=0 i=4 l=25 p=0 i=5 l=78 p=0  total=446
[13236.612614] print_cpu_iova cpu57 i=0 l=112 p=0 i=1 l=127 p=0 i=2 
l=127 p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=124 p=0  total=744
[13236.624042] print_cpu_iova cpu58 i=0 l=82 p=0 i=1 l=0 p=0 i=2 l=125 
p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=127 p=0  total=585
[13236.635212] print_cpu_iova cpu59 i=0 l=107 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=125 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=486
[13236.646298] print_cpu_iova cpu60 i=0 l=86 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=213
[13236.656951] print_cpu_iova cpu61 i=0 l=38 p=0 i=1 l=127 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=419
[13236.667948] print_cpu_iova cpu62 i=0 l=107 p=0 i=1 l=127 p=0 i=2 
l=127 p=0 i=3 l=124 p=0 i=4 l=126 p=0 i=5 l=0 p=0  total=611
[13236.679208] print_cpu_iova cpu63 i=0 l=67 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=67
[13236.689600] print_cpu_iova cpu64 i=0 l=122 p=128 i=1 l=17 p=0 i=2 
l=15 p=128 i=3 l=94 p=0 i=4 l=71 p=0 i=5 l=48 p=0  total=623
[13236.700943] print_cpu_iova cpu65 i=0 l=65 p=0 i=1 l=119 p=0 i=2 l=110 
p=0 i=3 l=103 p=0 i=4 l=87 p=0 i=5 l=99 p=0  total=583
[13236.712113] print_cpu_iova cpu66 i=0 l=51 p=0 i=1 l=126 p=0 i=2 l=127 
p=0 i=3 l=125 p=0 i=4 l=119 p=0 i=5 l=114 p=0  total=662
[13236.723456] print_cpu_iova cpu67 i=0 l=104 p=0 i=1 l=127 p=0 i=2 
l=123 p=0 i=3 l=123 p=0 i=4 l=120 p=0 i=5 l=120 p=0  total=717
[13236.734888] print_cpu_iova cpu68 i=0 l=49 p=0 i=1 l=127 p=0 i=2 l=127 
p=0 i=3 l=122 p=0 i=4 l=120 p=0 i=5 l=121 p=0  total=666
[13236.746232] print_cpu_iova cpu69 i=0 l=107 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=361
[13236.757143] print_cpu_iova cpu70 i=0 l=41 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=124 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=419
[13236.768140] print_cpu_iova cpu71 i=0 l=114 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=125 p=0 i=5 l=127 p=0  total=493
[13236.779226] print_cpu_iova cpu72 i=0 l=29 p=128 i=1 l=34 p=128 i=2 
l=125 p=0 i=3 l=89 p=0 i=4 l=57 p=0 i=5 l=106 p=0  total=696
[13236.790654] print_cpu_iova cpu73 i=0 l=9 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=390
[13236.801566] print_cpu_iova cpu74 i=0 l=1 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=126 p=0  total=127
[13236.812132] print_cpu_iova cpu75 i=0 l=46 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=46
[13236.822524] print_cpu_iova cpu76 i=0 l=123 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=123
[13236.833089] print_cpu_iova cpu77 i=0 l=112 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=112
[13236.843655] print_cpu_iova cpu78 i=0 l=27 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=27
[13236.854049] print_cpu_iova cpu79 i=0 l=8 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=8
[13236.864271] print_cpu_iova cpu80 i=0 l=6 p=128 i=1 l=90 p=0 i=2 l=126 
p=0 i=3 l=84 p=0 i=4 l=49 p=0 i=5 l=87 p=0  total=570
[13236.875355] print_cpu_iova cpu81 i=0 l=43 p=0 i=1 l=125 p=0 i=2 l=122 
p=0 i=3 l=125 p=0 i=4 l=123 p=0 i=5 l=122 p=0  total=660
[13236.886699] print_cpu_iova cpu82 i=0 l=4 p=0 i=1 l=126 p=0 i=2 l=126 
p=0 i=3 l=123 p=0 i=4 l=0 p=0 i=5 l=117 p=0  total=496
[13236.897784] print_cpu_iova cpu83 i=0 l=21 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=21
[13236.908175] print_cpu_iova cpu84 i=0 l=85 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=85
[13236.918569] print_cpu_iova cpu85 i=0 l=108 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=108
[13236.929134] print_cpu_iova cpu86 i=0 l=32 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=32
[13236.939528] print_cpu_iova cpu87 i=0 l=60 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=60
[13236.949922] print_cpu_iova cpu88 i=0 l=41 p=128 i=1 l=73 p=0 i=2 l=18 
p=0 i=3 l=13 p=128 i=4 l=84 p=0 i=5 l=1 p=128  total=614
[13236.961266] print_cpu_iova cpu89 i=0 l=43 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=43
[13236.971660] print_cpu_iova cpu90 i=0 l=117 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=244
[13236.982398] print_cpu_iova cpu91 i=0 l=32 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=32
[13236.992790] print_cpu_iova cpu92 i=0 l=18 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=18
[13237.003185] print_cpu_iova cpu93 i=0 l=100 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=100
[13237.013751] print_cpu_iova cpu94 i=0 l=77 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=77
[13237.024144] print_cpu_iova cpu95 i=0 l=79 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=79
[13237.035913] print_cpu_iova cpu96 i=0 l=21 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=127 p=0 i=4 l=125 p=0 i=5 l=127 p=0  total=526
[13237.048458] print_cpu_iova cpu97 i=0 l=119 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=119
[13237.060400] print_cpu_iova cpu98 i=0 l=112 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=239
[13237.072515] print_cpu_iova cpu99 i=0 l=118 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=118
[13237.084457] print_cpu_iova cpu100 i=0 l=122 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=122
[13237.096481] print_cpu_iova cpu101 i=0 l=118 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=372
[13237.108766] print_cpu_iova cpu102 i=0 l=122 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=122
[13237.119419] print_cpu_iova cpu103 i=0 l=127 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=127
[13237.130073] print_cpu_iova cpu104 i=0 l=47 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=1 p=0  total=48
[13237.140554] print_cpu_iova cpu105 i=0 l=125 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=252
[13237.151378] print_cpu_iova cpu106 i=0 l=124 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=251
[13237.162205] print_cpu_iova cpu107 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.172512] print_cpu_iova cpu108 i=0 l=115 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=115
[13237.183165] print_cpu_iova cpu109 i=0 l=119 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=246
[13237.193992] print_cpu_iova cpu110 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[13237.204645] print_cpu_iova cpu111 i=0 l=105 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=105
[13237.215298] print_cpu_iova cpu112 i=0 l=82 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=209
[13237.226036] print_cpu_iova cpu113 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[13237.236689] print_cpu_iova cpu114 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.246997] print_cpu_iova cpu115 i=0 l=125 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=125
[13237.257650] print_cpu_iova cpu116 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[13237.268303] print_cpu_iova cpu117 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[13237.278955] print_cpu_iova cpu118 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[13237.289608] print_cpu_iova cpu119 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.299914] print_cpu_iova cpu120 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=1 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=1
[13237.310222] print_cpu_iova cpu121 i=0 l=127 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=127
[13237.320875] print_cpu_iova cpu122 i=0 l=125 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=252
[13237.331701] print_cpu_iova cpu123 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[13237.342353] print_cpu_iova cpu124 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.352659] print_cpu_iova cpu125 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.362965] print_cpu_iova cpu126 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.373271] print_cpu_iova cpu127 i=0 l=0 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=0
[13237.383583] print_iova rcache0 128 128 128 128 128 128 128 128 128 
128 128 128 128 128 128 124 124 0 0 128 0 0 0 0 122 0 128 0 0 0  [dcount=30]
[13237.396393] print_iova rcache1 119 0 0 0 0 0  [dcount=6]
[13237.401688] print_iova rcache2 128 76 0 0 0 0 0 127  [dcount=8]
[13237.407586] print_iova rcache3 128 117 0 0 0 0  [dcount=6]
[13237.413052] print_iova rcache4 128 106 0 0 0 128  [dcount=6]
[13237.418692] print_iova rcache5 128 76 96 40 0 0  [dcount=6]
[13237.424243] print_iova1 cpu_total=40796 depot_total=3943 total=44739
[13237.430574] print_iova2 iova_allocs(=5000000 rcache=4940355 (98 %) 
new_iova=59645 diff=0 fail=0 flush=0) rcache_get=(4940367, pfn=4940355, 
success=4940355, zero depot=12) insert depot full=0 too_big=59496

Late:

[56651.548944] print_cpu_iova cpu0 i=0 l=97 p=128 i=1 l=80 p=0 i=2 l=49 
p=0 i=3 l=18 p=0 i=4 l=76 p=0 i=5 l=46 p=0  total=494
[56651.560028] print_cpu_iova cpu1 i=0 l=57 p=0 i=1 l=54 p=0 i=2 l=119 
p=0 i=3 l=113 p=0 i=4 l=22 p=0 i=5 l=97 p=0  total=462
[56651.571033] print_cpu_iova cpu2 i=0 l=95 p=0 i=1 l=83 p=0 i=2 l=44 
p=0 i=3 l=112 p=0 i=4 l=36 p=0 i=5 l=47 p=0  total=417
[56651.581948] print_cpu_iova cpu3 i=0 l=17 p=0 i=1 l=114 p=0 i=2 l=91 
p=0 i=3 l=73 p=0 i=4 l=56 p=0 i=5 l=34 p=0  total=385
[56651.592864] print_cpu_iova cpu4 i=0 l=76 p=0 i=1 l=121 p=0 i=2 l=117 
p=0 i=3 l=111 p=0 i=4 l=106 p=0 i=5 l=100 p=0  total=631
[56651.604127] print_cpu_iova cpu5 i=0 l=67 p=0 i=1 l=127 p=0 i=2 l=125 
p=0 i=3 l=122 p=0 i=4 l=115 p=0 i=5 l=113 p=0  total=669
[56651.615388] print_cpu_iova cpu6 i=0 l=76 p=0 i=1 l=126 p=0 i=2 l=0 
p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=123 p=0  total=576
[56651.626477] print_cpu_iova cpu7 i=0 l=24 p=0 i=1 l=127 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=125 p=0 i=5 l=115 p=0  total=518
[56651.637563] print_cpu_iova cpu8 i=0 l=78 p=128 i=1 l=13 p=0 i=2 l=9 
p=128 i=3 l=70 p=0 i=4 l=14 p=0 i=5 l=83 p=0  total=523
[56651.648651] print_cpu_iova cpu9 i=0 l=71 p=0 i=1 l=125 p=0 i=2 l=125 
p=0 i=3 l=121 p=0 i=4 l=122 p=0 i=5 l=124 p=0  total=688
[56651.659913] print_cpu_iova cpu10 i=0 l=95 p=0 i=1 l=124 p=0 i=2 l=123 
p=0 i=3 l=123 p=0 i=4 l=125 p=0 i=5 l=126 p=0  total=716
[56651.672634] print_cpu_iova cpu11 i=0 l=74 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=120 p=0 i=4 l=127 p=0 i=5 l=123 p=0  total=444
[56651.685008] print_cpu_iova cpu12 i=0 l=62 p=0 i=1 l=0 p=0 i=2 l=125 
p=0 i=3 l=123 p=0 i=4 l=121 p=0 i=5 l=121 p=0  total=552
[56651.697554] print_cpu_iova cpu13 i=0 l=35 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=120 p=0 i=4 l=123 p=0 i=5 l=127 p=0  total=405
[56651.709926] print_cpu_iova cpu14 i=0 l=81 p=0 i=1 l=127 p=0 i=2 l=124 
p=0 i=3 l=122 p=0 i=4 l=126 p=0 i=5 l=127 p=0  total=707
[56651.722645] print_cpu_iova cpu15 i=0 l=56 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=124 p=0 i=4 l=123 p=0 i=5 l=126 p=0  total=555
[56651.735201] print_cpu_iova cpu16 i=0 l=15 p=128 i=1 l=31 p=128 i=2 
l=97 p=128 i=3 l=24 p=128 i=4 l=21 p=128 i=5 l=111 p=128  total=1067
[56651.748608] print_cpu_iova cpu17 i=0 l=120 p=0 i=1 l=0 p=0 i=2 l=125 
p=0 i=3 l=123 p=0 i=4 l=125 p=0 i=5 l=124 p=0  total=617
[56651.759870] print_cpu_iova cpu18 i=0 l=115 p=0 i=1 l=125 p=0 i=2 
l=126 p=0 i=3 l=114 p=0 i=4 l=123 p=0 i=5 l=125 p=0  total=728
[56651.771302] print_cpu_iova cpu19 i=0 l=1 p=0 i=1 l=126 p=0 i=2 l=126 
p=0 i=3 l=123 p=0 i=4 l=122 p=0 i=5 l=126 p=0  total=624
[56651.782564] print_cpu_iova cpu20 i=0 l=66 p=0 i=1 l=127 p=0 i=2 l=121 
p=0 i=3 l=120 p=0 i=4 l=126 p=0 i=5 l=127 p=0  total=687
[56651.793912] print_cpu_iova cpu21 i=0 l=13 p=0 i=1 l=0 p=0 i=2 l=124 
p=0 i=3 l=127 p=0 i=4 l=124 p=0 i=5 l=125 p=0  total=513
[56651.805085] print_cpu_iova cpu22 i=0 l=68 p=0 i=1 l=0 p=0 i=2 l=124 
p=0 i=3 l=125 p=0 i=4 l=0 p=0 i=5 l=125 p=0  total=442
[56651.816087] print_cpu_iova cpu23 i=0 l=69 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=124 p=0 i=4 l=123 p=0 i=5 l=0 p=0  total=443
[56651.827087] print_cpu_iova cpu24 i=0 l=70 p=128 i=1 l=126 p=0 i=2 
l=80 p=0 i=3 l=66 p=0 i=4 l=61 p=0 i=5 l=17 p=0  total=548
[56651.838261] print_cpu_iova cpu25 i=0 l=127 p=0 i=1 l=127 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=121 p=0 i=5 l=121 p=0  total=623
[56651.849522] print_cpu_iova cpu26 i=0 l=87 p=0 i=1 l=0 p=0 i=2 l=123 
p=0 i=3 l=0 p=0 i=4 l=121 p=0 i=5 l=0 p=0  total=331
[56651.860352] print_cpu_iova cpu27 i=0 l=64 p=0 i=1 l=126 p=0 i=2 l=124 
p=0 i=3 l=121 p=0 i=4 l=126 p=0 i=5 l=125 p=0  total=686
[56651.871698] print_cpu_iova cpu28 i=0 l=47 p=0 i=1 l=0 p=0 i=2 l=124 
p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=124 p=0  total=546
[56651.882875] print_cpu_iova cpu29 i=0 l=43 p=0 i=1 l=124 p=0 i=2 l=123 
p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=124 p=0  total=665
[56651.894221] print_cpu_iova cpu30 i=0 l=106 p=0 i=1 l=126 p=0 i=2 
l=127 p=0 i=3 l=123 p=0 i=4 l=124 p=0 i=5 l=122 p=0  total=728
[56651.905653] print_cpu_iova cpu31 i=0 l=6 p=0 i=1 l=126 p=0 i=2 l=127 
p=0 i=3 l=124 p=0 i=4 l=123 p=0 i=5 l=126 p=0  total=632
[56651.916913] print_cpu_iova cpu32 i=0 l=38 p=128 i=1 l=27 p=0 i=2 l=5 
p=128 i=3 l=84 p=0 i=4 l=78 p=0 i=5 l=36 p=0  total=524
[56651.928088] print_cpu_iova cpu33 i=0 l=68 p=0 i=1 l=14 p=0 i=2 l=36 
p=0 i=3 l=24 p=0 i=4 l=103 p=0 i=5 l=18 p=0  total=263
[56651.939089] print_cpu_iova cpu34 i=0 l=76 p=0 i=1 l=107 p=0 i=2 l=73 
p=0 i=3 l=15 p=0 i=4 l=18 p=0 i=5 l=21 p=0  total=310
[56651.950092] print_cpu_iova cpu35 i=0 l=101 p=0 i=1 l=124 p=0 i=2 
l=115 p=0 i=3 l=102 p=0 i=4 l=78 p=0 i=5 l=90 p=0  total=610
[56651.961352] print_cpu_iova cpu36 i=0 l=103 p=0 i=1 l=125 p=0 i=2 
l=119 p=0 i=3 l=117 p=0 i=4 l=117 p=0 i=5 l=118 p=0  total=699
[56651.972784] print_cpu_iova cpu37 i=0 l=57 p=0 i=1 l=123 p=0 i=2 l=123 
p=0 i=3 l=123 p=0 i=4 l=123 p=0 i=5 l=117 p=0  total=666
[56651.984132] print_cpu_iova cpu38 i=0 l=125 p=0 i=1 l=127 p=0 i=2 
l=123 p=0 i=3 l=120 p=0 i=4 l=113 p=0 i=5 l=117 p=0  total=725
[56651.995565] print_cpu_iova cpu39 i=0 l=93 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=127 p=0 i=4 l=126 p=0 i=5 l=124 p=0  total=596
[56652.006740] print_cpu_iova cpu40 i=0 l=92 p=128 i=1 l=91 p=0 i=2 l=42 
p=0 i=3 l=86 p=0 i=4 l=14 p=0 i=5 l=76 p=0  total=529
[56652.017828] print_cpu_iova cpu41 i=0 l=95 p=0 i=1 l=126 p=0 i=2 l=122 
p=0 i=3 l=121 p=0 i=4 l=120 p=0 i=5 l=120 p=0  total=704
[56652.029174] print_cpu_iova cpu42 i=0 l=1 p=0 i=1 l=126 p=0 i=2 l=123 
p=0 i=3 l=120 p=0 i=4 l=120 p=0 i=5 l=124 p=0  total=614
[56652.040434] print_cpu_iova cpu43 i=0 l=49 p=0 i=1 l=127 p=0 i=2 l=126 
p=0 i=3 l=123 p=0 i=4 l=122 p=0 i=5 l=124 p=0  total=671
[56652.051781] print_cpu_iova cpu44 i=0 l=7 p=0 i=1 l=127 p=0 i=2 l=126 
p=0 i=3 l=126 p=0 i=4 l=124 p=0 i=5 l=119 p=0  total=629
[56652.063042] print_cpu_iova cpu45 i=0 l=4 p=0 i=1 l=0 p=0 i=2 l=125 
p=0 i=3 l=125 p=0 i=4 l=119 p=0 i=5 l=126 p=0  total=499
[56652.074131] print_cpu_iova cpu46 i=0 l=112 p=0 i=1 l=126 p=0 i=2 l=0 
p=0 i=3 l=126 p=0 i=4 l=123 p=0 i=5 l=126 p=0  total=613
[56652.085393] print_cpu_iova cpu47 i=0 l=20 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=125 p=0 i=4 l=126 p=0 i=5 l=127 p=0  total=525
[56652.096567] print_cpu_iova cpu48 i=0 l=67 p=128 i=1 l=96 p=0 i=2 l=14 
p=0 i=3 l=31 p=0 i=4 l=57 p=0 i=5 l=81 p=0  total=474
[56652.107656] print_cpu_iova cpu49 i=0 l=5 p=0 i=1 l=126 p=0 i=2 l=126 
p=0 i=3 l=125 p=0 i=4 l=123 p=0 i=5 l=125 p=0  total=630
[56652.118916] print_cpu_iova cpu50 i=0 l=38 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=125 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=543
[56652.130091] print_cpu_iova cpu51 i=0 l=113 p=0 i=1 l=127 p=0 i=2 
l=122 p=0 i=3 l=126 p=0 i=4 l=125 p=0 i=5 l=127 p=0  total=740
[56652.141524] print_cpu_iova cpu52 i=0 l=98 p=0 i=1 l=127 p=0 i=2 l=125 
p=0 i=3 l=121 p=0 i=4 l=122 p=0 i=5 l=125 p=0  total=718
[56652.152870] print_cpu_iova cpu53 i=0 l=57 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=127 p=0 i=4 l=126 p=0 i=5 l=125 p=0  total=435
[56652.163870] print_cpu_iova cpu54 i=0 l=37 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=126 p=0 i=5 l=125 p=0  total=288
[56652.174699] print_cpu_iova cpu55 i=0 l=99 p=0 i=1 l=125 p=0 i=2 l=124 
p=0 i=3 l=122 p=0 i=4 l=122 p=0 i=5 l=124 p=0  total=716
[56652.186048] print_cpu_iova cpu56 i=0 l=4 p=128 i=1 l=73 p=0 i=2 l=63 
p=0 i=3 l=88 p=0 i=4 l=90 p=0 i=5 l=109 p=0  total=555
[56652.197135] print_cpu_iova cpu57 i=0 l=65 p=0 i=1 l=127 p=0 i=2 l=123 
p=0 i=3 l=125 p=0 i=4 l=126 p=0 i=5 l=124 p=0  total=690
[56652.208483] print_cpu_iova cpu58 i=0 l=102 p=0 i=1 l=0 p=0 i=2 l=124 
p=0 i=3 l=124 p=0 i=4 l=124 p=0 i=5 l=122 p=0  total=596
[56652.219743] print_cpu_iova cpu59 i=0 l=31 p=0 i=1 l=0 p=0 i=2 l=125 
p=0 i=3 l=122 p=0 i=4 l=126 p=0 i=5 l=0 p=0  total=404
[56652.230743] print_cpu_iova cpu60 i=0 l=92 p=0 i=1 l=126 p=0 i=2 l=125 
p=0 i=3 l=125 p=0 i=4 l=126 p=0 i=5 l=127 p=0  total=721
[56652.242091] print_cpu_iova cpu61 i=0 l=109 p=0 i=1 l=126 p=0 i=2 
l=127 p=0 i=3 l=126 p=0 i=4 l=124 p=0 i=5 l=126 p=0  total=738
[56652.253525] print_cpu_iova cpu62 i=0 l=104 p=0 i=1 l=124 p=0 i=2 
l=125 p=0 i=3 l=121 p=0 i=4 l=121 p=0 i=5 l=124 p=0  total=719
[56652.264957] print_cpu_iova cpu63 i=0 l=104 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=358
[56652.275872] print_cpu_iova cpu64 i=0 l=37 p=128 i=1 l=18 p=0 i=2 l=16 
p=0 i=3 l=42 p=0 i=4 l=47 p=0 i=5 l=15 p=0  total=303
[56652.286962] print_cpu_iova cpu65 i=0 l=50 p=0 i=1 l=94 p=0 i=2 l=69 
p=0 i=3 l=49 p=0 i=4 l=120 p=0 i=5 l=15 p=0  total=397
[56652.297965] print_cpu_iova cpu66 i=0 l=20 p=0 i=1 l=118 p=0 i=2 l=112 
p=0 i=3 l=103 p=0 i=4 l=100 p=0 i=5 l=82 p=0  total=535
[56652.309226] print_cpu_iova cpu67 i=0 l=82 p=0 i=1 l=126 p=0 i=2 l=118 
p=0 i=3 l=116 p=0 i=4 l=111 p=0 i=5 l=105 p=0  total=658
[56652.320573] print_cpu_iova cpu68 i=0 l=48 p=0 i=1 l=127 p=0 i=2 l=123 
p=0 i=3 l=118 p=0 i=4 l=112 p=0 i=5 l=116 p=0  total=644
[56652.331921] print_cpu_iova cpu69 i=0 l=33 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=124 p=0 i=4 l=118 p=0 i=5 l=121 p=0  total=523
[56652.343095] print_cpu_iova cpu70 i=0 l=97 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=123 p=0 i=4 l=123 p=0 i=5 l=123 p=0  total=592
[56652.354272] print_cpu_iova cpu71 i=0 l=94 p=0 i=1 l=125 p=0 i=2 l=124 
p=0 i=3 l=125 p=0 i=4 l=121 p=0 i=5 l=123 p=0  total=712
[56652.365618] print_cpu_iova cpu72 i=0 l=83 p=128 i=1 l=63 p=0 i=2 l=62 
p=0 i=3 l=83 p=0 i=4 l=30 p=0 i=5 l=105 p=0  total=554
[56652.376795] print_cpu_iova cpu73 i=0 l=53 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=126 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=433
[56652.387795] print_cpu_iova cpu74 i=0 l=55 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=123 p=0  total=178
[56652.398451] print_cpu_iova cpu75 i=0 l=48 p=0 i=1 l=127 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=126 p=0 i=5 l=0 p=0  total=428
[56652.409452] print_cpu_iova cpu76 i=0 l=77 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=204
[56652.420108] print_cpu_iova cpu77 i=0 l=48 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=48
[56652.430502] print_cpu_iova cpu78 i=0 l=1 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=1
[56652.440727] print_cpu_iova cpu79 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[56652.451296] print_cpu_iova cpu80 i=0 l=72 p=128 i=1 l=75 p=0 i=2 l=66 
p=0 i=3 l=42 p=0 i=4 l=112 p=0 i=5 l=104 p=0  total=599
[56652.462558] print_cpu_iova cpu81 i=0 l=108 p=0 i=1 l=124 p=0 i=2 
l=121 p=0 i=3 l=125 p=0 i=4 l=123 p=0 i=5 l=120 p=0  total=721
[56652.473992] print_cpu_iova cpu82 i=0 l=117 p=0 i=1 l=126 p=0 i=2 
l=123 p=0 i=3 l=117 p=0 i=4 l=126 p=0 i=5 l=103 p=0  total=712
[56652.485426] print_cpu_iova cpu83 i=0 l=39 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=39
[56652.495822] print_cpu_iova cpu84 i=0 l=113 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=113
[56652.506392] print_cpu_iova cpu85 i=0 l=124 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=124
[56652.516962] print_cpu_iova cpu86 i=0 l=29 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=29
[56652.527359] print_cpu_iova cpu87 i=0 l=116 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=116
[56652.537927] print_cpu_iova cpu88 i=0 l=12 p=128 i=1 l=20 p=128 i=2 
l=72 p=128 i=3 l=100 p=0 i=4 l=13 p=128 i=5 l=93 p=128  total=950
[56652.549793] print_cpu_iova cpu89 i=0 l=8 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=126 p=0 i=4 l=120 p=0 i=5 l=119 p=0  total=373
[56652.560709] print_cpu_iova cpu90 i=0 l=81 p=0 i=1 l=125 p=0 i=2 l=117 
p=0 i=3 l=104 p=0 i=4 l=106 p=0 i=5 l=99 p=0  total=632
[56652.571972] print_cpu_iova cpu91 i=0 l=102 p=0 i=1 l=127 p=0 i=2 
l=125 p=0 i=3 l=119 p=0 i=4 l=117 p=0 i=5 l=104 p=0  total=694
[56652.583404] print_cpu_iova cpu92 i=0 l=57 p=0 i=1 l=127 p=0 i=2 l=120 
p=0 i=3 l=111 p=0 i=4 l=122 p=0 i=5 l=121 p=0  total=658
[56652.594919] print_cpu_iova cpu93 i=0 l=56 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=56
[56652.605317] print_cpu_iova cpu94 i=0 l=34 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=34
[56652.615713] print_cpu_iova cpu95 i=0 l=68 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=68
[56652.626108] print_cpu_iova cpu96 i=0 l=45 p=0 i=1 l=1 p=128 i=2 l=0 
p=128 i=3 l=0 p=128 i=4 l=123 p=0 i=5 l=126 p=0  total=679
[56652.637454] print_cpu_iova cpu97 i=0 l=109 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=363
[56652.648368] print_cpu_iova cpu98 i=0 l=92 p=0 i=1 l=0 p=0 i=2 l=0 p=0 
i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=125 p=0  total=471
[56652.659369] print_cpu_iova cpu99 i=0 l=104 p=0 i=1 l=126 p=0 i=2 
l=127 p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=126 p=0  total=483
[56652.670456] print_cpu_iova cpu100 i=0 l=101 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=355
[56652.682838] print_cpu_iova cpu101 i=0 l=93 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=474
[56652.695297] print_cpu_iova cpu102 i=0 l=80 p=0 i=1 l=127 p=0 i=2 
l=126 p=0 i=3 l=124 p=0 i=4 l=0 p=0 i=5 l=126 p=0  total=583
[56652.707928] print_cpu_iova cpu103 i=0 l=114 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=126 p=0  total=621
[56652.720646] print_cpu_iova cpu104 i=0 l=61 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=127 p=0 i=4 l=126 p=0 i=5 l=1 p=0  total=442
[56652.733103] print_cpu_iova cpu105 i=0 l=101 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=127 p=0  total=355
[56652.745476] print_cpu_iova cpu106 i=0 l=120 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=247
[56652.757591] print_cpu_iova cpu107 i=0 l=113 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=113
[56652.768244] print_cpu_iova cpu108 i=0 l=104 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=231
[56652.779072] print_cpu_iova cpu109 i=0 l=110 p=0 i=1 l=0 p=0 i=2 l=127 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=491
[56652.790247] print_cpu_iova cpu110 i=0 l=123 p=0 i=1 l=127 p=0 i=2 
l=127 p=0 i=3 l=126 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=503
[56652.801422] print_cpu_iova cpu111 i=0 l=91 p=0 i=1 l=0 p=0 i=2 l=126 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=127 p=0  total=471
[56652.812510] print_cpu_iova cpu112 i=0 l=81 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=126 p=0  total=334
[56652.823425] print_cpu_iova cpu113 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[56652.834081] print_cpu_iova cpu114 i=0 l=125 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=125
[56652.844736] print_cpu_iova cpu115 i=0 l=123 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=123
[56652.855391] print_cpu_iova cpu116 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[56652.866046] print_cpu_iova cpu117 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[56652.876702] print_cpu_iova cpu118 i=0 l=126 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=126
[56652.887356] print_cpu_iova cpu119 i=0 l=127 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=126 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=253
[56652.898182] print_cpu_iova cpu120 i=0 l=10 p=0 i=1 l=1 p=0 i=2 l=127 
p=0 i=3 l=2 p=0 i=4 l=1 p=0 i=5 l=0 p=0  total=141
[56652.908925] print_cpu_iova cpu121 i=0 l=123 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=377
[56652.919926] print_cpu_iova cpu122 i=0 l=122 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=127 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=249
[56652.930755] print_cpu_iova cpu123 i=0 l=119 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=119
[56652.941414] print_cpu_iova cpu124 i=0 l=125 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=125
[56652.952069] print_cpu_iova cpu125 i=0 l=127 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=126 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=253
[56652.962896] print_cpu_iova cpu126 i=0 l=119 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=127 p=0 i=5 l=0 p=0  total=246
[56652.973724] print_cpu_iova cpu127 i=0 l=118 p=0 i=1 l=0 p=0 i=2 l=0 
p=0 i=3 l=0 p=0 i=4 l=0 p=0 i=5 l=0 p=0  total=118
[56652.984382] print_iova rcache0 128 128 128 128 128 128 128 128 128 
128 128 128 128 128 128 115 108 97 82 83 0 0 91 75 0 8 0 0 0 0 - 9 
[dcount=31]
[56652.997455] print_iova rcache1 128 128 128 128 128 0 0  [dcount=7]
[56653.003614] print_iova rcache2 128 128 126 74 128 0 0 0  [dcount=8]
[56653.009860] print_iova rcache3 128 128 128 107 0 0 0  [dcount=7]
[56653.015849] print_iova rcache4 128 128 128 128 112 0 0 0  [dcount=8]
[56653.022180] print_iova rcache5 128 128 128 128 128 128 128 92 0 
[dcount=9]
[56653.029116] print_iova1 cpu_total=59227 depot_total=5915 total=65142
[56653.035447] print_iova2 iova_allocs(=5000000 rcache=4678340 (93 %) 
new_iova=33353 diff=288307 fail=288307 flush=0) rcache_get=(4933294, 
pfn=4933294, success=4678340, zero depot=0) insert depot full=0 
too_big=66406


> 
>> I can get the depot swinging between full and empty if it's simply too 
>> small to bounce magazines between a large number of "CPU A"s and "CPU 
>> B"s, but again, that's surely going to show as repeated performance 
>> swings between bad at each end and good in the middle, not a steady 
>> degradation.
> 
> Yeah, so I see the depot max size (32) is adequate in size, such that 
> this does not happen.
> 
>>
>>>> Now indeed that could happen over the short term if IOVAs are allocated
>>>> and freed again in giant batches larger than the total global cache
>>>> capacity, but that would show a cyclic behaviour - when activity 
>>>> starts,
>>>> everything is first allocated straight from the tree, then when it ends
>>>> the caches would get overwhelmed by the large burst of freeing and 
>>>> start
>>>> having to release things back to the tree, but eventually that would
>>>> stop once everything *is* freed, then when activity begins again the
>>>> next round of allocating would inherently clear out all the caches
>>>> before going anywhere near the tree. 
>>>
>>> But there is no clearing. A CPU will keep the IOVA cached 
>>> indefinitely, even when there is no active DMA mapping present at all.
>>
>> Sure, the percpu caches can buffer IOVAs for an indefinite amount of 
>> time depending on how many CPUs are active, but the depot usage is 
>> still absolutely representative of the total working set for whichever 
>> CPUs *are* active. In this whole discussion I'm basically just 
>> considering the percpu caches as pipeline stages for serialising IOVAs 
>> into and out of magazines. It's the motion of magazines that's the 
>> interesting part.
>>
>> If the depot keeps continually filling up, *some* CPUs are freeing 
>> enough IOVAs to push out full magazines, and those IOVAs have to come 
>> from somewhere, so *some* CPUs are allocating, and those CPUs can't 
>> allocate forever without taking magazines back out of the depot 
>> (that's the "clearing out" I meant).

But I still think that since we don't centrally cache the IOVAs 
individually, but rather in large magazines, that there is a tendency 
for less-active CPUs to grab magazines from the depot and under utilize 
them. While in the meantime, other more active CPUs are putting and 
getting magazines from the depot in a balanced fashion - those are 
generally the lower indexed CPUs, due to scheduler, I figure.

Anyway, please let me know any further thoughts.

> Something about a steady 
>> degradation that never shows any sign of recovery (even periodically) 
>> just doesn't seem to add up.
>>
>> Anyway, by now I think it would be most interesting to get rid of this 
>> bottleneck completely rather than dance around bodging it, and see 
>> what happens if we simply let the depot grow to fit the maximum 
>> working set, so I did this:
>>

Thanks,
John

