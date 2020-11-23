Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052432BFE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKWCnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:43:19 -0500
Received: from foss.arm.com ([217.140.110.172]:52464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgKWCnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:43:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB47730E;
        Sun, 22 Nov 2020 18:43:18 -0800 (PST)
Received: from [10.163.82.200] (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028383F70D;
        Sun, 22 Nov 2020 18:43:16 -0800 (PST)
Subject: Re: [RFC 00/11] arm64: coresight: Enable ETE and TRBE
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <20201114051715.GA23685@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8f323987-3327-1352-b097-8c018cc8d575@arm.com>
Date:   Mon, 23 Nov 2020 08:13:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201114051715.GA23685@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tingwei,

On 11/14/20 10:47 AM, Tingwei Zhang wrote:
> Hi Anshuman,
> 
> On Tue, Nov 10, 2020 at 08:44:58PM +0800, Anshuman Khandual wrote:
>> This series enables future IP trace features Embedded Trace Extension (ETE)
>> and Trace Buffer Extension (TRBE). This series depends on the ETM system
>> register instruction support series [0] and the v8.4 Self hosted tracing
>> support series (Jonathan Zhou) [1]. The tree is available here [2] for
>> quick access.
>>
>> ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
>> extensions. ETE overlaps with the ETMv4 architecture, with additions to
>> support the newer architecture features and some restrictions on the
>> supported features w.r.t ETMv4. The ETE support is added by extending the
>> ETMv4 driver to recognise the ETE and handle the features as exposed by the
>> TRCIDRx registers. ETE only supports system instructions access from the
>> host CPU. The ETE could be integrated with a TRBE (see below), or with the
>> legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
>> description as the ETMs and requires a node per instance.
>>
>> Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
>> accessible via the system registers and can be combined with the ETE to
>> provide a 1x1 configuration of source & sink. TRBE is being represented
>> here as a CoreSight sink. Primary reason is that the ETE source could work
>> with other traditional CoreSight sink devices. As TRBE captures the trace
>> data which is produced by ETE, it cannot work alone.
>>
>> TRBE representation here have some distinct deviations from a traditional
>> CoreSight sink device. Coresight path between ETE and TRBE are not built
>> during boot looking at respective DT or ACPI entries. Instead TRBE gets
>> checked on each available CPU, when found gets connected with respective
>> ETE source device on the same CPU, after altering its outward connections.
>> ETE TRBE path connection lasts only till the CPU is online. But ETE-TRBE
>> coupling/decoupling method implemented here is not optimal and would be
>> reworked later on.
> Only perf mode is supported in TRBE in current path. Will you consider
> support sysfs mode as well in following patch sets?

Yes, either in subsequent versions or later on, after first getting the perf
based functionality enabled. Nonetheless, sysfs is also on the todo list as
mentioned in the cover letter.

- Anshuman
