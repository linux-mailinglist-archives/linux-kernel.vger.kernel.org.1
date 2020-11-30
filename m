Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F312C8C99
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgK3SVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgK3SVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:21:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D83C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=t2FL4Bb5lfATBQNA3zpdSm0Nejfrg07A2sqpuX0HhTg=; b=APOU/S6UY8bEafAg+warV9E4a/
        XOa3Zn3wKp3VmneEu5ktNTHeJmDrGY6yVpXLqZF0dyUEFRwKz1TX4hsZCj+jODfhSo7tv1DR4jREX
        vMeS36VMVkCUrEdc6DclARIPMgCkOv6z8D4fuv7tqnv72Ai5bdh/1XFPSuLHUR8D4a+BXfK48fIvM
        6PtQdGgcAqpbxloTEkgJt5Dn2T0bMgLYmwlCRSlKuXXlUPF/kGvUPVd/JDrmF3vR+lEQR44xM0jSs
        jbfegCRuhzK1sQrrAi28hhj5Y7f7L9VPqrO1PswJdYHcfxpdWxIsX3Oq4hBuAbFu/cIXkq2RAnaw3
        8wiVacUA==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjnmU-0007nE-0e; Mon, 30 Nov 2020 18:20:11 +0000
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
To:     Marc Zyngier <maz@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7c9999bc-1340-955d-d361-bb5cc3364ad2@infradead.org>
Date:   Mon, 30 Nov 2020 10:20:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 10:05 AM, Marc Zyngier wrote:
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

I agree with the requests for justification.

Rongwei mentions that this driver functions the same as the
x86 platform MSR driver.  This one uses /dev.
I thought that the x86 driver used /sys, but I could be wrong.

Do we (or not) want cross-platform compatabilities?

Regarding permissions, /dev or /sys files have permission settings.
They don't have to be world-readable.


-- 
~Randy

