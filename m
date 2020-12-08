Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C302D27EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgLHJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgLHJlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:41:13 -0500
Date:   Tue, 8 Dec 2020 09:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607420432;
        bh=l03X9b1AwR7eEYo3VLDO+AWbKPeOsT8lUlLG3XUEGcc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9yFCJVPeCmI8cxF0hHxdebit6cTtoLiw93kazgl0x+BJCfUJJXOZNfRGlYKaygXI
         S/N+40Uwu0X5uWaRwpuCZ2jc8AlyUfdZpE/NM3RSP3QSz+o8XgD35WRRD2+xDNbXGZ
         VGH+IiMIgdJj74Kd/2A2KesH+nrjgb9PcdGfaCUAdXvQdli5MpnnWsUwzJHKiwEvDd
         SmjfzgawHzDoD/40UPolbneGtEDobrxNbSh5oHZO3KfAdI+flFHiVg9esS9VGe/Oxr
         Rh5SfXP/9IDR+s7jMOFYBEKEwxZ8kOghkhqxHHdsyKIbnhjx4/wuZXbaNwKKQBF7mu
         GXiLXL8rGbQ2w==
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20201208094026.GA5562@willie-the-truck>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <20201207134052.GA4563@willie-the-truck>
 <X844CBNCTL4XT3iq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X844CBNCTL4XT3iq@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:11:20PM +0000, Quentin Perret wrote:
> On Monday 07 Dec 2020 at 13:40:52 (+0000), Will Deacon wrote:
> > Why not use the RESERVEDMEM_OF_DECLARE() interface for the hypervisor
> > memory? That way, the hypervisor memory can either be statically partitioned
> > as a carveout or allocated dynamically for us -- we wouldn't need to care.
> 
> Yup, I did consider that, but the actual amount of memory we need to
> reserve for the hypervisor depends on things such as the size of struct
> hyp_page, which depends on the kernel you're running (that is, it might
> change over time). So, that really felt like something the kernel should
> be doing, to keep the DT backward compatible, ... Or did you have
> something more elaborate in mind?

No, that's fair. Just wanted to make sure we had a good reason not to use
the existing memory reservation code.

Will
