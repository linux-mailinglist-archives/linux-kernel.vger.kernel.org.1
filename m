Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436A02CD4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgLCLvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:51:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgLCLve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:51:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6846113E;
        Thu,  3 Dec 2020 03:50:48 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3FEE3F66B;
        Thu,  3 Dec 2020 03:50:44 -0800 (PST)
Date:   Thu, 3 Dec 2020 11:50:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Marc Zyngier <maz@kernel.org>, vkoul@kernel.org, gshan@redhat.com,
        Anson.Huang@nxp.com, geert+renesas@glider.be,
        catalin.marinas@arm.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        bjorn.andersson@linaro.org, michael@walle.cc, olof@lixom.net,
        shawnguo@kernel.org, vincenzo.frascino@arm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
Message-ID: <20201203115042.GF96754@C02TD0UTHF1T.local>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
 <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
 <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
 <4513911D-77BF-4459-B8DF-9889395C16AC@linux.alibaba.com>
 <4f89671e080eb23b084c0e0942f111e6@kernel.org>
 <58C4701C-DEAC-4FE9-B54C-3B9ADC8E197D@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58C4701C-DEAC-4FE9-B54C-3B9ADC8E197D@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 07:25:43PM +0800, Rongwei Wang wrote:
> 
> 
> > 2020年12月3日 下午4:35，Marc Zyngier <maz@kernel.org> 写道：
> > 
> > On 2020-12-03 05:45, Rongwei Wang wrote:
> >>> 2020年12月1日 下午11:37，Marc Zyngier <maz@kernel.org> 写道：
> >>> On 2020-12-01 14:25, wangrongwei wrote:
> >>>>> 2020年12月1日 下午4:12，Marc Zyngier <maz@kernel.org> 写道：
> >>>>> On 2020-12-01 03:09, wangrongwei wrote:
> >>>>>> Hi
> >>>>>> We have validate this driver in vm and physical machine, and works fine.
> >>>>> But what does "work fine" mean? None of these system registers are supposed
> >>>>> to be accessible from userspace, so please explain *what* you are trying to
> >>>>> do with this, other that introducing security holes and general system
> >>>>> instability?
> >>>> I think I know what you mean. Do you want me to describe how we achieved it?
> >>>> In x86, the different registers can be accessed directly using the
> >>>> rdmsr and wrmsr instructions, but in ARM, since these two instructions
> >>>> are missing, so we modify the code segment during runtime, similar to
> >>>> the principle of static_key.
> >>> [...]
> >>> These are implementation details, none of which answer my question:
> >>> What makes you think this is a good idea? I cannot see any legitimate
> >> In fact, I think this tool useful mainly in the following scenarios:
> >> 	1. performance debug
> >> 	2. Arm-core features test
> >> 	3. Debug-tool for kernel developer
> >> Also, for example, MSR-ARM is needed for chip verification and
> >> system-level functional verification.
> >> A simple example, perf stat can test pmu, but the overflow interrupt
> >> function and forced overflow function of pmu is not covered.
> > 
> > But what does it mean to change random system registers while the kernel
> > itself is using them in parallel? All you are introducing is a bunch of
> > uncontrolled, unexpected, and possibly fatal side effects.
> This problem exists when writing to a register, but it does not exist when reading a register.

Reading registers can also have side-effects. For example the ICC_IAR_*
registers are read-sensitive, and reading those could cause the kernel
to stop receiving timer interrupts or similar. The problem /does/ exist
when reading registers.

I concur with Marc and others that this simply isn't safe, regardless of
read or write, and not something we want upstream in Linux.

For debug and testing, I suggest looking at kvm-unit-tests. That has
some PMU tests already, and is gaining the ability to run bare-metal
around now (and so might be helpful for testing HW). Having improved
tests there would benefit everyone.

Thanks,
Mark.
