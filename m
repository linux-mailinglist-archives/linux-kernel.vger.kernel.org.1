Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D5302EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbhAYWI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:08:59 -0500
Received: from foss.arm.com ([217.140.110.172]:35266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733173AbhAYWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:06:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC646D6E;
        Mon, 25 Jan 2021 14:05:20 -0800 (PST)
Received: from [10.57.40.145] (unknown [10.57.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A96753F68F;
        Mon, 25 Jan 2021 14:05:18 -0800 (PST)
Subject: Re: [PATCH v7 00/28] coresight: etm4x: Support for system
 instructions
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
 <20210125184950.GC894394@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4f1171f1-8d3c-cba7-ac5c-d88264e959bc@arm.com>
Date:   Mon, 25 Jan 2021 22:05:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125184950.GC894394@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 6:49 PM, Mathieu Poirier wrote:
> On Sun, Jan 10, 2021 at 10:48:22PM +0000, Suzuki K Poulose wrote:
>> CoreSight ETMv4.4 obsoletes memory mapped access to ETM and
>> mandates the system instructions for registers.
>> This also implies that they may not be on the amba bus.
>> Right now all the CoreSight components are accessed via memory
>> map. Also, we have some common routines in coresight generic
>> code driver (e.g, CS_LOCK, claim/disclaim), which assume the
>> mmio. In order to preserve the generic algorithms at a single
>> place and to allow dynamic switch for ETMs, this series introduces
>> an abstraction layer for accessing a coresight device. It is
>> designed such that the mmio access are fast tracked (i.e, without
>> an indirect function call).
>>
>> This will also help us to get rid of the driver+attribute specific
>> sysfs show/store routines and replace them with a single routine
>> to access a given register offset (which can be embedded in the
>> dev_ext_attribute). This is not currently implemented in the series,
>> but can be achieved.
>>
>> Further we switch the generic routines to work with the abstraction.
>> With this in place, we refactor the etm4x code a bit to allow for
>> supporting the system instructions with very little new code.
>>
>> We use TRCDEVARCH for the detection of the ETM component, which
>> is a standard register as per CoreSight architecture, rather than
>> the etm specific id register TRCIDR1. This is for making sure
>> that we are able to detect the ETM via system instructions accurately,
>> when the the trace unit could be anything (etm or a custom trace unit).
>> To keep the backward compatibility for any existing broken
>> impelementation which may not implement TRCDEVARCH, we fall back to TRCIDR1.
>> Also this covers us for the changes in the future architecture [0].
>>
>> Also, v8.4 self-hosted tracing extensions (coupled with ETMv4.4) adds
>> new filtering registers for trace by exception level. So on a v8.4
>> system, with Trace Filtering support, without the appropriate
>> programming of the Trace filter registers (TRFCR_ELx), tracing
>> will not be enabled. This series also includes the TraceFiltering
>> support to cover the ETM-v4.4 support.
>>
>> The series has been mildly tested on a model for system instructions.
>> I would really appreciate any testing on real hardware.
>>
>> Applies on coresight/next. A tree is available here [1].
> 
> I have applied this set.

Thanks Mathieu, appreciate it.

Cheers
Suzuki
