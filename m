Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9933F2CD572
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbgLCMXc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 07:23:32 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59644 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgLCMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:23:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHPxg.D_1606998163;
Received: from 30.27.144.231(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHPxg.D_1606998163)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 20:22:44 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <6698aa55cf4ee69a18049c4bf8a21c4f@kernel.org>
Date:   Thu, 3 Dec 2020 20:22:43 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <82A9ACCC-9A2A-48A7-939A-6E13E13EA465@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
 <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
 <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
 <4513911D-77BF-4459-B8DF-9889395C16AC@linux.alibaba.com>
 <4f89671e080eb23b084c0e0942f111e6@kernel.org>
 <58C4701C-DEAC-4FE9-B54C-3B9ADC8E197D@linux.alibaba.com>
 <6698aa55cf4ee69a18049c4bf8a21c4f@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2020, at 7:45 PM, Marc Zyngier <maz@kernel.org> wrote:
> 
> On 2020-12-03 11:25, Rongwei Wang wrote:
>>> 2020年12月3日 下午4:35，Marc Zyngier <maz@kernel.org> 写道：
> 
> [...]
> 
>>> But what does it mean to change random system registers while the kernel
>>> itself is using them in parallel? All you are introducing is a bunch of
>>> uncontrolled, unexpected, and possibly fatal side effects.
>> This problem exists when writing to a register, but it does not exist
>> when reading a register.
> 
> If you're not aware that the ARM architecture does have system registers
> with read side-effects, you really shouldn't be writing this code.
Thanks, Does it make sense to put this feature in the drivers/ directory, likes misc drivers? Whether it can exist as a debugging tool in kernel or not?
When debugging, then enables CONFIG_ARM64_MSR or CONFIG_ARM64_MSR_DEBUG.
> 
>        M.
> -- 
> Jazz is not dead. It just smells funny…
Thanks,
Rongwei Wang.

