Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB25A2C9596
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgLADKC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 22:10:02 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36315 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgLADKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:10:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UH4wNhQ_1606792158;
Received: from 30.225.32.58(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UH4wNhQ_1606792158)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 11:09:18 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   wangrongwei <rongwei.wang@linux.alibaba.com>
In-Reply-To: <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
Date:   Tue, 1 Dec 2020 11:09:18 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
We have validate this driver in vm and physical machine, and works fine.
Actually, we used existing interfaces to realize this driver, likes aarch64_insn_read and aarch64_insn_patch_text. These existing intefaces had validated a CPU. 

> 2020年12月1日 上午2:05，Marc Zyngier <maz@kernel.org> 写道：
> 
> On 2020-11-30 17:48, Rongwei Wang wrote:
> 
>> The interfaces of this module is same as MSR module in user space, and to solve
>> the problem that ARM platform has no similar MSR module. Using this interface,
>> we did some pressure tests to test the stability and security of MSR driver. The
>> test results show that the driver will not cause system panic if various
>> illegal values and multithreading concurrent access are passed through the
>> interface.
> 
> It would certainly help if you described what problem you are trying
> to solve here. In general, giving userspace access to random system
> registers is a pretty bad idea.
> 
> Are you trying to validate a CPU? a hypervisor? Or is it just a fun way
> to check how many things you can poke before something catches fire?
> 
> Thanks,
> 
>        M.
> -- 
> Jazz is not dead. It just smells funny...

