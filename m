Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85E2E2E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgLZMPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLZMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:15:08 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BBC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 04:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WkduoRvavGYuUL4Ox1oO1swID6wNM6KOx4jf7cUobIA=; b=j99KAZtsOKSGp0dMYOwEs8vhX
        2zZ9uNdLQccw3wdEUNxYgEFf5UCJLrqHfpmlHQZ4FFj7LOZDtk3jNeVarf3tgDJN91QC7Y9N/BvW1
        05ZeL3W4YS3U+WBqqrtvoBdje+3wgzJ+KichNJN48+evwxu4XkoSNcDjpDm4ThpcIDXKFmKGh78xC
        yGoz02jBBLHxLFeQI9dPVurjqqfpZPC04ObJQH2EH+31XMOjxxX9ydEfwsVi5WrR2tNafDLUQNqwm
        jQJ2qAIuucm1B/FHr3xwSsRnSFiFgdDCFkg9SDcJjEV5jMZOvOcu0qVdBdVA0u8m98I83XkWsdHsl
        u4pVWXPbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44536)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kt8SG-0003Qs-2z; Sat, 26 Dec 2020 12:13:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kt8SA-0006pa-VN; Sat, 26 Dec 2020 12:13:46 +0000
Date:   Sat, 26 Dec 2020 12:13:46 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
Message-ID: <20201226121346.GB1551@shell.armlinux.org.uk>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225114458.1334-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 07:44:58PM +0800, Zhen Lei wrote:
> The outercache of some Hisilicon SOCs support physical addresses wider
> than 32-bits. The unsigned long datatype is not sufficient for mapping
> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
> use phys_addr_t instead of unsigned long in outercache functions") has
> already modified the outercache functions. But the parameters of the
> outercache hooks are not changed. This patch use phys_addr_t instead of
> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
> 
> To ensure the outercache that does not support LPAE works properly, do
> cast phys_addr_t to unsigned long by adding a middle-tier function.

Please don't do that. The cast can be done inside the L2 functions
themselves without needing all these additional functions.

We probably ought to also add some protection against addresses > 4GB,
although these are hot paths, so we don't want to add tests in these
functions. Maybe instead checking whether the system has memory above
4GB while the L2 cache is being initialised would be a good idea?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
