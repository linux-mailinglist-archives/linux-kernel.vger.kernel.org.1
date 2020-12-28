Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F72E6A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgL1TDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1TDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:03:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B9CC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:02:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so132586pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9L6Dr5sxdezBC4OpmmaOhXe6b4vZdmWSZ6Gdec9tCP8=;
        b=tlT53lzSTmTG0ty6NL+gXCzXXdyL+uu/gbAAfX6K+KenKLJJZCjRylvCcP578eDjkY
         XxJ3NryW9DGB81TCMOnkY5Lyoyh5Kdilynm6T0dirZMzeYaoqstXj8S22uyqOWhVE0Lw
         Fqp5auhuXb+WQrsM1S0l3b7VKx87H6mHWjcSQlZi++XpawjGzGuoj2GoN4uijrEiT6MV
         009OcYvZWt8BA09v4Aq/pft81pxFIHRwntqUWWg4sa/VPV+Vnz1U8r+gq4U8IUDfsFz8
         N7kDqHphYHwO4FdFD2PMOYnBRehyut9UrOTLsSJt8In4LGeVFxYJGFRe4QYm9tOjoqo0
         gevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9L6Dr5sxdezBC4OpmmaOhXe6b4vZdmWSZ6Gdec9tCP8=;
        b=U5VGNxyIAgY/wunF1/z1JrjFiSs7qgyhhJvlZ1D+jR0zXiL5Zybz97nN4dAU/cqiLz
         D7qR/lQ2anLivSDz7R8l0m7krz8J2xGbF0pPPaJgqQ3/WkObomnBPr98RtwBuTbMwVfD
         2XF4DRy8XBAkUwXxhNP3duhdtLI3E2Qqx+cr+HbcabKZw4zNwUZRKJGQpQKJU05vDbBZ
         Jh8yAfWLnZNcNfpOsgmgH9ouDF+KrbJgJly3y8OZZaC32w/r9O/XWjXoeeD39Jhr+zgr
         S2VbrE/Fw+QnDOPXnMcVpxXjTPNTNdmPhpsLPxH2ET+bq5wveCEuF1zusTbeztoC0/XR
         aYYA==
X-Gm-Message-State: AOAM532I3PREiA0VbTbkGiT9u9bemv0jNoNqeMnIBZuw8LOratNuDdsP
        6nP7FBsSOn0Wn/WTTyuPUcuZPg==
X-Google-Smtp-Source: ABdhPJxSxW06v1JsYutv54cB5EFV0+8MEhaqnSGzGgS4+PRrLxsCFBoECynlRw2MapRfxa1mEXYEtw==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr323206pjb.12.1609182142087;
        Mon, 28 Dec 2020 11:02:22 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id a29sm37072233pfr.73.2020.12.28.11.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:02:21 -0800 (PST)
Date:   Mon, 28 Dec 2020 11:02:14 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <X+ortkgzfCfW6wS3@google.com>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
 <X+JCCqTJkgZASj7T@google.com>
 <20201222192517.GE13463@zn.tnic>
 <X+odFBu+smuDiOcO@google.com>
 <20201228181544.GA20321@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228181544.GA20321@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020, Borislav Petkov wrote:
> On Mon, Dec 28, 2020 at 09:59:48AM -0800, Sean Christopherson wrote:
> > Obvious and superfluous for people that are intimately familiar with the code,
> > but explicit call stacks are extremely helpful when (re)learning code.
> 
> Here's an example:
> 
> [    2.649874] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    2.651774] ------------[ cut here ]------------
> [    2.652726] WARNING: CPU: 2 PID: 1 at init/main.c:1436 kernel_init+0x58/0x107
> [    2.653643] Modules linked in:
> [    2.654260] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc1+ #2
> [    2.654396] usb 1-1: new full-speed USB device number 2 using uhci_hcd
> [    2.655125] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> [    2.657687] RIP: 0010:kernel_init+0x58/0x107
> [    2.658391] Code: 5e fc ff eb 0c 48 c7 c7 18 bc 09 82 e8 8a a4 fc ff c7 05 a2 5f b0 07 02 00 00 00 e8 a9 1c 9b ff e8 b4 dc 89 ff e8 2f d3 a6 ff <0f> 0b 48 8b 3d 76 87 9d 00 48 85 ff 74 22 e8 ef 19 fc ff 85 c0 89
> [    2.660707] RSP: 0018:ffffc90000013f50 EFLAGS: 00010292
> [    2.661499] RAX: ffff88800ebcdc01 RBX: ffffffff81837b59 RCX: 0000000000000802
> [    2.662469] RDX: 00000000000007f2 RSI: 05b5d427c1a6d18d RDI: 000000000002d100
> [    2.663411] RBP: 0000000000000000 R08: 000000000000000d R09: 000000000000000c
> [    2.664318] R10: 000000000000000d R11: 0000000000000020 R12: 0000000000000000
> [    2.666458] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    2.667462] FS:  0000000000000000(0000) GS:ffff88807da80000(0000) knlGS:0000000000000000
> [    2.668472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.669257] CR2: 0000000000000000 CR3: 000000000220a000 CR4: 00000000003506e0
> [    2.670183] Call Trace:
> [    2.670723]  ret_from_fork+0x22/0x30
> [    2.671340] ---[ end trace 385e10f347736cf9 ]---
> 
> Yes, useless. The callstack is not even there.
> 
> This is the only line that matters:
> 
> [    2.652726] WARNING: CPU: 2 PID: 1 at init/main.c:1436 kernel_init+0x58/0x107
> 
> because what caused it is:
> 
> diff --git a/init/main.c b/init/main.c
> index 6feee7f11eaf..aa52355d98ae 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1433,6 +1433,8 @@ static int __ref kernel_init(void *unused)
>  
>         do_sysctl_args();
>  
> +       WARN_ON_ONCE(1);
> +
>         if (ramdisk_execute_command) {
>                 ret = run_init_process(ramdisk_execute_command);
>                 if (!ret)
> 
> 
> even if you had a stack trace here, it would be totally useless because
> you *know* where it came from.
> 
> But ok, I can change the formulation that it is up to the committer's
> judgement to decide whether to remove that blurb. Because I definitely
> will be removing a useless noise like that before committing.

I 100% agree in this specific case.  What I'm arguing is that cases like this
where the call stack is completely uninteresting are few and far between.  The
documentation should focus on the common case where, IMO, the call stack should
be included, even if it might be obvious for some/many people.  E.g. similar to
how many kconfig options have something like "If unsure, say Y", I think the
blurb should encourage including the call stack unless the author is 100% sure
that it's useless.
