Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55042CA5C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgLAOef convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Dec 2020 09:34:35 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37284 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbgLAOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:34:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHDgYhH_1606833223;
Received: from 192.168.74.104(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHDgYhH_1606833223)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 22:33:43 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   wangrongwei <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20201201112647.GA22927@zn.tnic>
Date:   Tue, 1 Dec 2020 22:33:42 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
 <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
 <20201201112647.GA22927@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年12月1日 下午7:26，Borislav Petkov <bp@alien8.de> 写道：
> 
> On Tue, Dec 01, 2020 at 11:44:52AM +0800, wangrongwei wrote:
>> Indeed, I have read the commit message, and it seems that writes data
>> to a system register may cause many problems. Actually, we have taken
>> this into account. In the current version, we have separated the read
>> and write functions to the system registers into two commands,
> 
> There's rdmsr and wrmsr in msr-tools on x86 too.
Yes, and x86 also provides two instructions with the same name in the instruction set, but not in ARM.
> 
>> In providing the WRASR function, we consider that users should bear
>> the consequences of rewriting registers during the debugging phase. In
>> fact, most of the time we rarely use WRASR, and only use it when we
>> are very confident.
> 
> As I said, there should never never ever be a tool which allows writing
> of registers from userspace. If I could go back in time, I'd stop this
> on x86 but it is too late now. Not for ARM though.
> 
> Also, do you see how all the people who replied to your mail, put the
> text under the quoted text. Do that too, pls, from now on, and refrain
> from top-posting.
Thank you for the reminder, it has been corrected!
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>    Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
Thanks,
Rongwei Wang.

