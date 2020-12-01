Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F62C9572
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgLAC4O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Nov 2020 21:56:14 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54458 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgLAC4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:56:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UH5AeAb_1606791329;
Received: from 30.225.32.58(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UH5AeAb_1606791329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 10:55:30 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
From:   wangrongwei <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20201130175706.GA25457@willie-the-truck>
Date:   Tue, 1 Dec 2020 10:55:29 +0800
Cc:     catalin.marinas@arm.com, bjorn.andersson@linaro.org,
        shawnguo@kernel.org, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, krzk@kernel.org,
        olof@lixom.net, vincenzo.frascino@arm.com, ardb@kernel.org,
        masahiroy@kernel.org, gshan@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B7C5D40A-CBD9-49BC-878B-A527C79476E7@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130175706.GA25457@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will
Thanks for your reply!
There are absolutely privileged registers, and seriously expose the interface directly! 
However, these interfaces (/dev/cpu/<N>/msr) need permissions to access, so there should be few security issues. In addition, it may be due to my unclear description above. This driver is mainly a debugging tool. It make developers can easily get the values of some system registers without modifying the kernel.
In fact, we first considered the /dev/mem solution, but it seems that /dev/mem can map peripheral or IO registers, but not system registers.

> 2020年12月1日 上午1:57，Will Deacon <will@kernel.org> 写道：
> 
> On Tue, Dec 01, 2020 at 01:48:30AM +0800, Rongwei Wang wrote:
>> MSR ARM driver aims to provide interfacs for user to read or write data to all
>> system registers. Its functions is same as MSR driver (x86 platform). It mainly
>> depends on kprobe and undef exception to read or write system registers
>> dynamicly.
> 
> ... but why? These are privileged registers for a reason, and giving
> userspace access to them is bound to cause serious problems. Why can't we
> do whatever it is that userspace is trying to do by poking these things in
> the kernel instead? This interface is a bit like using /dev/mem instead of
> writing a proper device driver.
> 
> Thanks,
> 
> Will

