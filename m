Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148E92CA734
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbgLAPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbgLAPiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:38:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D512080A;
        Tue,  1 Dec 2020 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606837049;
        bh=W4oSw5pqPg7HSVD+Y7fKRaIcd0puZHiqkYGcP7sRgQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1fAgPVa8GfZSVejj8sHJvSwqNUOe0hyoyqoyEKjZyszMEvs4LHxIwxHc9r6KIH1Qo
         xpl6TFrFCUM2NQDK5IJzr4fQ1hQHMk6Yo1AkZsf+Ax1H5gFLbeqz32DudQHh1AhoX9
         wsQ7nLAG3D7lNsCxlh9Jz3tRuWaAq0+4N6+Hn2Ac=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kk7iY-00F5UN-I1; Tue, 01 Dec 2020 15:37:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 01 Dec 2020 15:37:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     wangrongwei <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
In-Reply-To: <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
 <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rongwei.wang@linux.alibaba.com, catalin.marinas@arm.com, will@kernel.org, bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com, geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org, michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com, ardb@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-01 14:25, wangrongwei wrote:
>> 2020年12月1日 下午4:12，Marc Zyngier <maz@kernel.org> 写道：
>> 
>> On 2020-12-01 03:09, wangrongwei wrote:
>>> Hi
>>> We have validate this driver in vm and physical machine, and works 
>>> fine.
>> 
>> But what does "work fine" mean? None of these system registers are 
>> supposed
>> to be accessible from userspace, so please explain *what* you are 
>> trying to
>> do with this, other that introducing security holes and general system
>> instability?
> I think I know what you mean. Do you want me to describe how we 
> achieved it?
> In x86, the different registers can be accessed directly using the
> rdmsr and wrmsr instructions, but in ARM, since these two instructions
> are missing, so we modify the code segment during runtime, similar to
> the principle of static_key.

[...]

These are implementation details, none of which answer my question:

What makes you think this is a good idea? I cannot see any legitimate
reason for userspace to ever access privileged system registers, and
the fact that x86 has such feature isn't a good justification.

         M.
-- 
Jazz is not dead. It just smells funny...
