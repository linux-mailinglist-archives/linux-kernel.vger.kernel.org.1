Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931D02FD6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404163AbhATRQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391278AbhATRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:08:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:07:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b5so2592693pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+akV9+498hWAyHQj1gJxVNZ06aod6fZIAeKpazBamJ8=;
        b=tD6Q6bhhstouDPVfYjGCPiyMS/q01Qua1A3dSQXRRD1e/pgrTi5en2FuYh6KAFa8/o
         aoZFFS57zhqrVKZE4cIalUJ35Gd5wFEcCQNrdrGZJ/4FNFsu5Dj6pvnuZNt0NkOqzXZJ
         f9yNnXMKnMXTrCkSjkhN8SRv1OKlEdV/lGkM8bw42K4TdUp4lAK7VitZT0pYi9E7JPQE
         yabaeBfGVm7/01IsQhhD0MPMPgQ+cUBtBgzs3Hjs/94S0MC5ba6MPzRDIg2LKyw6j6eM
         4WKkOZNWLd9WRSJF0+5LkC8Rn7acIwf6W04OVZ2tToeHDE1nwZAyYy40vKeTOa+AlEON
         mnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+akV9+498hWAyHQj1gJxVNZ06aod6fZIAeKpazBamJ8=;
        b=AQeIGNPnUFqGtnD5mSyVmWaiCRTtFSciQjKF3ZKtdq/ij0YBgLmSf+xRY+puL5G2pQ
         vsbSPK6TosNSimKRcSRp/scK3kKxHLNFc3GI+KwwMIN7I2uUb7QxxmHRXXYeyO4hG+Gx
         iaNbClkPD2cRj+Fyx1eM9RiJVxGURorKmInjIQF6pTquJ4N/NF1hoTD5s7z+LWEuYT+q
         +dxms/Q/CJ7mIkYc9dnUOD29ClNCoGYHpQbVfSbElcg/VM6VYMH7Z3haOnTug29FfuTK
         uX9NRh7ogY8Hbez55dfL2yrLF51Bym8rqAXn38Ava/aIKTQ/Tex9n1cFC250lBo57FVL
         g65w==
X-Gm-Message-State: AOAM530t5wco5wZdnH68KXpn2bmKsN5+zRPs1XJn64KYGFitG88m3tJ1
        ET2C3foX1RcHK1nbkxZdmg3lIKkErXZV5dBRj83Iw3T4S7XaPA==
X-Google-Smtp-Source: ABdhPJxei248SQTiwFaDKDsBZRlcAASfDxW4cdLAd6y9GUG2KWsJG3YwHfaaLIkzcxLIBQg3NXifrBLl9dicD1N9Fs0=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr6769396pja.228.1611162471139;
 Wed, 20 Jan 2021 09:07:51 -0800 (PST)
MIME-Version: 1.0
References: <faa7532b-e345-c125-4db9-13d3b6bc372f@oracle.com>
In-Reply-To: <faa7532b-e345-c125-4db9-13d3b6bc372f@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jan 2021 19:08:40 +0200
Message-ID: <CAHp75VfqCKiHiQsxRHshtQXe9mcQNcdgdvt8zK+kjnNzXP6qwg@mail.gmail.com>
Subject: Re: PVPANIC PCI driver
To:     Mihai Carabas <mihai.carabas@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Hao <peng.hao2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: LKML and Peng

On Wed, Jan 20, 2021 at 6:48 PM Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> Hello Andy,
>
> Some time ago you have created a patchset where you have combined
> ACPI/MMIO into a single driver for pvpanic:
>
> commit f104060813fe79350565b68c1098fcea050a6504
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Wed Dec 9 22:36:41 2020 +0200
>
>       misc: pvpanic: Combine ACPI and platform drivers
>
> I also have sent some patches where I created a driver framework for
> adding a PCI driver. These being said, I want to send again another
> patchset to add a PVPANIC PCI driver, but I am not sure what is the
> right approach you would like to see:
> - create a totally different driver for pvpanic pci and naming it
> pvpanic-pci.c with its config PVPANIC_PCI
> - create the framework I have sent before but having only two buses
> (ACPI/MMIO in one file and PCI in another)

Generic approach is to have three files:
 - core part
 - platform driver
 - PCI driver

in this case.

> In qemu they are basically two different devices (one is -device pvpanic
> and the other is -device pvpanic-pci)
>
> I could not find any precedence in other drivers. Your input is welcome.


-- 
With Best Regards,
Andy Shevchenko
