Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540142FE3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbhAUHV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbhAUHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:19:03 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C7C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:17:56 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e22so2118154iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvUB6aKTOzb1ncLTrU4MC8B0a/Xf0eV3JbdY7KR8XWI=;
        b=QwVlgg8H6YaIXQT8K3QbhZQTqbg+fz1+f8csutbYeK0afl43h35YReYeN7eW0fK7uM
         cKKo4VHjgH0wfjQJ/0bHJqJR5ZLU1zmy1t8aS2f4SnwCza3+QJKLdP3IrUq9Ds9BdDia
         bwXPDY26PwIHrJu6ccb3XvEV9wkek0iOJl5R5N/ptYEnf8h1AkmMMPVavUTSzJ4VIbyY
         hf87LxPVQv4SBjrFWEV8s3T6sipvBuG6jj5fp63VzQbBlg/ZQPLVUrVgDf9NeCD3U2mT
         5kwSHK1LHp8cwvAQ+ENR2VJbtAyElHXd2rWyliC0FoH7HHagDNOdfCKwh2zP6rl1MEf7
         B/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvUB6aKTOzb1ncLTrU4MC8B0a/Xf0eV3JbdY7KR8XWI=;
        b=mcfiqw6EGaLYOmxOEq6jor1b9oTyKTVIITifNUAwZmevfJLfqq1YTMqI8BGRMsar07
         HDnMHmKwc9OoB40WJw2wggwMw7Vofiq23hS4ny4+T8Dn2B1coA7wHYdqKk+I6+CDuGrn
         IQC+vLYs0xY/7M0beD/q0zXhGesvMT4aCzjVZnoDqs+NVOVba0XUU+mAZFS0MLDA3iWK
         pxd8s0JraeJKv1ycHXcDuGtjDbjGQdV0yUSc3P3xmFIpVjRZSbxyRkKHpfoWJnJlHW9t
         rOep1c7iLjzI0+h9nLJgUvQbMp9TZ8a2uTQ2il3DTa1im7SXQb5ycXWhMJtZmxoYpwUs
         BLpQ==
X-Gm-Message-State: AOAM532+JQbGXHJevIE3mnCmtJrerXsJmiHBi8Qc/oZEp6AWR3hkOdHn
        52eYT1MB6VQpgXj8hBG19Rj/LW9yn0OB6FfwTnOoImfFxlZMRg==
X-Google-Smtp-Source: ABdhPJwgRob+ZjxdJAWZNxtHrVKFw7ZkLEMIbc6KQ7HYWxcfM4fkRI2BTyyG9XtnH6owVm+gjLQlUk2Q+xSGkAr+Odw=
X-Received: by 2002:a6b:d804:: with SMTP id y4mr9243979iob.141.1611213475934;
 Wed, 20 Jan 2021 23:17:55 -0800 (PST)
MIME-Version: 1.0
References: <CAAH8bW8-6Dp29fe6rrnA4eL1vo+mu0HuAVJ-5yjbwxDSvaHdeQ@mail.gmail.com>
 <6c442012-3bef-321b-bbc3-09c54608661f@infradead.org>
In-Reply-To: <6c442012-3bef-321b-bbc3-09c54608661f@infradead.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 20 Jan 2021 23:17:45 -0800
Message-ID: <CAAH8bW-az-WSnbHshwmFuu=oANiZyVKCZ+dHoN119Cy-5KftMA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix AKEBONO build failures
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/20/21 1:29 PM, Yury Norov wrote:
> > Hi all,
> >
> > I found the power pc build broken on today's
> > linux-next (647060f3b592).
>
> Darn, I was building linux-5.11-rc4.
>
> I'll try linux-next after I send this.
>
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fulfill AKEBONO Kconfig requirements.
>
> Fixes these Kconfig warnings (and more) and fixes the subsequent
> build errors:
>
> WARNING: unmet direct dependencies detected for NETDEVICES
>   Depends on [n]: NET [=n]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> WARNING: unmet direct dependencies detected for MMC_SDHCI
>   Depends on [n]: MMC [=n] && HAS_DMA [=y]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- lnx-511-rc4.orig/arch/powerpc/platforms/44x/Kconfig
> +++ lnx-511-rc4/arch/powerpc/platforms/44x/Kconfig
> @@ -206,6 +206,7 @@ config AKEBONO
>         select PPC4xx_HSTA_MSI
>         select I2C
>         select I2C_IBM_IIC
> +       select NET
>         select NETDEVICES
>         select ETHERNET
>         select NET_VENDOR_IBM
> @@ -213,6 +214,7 @@ config AKEBONO
>         select USB if USB_SUPPORT
>         select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
>         select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
> +       select MMC
>         select MMC_SDHCI
>         select MMC_SDHCI_PLTFM
>         select ATA

Looks working, thanks.

Tested-by: Yury Norov <yury.norov@gmail.com>
