Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2BF282634
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgJCTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJCTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:30:12 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757FC0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 12:30:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o18so4375462ilg.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZ1DkwSWJLJyYMYsQtbtyLF9BA7njwH8/m0Qh4QFyf0=;
        b=A5vNPlSg4HijI19FL1wcWgBkX6IvHjg0QVpuOEIfTEA8iQ0aoSLXQjpE1OgWypVbho
         jrGD4HJhrSprVjPwFBbkNvqHTimfJ/SMXv9HCiSUnn+SqDmpfAZ0Wz8fkZAOjEymHokx
         h3AXG6fpmmeQxZAFyfiAISkonpgr48kELwII8iJiaQo+G414Yq1El+YlpLbkmu80kMzq
         1hze753ZMN1gzExfSrewSMxGEM6bzc5RmgV71myGJR4b2smD3yWwJUDcsFvFe/kfs/g9
         b1InsD0t6ubXRm/B4DQ0rn2qvgqsjakMb9HchoRwzEGcuO2uEvuRmDKzrit7IBboXv6d
         o2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZ1DkwSWJLJyYMYsQtbtyLF9BA7njwH8/m0Qh4QFyf0=;
        b=MUobDtNufzCmaKdqmJl5SMi/38SB81yDf6nEmOuRMNBevE11VL1o3xj6Rzf7MykbUX
         HPa9Paw+JXFcHnL3kR+LiWqOYXMT9Kg9i3M47K+5vFfYt5Tqqi2Oasy+WpBwvfhzVYWC
         p2Ifru9pZ130homRpjl1I/aV1T9tfvBXOdqvghsPT82WXAeaZD41FldEBCsTjSxuvPVp
         jyHvnQAuPlYF4A3T6NW7AoWQMxP+iZCU0d6k5mNCQUF0D3tuBkIHZwG4N9a3W2SFRCMw
         LWNV/9sTf9nkt1NzXzlqFiFOd1PB2GPn033e+wZPk8Pmf+PA/r7L5drBSjKXf62E/C8B
         rytQ==
X-Gm-Message-State: AOAM530TWPbHNkiS1NAk4M6+E7k2O+ORKkQR38nkiHrmp7ackBJpIY4D
        9ypVFGdN4Ixc6QisC6uFEibjEWa0bMnptFrQQxjhtg==
X-Google-Smtp-Source: ABdhPJxKg0IoqJI26FZ9A3MzYx9uR79rmwvgiHj4d/z29C+q8n+2BLlXrFyK67G4mAxZaLLsKBj31wLjA7e6avXfkws=
X-Received: by 2002:a92:6403:: with SMTP id y3mr6327624ilb.72.1601753409817;
 Sat, 03 Oct 2020 12:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200920160705.9651-1-krzk@kernel.org> <20200920160705.9651-5-krzk@kernel.org>
 <20200926195026.GA2230@lx2k>
In-Reply-To: <20200926195026.GA2230@lx2k>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 3 Oct 2020 21:29:58 +0200
Message-ID: <CAOesGMgQ67n1F-od-amKN8MuG75V3euOhEwdyYryQSQyWH3TBQ@mail.gmail.com>
Subject: Re: [GIT PULL 4/5] ARM: samsung: mach/soc for v5.10
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM-SoC Maintainers <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 9:29 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Sun, Sep 20, 2020 at 06:07:04PM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > This will conflict around renamed/moved files:
> >
> > 1. arch/arm/mach-s3c/s3c24xx.c:
> >    Merge both changes to new location, so:
> > =======
> >  +#include "s3c24xx.h"
> >  +#include "fb-core-s3c24xx.h"
> >  +#include "nand-core-s3c24xx.h"
> >  +#include "spi-core-s3c24xx.h"
> >
> > - static struct map_desc s3c2416_iodesc[] __initdata = {
> > + static struct map_desc s3c2416_iodesc[] __initdata __maybe_unused = {
> > =======
> >
> > 2. drivers/soc/samsung/Kconfig
> >    Add DEBUG_LL && MMU to SAMSUNG_PM_DEBUG section, so:
> >
> > =======
> >   config EXYNOS_PM_DOMAINS
> >       bool "Exynos PM domains" if COMPILE_TEST
> >  -    depends on PM_GENERIC_DOMAINS || COMPILE_TEST
> >  +    depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
> >  +
> >  +config SAMSUNG_PM_DEBUG
> >  +    bool "Samsung PM Suspend debug"
> >  +    depends on PM && DEBUG_KERNEL
> >  +    depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
> >  +    depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
> > ++    depends on DEBUG_LL && MMU
> >  +    help
> >  +      Say Y here if you want verbose debugging from the PM Suspend and
> >  +      Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
> >  +      for more information.
> >  +
> > =======
>
> I don't mind doing this conflict resolution, and will merge it now,
> but next time you can just base this branch on the cleanup branch.

Apologies for sitting on this email, I flush the outbound queue by
hand and seem to have forgotten. :)


-Olof
