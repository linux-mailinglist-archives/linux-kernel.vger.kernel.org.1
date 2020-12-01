Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920412CA58C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgLAO0a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Dec 2020 09:26:30 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57006 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728702AbgLAO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:26:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHDTbL7_1606832743;
Received: from 192.168.74.104(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHDTbL7_1606832743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 22:25:44 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   wangrongwei <rongwei.wang@linux.alibaba.com>
In-Reply-To: <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
Date:   Tue, 1 Dec 2020 22:25:43 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年12月1日 下午4:12，Marc Zyngier <maz@kernel.org> 写道：
> 
> On 2020-12-01 03:09, wangrongwei wrote:
>> Hi
>> We have validate this driver in vm and physical machine, and works fine.
> 
> But what does "work fine" mean? None of these system registers are supposed
> to be accessible from userspace, so please explain *what* you are trying to
> do with this, other that introducing security holes and general system
> instability?
I think I know what you mean. Do you want me to describe how we achieved it?
In x86, the different registers can be accessed directly using the rdmsr and wrmsr instructions, but in ARM, since these two instructions are missing, so we modify the code segment during runtime, similar to the principle of static_key.
> 
>> Actually, we used existing interfaces to realize this driver, likes
>> aarch64_insn_read and aarch64_insn_patch_text.
> 
> Sure. At that stage, you could also directly expose the linear mapping to
> userspace and start writing to it, it would probably be a fitting addition...
Yes, but accessing those system registers doesn't seem to have an address, just have a register number (I'm not sure about that)?
> 
>> These existing intefaces had validated a CPU.
> 
> If CPU validation is your goal, I suggest this is kept out of tree, as the
> kernel is hardly a validation tool for the arm64 architecture.
Not really sure what you mean by CPU validation as you describe above? However, the biggest challenge we encountered during implementation was an undefined instruction exception that could occur after modifying a code segment, but this problem was also solved using the kernel's existing interface.
> 
> Thanks,
> 
>        M.
> -- 
> Jazz is not dead. It just smells funny…
Regard,
Rongwei.


