Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1228A98B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgJKTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 15:06:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgJKTGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 15:06:32 -0400
Received: from zn.tnic (p200300ec2f235400da461b0b2cbca2d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:5400:da46:1b0b:2cbc:a2d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E20021EC0407;
        Sun, 11 Oct 2020 21:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602443191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mDBvvNkTEmEIc1rgmGJ+DMSXW8TQIiaUaad2vdSqBbY=;
        b=RGXXiXQy1I00Qn9c5Knu1YuZX0+dqACHd6C0GnR+IizDEVZnkono2gpbRG7hatiGz+1Gf+
        RwJ8K4hjQgnoivFtpMraHCKIhQgb9gaXNZHTKkJRRztCnf8cPr0YKakJTW2t+sMq5FL2Y5
        nYQDpfZ6pfOqBS66KJucXda/KmpI9/w=
Date:   Sun, 11 Oct 2020 21:06:22 +0200
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
Message-ID: <20201011190622.GD15925@zn.tnic>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
 <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 07:05:55PM +0200, Enric Balletbo i Serra wrote:
> For x86:
>    1. You send a patch to list enabling the CONFIG_YOUR_V4L2_DEVICE=m
>    2. The patch is rejected because doesn't fit the requirements (is not common
> enough)

Well, what if that config option enables hardware which is ARM-only.
Then it doesn't make any sense to enable it in the x86 defconfig.

>    3. If you're lucky someone will tell you to send the patch, to the specific
> KernelCI x86 fragment project.

You lost me here: there's a specific fragment project?!?

>    4. You send a patch to the separate KernelCI x86 project.
>    5. The patch is accepted and merged.
>    6. KernelCI builds linux-next, boots the kernel on the hardware, detects a
> new v4l2 device, and runs the v4l2-compliance tests.
> 
> 
> Of course you can skip 1-3 if you know already that. Another example:

So this second example confused me even more. Looking at your original
patch, you want this enabled in the defconfig:

config SERIAL_8250_DW
        tristate "Support for Synopsys DesignWare 8250 quirks"
        depends on SERIAL_8250
        select SERIAL_8250_DWLIB
        help
          Selecting this option will enable handling of the extra features
          present in the Synopsys DesignWare APB UART.

and for that you need those other two: X86_AMD_PLATFORM_DEVICE and
MFD_INTEL.

What I don't get is why can't you have a .config.snippet which enables
what you need on the chromebooks and you can have all the serial you
want. And the net card driver for that matter.

And in all that, I still don't get why this is relevant for the upstream
kernel.

By this logic, other projects would start wanting to add more to
defconfig and which would slowly turn into an allmodconfig. So you can
simply build an allmodconfig kernel and do *all* your testing with it,
just like the distros ship an allmodconfig-like kernel. Problem solved.

/me is more confused.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
