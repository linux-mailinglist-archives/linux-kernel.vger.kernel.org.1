Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724A42A4A37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKCPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:44:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59460 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgKCPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:44:38 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CFB520B4907
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:44:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CFB520B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604418276;
        bh=35698MkCXsNn3PwyTGZp3RCJkYM/bhuFnz3i/8GNJCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M6paEaHyMSoT/UCNUL/sUYznem1ydDj2gHTb5EHlJYffWAI5hRqN59M6Ktk9DHLMO
         TE+oBFSR+D0ElDSuPbioiiueBCkAHieaIa/D3pwncHxKrM5QREklV6wRFr9MpKjt1c
         dVrR7DumgyyobptHdJA+eIH+HfHFu01cgYpp1DLc=
Received: by mail-qt1-f178.google.com with SMTP id f93so11864404qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:44:36 -0800 (PST)
X-Gm-Message-State: AOAM533TPdDsK8nbAirPfNPsrI85ORrR3VLM2iV4zTNwmNqMm+Cs1Ck8
        s/N9rofhhibcueKnKeqlbZXZEsWA9V42MUsbZEQ=
X-Google-Smtp-Source: ABdhPJzVfwdKVDQi+yc134VLZSc08oF971tu6wJxUJqzRxvTy0zOADSObKlVPhfAAPSGOfE5L6632LPNlWK8mMUlIJs=
X-Received: by 2002:ac8:7408:: with SMTP id p8mr18723540qtq.320.1604418275680;
 Tue, 03 Nov 2020 07:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20201027133545.58625-1-mcroce@linux.microsoft.com>
 <20201027133545.58625-3-mcroce@linux.microsoft.com> <20201030143049.GE1602@alley>
 <CAFnufp2zSsESBK-ZfCJD5dFzMGc9pU4R-VT1j8eu1f4xPde19w@mail.gmail.com>
 <20201102110107.GG20201@alley> <CAFnufp3tOKOB=xqe8Ln46n2wBFMDC4XoZpu51xk5B=Acp=L-JA@mail.gmail.com>
 <20201103142543.GP20201@alley>
In-Reply-To: <20201103142543.GP20201@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 16:43:59 +0100
X-Gmail-Original-Message-ID: <CAFnufp1Uurxq=D6a-0SoFuRLuYJwU1+egrec3NTri8S6b+6ixg@mail.gmail.com>
Message-ID: <CAFnufp1Uurxq=D6a-0SoFuRLuYJwU1+egrec3NTri8S6b+6ixg@mail.gmail.com>
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

On Tue, Nov 3, 2020 at 3:25 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2020-11-03 12:43:32, Matteo Croce wrote:
> > On Mon, Nov 2, 2020 at 12:01 PM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Sun 2020-11-01 02:57:40, Matteo Croce wrote:
> > > > On Fri, Oct 30, 2020 at 3:30 PM Petr Mladek <pmladek@suse.com> wrote:
> > > > >
> > > > > On Tue 2020-10-27 14:35:45, Matteo Croce wrote:
> > > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > > >
> > > > > > The kernel cmdline reboot= argument allows to specify the CPU used
> > > > > > for rebooting, with the syntax `s####` among the other flags, e.g.
> > > > > >
> > > > > >   reboot=soft,s4
> > > > > >   reboot=warm,s31,force
> > > > > >
> > > > > > In the early days the parsing was done with simple_strtoul(), later
> > > > > > deprecated in favor of the safer kstrtoint() which handles overflow.
> > > > > >
> > > > > > But kstrtoint() returns -EINVAL if there are non-digit characters
> > > > > > in a string, so if this flag is not the last given, it's silently
> > > > > > ignored as well as the subsequent ones.
> > > > > >
> > > > > > To fix it, revert the usage of simple_strtoul(), which is no longer
> > > > > > deprecated, and restore the old behaviour.
> > > > > >
> > > > > > While at it, merge two identical code blocks into one.
> > > > >
> > > > > > --- a/kernel/reboot.c
> > > > > > +++ b/kernel/reboot.c
> > > > > > @@ -552,25 +552,19 @@ static int __init reboot_setup(char *str)
> > > > > >
> > > > > >               case 's':
> > > > > >               {
> > > > > > -                     int rc;
> > > > > > -
> > > > > > -                     if (isdigit(*(str+1))) {
> > > > > > -                             rc = kstrtoint(str+1, 0, &reboot_cpu);
> > > > > > -                             if (rc)
> > > > > > -                                     return rc;
> > > > > > -                             if (reboot_cpu >= num_possible_cpus()) {
> > > > > > -                                     reboot_cpu = 0;
> > > > > > -                                     return -ERANGE;
> > > > > > -                             }
> > > > > > -                     } else if (str[1] == 'm' && str[2] == 'p' &&
> > > > > > -                                isdigit(*(str+3))) {
> > > > > > -                             rc = kstrtoint(str+3, 0, &reboot_cpu);
> > > > > > -                             if (rc)
> > > > > > -                                     return rc;
> > > > > > -                             if (reboot_cpu >= num_possible_cpus()) {
> > > > > > -                                     reboot_cpu = 0;
> > > > >
> > > > >                                                      ^^^^^^
> > > > >
> > > > > > +                     int cpu;
> > > > > > +
> > > > > > +                     /*
> > > > > > +                      * reboot_cpu is s[mp]#### with #### being the processor
> > > > > > +                      * to be used for rebooting. Skip 's' or 'smp' prefix.
> > > > > > +                      */
> > > > > > +                     str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
> > > > > > +
> > > > > > +                     if (isdigit(str[0])) {
> > > > > > +                             cpu = simple_strtoul(str, NULL, 0);
> > > > > > +                             if (cpu >= num_possible_cpus())
> > > > > >                                       return -ERANGE;
> > > > > > -                             }
> > > > > > +                             reboot_cpu = cpu;
> > > > >
> > > > > The original value stays when the new one is out of range. It is
> > > > > small functional change that should get mentioned in the commit
> > > > > message or better fixed separately.
> > >
> > > Ah, I see. From some reason, I assumed that it was defined as
> > > module_param() or core_param(). Then it would be possible to modify
> > > it later via /sys.
> > >
> > > I am sorry for the noise.
> > >
> >
> > Never mind :)
> >
> > So, is this an ack? Or I need to prepare a v3 with the revert as first patch?
>
> Good question ;-) It would be nice to do it the cleaner way but I do
> not resist on it. Feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Now, the question is who would actually push this upstream. These
> patches often go via Andrew Morton. He actually committed both
> changes that are fixed here.
>
> I suggest to resend the patchset with my Reviewed-by and
> Cc: stable@vger.kernel.org lines. And put Andrew and Greg into Cc.
>

I see that by doing the revert first, makes the patch very small.
It's worth it.

I'm thinking, what should be the right action to do when the supplied
cpu number is too big?
With my patch I stop the parsing, while the previous behavior (other
than setting a wrong cpu number) was to continue parsing other fields.
Maybe I should just continue the loop and continue the parsing?
Maybe with a pr_warn "cpu X exceeds possible cpu number Y" etc.

-- 
per aspera ad upstream
