Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102812E6FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgL2Kzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL2Kzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:55:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F83C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0uQgaj597Ggj1wDQBfIEf1REq00x52pMob7nc+PArJU=; b=mlhUCDwZ+CoWj3o1JuQ8YPN/v
        kuVr8wCcnpL3CJmQcVa6UeM6tWmv4oPhGz1xVNocGRANCxSmmrolYfZI+6ygqgrKcMTUd/VB/GSeC
        2ecDBVLsgmTxKkIf69TJ+xJMB905Obyy7f0XrQun20TbsgTVLoasg/kkT8MyAFgQfR2oCGfqJtze6
        BJbq5obH4nJR8vpTF3riOFUQxE0g70QW8YM4561/dc/pmF/a4GbrXI8rym9bnyNDYcgM91w81PhCk
        jRz4MuSc8UmSXO7edSl5WPPV4r8H3KP64dWMg3moDTVBHl3y7RHPy+IoYkrWgkbOuQPYOz7uO8ctD
        CzWUNvKFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44868)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kuCeW-00053e-VP; Tue, 29 Dec 2020 10:54:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kuCeW-0001An-IG; Tue, 29 Dec 2020 10:54:56 +0000
Date:   Tue, 29 Dec 2020 10:54:56 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
Message-ID: <20201229105456.GM1551@shell.armlinux.org.uk>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
 <CAK8P3a1-zTyd9WoWxaqZ3s1ye44t1CUuZaU0a5w9bE+krk2cBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1-zTyd9WoWxaqZ3s1ye44t1CUuZaU0a5w9bE+krk2cBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 08:00:00AM +0100, Arnd Bergmann wrote:
> Wouldn't this also be needed by an Armada XP that supports
> more than 4GB of RAM but has an outer cache?

While Armada XP has an outer cache, it requires no maintanence; the
only support the kernel has is for configuring it at boot and resume:

 * For Aurora cache in no outer mode, enable via the CP15 coprocessor
 * broadcasting of cache commands to L2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
