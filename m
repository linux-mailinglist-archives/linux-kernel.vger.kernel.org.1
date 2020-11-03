Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B482A446E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgKCLoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:44:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57214 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKCLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:44:11 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id E7A7820C1713
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 03:44:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7A7820C1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604403850;
        bh=37ChBpsbVjcfTyXaezJtJ5UnNPk/LUKQFX519mQ46jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S40pzj4z7zAJcfObKQ+IE+eQQT1WJUJ0gaMHMEn/KQqw7cKKjeScUsbfiDmrAwXW2
         iHCsER+v1h73oenAfK5vHkHveBlXQzpaKq0lgDZlGKZYH/gquui1UdheilV8XWM3S2
         6LPuLTwHrEx7nw6cwx4OmLqeX8Tt/D5EWQS3fdk0=
Received: by mail-qk1-f176.google.com with SMTP id s14so14255307qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 03:44:09 -0800 (PST)
X-Gm-Message-State: AOAM531bOvIwukVWSJ/jOQQbBv8kXNwT95JtD/bIUql5YCicKvC/AoB3
        82I8NKPIH8P6M8EZGhq+grrlvsGCwy9UPneDepg=
X-Google-Smtp-Source: ABdhPJx3hhs5D0RVItSKDm3AIiXH8xRxlpQW2R7DDDG51LAtMFtFDouyJAZ8UhCKEQ8uvQ6GQDWH0ffkRxOIut/9BJA=
X-Received: by 2002:a37:508:: with SMTP id 8mr18956658qkf.207.1604403848891;
 Tue, 03 Nov 2020 03:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20201027133545.58625-1-mcroce@linux.microsoft.com>
 <20201027133545.58625-3-mcroce@linux.microsoft.com> <20201030143049.GE1602@alley>
 <CAFnufp2zSsESBK-ZfCJD5dFzMGc9pU4R-VT1j8eu1f4xPde19w@mail.gmail.com> <20201102110107.GG20201@alley>
In-Reply-To: <20201102110107.GG20201@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 12:43:32 +0100
X-Gmail-Original-Message-ID: <CAFnufp3tOKOB=xqe8Ln46n2wBFMDC4XoZpu51xk5B=Acp=L-JA@mail.gmail.com>
Message-ID: <CAFnufp3tOKOB=xqe8Ln46n2wBFMDC4XoZpu51xk5B=Acp=L-JA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reboot: fix parsing of reboot cpu number
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 12:01 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sun 2020-11-01 02:57:40, Matteo Croce wrote:
> > On Fri, Oct 30, 2020 at 3:30 PM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Tue 2020-10-27 14:35:45, Matteo Croce wrote:
> > > > From: Matteo Croce <mcroce@microsoft.com>
> > > >
> > > > The kernel cmdline reboot= argument allows to specify the CPU used
> > > > for rebooting, with the syntax `s####` among the other flags, e.g.
> > > >
> > > >   reboot=soft,s4
> > > >   reboot=warm,s31,force
> > > >
> > > > In the early days the parsing was done with simple_strtoul(), later
> > > > deprecated in favor of the safer kstrtoint() which handles overflow.
> > > >
> > > > But kstrtoint() returns -EINVAL if there are non-digit characters
> > > > in a string, so if this flag is not the last given, it's silently
> > > > ignored as well as the subsequent ones.
> > > >
> > > > To fix it, revert the usage of simple_strtoul(), which is no longer
> > > > deprecated, and restore the old behaviour.
> > > >
> > > > While at it, merge two identical code blocks into one.
> > >
> > > > --- a/kernel/reboot.c
> > > > +++ b/kernel/reboot.c
> > > > @@ -552,25 +552,19 @@ static int __init reboot_setup(char *str)
> > > >
> > > >               case 's':
> > > >               {
> > > > -                     int rc;
> > > > -
> > > > -                     if (isdigit(*(str+1))) {
> > > > -                             rc = kstrtoint(str+1, 0, &reboot_cpu);
> > > > -                             if (rc)
> > > > -                                     return rc;
> > > > -                             if (reboot_cpu >= num_possible_cpus()) {
> > > > -                                     reboot_cpu = 0;
> > > > -                                     return -ERANGE;
> > > > -                             }
> > > > -                     } else if (str[1] == 'm' && str[2] == 'p' &&
> > > > -                                isdigit(*(str+3))) {
> > > > -                             rc = kstrtoint(str+3, 0, &reboot_cpu);
> > > > -                             if (rc)
> > > > -                                     return rc;
> > > > -                             if (reboot_cpu >= num_possible_cpus()) {
> > > > -                                     reboot_cpu = 0;
> > >
> > >                                                      ^^^^^^
> > >
> > > > +                     int cpu;
> > > > +
> > > > +                     /*
> > > > +                      * reboot_cpu is s[mp]#### with #### being the processor
> > > > +                      * to be used for rebooting. Skip 's' or 'smp' prefix.
> > > > +                      */
> > > > +                     str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
> > > > +
> > > > +                     if (isdigit(str[0])) {
> > > > +                             cpu = simple_strtoul(str, NULL, 0);
> > > > +                             if (cpu >= num_possible_cpus())
> > > >                                       return -ERANGE;
> > > > -                             }
> > > > +                             reboot_cpu = cpu;
> > >
> > > The original value stays when the new one is out of range. It is
> > > small functional change that should get mentioned in the commit
> > > message or better fixed separately.
>
> Ah, I see. From some reason, I assumed that it was defined as
> module_param() or core_param(). Then it would be possible to modify
> it later via /sys.
>
> I am sorry for the noise.
>

Never mind :)

So, is this an ack? Or I need to prepare a v3 with the revert as first patch?

Regards,
-- 
per aspera ad upstream
