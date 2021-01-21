Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5A2FF29A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbhAUR6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389328AbhAUR4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:56:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76B5A23A03;
        Thu, 21 Jan 2021 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251731;
        bh=6A3+p4zWcLPEy9gVma3xC8MNdblASD6WYxOB2q1oga4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgs0DMJskyjBAjTTM6uhrc61I66lNqG3i7oE+WX0JZhcri9n7eNXJazW17SWkRKDt
         B1Fa1YQEuuBL0ujLqp80XSyO0kWuIIcduNn21KXSs90boy608Oxl1qDQ6eoXwUC3Pu
         4p6Mf9YYL3GdBxmUG8rTz4xOAvsY4bGLmLSOa7R2qIM+HZJi6V410FbjLC59um0jIe
         XvINHmKhtTBmOtCHmYCyVXdwOSTlBOeXGOGLvS5JkYkUbK3b7kwH7NT8jtlg7jVGUY
         ZThD4lW+rek6yvVeGOES4mxQBgXgLb1traG64iBMU5I+WLLtbkzpiXK20AhpOKZd5S
         +lMLko0O2HRSg==
Date:   Thu, 21 Jan 2021 17:55:26 +0000
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
Message-ID: <20210121175525.GB22963@willie-the-truck>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
 <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
 <20210121124742.GA22123@willie-the-truck>
 <39067FDD-F7D3-4F37-8B43-1A9FCF80EEE5@caramail.com>
 <195e2bfe3a5e5503d9988b517159300e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <195e2bfe3a5e5503d9988b517159300e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:25:54PM +0000, Marc Zyngier wrote:
> On 2021-01-21 15:12, Mohamed Mediouni wrote:
> > Please ignore that patch.
> > 
> > It turns out that the PCIe controller on Apple M1 expects posted
> > writes and so the memory range for it ought to be set nGnRE.
> > So, we need to use nGnRnE for on-chip MMIO and nGnRE for PCIe BARs.
> > 
> > The MAIR approach isn’t adequate for such a thing, so we’ll have to
> > look elsewhere.
> 
> Well, there isn't many alternative to having a memory type defined
> in MAIR if you want to access your PCIe devices with specific
> semantics.
> 
> It probably means defining a memory type for PCI only, but:
> - we only have a single free MT entry, and I'm not sure we can
>   afford to waste this on a specific platform (can we re-purpose
>   GRE instead?),

We already have an nGnRnE MAIR for config space accesses.

Will
