Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A32A1BA3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 03:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgKAB6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 21:58:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35346 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKAB6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 21:58:19 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id E6F7920C1713
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 18:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6F7920C1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604195898;
        bh=IU8B0aFLd/KWfH3aKTl6Ct/JdgFqy8SYYsQYannDfCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lx+bEO0P6WYrbeaW+B9iduaSFxZOI8mrv9JWePxCwef1QQAt7jE40FoxWf3fOFHXA
         yencoLf9RMrxO7+p3pHlQiomJk5FPTCkREBYgIjx6xC5SLSxAQHy8K7oZBXdmkLBz0
         V8IYhqdcRe5N8j/6TJyTEWFmCr9/0GAXjzY0BlHE=
Received: by mail-qv1-f53.google.com with SMTP id t20so4624775qvv.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 18:58:17 -0700 (PDT)
X-Gm-Message-State: AOAM532bE0FJkFwO+WOE8Okow2cvbgK2gqm8VyHS4x3WISH8qCkJ5FvK
        Qur4lf7h96yz+sDyCK/MBj74b/8eCr5VM30fzhQ=
X-Google-Smtp-Source: ABdhPJw+POfdSqE+WEnEFgAVff6SXCEGFJ9CqXhf6t/MCYagNmCqss9zOTaNpoMeDISlvDglf8Ne8A1QbHpfuLPIFYo=
X-Received: by 2002:a0c:e250:: with SMTP id x16mr16192637qvl.1.1604195896528;
 Sat, 31 Oct 2020 18:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201027133545.58625-1-mcroce@linux.microsoft.com>
 <20201027133545.58625-3-mcroce@linux.microsoft.com> <20201030143049.GE1602@alley>
In-Reply-To: <20201030143049.GE1602@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sun, 1 Nov 2020 02:57:40 +0100
X-Gmail-Original-Message-ID: <CAFnufp2zSsESBK-ZfCJD5dFzMGc9pU4R-VT1j8eu1f4xPde19w@mail.gmail.com>
Message-ID: <CAFnufp2zSsESBK-ZfCJD5dFzMGc9pU4R-VT1j8eu1f4xPde19w@mail.gmail.com>
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

On Fri, Oct 30, 2020 at 3:30 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2020-10-27 14:35:45, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > The kernel cmdline reboot= argument allows to specify the CPU used
> > for rebooting, with the syntax `s####` among the other flags, e.g.
> >
> >   reboot=soft,s4
> >   reboot=warm,s31,force
> >
> > In the early days the parsing was done with simple_strtoul(), later
> > deprecated in favor of the safer kstrtoint() which handles overflow.
> >
> > But kstrtoint() returns -EINVAL if there are non-digit characters
> > in a string, so if this flag is not the last given, it's silently
> > ignored as well as the subsequent ones.
> >
> > To fix it, revert the usage of simple_strtoul(), which is no longer
> > deprecated, and restore the old behaviour.
> >
> > While at it, merge two identical code blocks into one.
>
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -552,25 +552,19 @@ static int __init reboot_setup(char *str)
> >
> >               case 's':
> >               {
> > -                     int rc;
> > -
> > -                     if (isdigit(*(str+1))) {
> > -                             rc = kstrtoint(str+1, 0, &reboot_cpu);
> > -                             if (rc)
> > -                                     return rc;
> > -                             if (reboot_cpu >= num_possible_cpus()) {
> > -                                     reboot_cpu = 0;
> > -                                     return -ERANGE;
> > -                             }
> > -                     } else if (str[1] == 'm' && str[2] == 'p' &&
> > -                                isdigit(*(str+3))) {
> > -                             rc = kstrtoint(str+3, 0, &reboot_cpu);
> > -                             if (rc)
> > -                                     return rc;
> > -                             if (reboot_cpu >= num_possible_cpus()) {
> > -                                     reboot_cpu = 0;
>
>                                                      ^^^^^^
>
> > +                     int cpu;
> > +
> > +                     /*
> > +                      * reboot_cpu is s[mp]#### with #### being the processor
> > +                      * to be used for rebooting. Skip 's' or 'smp' prefix.
> > +                      */
> > +                     str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
> > +
> > +                     if (isdigit(str[0])) {
> > +                             cpu = simple_strtoul(str, NULL, 0);
> > +                             if (cpu >= num_possible_cpus())
> >                                       return -ERANGE;
> > -                             }
> > +                             reboot_cpu = cpu;
>
> The original value stays when the new one is out of range. It is
> small functional change that should get mentioned in the commit
> message or better fixed separately.
>

Hi,

I didn't understand, the original value is 0 since reboot_cpu is global.
reboot_setup() is only called once at boot to parse the cmdline,
indeed it's __init.
I don't know any way to call it more than once (exept passing multiple
reboot= arguments)

> Hmm, I suggest to split this into 3 patches and switch the order:
>
>   + 1st patch should simply revert the commit 616feab75397
>    ("kernel/reboot.c: convert simple_strtoul to kstrtoint").
>
>   + 2nd patch should merge the two branches without any
>     functional change.
>
>   + 3rd patch should add the check for num_possible_cpus()
>     and update the value only when it is valid.
>
> I am sorry that I did not suggested this when reviewed v1.
> I have missed this functional change at that time.
>

Np :)

Bye,

--
per aspera ad upstream
