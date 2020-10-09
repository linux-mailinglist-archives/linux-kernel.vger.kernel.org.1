Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB62884EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgJIIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbgJIIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:09:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9276C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kEaJrhB49jY9ylGi747PC2d3zrqsG3GTNHlV2nr1xSo=; b=ve8cCGYklFqGLKtG5GkwJljNv
        a3hbBRQkLbNvUxGBvRLjfgm8UYZTG64wt/m0NgpJL8GTh+fmKL5e1YuiE6RUMJY5IHvRBitFMV07P
        VuNeBlLoz8yJ1U/X7/zi8hIcCw40aQddMK62i2TCOL5Zfzf9AZm9SaKhMGUJ/L4wa/s+hpbT/geGr
        6znwoJ9jU6CJGyPnlmntqiuNeh9en5i/iQG4MSe6taT2anM9hRQKfv7pj9V8W5032KYMHT69wpH8d
        xZYErn38o1U5L5szCdPa0oEpo3tZl2PwQz13EyumuR3WeGrImdHMt1pDLD9Xu8UkpPKcV+audPxof
        qWK9gP5hA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43798)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kQnSR-0007iv-PC; Fri, 09 Oct 2020 09:08:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kQnSM-0002VN-ES; Fri, 09 Oct 2020 09:08:50 +0100
Date:   Fri, 9 Oct 2020 09:08:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     dima@arista.com, will@kernel.org, jpoimboe@redhat.com,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        viro@zeniv.linux.org.uk, ldufour@linux.ibm.com, amanieu@gmail.com,
        walken@google.com, ben.dooks@codethink.co.uk, tglx@linutronix.de,
        bigeasy@linutronix.de, mingo@kernel.org,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com,
        luohaizheng@huawei.com
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
Message-ID: <20201009080849.GM1551@shell.armlinux.org.uk>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009075957.110017-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:59:57PM +0800, Xiaoming Ni wrote:
> Printing raw pointer values in backtraces has potential security
> implications and are of questionable value anyway.
> 
> This patch follows x86 and arm64's lead and removes the "Exception stack:"
> dump from kernel backtraces:
> 	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
> 	 PC/LR values in backtraces")
> 	commit 0ee1dd9f5e7eae ("x86/dumpstack: Remove raw stack dump")
> 	commit bb5e5ce545f203 ("x86/dumpstack: Remove kernel text
> 	 addresses from stack dump")
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

I am really not happy about this - it hurts at least my ability to
debug the kernel when people post oopses to the mailing list. If
people wish to make the kernel harder to debug, and are prepared
to be told "your kernel is undebuggable" then this patch is fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
