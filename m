Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81EA28AAC0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgJKVdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgJKVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:33:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E002C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/JQeKHwzqW3O8yhtwkVNGIvzBEk96NPH81pzSigtML4=; b=g8r2lVsOr76ewNgL6XwarEm3f
        0hGIc0y+DzYI/jAhXqvRD2fikvELcXmZEZl/otrNdHgslITGzPFdzFBEz22bL6kdmERetv9SbZbMk
        HvAqwHsoHnq/BIRnk47O254CyouxXGifwD3wc/02D1qz75EJWXugg3iSnKniM+V+nxNXL37E94rLR
        nlJev4HjAlhIq2f3zYb2aDSGJWkkFc2CiRs7CEKTBooxk9ERt25Dwt/Mzjt9WIEy0DEEDM5ErqaTw
        Ii9DqI8TyhCvXJTRQUQp/U20dz6fehVnzOGyS2XAMdV9A3w+OPF23WnCR1OcPfgfe7jSgZSyGnUsp
        +VXWCBdtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44810)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kRixQ-00033x-Mn; Sun, 11 Oct 2020 22:32:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kRixK-0004vp-GA; Sun, 11 Oct 2020 22:32:38 +0100
Date:   Sun, 11 Oct 2020 22:32:38 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, dima@arista.com,
        will@kernel.org, jpoimboe@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, viro@zeniv.linux.org.uk,
        ldufour@linux.ibm.com, amanieu@gmail.com, walken@google.com,
        ben.dooks@codethink.co.uk, tglx@linutronix.de, mingo@kernel.org,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com,
        luohaizheng@huawei.com
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
Message-ID: <20201011213238.GN1551@shell.armlinux.org.uk>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
 <20201009080849.GM1551@shell.armlinux.org.uk>
 <20201009081820.jargnmck6zfkzegx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009081820.jargnmck6zfkzegx@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 10:18:20AM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-09 09:08:50 [+0100], Russell King - ARM Linux admin wrote:
> > I am really not happy about this - it hurts at least my ability to
> > debug the kernel when people post oopses to the mailing list. If
> > people wish to make the kernel harder to debug, and are prepared
> > to be told "your kernel is undebuggable" then this patch is fine.
> 
> I haven't look at the patch but don't they keep/add the representation:
>   PC: symbol+offset/size
>   LR: symbol+offset/size
> 
> ? This is needed at very least as a replacement for the missing address.

I don't have a problem getting rid of the hex numbers in [< >]
although then I will need to convert the symbol back to an address
using the vmlinux to then calculate its address to then find the
appropriate place in the objdump output - because objdump does
_not_ use the symbol+offset annotation.  Yes, I really do look up
the numeric addresses in the objdump output to then read the
disassembly.

$ objdump -d vmlinux | less

and then search for the address is the fastest and most convenient
way for me rather than having to deal with some random script.

Maybe I'm just antequated about how I do my debugging, but this
seems to me to be the most efficient and fastest way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
