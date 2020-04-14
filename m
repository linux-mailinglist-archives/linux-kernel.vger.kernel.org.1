Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66CD1A7A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439973AbgDNMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:16:26 -0400
Received: from foss.arm.com ([217.140.110.172]:54178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbgDNMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1C11FB;
        Tue, 14 Apr 2020 05:16:18 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AA2C3F6C4;
        Tue, 14 Apr 2020 05:16:17 -0700 (PDT)
Subject: Re: [PATCH] arm64: panic on synchronous external abort in kernel
 context
To:     Mark Rutland <mark.rutland@arm.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        tanxiaofei@huawei.com, wangxiongfeng2@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200410015245.23230-1-xiexiuqi@huawei.com>
 <20200414105923.GA2486@C02TD0UTHF1T.local>
From:   James Morse <james.morse@arm.com>
Message-ID: <adc93578-5cfc-09c3-0b88-b265e310ef97@arm.com>
Date:   Tue, 14 Apr 2020 13:16:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414105923.GA2486@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie,

On 14/04/2020 11:59, Mark Rutland wrote:
> On Fri, Apr 10, 2020 at 09:52:45AM +0800, Xie XiuQi wrote:
>> We should panic even panic_on_oops is not set, when we can't recover
>> from synchronous external abort in kernel context.

Hmm, fault-from-kernel-context doesn't mean the fault affects the kernel. If the kernel is
reading or writing from user-space memory for a syscall, its the user-space memory that is
affected. This thread can't make progress, so we kill it.
If its a kernel thread or we were in irq context, we panic().

I don't think you really want all faults that happen as a result of a kernel access to be
fatal!

[...]

> What exactly are you trying to catch here? If you are seeing a problem
> in practice, can you please share your log from a crash?

Yes please!


I suspect you want to make memory_failure() smarter about faults that affect the kernel
text or data. If so, please do it in memory_failure() where it benefits all architectures,
and all methods of reporting errors.
(we may need a 'synchronous' hint to memory_failure(), it expects everything to be
asynchronous).

If its not memory, we should extend the RAS handling to know what this error is, and that
it is fatal. (e.g. PE state is infected)


Thanks,

James
