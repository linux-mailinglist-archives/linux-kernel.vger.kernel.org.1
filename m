Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276EC29E438
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgJ2HgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgJ2HY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E38DC0610E1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 22:57:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u62so2129697iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjvwfAoMwV46SiGdX0h1AO+7TbryedwzCJ/wh+tBt0M=;
        b=aPkcftQ3lRkHIbQDO4N6n0rLkdiaehY7sG1dpc2iVbE6569nfkWwKFt1fa25vc+Sl+
         EuUBHlhE37LOPjHhk6gR3GgFeaEHUnBG4P/duvykO5o5dXMsFrc1qaSsdPv5R1gWUeSg
         Unsjz1AbCkgTQFuo1amwsHxXX4PMwgGf/p1BbQe+AAh8U0BE8Mrv+BmmxV3QxLNSx6FP
         Mz3b5ggFycWiCNHAHpA0UpvS9XtXozbMzmKjUcGXfdfKm+HDktujggb92/dr+exnkSHa
         fz8Nbn/fDYDMyRaoohVV0kOErVEvoApYFroNWGK73+tSUYnt/ap30NW2QPyxUo7tI4Cb
         VyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjvwfAoMwV46SiGdX0h1AO+7TbryedwzCJ/wh+tBt0M=;
        b=AI3G7Maci1YDc8dviPbzUGMBkNiE63pqBUr0T+XNt7AbsEuV2Wj02crmQdb3pzoArG
         8/7y26acPWaMPs3uYDupv4UU2nzXd1nifiKbV4Q1gxW1fnGoCXjC60U/REsqJIyo+0OI
         HRSEp5YWJ7pw5os+Ueu2C8HhSfJk/+/5xHsaEimr4+T0CRxvnvVh+H0OxkCkGpUXWnxU
         Wgr7mEoHPKvIUp3OWApYQ9XCvUn718lPrCmFPcWFRAANVs6CTrQc9IZJD0ehBJj9iKwR
         c/86uUhz4qv9yYTCRb2N31TWuYjiYQMuRTczAc7z1pJWRwJdY1jupMogCCNPde6MMoT+
         BUdg==
X-Gm-Message-State: AOAM533ABtntwo9lOGRuknzUEDMOAhfCKff4zfncOpVU5KNJxHbvws4S
        wXKkYy45Lr1/JGwc4gzPA1Sitf2mR9tzZtv9lXU=
X-Google-Smtp-Source: ABdhPJzJIANFtM8B5/G178o4UAKcy+iHEyBDA4j01j4qnaAvw+UdNi0dNV/87j+XLAfa7KZigF+L8VNKE9tAysBx1NE=
X-Received: by 2002:a02:a798:: with SMTP id e24mr2281570jaj.105.1603951035631;
 Wed, 28 Oct 2020 22:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201028152717.8967-1-cai@redhat.com>
In-Reply-To: <20201028152717.8967-1-cai@redhat.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 29 Oct 2020 16:57:04 +1100
Message-ID: <CAOSf1CGQALrEA9wHK8usbqfeRSOKYXRK3d=D7Qh=YOM8ifHwGA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/eeh_cache: Fix a possible debugfs deadlock
To:     Qian Cai <cai@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:27 AM Qian Cai <cai@redhat.com> wrote:
>
> Lockdep complains that a possible deadlock below in
> eeh_addr_cache_show() because it is acquiring a lock with IRQ enabled,
> but eeh_addr_cache_insert_dev() needs to acquire the same lock with IRQ
> disabled. Let's just make eeh_addr_cache_show() acquire the lock with
> IRQ disabled as well.
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&pci_io_addr_cache_root.piar_lock);
>                                 local_irq_disable();
>                                 lock(&tp->lock);
>                                 lock(&pci_io_addr_cache_root.piar_lock);
>    <Interrupt>
>      lock(&tp->lock);
>
>   *** DEADLOCK ***
>
>   lock_acquire+0x140/0x5f0
>   _raw_spin_lock_irqsave+0x64/0xb0
>   eeh_addr_cache_insert_dev+0x48/0x390
>   eeh_probe_device+0xb8/0x1a0
>   pnv_pcibios_bus_add_device+0x3c/0x80
>   pcibios_bus_add_device+0x118/0x290
>   pci_bus_add_device+0x28/0xe0
>   pci_bus_add_devices+0x54/0xb0
>   pcibios_init+0xc4/0x124
>   do_one_initcall+0xac/0x528
>   kernel_init_freeable+0x35c/0x3fc
>   kernel_init+0x24/0x148
>   ret_from_kernel_thread+0x5c/0x80
>
>   lock_acquire+0x140/0x5f0
>   _raw_spin_lock+0x4c/0x70
>   eeh_addr_cache_show+0x38/0x110
>   seq_read+0x1a0/0x660
>   vfs_read+0xc8/0x1f0
>   ksys_read+0x74/0x130
>   system_call_exception+0xf8/0x1d0
>   system_call_common+0xe8/0x218
>
> Fixes: 5ca85ae6318d ("powerpc/eeh_cache: Add a way to dump the EEH address cache")
> Signed-off-by: Qian Cai <cai@redhat.com>

Good catch,

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
