Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5302E7796
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 10:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgL3Jze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 04:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3Jze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 04:55:34 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2BC061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tC5AzUFj3vhhQUtd8mKtAuskWB2M0osIMt6IGW6xE/k=; b=vIDBJsd4+lkzkDp3JM7aiya5O
        6DlAocHYxO0gkbupDVwIhkn1j8AG67zt/BKtSkZjcEZUMBDJkO30yM7BGv3HyWmU59uFeXufOWeUx
        U4m2I+dFL+DY+wRirB8jDs56Zd66xwt3KbxwnWe6lde7zpvxvLtTQkIWYlc0CPqFza4BFLDF9Zvlt
        Dq89S0R6IdpAY93NxuxB0psaB8uRodLxgTVgOpEnR6mrIcEL6FfXmcYlx5teHiFlcWxWDLuPsQw6y
        mFity4HIgG3nBqzDxv7bl0k/3rt69tJUpR/+LcOK8xE6yVPwl0Ax4hDBVJbVBYOANekkVC4RL/CuE
        tN6Ck42TQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44900)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kuYBY-0005bQ-Fp; Wed, 30 Dec 2020 09:54:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kuYBU-000263-VP; Wed, 30 Dec 2020 09:54:24 +0000
Date:   Wed, 30 Dec 2020 09:54:24 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ARM: LPAE: use phys_addr_t instead of unsigned
 long in outercache hooks
Message-ID: <20201230095424.GO1551@shell.armlinux.org.uk>
References: <20201230082805.1428-1-thunder.leizhen@huawei.com>
 <20201230082805.1428-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230082805.1428-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:28:05PM +0800, Zhen Lei wrote:
> The outercache of some Hisilicon SOCs support physical addresses wider
> than 32-bits. The unsigned long datatype is not sufficient for mapping
> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
> use phys_addr_t instead of unsigned long in outercache functions") has
> already modified the outercache functions. But the parameters of the
> outercache hooks are not changed. This patch use phys_addr_t instead of
> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
> 
> To ensure the outercache that does not support LPAE works properly, do
> cast phys_addr_t to unsigned long by adding a group of temporary
> variables. For example:
> -static void l2c220_inv_range(unsigned long start, unsigned long end)
> +static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
>  {
> +	unsigned long start = pa_start;
> +	unsigned long end = pa_end;
> 
> Note that the outercache functions have been doing this cast before this
> patch. So now, the cast is just moved into the outercache hook functions.
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

This is fine, but there really needs to be a patch that makes use of
this change before we accept it into mainline kernels.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
