Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457842AA468
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgKGKWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 05:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgKGKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 05:22:16 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D43C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xKuw8zhvtdu4k0q3nrygkrJRwLjOFB13/MQ9ZczbDd4=; b=gyCEgepe3kjI9lo/a/W+lcA1W
        SmIG8GD7itnwyFoTN3tCbUScOMqJj3cJXBT+Qvy/V7kwCeXZ548QX2VI2ZzDkT153oPKn+qobKsVX
        sw/iz4QFapBWqu0uZUE1BScP9qIapnkVpHEtRZxmDqvedW2xnvHe47BFo/HsqJxn2eJvISsOFWv7i
        4XbdYjGQL9gw6gk+WCJuz1Qm9u2+J77q66qo3/ZR8SQbc0S9Vuih5PWS/QMYfIVclGLm5p5FnY8NN
        5SSO+rDfvuaIoTq7VUsqRaU3C6eCIzkRNajdn3Z2vbbWf9T4TwbltcKeqa1wfypF+BtkU5M3JWv71
        2929RA0YQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56150)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kbLMD-0006Zo-9x; Sat, 07 Nov 2020 10:22:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kbLMB-0006k4-Vd; Sat, 07 Nov 2020 10:22:04 +0000
Date:   Sat, 7 Nov 2020 10:22:03 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201107102203.GV1551@shell.armlinux.org.uk>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106051436.2384842-3-adrian.ratiu@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote:
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index e1e76186ec23..84c91c48dfa2 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -18,6 +18,10 @@ MODULE_LICENSE("GPL");
>   * Pull in the reference implementations while instructing GCC (through
>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>   * NEON instructions.
> +

Please tidy this up before submission; we normally continue the "*" for
blank lines in comment blocks. Thanks.

> + * On Clang the loop vectorizer is enabled by default, but due to a bug
> + * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
> + * so xor-neon is disabled in favor of the default reg implementations.
>   */
>  #ifdef CONFIG_CC_IS_GCC
>  #pragma GCC optimize "tree-vectorize"
> -- 
> 2.29.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
