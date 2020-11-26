Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBF2C5323
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbgKZLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:36:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2162 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgKZLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:36:13 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ChbHv5dh8z67Gc0;
        Thu, 26 Nov 2020 19:34:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 26 Nov 2020 12:36:11 +0100
Received: from [10.210.172.213] (10.210.172.213) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 26 Nov 2020 11:36:10 +0000
Subject: Re: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Frank Li <frank.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "irogers@google.com" <irogers@google.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
 <160631703729.2332128.13220150013299384201.b4-ty@kernel.org>
 <2a24a5c9-fa9f-f402-9b43-29d1f8241a17@huawei.com>
 <DB8PR04MB67957DF5D757E4A52DE177BCE6F90@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bbb0b612-4d0b-2a15-9c2e-8f643f7a2ffe@huawei.com>
Date:   Thu, 26 Nov 2020 11:35:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67957DF5D757E4A52DE177BCE6F90@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.213]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2020 01:35, Joakim Zhang wrote:
>> @Joakim, can you resend 3/4? And I think that we should keep the explicit
>> support for "fsl,imx8m-ddr-pmu" as a good practice in imx_ddr_pmu_dt_ids[],
>> while also adding the soc-specific sub compat string support
> Yes, thanks John. I will follow up.
> 

OK, and I can look to advance the perf tool part now.

thanks,
John
