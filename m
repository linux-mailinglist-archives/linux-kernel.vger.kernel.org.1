Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C63042A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406358AbhAZPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391662AbhAZPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:30:16 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A647C061A29
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A20Bi9wZP7zPkKZLGraseELGOsG8tQSIu5hQv1oEWsw=; b=rFH8WB+NRAnS12nZ6M6xKAK80
        WqkFh/5k8qdjZgtyx34CyG6LEQxmlgi8+vQQ0RjeW1hkfhDIALXvi+Jb20laqy+MEC52SKON83Ifm
        hJxgNNSnTHhlTGeyo8ts0XVlnqFZyZpcppPAanSH6XKtJAM/i2nDwn4Sv5jTzHusIKJNGa3RyFOH5
        KNKxYlkhsyknMpMA1eVFK02KXmUkP6j88Z2sj6Ocfyixl9jLlnZ256Y5z7pfD3NX40FPRVw5ncZdG
        a14cbzb0lWwx5aGQgReO+jjWkCDcUkypp8Izhs0CqYubhYkHXOWqYDVGeHXhivlDv/tYJ5eLZyJdz
        E+cUCHrvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53002)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l4QHP-0004b7-L1; Tue, 26 Jan 2021 15:29:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l4QHM-0003uJ-TA; Tue, 26 Jan 2021 15:29:16 +0000
Date:   Tue, 26 Jan 2021 15:29:16 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     bigeasy@linutronix.de, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, yj.chiang@mediatek.com,
        peterx@redhat.com, linux-kernel@vger.kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, walken@google.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: mm: harden branch predictor before opening
 interrupts during fault
Message-ID: <20210126152916.GJ1551@shell.armlinux.org.uk>
References: <20210126110716.wv4igts76n3kg3ch@linutronix.de>
 <20210126150150.13905-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126150150.13905-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:01:50PM +0800, Lecopzer Chen wrote:
> > On 2021-01-26 10:59:32 [+0000], Russell King - ARM Linux admin wrote:
> > > On Tue, Jan 26, 2021 at 05:17:08PM +0800, Lecopzer Chen wrote:
> > > > Hi all,
> > > > 
> > > > I don't see any fix for this issue now(maybe I missed it..?),
> > > > could we fix this if there is better solution?
> > > > This issue exists almost two years.
> > > 
> > > I don't think anyone provided an acceptable patch.
> > > 
> > > The first patch moved the hardening out of the translation/section
> > > fault handling. Since the kernel is mapped with sections, these
> > > are above TASK_SIZE, and the whole point of the branch prediction
> > > hardening is to prevent the prediction in the kernel being exploited,
> > > missing the hardening effectively makes the mitigation useless.
> > > 
> > > The discussion in February 2019 never concluded from what I can see.
> > 
> > My memory is that I never got a reply which I understood.
> > Let me try again this week with the information above.
> 
> 
> NOTE:
> Before sending this mail, I had searched the relative threads and
> there are two solutions in general:
>     1. Add get_pcpu()/put_cpu() https://lkml.org/lkml/2019/6/3/426
>        Reject by Marc:
>        > The right fix would be to move the call to a point where we haven't
>        > enabled preemption yet.
> 
>     2. Move out like the patch from Sebastian:
>        This seems follow the concept of 1.
>        (move the call to a point where we haven't enabled preemption yet).
>        But I can't find any reply in the thread.
> 
> Now the CONFIG_HARDEN_BRANCH_PREDICTOR has already backported to LTS,
> and after upgrading ARM CONFIG_CPU_V7 products to latest LTS, the
> CONFIG_HARDEN_BRANCH_PREDICTOR will be default y and this issue makes
> our devices panic and we have to either disable HARDEN_BRANCH_PREDICTOR
> or hack in-house to avoid the kernel panic.

It does _not_ cause the kernel to panic, ever. A kernel panic takes
out the system. This is not the case here.

It merely causes a noisy message to be emitted in the kernel log, and
the system survives. That is way more preferable than breaking the
effect of branch predictor hardening.

If it is taking out your kernel with a real panic, then there is
something wrong elsewhere - and this is _not_ something that should
be happening during normal system operation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
