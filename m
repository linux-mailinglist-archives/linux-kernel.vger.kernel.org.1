Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056422E77A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgL3KHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgL3KHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:07:03 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4EA21D94;
        Wed, 30 Dec 2020 10:06:22 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kuYN2-004YYb-0Y; Wed, 30 Dec 2020 10:06:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Dec 2020 10:06:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, Will Deacon <will@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
In-Reply-To: <20201229170412.GN1551@shell.armlinux.org.uk>
References: <20201229160059.64135-1-dbrazdil@google.com>
 <20201229170412.GN1551@shell.armlinux.org.uk>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0e1d555404e4ae8edcf6737735dc0eb7@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@armlinux.org.uk, dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, suzuki.poulose@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, kernel-team@android.com, will@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-29 17:04, Russell King - ARM Linux admin wrote:
> On Tue, Dec 29, 2020 at 04:00:59PM +0000, David Brazdil wrote:
>> The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET 
>> should
>> not return, as dictated by the PSCI spec. However, there is firmware 
>> out
>> there which breaks this assumption, leading to a hyp panic. Make KVM
>> more robust to broken firmware by allowing these to return.
> 
> Are you sure you should just return?
> 
> We've had issues in the past with Linux reboot(2) that returns
> to userspace, allowing on 32-bit ARM for example watchdogs to
> unexpectedly continue being serviced.

I don't think this changes anything compared to the case where
the PSCI relay isn't enabled. The EL1 part of the kernel would
see the SYSTEM_RESET call return, and handle it accordingly
(stay in a while(1) loop).

This is consistent with the PSCI relay design goal of being
invisible to the EL1 kernel.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
