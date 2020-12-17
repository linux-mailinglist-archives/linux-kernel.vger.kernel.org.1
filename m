Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F82DCD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgLQIIG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Dec 2020 03:08:06 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45267 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLQIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:08:02 -0500
Received: by mail-ot1-f45.google.com with SMTP id h18so26457054otq.12;
        Thu, 17 Dec 2020 00:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tkFy9mJST+o3B7vG/V4z83NcOP4SSGZ/hCmmqk0Qf38=;
        b=qjJU7mTtQ3K2xGVROfza7KU5p9WDz3UfFLiqTTW58tWuSdUFIuTgQqrfe7Ayym+3VX
         fdi20DDHLAgqGenjb+HZ8IUehPaGdHGF0kBwvKXvnR7pRpyt823tQL9qUMwMcizTMiP2
         s7Y7MaQI3SMGTh+ze7r5Xy4jwRD8k7fyM4uwjO4yJFjLGgjlywzD42GcngXhGAyrGllA
         18KrdRSY8uHlsFWeUxRexoIoAZMXAvKehzO7ay0ygc8wdP2SJBN2+71gF9rPaGA3v79I
         AMZ5GMnTpYbF68LS71XsxDR7ynO1NNsFrVsvuzggwko/WY6DfkpXzdH7S5JKg9O+pu2v
         U5yQ==
X-Gm-Message-State: AOAM5309519cNfy4lU5hojL0krzvYpOs7GW342i94GO2rDyOEgoFmsWZ
        9WOcfFqVSHxneA7A7qVxNTmwPAInVi7IAkFdFXl+c4ua
X-Google-Smtp-Source: ABdhPJwAIeans41vmhpNH6kitcJUMZ09kGre2a0cti8wiz7KJJCmpMW2MsMcjCcCKvXFBXJyiOzAYiss5fsTrJlJG/8=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr28576107oth.250.1608192441465;
 Thu, 17 Dec 2020 00:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20201216163103.GA59351@roeck-us.net> <CAGMNF6V-w47SDAUgVAtG+Xrp0ECNOvVV1Xy5=FsXTwqc-c3NbQ@mail.gmail.com>
 <20201216201747.GB68047@roeck-us.net>
In-Reply-To: <20201216201747.GB68047@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Dec 2020 09:07:10 +0100
Message-ID: <CAMuHMdWRGs+q1vFr+H__nq-frU-ohwvEca32s721W7h=WQH=5g@mail.gmail.com>
Subject: Re: [PATCH] hwmon: SENSORS_SBTSI should depend on X86
To:     Kun Yi <kunyi@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kun, Günter,

On Wed, Dec 16, 2020 at 9:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Dec 16, 2020 at 09:27:28AM -0800, Kun Yi wrote:
> > On Wed, Dec 16, 2020 at 8:31 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Wed, Dec 16, 2020 at 02:46:41PM +0100, Geert Uytterhoeven wrote:
> > > > The AMD SB Temperature Sensor Interface (SB-TSI) is only present on AMD
> > > > X86 SoCs.  Hence add a dependency on X86, to prevent asking the user
> > > > about this driver when configuring a kernel without AMD X86 platform
> > > > support.
> >
> > Sorry, I think there is some confusion. AMD SoC is a 'remote sensor',
> > or the client, whereas the device using the SB-TSI hwmon driver is the
> > master.
> > In industry, a typical scenario is ARM-based Board Management
> > Controllers (BMCs) using SB-TSI to monitor the host CPU temperature.

Thanks for the explanation!

> Ah, good point. I'll drop this patch.

Agreed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
