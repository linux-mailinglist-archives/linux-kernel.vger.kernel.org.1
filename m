Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65A22FF32A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhAUS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733185AbhAUSP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:15:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83C323A56;
        Thu, 21 Jan 2021 18:15:09 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2eU6-009Fuq-SI; Thu, 21 Jan 2021 18:15:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 21 Jan 2021 18:15:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
In-Reply-To: <20210121175525.GB22963@willie-the-truck>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
 <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
 <20210121124742.GA22123@willie-the-truck>
 <39067FDD-F7D3-4F37-8B43-1A9FCF80EEE5@caramail.com>
 <195e2bfe3a5e5503d9988b517159300e@kernel.org>
 <20210121175525.GB22963@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <f2b1cb981e7c3d42a9f815c2d2be08bb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, mohamed.mediouni@caramail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, mark.rutland@arm.com, marcan@marcan.st, linux-kernel@vger.kernel.org, stan@corellium.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-21 17:55, Will Deacon wrote:
> On Thu, Jan 21, 2021 at 04:25:54PM +0000, Marc Zyngier wrote:
>> On 2021-01-21 15:12, Mohamed Mediouni wrote:
>> > Please ignore that patch.
>> >
>> > It turns out that the PCIe controller on Apple M1 expects posted
>> > writes and so the memory range for it ought to be set nGnRE.
>> > So, we need to use nGnRnE for on-chip MMIO and nGnRE for PCIe BARs.
>> >
>> > The MAIR approach isn’t adequate for such a thing, so we’ll have to
>> > look elsewhere.
>> 
>> Well, there isn't many alternative to having a memory type defined
>> in MAIR if you want to access your PCIe devices with specific
>> semantics.
>> 
>> It probably means defining a memory type for PCI only, but:
>> - we only have a single free MT entry, and I'm not sure we can
>>   afford to waste this on a specific platform (can we re-purpose
>>   GRE instead?),
> 
> We already have an nGnRnE MAIR for config space accesses.

I'm confused. If M1 needs nGnRE for PCI, and overrides nGnRE to nE
for its in-SoC accesses, where does nGnRE goes?

Or do you propose that it is the page tables that get a different
MT index?

         M.
-- 
Jazz is not dead. It just smells funny...
