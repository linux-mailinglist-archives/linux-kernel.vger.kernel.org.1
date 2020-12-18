Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFC2DE3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLROBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLROBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:01:37 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457DBC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YsRdlIw1j0ww4MkAqOnBL7nj6Bz8RfTaAFPukAbPwQw=; b=VSpiS+DP56PSv88kUvUmc00Km
        Qgq4423c/3W2k277eCxXw4dDlDVGnNO+IGc9hF7R3kd2AnAEy6wWC63j5Nu4iMzZAX81hsN+aeHzf
        QlIkqIx7S6LdVkQAxXsgeJwdU0AW6dobW6TkET4UolFpwt8tqI4kBl1Pz4Rh7JnTeXN5YYexiiFZJ
        i7MbnvsgdWju5Wkgf7UgbOJ2LFjR9m6F+Skqes/WEs0MM1St44i/I4EQnVlSnIB/URDp+7Rl7bIOh
        gMY9KjOEsu1Ze4WoBgW/l6mmeZN0n+8JQ3tV+grdZcq+iqFnFPirfDmMNBc6bpqe/wZjw1J+HyjNG
        tWSTyYStQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44338)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kqGIx-0005do-1m; Fri, 18 Dec 2020 14:00:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kqGIs-0007xC-8t; Fri, 18 Dec 2020 14:00:18 +0000
Date:   Fri, 18 Dec 2020 14:00:18 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     kernelci-results@groups.io,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        linux-kernel@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: next/master bisection: baseline.login on
 ox820-cloudengines-pogoplug-series-3
Message-ID: <20201218140018.GZ1551@shell.armlinux.org.uk>
References: <5fdc89c3.1c69fb81.c9707.68bb@mx.google.com>
 <3e1680ed-94b8-74c9-ffe6-c2bd71f2a705@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1680ed-94b8-74c9-ffe6-c2bd71f2a705@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 01:48:09PM +0000, Guillaume Tucker wrote:
> Please see the bisection report below about a boot failure on
> ox820-cloudengines-pogoplug-series-3.  There was also a bisection
> yesterday with next-20201216 which landed on the same commit, on
> the same platform and also with oxnas_v6_defconfig.  I'm not
> aware of any other platform on kernelci.org showing the same
> regression.

Ah, I bet I know what's happening.

We test for the presence of VFP by issuing an instruction to read
FPSID. If VFP is not present, this will raise an undefined instruction
exception, and we expect to head into the vfp_testing_entry code.

I bet Pogoplug, being an ARM11 MPCore platform, either raises an
exception here.

We probably need to also rework the code in vfp_init() as well to
register a temporary hook when reading the FPSID.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
