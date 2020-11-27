Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BD2C6430
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgK0MDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:03:45 -0500
Received: from foss.arm.com ([217.140.110.172]:39508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgK0MDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:03:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7A831B;
        Fri, 27 Nov 2020 04:03:44 -0800 (PST)
Received: from [10.57.56.151] (unknown [10.57.56.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E81463F71F;
        Fri, 27 Nov 2020 04:03:40 -0800 (PST)
Subject: Re: [PATCH v3] drivers/perf: Add support for ARMv8.3-SPE
To:     Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
References: <20201127060322.29025-1-liwei391@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <861cf678-3e6f-7627-8d41-b9395cb6e5e0@arm.com>
Date:   Fri, 27 Nov 2020 12:03:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127060322.29025-1-liwei391@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 6:03 AM, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>    using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>    packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>    and filtering on these events using PMSEVFR_EL1.
> 
> Update the check of pmsevfr for empty/partial predicated SVE and
> alignment event in SPE driver. For adaption by the version of SPE,
> expose 'pmsver' as cap attribute to userspace.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>

nit: Do we need to update the Kconfig help text too ? Right now that says :

--


tristate "Enable support for the ARMv8.2 Statistical Profiling Extension""
....

help
   Enable perf support for the ARMv8.2 Statistical Profiling
   Extension, which provides periodic sampling of operations in

--

Suzuki
