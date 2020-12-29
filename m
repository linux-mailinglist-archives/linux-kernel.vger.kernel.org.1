Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAE2E6FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgL2Kwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2Kwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:52:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hqlpDHbQI+IW+gacvz8RsUWJocaaMYB1ckj8x8KROw0=; b=AO8NMCaTYDMv/EwFlPSCdX9J9
        VAWyxsNdUR+qLwEiVbRNMWsZepOuWbRz4CPwoRq40Hzf53li8G9gECptV+7+e6/DmVdMXIcRV8dmE
        ATupU0LKG0rOhWJ0vBeCreOkPSEW1MEeu+cxAz0UWj35Jo9kHEQ5Al6sTwb4987FZ9Vk2NbJ6os5z
        mCuXM3q2WLrXDUgyj7PrnDvmLIjHFoB8IyshbJ2JLi8Pj7S9tbtg1gVMQSkmhS58V8dyerfjftOGg
        h4LmT400Kd81UdQBlwDJnN6OGH0+/cCV0sJneYXZblEi1Eoi2t4GlVVE/t89vdwibFsklzQ1VM2Z/
        JwPDZOnhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44866)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kuCbT-00053K-8j; Tue, 29 Dec 2020 10:51:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kuCbP-0001Ae-S2; Tue, 29 Dec 2020 10:51:43 +0000
Date:   Tue, 29 Dec 2020 10:51:43 +0000
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
Message-ID: <20201229105143.GL1551@shell.armlinux.org.uk>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
 <20201226121346.GB1551@shell.armlinux.org.uk>
 <3a597586-2bce-66cf-b9f8-4bb667a600d0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a597586-2bce-66cf-b9f8-4bb667a600d0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 02:30:56PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/12/26 20:13, Russell King - ARM Linux admin wrote:
> > On Fri, Dec 25, 2020 at 07:44:58PM +0800, Zhen Lei wrote:
> >> The outercache of some Hisilicon SOCs support physical addresses wider
> >> than 32-bits. The unsigned long datatype is not sufficient for mapping
> >> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
> >> use phys_addr_t instead of unsigned long in outercache functions") has
> >> already modified the outercache functions. But the parameters of the
> >> outercache hooks are not changed. This patch use phys_addr_t instead of
> >> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
> >>
> >> To ensure the outercache that does not support LPAE works properly, do
> >> cast phys_addr_t to unsigned long by adding a middle-tier function.
> > 
> > Please don't do that. The cast can be done inside the L2 functions
> > themselves without needing all these additional functions.
> 
> OK. At first, I wanted to fit in like this:
> 
> -static void l2c220_inv_range(unsigned long start, unsigned long end)
> +static void l2c220_inv_range(phys_addr_t lpae_start, phys_addr_t lpae_end)
>  {
> +  unsigned long start = lpae_start;
> +  unsigned long end = lpae_end;

It sounds like there should be a "but..." clause here. This is exactly
what I'm suggesting you should be doing. Currently, there's a silent
narrowing cast in every single caller of the outer_.*_range() functions
and you're only moving it from the callsites to inside the called
functions.

> > We probably ought to also add some protection against addresses > 4GB,
> > although these are hot paths, so we don't want to add tests in these
> > functions. Maybe instead checking whether the system has memory above
> > 4GB while the L2 cache is being initialised would be a good idea?
> 
> I'm sorry, I didn't quite understand what you meant. Currently, the
> biggest problem is the compilation problem. The sizeof(long) may be
> 32, and the 64-bit physical address cannot be transferred from outcache
> functions to outcache hooks.

What I mean is that we really ought to warn if the L2C310 code tries to
initialise on a system where memory is above 4GB. However, it's very
unlikely that such a system exists, so it's probably fine not implement
a check, but it just feels fragile to be truncating the 64-bit address
to 32-bit on a kernel that _could_ support higher addresses, even though
that's exactly what is happening today (kind of by accident - I don't
think anyone realised.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
