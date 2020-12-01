Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61A2CA6D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbgLAPSl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Dec 2020 10:18:41 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44813 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388815AbgLAPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:18:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UHDG.XL_1606835859;
Received: from 30.15.205.17(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UHDG.XL_1606835859)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 23:17:42 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20201201145415.GC22927@zn.tnic>
Date:   Tue, 1 Dec 2020 23:17:39 +0800
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, vkoul@kernel.org,
        geert+renesas@glider.be, Anson.Huang@nxp.com, michael@walle.cc,
        krzk@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8ED75067-DB02-4502-BA03-45B3519E408A@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic>
 <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
 <20201201112647.GA22927@zn.tnic>
 <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
 <20201201145415.GC22927@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年12月1日 下午10:54，Borislav Petkov <bp@alien8.de> 写道：
> 
> On Tue, Dec 01, 2020 at 10:33:42PM +0800, wangrongwei wrote:
>> Yes, and x86 also provides two instructions with the same name in the
>> instruction set, but not in ARM.
> 
> Sorry, I can't parse what you're trying to say here.
In the ARM architecture, there are no rdmsr and wrmsr instructions. 
In ARM, the system registers can only be accessed through msr and mrs, so the problem created by MSR driver (depend on rdmsr and wrmsr) in x86 is not necessarily present in ARM, which is very different from x86.
In addition, we want cross-platform compatabilities, and fill these gaps in the ARM.
> 
> -- 
> Regards/Gruss,
>    Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
Regards,
Rongwei Wang.

