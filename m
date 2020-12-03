Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D42CCEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgLCFqW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 00:46:22 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44625 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727937AbgLCFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:46:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHNyBks_1606974337;
Received: from 30.27.144.231(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHNyBks_1606974337)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 13:45:38 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
Date:   Thu, 3 Dec 2020 13:45:36 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4513911D-77BF-4459-B8DF-9889395C16AC@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
 <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
 <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年12月1日 下午11:37，Marc Zyngier <maz@kernel.org> 写道：
> 
> On 2020-12-01 14:25, wangrongwei wrote:
>>> 2020年12月1日 下午4:12，Marc Zyngier <maz@kernel.org> 写道：
>>> On 2020-12-01 03:09, wangrongwei wrote:
>>>> Hi
>>>> We have validate this driver in vm and physical machine, and works fine.
>>> But what does "work fine" mean? None of these system registers are supposed
>>> to be accessible from userspace, so please explain *what* you are trying to
>>> do with this, other that introducing security holes and general system
>>> instability?
>> I think I know what you mean. Do you want me to describe how we achieved it?
>> In x86, the different registers can be accessed directly using the
>> rdmsr and wrmsr instructions, but in ARM, since these two instructions
>> are missing, so we modify the code segment during runtime, similar to
>> the principle of static_key.
> 
> [...]
> 
> These are implementation details, none of which answer my question:
> 
> What makes you think this is a good idea? I cannot see any legitimate
In fact, I think this tool useful mainly in the following scenarios:
	1. performance debug
	2. Arm-core features test
	3. Debug-tool for kernel developer 
Also, for example, MSR-ARM is needed for chip verification and system-level functional verification.
A simple example, perf stat can test pmu, but the overflow interrupt function and forced overflow function of pmu is not covered.
In both cases, we need a special interface to configure it, which can be considered as testing requirements, so it can only be tested by configuring (access) registers, e.g., devmem command for memmap registers, MSR-ARM driver for system registers.
> reason for userspace to ever access privileged system registers, and
> the fact that x86 has such feature isn't a good justification.
> 
>        M.
> -- 
> Jazz is not dead. It just smells funny…

Sorry for the delayed response.

Regards,
Rongwei Wang.


