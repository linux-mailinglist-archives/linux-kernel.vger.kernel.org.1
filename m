Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8045A2CD4DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgLCLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgLCLqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:46:08 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0198D20758;
        Thu,  3 Dec 2020 11:45:27 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kkn36-00FeCw-K0; Thu, 03 Dec 2020 11:45:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 03 Dec 2020 11:45:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com,
        geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org,
        michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
In-Reply-To: <58C4701C-DEAC-4FE9-B54C-3B9ADC8E197D@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <5e7f7225982b2df63e62ea60ec632376@misterjones.org>
 <855BA92C-5B22-4F14-965A-B1F72A872B8D@linux.alibaba.com>
 <059ed4a8768ff3881005796cb4a10d5e@kernel.org>
 <6FA68A07-F718-46F5-81B4-586A5ED3E479@linux.alibaba.com>
 <7e9ae04f3394a85aa3b8fe8947a44009@kernel.org>
 <4513911D-77BF-4459-B8DF-9889395C16AC@linux.alibaba.com>
 <4f89671e080eb23b084c0e0942f111e6@kernel.org>
 <58C4701C-DEAC-4FE9-B54C-3B9ADC8E197D@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <6698aa55cf4ee69a18049c4bf8a21c4f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rongwei.wang@linux.alibaba.com, catalin.marinas@arm.com, will@kernel.org, bjorn.andersson@linaro.org, shawnguo@kernel.org, gshan@redhat.com, geert+renesas@glider.be, Anson.Huang@nxp.com, masahiroy@kernel.org, michael@walle.cc, krzk@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, olof@lixom.net, vincenzo.frascino@arm.com, ardb@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-03 11:25, Rongwei Wang wrote:
>> 2020年12月3日 下午4:35，Marc Zyngier <maz@kernel.org> 写道：

[...]

>> But what does it mean to change random system registers while the 
>> kernel
>> itself is using them in parallel? All you are introducing is a bunch 
>> of
>> uncontrolled, unexpected, and possibly fatal side effects.
> This problem exists when writing to a register, but it does not exist
> when reading a register.

If you're not aware that the ARM architecture does have system registers
with read side-effects, you really shouldn't be writing this code.

         M.
-- 
Jazz is not dead. It just smells funny...
