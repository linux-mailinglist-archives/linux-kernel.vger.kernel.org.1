Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D536B2EF3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbhAHOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:16:20 -0500
Received: from foss.arm.com ([217.140.110.172]:51872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHOQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:16:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A0FED1;
        Fri,  8 Jan 2021 06:15:33 -0800 (PST)
Received: from [10.57.37.195] (unknown [10.57.37.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C455A3F70D;
        Fri,  8 Jan 2021 06:15:29 -0800 (PST)
Subject: Re: [PATCH v6 00/26] coresight: etm4x: Support for system
 instructions
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210108010907.GJ43045@xps15> <7f3304f7-8c68-3a61-48da-553de87c027d@arm.com>
Message-ID: <2f9d4b4e-4382-ab2a-5156-26fb9275d0f2@arm.com>
Date:   Fri, 8 Jan 2021 14:15:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7f3304f7-8c68-3a61-48da-553de87c027d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Please hold on with this series, I will update the series, fixing the
issues you have spotted and some additional patches to prevent accesses
to all the system registers that may not be available via system instructions.

Apologies for the inconvenience

Kind regards
Suzuki

On 1/8/21 9:08 AM, Suzuki K Poulose wrote:
> Hi Mathieu
> 
> On 1/8/21 1:09 AM, Mathieu Poirier wrote:
>> Hi Suzuki,
>>
>> On Thu, Jan 07, 2021 at 12:38:33PM +0000, Suzuki K Poulose wrote:
>>> CoreSight ETMv4.4 obsoletes memory mapped access to ETM and
>>> mandates the system instructions for registers.
>>> This also implies that they may not be on the amba bus.
>>> Right now all the CoreSight components are accessed via memory
>>> map. Also, we have some common routines in coresight generic
>>> code driver (e.g, CS_LOCK, claim/disclaim), which assume the
>>> mmio. In order to preserve the generic algorithms at a single
>>> place and to allow dynamic switch for ETMs, this series introduces
>>> an abstraction layer for accessing a coresight device. It is
>>> designed such that the mmio access are fast tracked (i.e, without
>>> an indirect function call).
>>>
>>> This will also help us to get rid of the driver+attribute specific
>>> sysfs show/store routines and replace them with a single routine
>>> to access a given register offset (which can be embedded in the
>>> dev_ext_attribute). This is not currently implemented in the series,
>>> but can be achieved.
>>>
>>> Further we switch the generic routines to work with the abstraction.
>>> With this in place, we refactor the etm4x code a bit to allow for
>>> supporting the system instructions with very little new code.
>>>
>>> We use TRCDEVARCH for the detection of the ETM component, which
>>> is a standard register as per CoreSight architecture, rather than
>>> the etm specific id register TRCIDR1. This is for making sure
>>> that we are able to detect the ETM via system instructions accurately,
>>> when the the trace unit could be anything (etm or a custom trace unit).
>>> To keep the backward compatibility for any existing broken
>>> impelementation which may not implement TRCDEVARCH, we fall back to TRCIDR1.
>>> Also this covers us for the changes in the future architecture [0].
>>>
>>> Also, v8.4 self-hosted tracing extensions (coupled with ETMv4.4) adds
>>> new filtering registers for trace by exception level. So on a v8.4
>>> system, with Trace Filtering support, without the appropriate
>>> programming of the Trace filter registers (TRFCR_ELx), tracing
>>> will not be enabled. This series also includes the TraceFiltering
>>> support to cover the ETM-v4.4 support.
>>>
>>> The series has been mildly tested on a model for system instructions.
>>> I would really appreciate any testing on real hardware.
>>
>> I have queued your work in my local tree.  I will have a final pass before
>> pushing to coresight-next tomorrow or on Monday.
>>
> 
> Thanks for the review and fixups. Please let me know if you need a respin.
> 
> Cheers
> Suzuki

