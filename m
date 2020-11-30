Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B072C8112
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgK3JbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:31:18 -0500
Received: from foss.arm.com ([217.140.110.172]:50946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbgK3JbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:31:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 055A4101E;
        Mon, 30 Nov 2020 01:30:32 -0800 (PST)
Received: from [10.57.56.151] (unknown [10.57.56.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A6D3F23F;
        Mon, 30 Nov 2020 01:30:30 -0800 (PST)
Subject: Re: [PATCH v4 17/25] coresight: etm4x: Use TRCDEVARCH for component
 discovery
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-18-suzuki.poulose@arm.com>
 <20201127182837.GA1092947@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8021ab00-3d10-d38a-6a13-dff9a726031b@arm.com>
Date:   Mon, 30 Nov 2020 09:30:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127182837.GA1092947@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 6:28 PM, Mathieu Poirier wrote:
> On Thu, Nov 19, 2020 at 04:45:39PM +0000, Suzuki K Poulose wrote:
>> We have been using TRCIDR1 for detecting the ETM version. This
>> is in preparation for the future IP support.
>>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> You have reviewed your own code - that's great!
> 
> I had a good giggle on that one.  I have started reviewing this set...

Yikes, sorry. It must have been a copy/paste error. It was supposed to be yours

https://lore.kernel.org/linux-arm-kernel/20201106214228.GE3299843@xps15/

Cheers
Suzuki
