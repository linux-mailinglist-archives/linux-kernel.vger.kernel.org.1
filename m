Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C232FF321
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbhAUS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbhAUSXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:23:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 404E723A54;
        Thu, 21 Jan 2021 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611253361;
        bh=rcFjElAtV5MM5FFQWcMSk44tUbSGXXb+TeaDIIY0O8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/IX7+GWeObKrbOIbVok3Aqxa4XFeu4BWT5Em0qxN+j1p38LeUY/VxaJqdfoIYMkD
         zQHXB+ZST8Jpm6QUqbll5nNtET0VrScW6GHgo1nYJ+5Bn95KXywqos38eoxBYlatAJ
         ROCPcy1wzi/ACv7vAE/r770DNFrKvJF9EtL9Pm4IMS66fWSDVyiv+MXYgiSbfMvFKy
         zRIX+CAnpQ/PyE5df4KR9GyMZGujxjoJTzKkAH4LdyA8w2hrmAKvpaHwcCbBrAgmmP
         W/rwdI5Uiy9RDPtT7Zk79FR+o5FxOa7KXvQsNn1tKaqdTrULoruHcqq4ovzB/d73p/
         D5P5O36CRpQXQ==
Date:   Thu, 21 Jan 2021 18:22:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
Message-ID: <20210121182236.GC22963@willie-the-truck>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
 <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
 <20210121124742.GA22123@willie-the-truck>
 <39067FDD-F7D3-4F37-8B43-1A9FCF80EEE5@caramail.com>
 <195e2bfe3a5e5503d9988b517159300e@kernel.org>
 <20210121175525.GB22963@willie-the-truck>
 <f2b1cb981e7c3d42a9f815c2d2be08bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2b1cb981e7c3d42a9f815c2d2be08bb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:15:06PM +0000, Marc Zyngier wrote:
> On 2021-01-21 17:55, Will Deacon wrote:
> > On Thu, Jan 21, 2021 at 04:25:54PM +0000, Marc Zyngier wrote:
> > > On 2021-01-21 15:12, Mohamed Mediouni wrote:
> > > > Please ignore that patch.
> > > >
> > > > It turns out that the PCIe controller on Apple M1 expects posted
> > > > writes and so the memory range for it ought to be set nGnRE.
> > > > So, we need to use nGnRnE for on-chip MMIO and nGnRE for PCIe BARs.
> > > >
> > > > The MAIR approach isn’t adequate for such a thing, so we’ll have to
> > > > look elsewhere.
> > > 
> > > Well, there isn't many alternative to having a memory type defined
> > > in MAIR if you want to access your PCIe devices with specific
> > > semantics.
> > > 
> > > It probably means defining a memory type for PCI only, but:
> > > - we only have a single free MT entry, and I'm not sure we can
> > >   afford to waste this on a specific platform (can we re-purpose
> > >   GRE instead?),
> > 
> > We already have an nGnRnE MAIR for config space accesses.
> 
> I'm confused. If M1 needs nGnRE for PCI, and overrides nGnRE to nE
> for its in-SoC accesses, where does nGnRE goes?
> 
> Or do you propose that it is the page tables that get a different
> MT index?

Right, I'm just saying that we already have an nGnRnE MAIR configuration
so there's no need to worry about running out of entries if we need both
nGnRE and nGnRnE to co-exist. The nasty part is how to plumb this into
the mappings only for on-chip MMIO; I guess either a new API or we get
ioremap() to pick the memory type based on the address :/

Will
