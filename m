Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26328A81E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgJKP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgJKP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:58:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D6C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 08:58:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f235400d5b33892b03486f9.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:5400:d5b3:3892:b034:86f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2D271EC038E;
        Sun, 11 Oct 2020 17:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602431883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oM+nZFjp3WYiWouKHZCaZYK4Gv2WS94tsYKM21OZ8Ew=;
        b=ZcPhRQMT9l0aRBVYcFrTOqBJGKM/a0siaEB1OEKDN1vecOs7vxB/RUAEuND/ZBUxTrgOm+
        XE5NAJbQP09Rjy9HWMlGgTJ5bLw8UxdZH88dNiiTYNE7e1mUG5nV6XX4gxYklbVyPScO8d
        bL9UKzDSV29RoJvHjOquoXiWWntlKRs=
Date:   Sun, 11 Oct 2020 17:57:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
Message-ID: <20201011155754.GC15925@zn.tnic>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 05:40:27PM +0200, Enric Balletbo i Serra wrote:
> How do you quantify those things are NOT common enough? Do you have a number?

I don't want to change the defconfig - you do. So quantifying is in your
court - not mine.

> I don't have a number, the only I can tell is that both symbols enable support
> for I2C, SPI an HS-UART. The AMD one, is found on AMD Carrizo and later
> chipsets, the Intel one, is found on Intel Skylake and later. I.e Lots of
> laptops need these to have support for the touchpad.

That sounds like a step in the right direction.

> KernelCI is focused on upstream kernel development. KernelCI builds lots of
> different versions of the kernel, including stable kernels, and maintainers
> trees. It does tests on real hardware, so having a config supporting as much as
> possible the x86 hardware that we have in the KernelCI labs will help us to
> increase the test coverage and catch more issues.

So those issues - where do you guys report them? Because I've never seen
one reported by kernelCI, AFAIR. I see 0day bot and syzbot doing such
reports on a regular basis but none from kernelCI AFAIK. Do you send
your bug reports to lkml and Cc the relevant parties?

> Yes, it can. As I said, is a matter of maintenance, if we do this we
> will have a different workflow for x86 hardware.

Lemme get this straight - your workflow would do:

$ make defconfig

and now here you'd have to add a single command:

$ .scripts/kconfig/merge_config.sh -m .config .kernelci.config.snippet

in order to get the symbols you want, enabled.

I've shown this one because this is how those other configs like
kvm_guest.config and xen.config work - they're config snippets and they
get merged with a preexisting config, see scripts/kconfig/Makefile.

Now, is that additional single command worth "hours of maintenance time"
or is it something you can do easily? As in:

	if (x86)
		<command>

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
