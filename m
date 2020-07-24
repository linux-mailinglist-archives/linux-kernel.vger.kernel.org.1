Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758DC22C5D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgGXNLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:11:05 -0400
Received: from foss.arm.com ([217.140.110.172]:33816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgGXNLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:11:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A52BAD6E;
        Fri, 24 Jul 2020 06:11:04 -0700 (PDT)
Received: from bogus (unknown [10.37.12.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 174233F66F;
        Fri, 24 Jul 2020 06:11:01 -0700 (PDT)
Date:   Fri, 24 Jul 2020 14:10:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
Message-ID: <20200724131059.GB6521@bogus>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:08:03AM +0800, Kefeng Wang wrote:
> +maillist
> 
> On 2020/7/24 11:04, Kefeng Wang wrote:
> > ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
> > 
> > ARM64 tegra194-cpufreq driver use cpu_logical_map, export
> > __cpu_logical_map to fix build issue.
> >

I wonder why like other instances in the drivers, the mpidr is not get
directly from the cpu. The cpufreq_driver->init call happens when the cpu
is being brought online and is executed on the required cpu IIUC.

read_cpuid_mpidr() is inline and avoids having to export the logical_cpu_map.
Though we may not add physical hotplug anytime soon, less dependency
on this cpu_logical_map is better given that we can resolve this without
the need to access the map.

-- 
Regards,
Sudeep
