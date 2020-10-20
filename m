Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296F22938F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbgJTKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgJTKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:13:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B73C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ulf1b4scapw8ctjjAAz+4kLXfTbjmbhJeEFBO0fcNVE=; b=bW/0XvzFz0jzLulc5aAH1fFri
        e3xmMJmksLdSUc7UG9xzd2z49GU6JCPdz/3zV3CvN8dtLpUt0iGWkfEhTA6rqzDughAlLRWSAnSB5
        unVgdLOzvO8oTTE7bnWIYQMuZ/yDXSBH0hKYz38Hpj/myzEUaocO6GvD3pzo310ORPuzNKuyqedlA
        yZSnSgnWuUT/vMFBs5fQPcNsY5ZxJ4FTUksoTuMxin/nq8R5qEhQPJZnEAnLD0X0P2EX0QGyGuLU6
        OOMYtgg5bIlRC+atsL9HS6HOKnw5Kt43gdxikf/QqeN1/1tFAf09brxvRTgHtRV0e/ngKV10TbyMZ
        rrtXBEwtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48618)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kUodz-00076j-FI; Tue, 20 Oct 2020 11:13:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kUodw-0005CL-QC; Tue, 20 Oct 2020 11:13:24 +0100
Date:   Tue, 20 Oct 2020 11:13:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mhiramat@kernel.org, labbott@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Subject: Re: [PATCH v2] ARM: kprobes: Avoid fortify_panic() when copying
 optprobe template
Message-ID: <20201020101324.GA1551@shell.armlinux.org.uk>
References: <20201001042927.2147800-1-andrew@aj.id.au>
 <CACPK8XcFhnnY8Q_DYRGo-AuRMxnVzUfCyjxRyAuFO=RSGyK=Sg@mail.gmail.com>
 <CACPK8XeJzHOH-ErWB8ZZS1rMVcPJx0exjnB-va-vhuvGvwFWCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XeJzHOH-ErWB8ZZS1rMVcPJx0exjnB-va-vhuvGvwFWCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 05:32:26AM +0000, Joel Stanley wrote:
> On Fri, 9 Oct 2020 at 05:20, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Thu, 1 Oct 2020 at 04:30, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > Setting both CONFIG_KPROBES=y and CONFIG_FORTIFY_SOURCE=y on ARM leads
> > > to a panic in memcpy() when injecting a kprobe despite the fixes found
> > > in commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> > > FORTIFY_SOURCE") and commit 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes:
> > > optimized kprobes illegal instruction").
> > >
> > > arch/arm/include/asm/kprobes.h effectively declares
> > > the target type of the optprobe_template_entry assembly label as a u32
> > > which leads memcpy()'s __builtin_object_size() call to determine that
> > > the pointed-to object is of size four. However, the symbol is used as a handle
> > > for the optimised probe assembly template that is at least 96 bytes in size.
> > > The symbol's use despite its type blows up the memcpy() in ARM's
> > > arch_prepare_optimized_kprobe() with a false-positive fortify_panic() when it
> > > should instead copy the optimised probe template into place:
> > >
> > > ```
> > > $ sudo perf probe -a aspeed_g6_pinctrl_probe
> > > [  158.457252] detected buffer overflow in memcpy
> > >
> > > Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> > > Fixes: 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction")
> > > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Tested-by: Joel Stanley <joel@jms.id.au>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > Thanks Andrew.
> >
> > > ---
> > > v1 was sent some time back, in May:
> > >
> > > https://lore.kernel.org/linux-arm-kernel/20200517153959.293224-1-andrew@aj.id.au/
> 
> Russell, are you picking this fix up?

Sorry, but I don't "pick" patches off the mailing list. See my
signature.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
