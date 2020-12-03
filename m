Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F8A2CD265
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgLCJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLCJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:20:10 -0500
Date:   Thu, 3 Dec 2020 09:19:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606987168;
        bh=g4ZTxyDoJc2ofiLEywA7CSH7BT199Th4IfgPacy3FN8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ql0QhUGhdAJl7TpjBdm2ozOMwP7frnOPgrdvJQsFGtfROn++9HOOSD403Xj2DCuRP
         RjILnJ2mFMEhnhM9TWoaINr/w5kLWK/vcZ8AOherzLmqEOvJLhJLJPEADm01yYswRA
         d4GKnr0vXXcGQooxPydiYdBHVgohYVHIavNyH4GRvaHXMx43AOb8uEFCiva+5OucsL
         Rw1wr2LfwYhvfb8jrqmWHlnS1lnoeAZoZEXrI42OlcrBmkOHBX3Q6hT1SSN0iPMHQg
         XMXMVT4ra/Ae1GERYkbVVbbLkFgLC/Aqb4t1cRubyF9HZhLP3CA7fuN52bI9wKQhpb
         8y+Px29AjV2FA==
From:   Will Deacon <will@kernel.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
Subject: Re: [PATCH v3] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20201203091922.GA30817@willie-the-truck>
References: <20201127060322.29025-1-liwei391@huawei.com>
 <20201130100628.GB24098@willie-the-truck>
 <47201e85-7cf3-7c94-d1be-9c83ef8c3416@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47201e85-7cf3-7c94-d1be-9c83ef8c3416@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 03, 2020 at 04:42:20PM +0800, liwei (GF) wrote:
> On 2020/11/30 18:06, Will Deacon wrote:
> > On Fri, Nov 27, 2020 at 02:03:22PM +0800, Wei Li wrote:
> >>  /* Perf callbacks */
> >>  static int arm_spe_pmu_event_init(struct perf_event *event)
> >>  {
> >> @@ -670,7 +686,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
> >>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> >>  		return -ENOENT;
> >>  
> >> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> >> +	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
> >>  		return -EOPNOTSUPP;
> >>  
> >>  	if (attr->exclude_idle)
> >> @@ -937,6 +953,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
> >>  			fld, smp_processor_id());
> >>  		return;
> >>  	}
> >> +	spe_pmu->pmsver = (u16)fld;
> > 
> > ... which also means we should clamp this value now that we expose it to
> > userspace. Otherwise, userspace can't rely on this field for anything.
> > 
> > That said -- please can you tell me what userspace intends to do with
> > this version number?
> > 
> 
> In fact, it is only used in our testcase for now, which needs to know the real version the
> chip has implemented, as these is no other way to get the info now. So i added it in the
> probe message in v1 at first.

If it's not needed, then let's not expose it yet. ABIs aren't cheap!

> Especially we use the of_device_id "arm,statistical-profiling-extension-v1" and the
> platform_device_id "arm,spe-v1". It's a little weird to ARMv8.3-SPE.
> 

What exactly breaks? It looks like it should work fine to me, but I don't
have any SPE systems to test on. The "v1" in the compatible string doesn't
really do anything at the moment because we can probe everything other than
the interrupt topology at runtime, so I wouldn't get hung up on that.

> Further more i am wondering if we need to add the 'spe-v2' device_id. If
> not, i think it's broken on a big.LITTLE system [1] as we can register
> only one device and the driver will work incorrectly if the big and LITTLE
> cores have different version of SPE.

This is only an issue for ACPI, right? I don't think that was ever intended
to work with big.LITTLE. See:

	pr_warn("ACPI: SPE must be homogeneous\n");

DT should handle it though.

Anyway, please can you post a new version of this patch without the ABI
changes? In other words, just including the RES0 part.

Thanks,

Will
