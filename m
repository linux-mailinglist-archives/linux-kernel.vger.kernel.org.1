Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FC2C4497
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgKYQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:00:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2150 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgKYQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:00:47 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ch5D321p1z67J01;
        Wed, 25 Nov 2020 23:58:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 25 Nov 2020 17:00:44 +0100
Received: from [10.47.4.25] (10.47.4.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 25 Nov
 2020 16:00:42 +0000
Subject: Re: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
To:     Will Deacon <will@kernel.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <mark.rutland@arm.com>,
        <Frank.li@nxp.com>, <robh+dt@kernel.org>
CC:     <catalin.marinas@arm.com>, <kernel-team@android.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <irogers@google.com>,
        <jolsa@redhat.com>, <devicetree@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
 <160631703729.2332128.13220150013299384201.b4-ty@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2a24a5c9-fa9f-f402-9b43-29d1f8241a17@huawei.com>
Date:   Wed, 25 Nov 2020 16:00:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <160631703729.2332128.13220150013299384201.b4-ty@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.25]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2020 15:44, Will Deacon wrote:
> Applied the hisi and smmu parts to will (for-next/perf), thanks!
> 
> [1/4] drivers/perf: hisi: Add identifier sysfs file
>        https://git.kernel.org/will/c/ac4511c9364c
> [...]
> [4/4] perf/smmuv3: Support sysfs identifier file
>        https://git.kernel.org/will/c/2c255223362e
> 

Thanks.

> I've completely lost track of the imx ddr PMU, so I dropped those parts
> (patch 3/4 seemed to remove a compatible string from the driver?).
> 

2/4 needed to be dropped anyway.

@Joakim, can you resend 3/4? And I think that we should keep the 
explicit support for "fsl,imx8m-ddr-pmu" as a good practice in 
imx_ddr_pmu_dt_ids[], while also adding the soc-specific sub compat 
string support

John

