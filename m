Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CBF2C95F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgLADph convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 22:45:37 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50435 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgLADph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:45:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UH5An4K_1606794292;
Received: from 30.225.32.58(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UH5An4K_1606794292)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 11:44:53 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   wangrongwei <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20201130190331.GI6019@zn.tnic>
Date:   Tue, 1 Dec 2020 11:44:52 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris, Thank your advice very much!
Indeed, I have read the commit message, and it seems that writes data to a system register may cause many problems. Actually, we have taken this into account. In the current version, we have separated the read and write functions to the system registers into two commands, they (rdasr and wrasr) can be found in system-register-tools (https://github.com/alibaba/system-register-tools).

In providing the WRASR function, we consider that users should bear the consequences of rewriting registers during the debugging phase. In fact, most of the time we rarely use WRASR, and only use it when we are very confident.

> 2020年12月1日 上午3:03，Borislav Petkov <bp@alien8.de> 写道：
> 
> On Tue, Dec 01, 2020 at 01:48:30AM +0800, Rongwei Wang wrote:
>> MSR ARM driver aims to provide interfacs for user to read or write
>> data to all system registers.
> 
> Just a warranty from x86 land: if I were an ARM arch maintainer, I would
> never never *ever* take such driver exposing naked hw registers to
> userspace.
> 
> We have been fighting with this on x86 for years:
> 
> a7e1f67ed29f ("x86/msr: Filter MSR writes")
> 
> with userspace tools poking at random MSRs. Read the commit message
> for what can happen. And taking that thing is like opening a huge
> can'o'worms that can't be closed anymore.
> 
> Currently, we're trying to move userspace tools to proper sysfs
> interfaces but it is a huuuge pain. It is a lot easier to have people
> define proper interfaces from the get-go where the kernel can control
> and synchronize access.
> 
> HTH.
> 
> -- 
> Regards/Gruss,
>    Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

