Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECCC2C8129
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgK3Jit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:38:49 -0500
Received: from foss.arm.com ([217.140.110.172]:51052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgK3Jit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:38:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6898101E;
        Mon, 30 Nov 2020 01:38:03 -0800 (PST)
Received: from [10.57.56.151] (unknown [10.57.56.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83B93F23F;
        Mon, 30 Nov 2020 01:38:00 -0800 (PST)
Subject: Re: [PATCH v4 02/25] coresight: etm4x: Skip accessing TRCPDCR in
 save/restore
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-3-suzuki.poulose@arm.com>
 <20201127185522.GB1092947@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <136f420d-7848-3ba3-fbb0-9f7edee1377b@arm.com>
Date:   Mon, 30 Nov 2020 09:37:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127185522.GB1092947@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 6:55 PM, Mathieu Poirier wrote:
> On Thu, Nov 19, 2020 at 04:45:24PM +0000, Suzuki K Poulose wrote:
>> When the ETM is affected by Qualcomm errata, modifying the
>> TRCPDCR could cause the system hang. Even though this is
>> taken care of during enable/disable ETM, the ETM state
>> save/restore could still access the TRCPDCR. Make sure
>> we skip the access during the save/restore.
>>
>> Found by code inspection.
>>
>> Fixes: commit 02510a5aa78df45 ("coresight: etm4x: Add support to skip trace unit power up")
> 
> https://elixir.bootlin.com/linux/v5.10-rc5/source/Documentation/process/submitting-patches.rst#L121

Thanks, I will remove the "commit".

Suzuki
