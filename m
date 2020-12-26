Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF87E2E2E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLZMQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLZMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:16:35 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EEC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 04:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QsnqwKrC8FAcmq1cPPiwc8IugCbcu9GsR0MUxmjHSGc=; b=GdsHm/xW8/6Or4SUsT5v5JOxj
        y7i8GCvXKGSuURt+XikaaV1zLN6oO4DvubALaS+xnIKWi2LuyhDOxXLqlyMYaTrLPxEznYRE5/ooL
        vq7xoTAJZQ7wKj2VMvjH+IZcACEtLvuA2rdEqQNSvC2jl4ZAfx/eC0dHhfU42B+Km3S6N1dr1QExp
        brh+rTrjA1girapFm+olYCAGamIYoVmWDSTkilFheGxBFLymjF5MtsH6HMnk/WQdWvvyvP1mlvUzO
        PucnDRtpwP+WpWQvBdOM0ZFxw2kPvfywCDh5AEOlql89M2VSSe2mrjAgxoiEAE4aOBBJZaF0lT65W
        D/66iXr3A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44538)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kt8U8-0003R4-71; Sat, 26 Dec 2020 12:15:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kt8U7-0006pi-Mc; Sat, 26 Dec 2020 12:15:47 +0000
Date:   Sat, 26 Dec 2020 12:15:47 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
Message-ID: <20201226121547.GC1551@shell.armlinux.org.uk>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
 <a0ca2ec8-40cf-4b5e-a6fe-f68d9650a82f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ca2ec8-40cf-4b5e-a6fe-f68d9650a82f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 10:18:08AM +0800, Leizhen (ThunderTown) wrote:
> On 2020/12/25 19:44, Zhen Lei wrote:
> > The outercache of some Hisilicon SOCs support physical addresses wider
> > than 32-bits. The unsigned long datatype is not sufficient for mapping
> > physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
> > use phys_addr_t instead of unsigned long in outercache functions") has
> > already modified the outercache functions. But the parameters of the
> > outercache hooks are not changed. This patch use phys_addr_t instead of
> > unsigned long in outercache hooks: inv_range, clean_range, flush_range.
> > 
> > To ensure the outercache that does not support LPAE works properly, do
> > cast phys_addr_t to unsigned long by adding a middle-tier function.
> 
> This patch will impact the outercache drivers that have not been merged into
> the kernel. They should also update the datatype of the outercache hooks.

This isn't much of a concern to mainline. If it's that big a problem
for you, then please consider merging your code into mainline so that
everyone can benefit from it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
