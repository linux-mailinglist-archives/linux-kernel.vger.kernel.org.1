Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2432CCC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgLCCKc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 21:10:32 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:6580 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgLCCKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:10:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHMt975_1606961376;
Received: from 30.27.144.231(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHMt975_1606961376)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Dec 2020 10:09:37 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20201201152552.GD22927@zn.tnic>
Date:   Thu, 3 Dec 2020 10:09:36 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F3E3ED35-F1E9-46ED-A7EC-FBF30D8DC45F@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
 <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
 <20201201112647.GA22927@zn.tnic>
 <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
 <20201201145415.GC22927@zn.tnic>
 <8ED75067-DB02-4502-BA03-45B3519E408A@linux.alibaba.com>
 <20201201152552.GD22927@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年12月1日 下午11:25，Borislav Petkov <bp@alien8.de> 写道：
> 
> On Tue, Dec 01, 2020 at 11:17:39PM +0800, Rongwei Wang wrote:
>> In ARM, the system registers can only be accessed through msr and mrs,
>> so the problem created by MSR driver (depend on rdmsr and wrmsr) in
>> x86 is not necessarily present in ARM, which is very different from
>> x86.
> 
> No, the point I'm making is that it doesn't matter what the architecture
> does or does not, register *writes* from userspace are a bad bad idea
> for the reasons I described.
Sorry, I was away for two days and didn't reply in time.
In fact, we find MSR in the x86 architecture to be a particularly useful interface. It helped us a lot when we were doing some kernel debugging. So we consider implementing a similar feature in ARM.
So as a debugging tool, could it exist, e.g. if I change CONFIG_ARM64_MSR to CONFIG_ARM64_MSR_DEBUG or others. Do you think this adjustment is possible?
> 
> -- 
> Regards/Gruss,
>    Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Regards,
Rongwei Wang.
