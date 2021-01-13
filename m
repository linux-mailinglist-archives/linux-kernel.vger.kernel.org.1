Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB12F5810
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbhANCNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbhAMVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:45:37 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BCC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jQMfbayy2yzW173Q/GJuPVzTG6Wm2caGZkDvDFIYEBo=; b=fnpZm0oIPbAh1CMnqRdAP3Umv
        44UShPSsUDqhPjL0bM8IpKs8YOESerkfnuIBTOEF9whdTw1zuyIZYR+6JrGxDsGvvXPAiZLFYQfgD
        3xhpt2JhlUFYv4V7ogQxVpaynC2ZJZHcs+MU6iC6ggARG/9gTxegVqt5atJtSKFBNi25roi82pejH
        CEzsy5Ou/S6+4MOKgfXnu14NHQE4VsWVV6Sk7COKsnfbtL3XZn/oH98yLJIG26ddU4226RCzJwfYf
        mPvK7iP3Sh2J7RRhl9zZEIsB4VKDe4QTSSqUpXoGiuC46XfJrFoWdq4TeqxaUqYYBrw3t241zts+Q
        Otay66j9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47598)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kznwV-0001ho-Go; Wed, 13 Jan 2021 21:44:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kznwT-0007f3-1M; Wed, 13 Jan 2021 21:44:37 +0000
Date:   Wed, 13 Jan 2021 21:44:37 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
Message-ID: <20210113214436.GL1551@shell.armlinux.org.uk>
References: <20210112224832.10980-1-will@kernel.org>
 <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:15:09AM -0800, Linus Torvalds wrote:
> On Wed, Jan 13, 2021 at 9:58 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Maybe, we can raise the minimal version to gcc 5.1
> > for all architectures.
> 
> It was discussed, but the immediate reason for this thing really does
> seem to be specific to just arm64 (ie this is not some generic gcc
> stack access bug that just happens to rear its head on arm64 - the
> patch to fix this in the gcc bugzilla is very much arm64-only).

I seem to remember during the discussion of the arm64 problem, that
there was a similar bug on e.g. sparc, but they patched the kernel.
*digs through irc logs...*

https://patchwork.kernel.org/project/linux-crypto/patch/20170602.112854.571030442583332811.davem@davemloft.net/
https://marc.info/?l=linux-sparc&m=149636946609980&w=2

(and they even reference the arm64 bug). If you move on two messages,
then the disassembly clearly shows that it is the same bug on Sparc.

DaveM came up with the following to fix it:

commit d41519a69b35b10af7fda867fb9100df24fdf403
Author: David Miller <davem@davemloft.net>
Date:   Fri Jun 2 11:28:54 2017 -0400

    crypto: Work around deallocated stack frame reference gcc bug on sparc.

which added a bunch of barriers across the kernel to cater for this,
but for them, ext4 was not impacted at that time.

Apparently, davem's justification for not changing ext4 was:

"Actually, ext4 doesn't trigger the problem because the on-stack object
used in ext4 is a fixed size at compile time"

So, maybe the Sparc issue was just a similar but different bug in gcc
4.9.x.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
