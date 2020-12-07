Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791CA2D0D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLGJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLGJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:46:37 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93FC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:45:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id i15so6907523ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ualberta-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWYoIWxpCmo6KzJfX9qCa6VdZF/5eI5RLo1WskkrQDI=;
        b=Q67VzEcw9PbNd7YVqB6DDDpj5BLiNxYRqnrbEHsfE6l6CXGirfeSPT8Wq9Tbgp/76z
         N9B8ndaGSCVUgkrkAp8OD7xRGU1zOiPSPvEW1mjMNL9+lymJZ8qZrQBSPccD36UElrGO
         rPbjCXyQNXaEpb1ARQ2XnUNr10cTMKi3Y3YhtaZsCSyXhQrnKjww5ye4boX+d7LhrRS3
         DGnMi9/PeJNi3rPkVAM1xa7hbPH3oobYuIyStFTKldVHEGZAmrssGpfFh4bVCfKI2ooo
         5qdbgrUfoQOOlwFsr+UAVlWHpLTksdJpW0XKSba0KlE4AcYLH7EFW5ReLXX9VfWM7zg1
         lYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWYoIWxpCmo6KzJfX9qCa6VdZF/5eI5RLo1WskkrQDI=;
        b=jgNVfTOEoZRhPRbDgYqR4ZG7MRE7QXhR+IUF1OhSMa9bTMi8GsbpXvE43w9ks7tJp3
         tBotKMcH+LgMCdl6euJd+l9wSZm05BhOLx0bVrlozoiAQdRVMmxCZK+M3i00z/Uku8mT
         OXNGREcpIo0KLaZdbblS+UAQ+syhpg9AxbMkm+J9mMYlDzmlwKzzpMH0jC5J5k5+byO6
         ZNLefCG5a/YB0nAaOaMghtC3BV5FqkpfXc77hCAuj/tDpvmrxMRutuW+/kvwfbFECL+F
         SRGC+G1DHsl+iFVvtWxJwoLT5yUVgLOj1obarEUZCXS4YA16CZH99XmnC3yHNjOggmvb
         OEyA==
X-Gm-Message-State: AOAM530VkrrSDQRX9r/T3WbMSvrfhJUvcAo+r4wMl/BSxoIFKwnBa8Yl
        3u2Kuyu4oxH558tpHyhbo4Q2CDkK8At2Mp9zGJ7aWQ==
X-Google-Smtp-Source: ABdhPJxJmqbSWnTX2EnST6a9FR+p8aLo/rPoQUButCI/b345de7HSxXAmB4Q56WVheqifO3bRs2fRbPHpEfax+Ksr6U=
X-Received: by 2002:a2e:7a0d:: with SMTP id v13mr8376643ljc.348.1607334355676;
 Mon, 07 Dec 2020 01:45:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJWrxn12rrMtomPUcu4GsDeTe5vpGKsR-F6=hM1Y8a=iAY+gag@mail.gmail.com>
 <56e933e4-a495-1497-eb48-b9b8f0da46d3@redhat.com>
In-Reply-To: <56e933e4-a495-1497-eb48-b9b8f0da46d3@redhat.com>
From:   Elias Carter <edcarter@ualberta.ca>
Date:   Mon, 7 Dec 2020 01:45:39 -0800
Message-ID: <CAJWrxn2+KL_O=cjDuhzpmVf7qPzr_Vx-eAmA3+8wg_CJS-LZag@mail.gmail.com>
Subject: Re: 5.10 RC 7: grub2 out of memory
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>What's the size difference between old vs. new kernel and old vs. new
initrd?

The new initrd is over twice as large as the old one, the kernels
appear to be similar sizes:
elias@elias-5600X:~$ ll -h /boot/
total 435M
drwxr-xr-x  4 root root 4.0K Dec  7 01:31 ./
drwxr-xr-x 23 root root 4.0K Dec  6 23:15 ../
-rw-r--r--  1 root root 160K Dec  7 01:31 config-5.10.0-rc7
-rw-r--r--  1 root root 243K Dec  7 00:11 config-5.10.0-rc7.old
-rw-r--r--  1 root root 233K Apr 20  2020 config-5.4.0-26-generic
-rw-r--r--  1 root root 233K Nov 23 10:06 config-5.4.0-56-generic
drwx------  3 root root 4.0K Dec 31  1969 efi/
drwxr-xr-x  4 root root 4.0K Dec  7 01:31 grub/
lrwxrwxrwx  1 root root   27 Dec  7 00:01 initrd.img ->
initrd.img-5.4.0-56-generic
-rw-r--r--  1 root root 206M Dec  7 01:31 initrd.img-5.10.0-rc7
-rw-r--r--  1 root root  82M Dec  6 23:23 initrd.img-5.4.0-26-generic
-rw-r--r--  1 root root  82M Dec  7 00:01 initrd.img-5.4.0-56-generic
lrwxrwxrwx  1 root root   21 Dec  7 00:01 initrd.img.old ->
initrd.img-5.10.0-rc7
-rw-r--r--  1 root root 5.3M Dec  7 01:31 System.map-5.10.0-rc7
-rw-r--r--  1 root root 5.5M Dec  7 00:11 System.map-5.10.0-rc7.old
-rw-------  1 root root 4.6M Apr 20  2020 System.map-5.4.0-26-generic
-rw-------  1 root root 4.6M Nov 23 10:06 System.map-5.4.0-56-generic
lrwxrwxrwx  1 root root   18 Dec  7 01:31 vmlinuz -> vmlinuz-5.10.0-rc7
-rw-r--r--  1 root root  12M Dec  7 01:31 vmlinuz-5.10.0-rc7
-rw-r--r--  1 root root  12M Dec  7 00:11 vmlinuz-5.10.0-rc7.old
-rw-r--r--  1 root root  12M Jun 24 11:59 vmlinuz-5.4.0-26-generic
-rw-------  1 root root  12M Nov 23 10:10 vmlinuz-5.4.0-56-generic
lrwxrwxrwx  1 root root   22 Dec  7 01:31 vmlinuz.old -> vmlinuz-5.10.0-rc7.old


> Which distro/grub2 version etc are
you running?
Linux Mint 20 Cinnamon.

elias@elias-5600X:~$ grub-install --version
grub-install (GRUB) 2.04-1ubuntu26.7


Thanks,
Elias

On Mon, Dec 7, 2020 at 1:38 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.12.20 10:16, Elias Carter wrote:
> > I just compiled and installed 5.10 RC 7 and got a message from grub2:
> > "out of memory, press any key to continue" shortly followed by a
> > kernel panic (see attached screenshot).
> >
> > The 5.4.0-56-generic kernel from Ubuntu works on my machine fine.
> >
> > Things I have tried so far:
> > - setting grub video mode to "console"
> > - setting grub video resolution to 800x600
> > - regenerating the initramfs for 5.10 RC 7
> > - verifying that /boot has free space
> > - changing boot mode from UEFI to legacy BIOS
> >
> > I have attached the following:
> > 1.) dmesg ran from using the 5.4 kernel (since I cant boot into 5.10 RC 7)
> > 2.) my 5.10 RC 7 kernel .config
> > 3.) screenshot of kernel panic after "out of memory" grub2 message
> > 4.) my /etc/default/grub
> >
> > Please let me know if you would like any more information or testing of patches.
>
> The kernel crashes because it's unable to mount root - I suspect the
> initrd is not loaded, because I would have expected systemd messages
> before trying to mount root (after loading additional drivers from the
> initrd). I assume grub2 fails to load the (now too big?) initrd - you
> could try compiling out debug symbols and give it a try.
>
> What's the size difference between old vs. new kernel and old vs. new
> initrd?
>
>
> Similar report for aarch64 was at
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1615969
>
> which turned out to be a grub2 issue. Which distro/grub2 version etc are
> you running?
>
> --
> Thanks,
>
> David / dhildenb
>
