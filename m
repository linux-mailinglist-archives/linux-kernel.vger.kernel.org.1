Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA22F91A4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbhAQKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbhAQKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:09:58 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ItbSYqJ0DbCe+J/gZUetRPMemBxEJIEpaxGcVk0SftY=; b=0mn8fckZlbhhwYm/aXkpvFTFQ
        Q+sWZ4yWv44x8bHqyF14DtXaRL+AIyzCR5a92GsrwEDyr2z3jWULutPT9gVEZrAZOJ8gWAlSCAua/
        8TE20ZOXND/WTK+mqe4r1P9aprwhblsuHr0gtWFKCAJ2oyxKVFN8NxdLgemTQBFAhUsdg/T24i2Qi
        rx/Ca8k8VkLqmN3ebW0dbwvr2kO1BQUAypZCOZ51rE66Hbq3kFPCTIY8vGH9HNJgpy4HwcfNABvbG
        Oqgjs7qMzjrrIwrFgfjq3J4oAZMiOFUw82nTNUD86SRF9+Agh32/q2mqL6HUHsZ83r5tFLgtRyH8j
        nlZ66ywfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49082)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l14zb-0005Mu-4k; Sun, 17 Jan 2021 10:09:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l14zY-0002tT-4x; Sun, 17 Jan 2021 10:09:04 +0000
Date:   Sun, 17 Jan 2021 10:09:04 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmerdabbelt@google.com,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v3 0/4] initrd: Use unified initrd reserve function in
 ARM/RISCV
Message-ID: <20210117100903.GB1551@shell.armlinux.org.uk>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
 <48c006a8-a352-488c-4981-768faffbe343@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c006a8-a352-488c-4981-768faffbe343@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 12:57:55PM +0800, Kefeng Wang wrote:
> Correct Russell's mail address (from linux@armlinux.org.uk to
> rmk+kernel@armlinux.org.uk, should update the MAINTAINERS)

No. MAINTAINERS is correct.

> On 2021/1/15 13:46, Kefeng Wang wrote:
> > Use the same implementation of initrd reserve to avoid duplication.
> > 
> > v3:
> > - split into four patches, suggested-by Palmer Dabbelt
> > v2:
> > - fix build error found by kernel test robot
> > 
> > Kefeng Wang (4):
> >    initrd: Add the preprocessor guard in initrd.h
> >    initramfs: Provide a common initrd reserve function
> >    ARM: Covert to reserve_initrd_mem()
> >    riscv: Covert to reserve_initrd_mem()
> > 
> >   arch/arm/mm/init.c     | 43 +--------------------------------
> >   arch/riscv/mm/init.c   | 54 +-----------------------------------------
> >   include/linux/initrd.h | 11 +++++++++
> >   init/initramfs.c       | 45 +++++++++++++++++++++++++++++++++++
> >   4 files changed, 58 insertions(+), 95 deletions(-)
> > 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
