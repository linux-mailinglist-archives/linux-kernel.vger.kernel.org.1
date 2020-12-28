Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3182E2E69F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgL1SQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:16:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbgL1SQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:16:31 -0500
Received: from zn.tnic (p200300ec2f07e40085f47ee5beeb4d19.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e400:85f4:7ee5:beeb:4d19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0EAA41EC04D6;
        Mon, 28 Dec 2020 19:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609179349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wufwo2Z1o8oLZgQjB0PcZyvWpV/HYOrROkTn2ihjfXE=;
        b=AcxBaZ/AKQVDO1bLBZsUp74HQWVJnSRjpxJ/xemieNETVVok20ec8HQC/akU8cmnvHQETu
        D19Mw96Mdln8K4ke52tOAK45lrrtH79y8Ka3qc12cfE5YimQHPzydpNLjtNFKqQGGWtN59
        mUwg5oR39w6b3JxDFItZybX2D8vhvJg=
Date:   Mon, 28 Dec 2020 19:15:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <20201228181544.GA20321@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
 <X+JCCqTJkgZASj7T@google.com>
 <20201222192517.GE13463@zn.tnic>
 <X+odFBu+smuDiOcO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X+odFBu+smuDiOcO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:59:48AM -0800, Sean Christopherson wrote:
> Obvious and superfluous for people that are intimately familiar with the code,
> but explicit call stacks are extremely helpful when (re)learning code.

Here's an example:

[    2.649874] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.651774] ------------[ cut here ]------------
[    2.652726] WARNING: CPU: 2 PID: 1 at init/main.c:1436 kernel_init+0x58/0x107
[    2.653643] Modules linked in:
[    2.654260] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc1+ #2
[    2.654396] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    2.655125] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[    2.657687] RIP: 0010:kernel_init+0x58/0x107
[    2.658391] Code: 5e fc ff eb 0c 48 c7 c7 18 bc 09 82 e8 8a a4 fc ff c7 05 a2 5f b0 07 02 00 00 00 e8 a9 1c 9b ff e8 b4 dc 89 ff e8 2f d3 a6 ff <0f> 0b 48 8b 3d 76 87 9d 00 48 85 ff 74 22 e8 ef 19 fc ff 85 c0 89
[    2.660707] RSP: 0018:ffffc90000013f50 EFLAGS: 00010292
[    2.661499] RAX: ffff88800ebcdc01 RBX: ffffffff81837b59 RCX: 0000000000000802
[    2.662469] RDX: 00000000000007f2 RSI: 05b5d427c1a6d18d RDI: 000000000002d100
[    2.663411] RBP: 0000000000000000 R08: 000000000000000d R09: 000000000000000c
[    2.664318] R10: 000000000000000d R11: 0000000000000020 R12: 0000000000000000
[    2.666458] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.667462] FS:  0000000000000000(0000) GS:ffff88807da80000(0000) knlGS:0000000000000000
[    2.668472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.669257] CR2: 0000000000000000 CR3: 000000000220a000 CR4: 00000000003506e0
[    2.670183] Call Trace:
[    2.670723]  ret_from_fork+0x22/0x30
[    2.671340] ---[ end trace 385e10f347736cf9 ]---

Yes, useless. The callstack is not even there.

This is the only line that matters:

[    2.652726] WARNING: CPU: 2 PID: 1 at init/main.c:1436 kernel_init+0x58/0x107

because what caused it is:

diff --git a/init/main.c b/init/main.c
index 6feee7f11eaf..aa52355d98ae 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1433,6 +1433,8 @@ static int __ref kernel_init(void *unused)
 
        do_sysctl_args();
 
+       WARN_ON_ONCE(1);
+
        if (ramdisk_execute_command) {
                ret = run_init_process(ramdisk_execute_command);
                if (!ret)


even if you had a stack trace here, it would be totally useless because
you *know* where it came from.

But ok, I can change the formulation that it is up to the committer's
judgement to decide whether to remove that blurb. Because I definitely
will be removing a useless noise like that before committing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
