Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530A9304431
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbhAZGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:03:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2408 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbhAYMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:48:09 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPV1201cyz67glq;
        Mon, 25 Jan 2021 20:44:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 25 Jan 2021 13:47:22 +0100
Received: from [10.47.2.25] (10.47.2.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 25 Jan
 2021 12:47:21 +0000
Subject: Re: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-4-nakamura.shun@jp.fujitsu.com>
 <a0f7c814-5c56-4e17-1198-a611d19f57d5@huawei.com>
 <OSBPR01MB4600A7B761F965C443D92DCFF7A00@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <59c31515-8275-5dfe-0276-ed9353bceb6c@huawei.com>
Date:   Mon, 25 Jan 2021 12:46:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB4600A7B761F965C443D92DCFF7A00@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.25]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2021 08:37, nakamura.shun@fujitsu.com wrote:
>> I think that we need to the same here as the IMPDEF recommended events - add a
>> common JSON to reduce the duplication.
>>
>> I had done work on this for current CPUs, but never got it finished. Let me check
>> the status.
> If you let me know the result, I will resend the patch according to the policy.

I just sent this:
https://lore.kernel.org/lkml/1611575600-2440-1-git-send-email-john.garry@huawei.com/T/#u

And now I have noticed that I did not cc arm64 reviewers :(

Anyway, it should be ok to base on that series.

And please add guys under "PERFORMANCE EVENTS SUBSYSTEM" for sending 
patches for perf, and not just the arm64 guys.

Thanks,
John
