Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCEC2FF23E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbhAURok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:44:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2392 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388997AbhAURn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:43:26 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DM8kc4HQfz67bkH;
        Fri, 22 Jan 2021 01:38:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:42:44 +0100
Received: from [10.210.167.120] (10.210.167.120) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 17:42:43 +0000
Subject: Re: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-4-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a0f7c814-5c56-4e17-1198-a611d19f57d5@huawei.com>
Date:   Thu, 21 Jan 2021 17:41:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210121105425.2695843-4-nakamura.shun@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.120]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 10:54, Shunsuke Nakamura wrote:
> +  {
> +    "PublicDescription": "This event counts each correction to the predicted program flow that occurs because of a misprediction from, or no prediction from, the branch prediction resources and that relates to instructions that the branch prediction resources are capable of predicting.",
> +    "EventCode": "0x10",
> +    "EventName": "BR_MIS_PRED",

I think that we need to the same here as the IMPDEF recommended events - 
add a common JSON to reduce the duplication.

I had done work on this for current CPUs, but never got it finished. Let 
me check the status.

Cheers,
John

Ps, arm have put JSONs here for their cores:

https://github.com/ARM-software/data/tree/master/pmu

But unfortunately the schema does not suit perf.

I raised an issue, but no response.

I'm just wondering if you hand copied the JSON data.


> +    "BriefDescription": "This event counts each correction to the predicted program flow that occurs because of a misprediction from, or no prediction from, the branch prediction resources and that relates to instructions that the branch prediction resources are capable of predicting."
> +  },

