Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752C72A3699
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgKBWgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKBWgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:36:51 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893C9C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:36:51 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id v18so14464863ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5uJS/jEKGLUY7/54yb7PsXjkj4P5AmY3KEzFYsfwHE=;
        b=n6SP1ZMbkWoENlJDPiZ38Zcls5wfXCuU3IkRB7Xtq2Wp8wZHPQcxUvJSIZkszw4Jn7
         o12UhWs69zVLd3cN1Az8bfLmqi3RLv5zGfKQ9JY/54iLiTr2Cb9cVvRQwts1P90eOXHm
         0gdiC6U2wt/rGxcRuQE6OioCzZOtIbJDlWWH87qSyG9qU2JpEjrFmoUovx7eLVQ0tCt9
         93W+hxDdSMJXhnuT8n62qY3ogMh+BxPSanvS2UoEa+rO2eorIxW/yzrtWszx6Gb9Ar6/
         hV8bnN/akU4cFVnW6o+qLwYIs6lwmPmzv/CED8tOSn91Uvn8/RplY6TWm3cpuo20Uhgi
         NdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5uJS/jEKGLUY7/54yb7PsXjkj4P5AmY3KEzFYsfwHE=;
        b=bYwBaqLd0lDWiQJM8irWSVvw++7AS0bprl5ahIm0HDH/nguRKvvmY93pUxX3c9FOrG
         t7i0jw8XZW9D/tHI6YYaa/f1BUxwRbxEOh/R5TTTb25uOl76qDNCj4kAsPJB28nw7jiZ
         mUGt1CfK6KFIXXHy+BNeLFRI4ybvsaT+uleqcPXwaAQ1VVdVw2pu2jNR+b6BduEjbSe3
         Fp2QdTcG4jMdiwt7qvvPylHdx+O1uzeaBo4WjF6M6VW+2d1r5KXxKocFcPzbQexu2Gkb
         EeMWQ2iQgfqQzeVuKIRSI+xOLP78xDn2gj3/ll/UTO+vSUwPck/Kw1ZJ1+I2YQ2crOrL
         i9+w==
X-Gm-Message-State: AOAM5308N2PJYGylc2msyWfVl8xsGUm/2jXt6S/ICzTfYacwiNSAaaUU
        YjZXYq9A7XXZZ6MzxR7GD94uUgqvHwJ5NltZshUA2A==
X-Google-Smtp-Source: ABdhPJxyEOymgPpG0rZw8fAZSubOjDL6U1YtbHy3VgZ5EYhSsP0I8io3+caw3bttxxZDVONhTIHsurRHMlzScADBZPo=
X-Received: by 2002:a92:41cf:: with SMTP id o198mr12656899ila.262.1604356610897;
 Mon, 02 Nov 2020 14:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20201025005916.64747-7-luka.kovacic@sartura.hr>
 <20201025005916.64747-6-luka.kovacic@sartura.hr> <20201025005916.64747-5-luka.kovacic@sartura.hr>
 <20201025005916.64747-4-luka.kovacic@sartura.hr> <20201025005916.64747-3-luka.kovacic@sartura.hr>
 <20201025005916.64747-2-luka.kovacic@sartura.hr> <20201025005916.64747-1-luka.kovacic@sartura.hr>
 <20201029180105.GD26053@duo.ucw.cz> <CADZsf3YE3d=dtMVVYHL91Z1WFcpNN4vyJJ6RG7VnJ2V-DqE+wQ@mail.gmail.com>
 <7821443b-ddbc-fc92-b990-14d116dda853@ti.com>
In-Reply-To: <7821443b-ddbc-fc92-b990-14d116dda853@ti.com>
From:   Luka Kovacic <luka.kovacic@sartura.hr>
Date:   Mon, 2 Nov 2020 23:36:39 +0100
Message-ID: <CADZsf3atet+Y7xfCey=R6hk+hQ0Za5Om8PFD7KcS6m3fVaLLFA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Add support for the IEI WT61P803 PUZZLE MCU
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Behun <marek.behun@nic.cz>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 2, 2020 at 7:30 PM Dan Murphy <dmurphy@ti.com> wrote:
>
> Hello
>
> On 11/1/20 3:56 AM, Luka Kovacic wrote:
> > Hello Pavel,
> >
> > On Thu, Oct 29, 2020 at 7:01 PM Pavel Machek <pavel@ucw.cz> wrote:
> >> Hi!
> >>
> >>> +What:                /sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/power_status
> >>> +Date:                September 2020
> >>> +Contact:     Luka Kovacic <luka.kovacic@sartura.hr>
> >>> +Description: (RO) Power status indicates the host platform power on method.
> >>> +             Value mapping (bitwise list):
> >>> +             0x80 - Null
> >>> +             0x40 - Firmware flag
> >>> +             0x20 - Power loss detection flag (powered off)
> >>> +             0x10 - Power loss detection flag (AC mode)
> >>> +             0x08 - Button power on
> >>> +             0x04 - WOL power on
> >>> +             0x02 - RTC alarm power on
> >>> +             0x01 - AC recover power on
> >> It would be nice to put this into standard place somewhere. Many
> >> machines will want to expose this information.
> > As this is specific to this microcontroller and to how it encodes
> > these values, I don't see a need to change this.
> > This isn't used anywhere else.
> >
> >> If not, at least spell out WoL, as it is not that common of acronym.
> > Okay.
>
> WoL is a very common acronym especially in the networking space

By WOL I meant Wake-on-LAN, I will spell out the whole acronym.

>
> But the overall this section does not make sense
>
> The description says that it indicates platform power on method but what
> is NULL power on? There are flags for power loss detection.

I will clarify the value mapping and try to replicate some of these states
so I can write a better description.

>
> Does the RTC mean that the processor real time clock woke up the uC? Or
> that the internal RTC woke up the controller?

These are all related to the platform as a whole.
So the Marvell SoC and all of the required peripherals are turned on.

>
> And for the
> /sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/ac_recovery_status
> what are those values?

These values indicate whether the board has been shut down gracefully and
whether it has been powered on automatically (when power came back) or by
pressing the power button.
I will also extend the documentation with the value mapping for this.

>
> It seems like some ABI's are documented well with formats and others are
> just described without a format.
>
> For instance
>
> /sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/version the format
> of this version is not described but
> /sys/bus/serial/devices/.../iei_wt61p803_puzzle_core/build_info is.

I left out the version format descriptions as they are in the recognizable
format and all of them are quite arbitrary (e.g. v1.000).

>
>
> Dan
>

Kind regards,
Luka
