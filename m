Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8589C2A4B33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgKCQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:59432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgKCQWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:22:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604420573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ncbfu00+z2ljfQkB8wK6dR5MBVW1Agfr/OoexPIcZXM=;
        b=H/Q1a6JLNwT23WwdE7HZnJM34AH6jqErP2c6racZcPhcitmYRe3Af/FKNh6od17tOEZxbH
        W8Mcs5c0FkoP3yZLlPC4wc6TmFYhaF9t9/joPJNt5HWfYa+gHBzYN/WOg/go1TqrkrhAy3
        VgdmoNAlNLx59T2jSuKrMD8TFcgd01Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 406C6ADB3;
        Tue,  3 Nov 2020 16:22:53 +0000 (UTC)
Date:   Tue, 3 Nov 2020 17:22:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>
Subject: Re: [PATCH v2 2/2] reboot: fix parsing of reboot cpu number
Message-ID: <20201103162252.GR20201@alley>
References: <20201027133545.58625-1-mcroce@linux.microsoft.com>
 <20201027133545.58625-3-mcroce@linux.microsoft.com>
 <20201030143049.GE1602@alley>
 <CAFnufp2zSsESBK-ZfCJD5dFzMGc9pU4R-VT1j8eu1f4xPde19w@mail.gmail.com>
 <20201102110107.GG20201@alley>
 <CAFnufp3tOKOB=xqe8Ln46n2wBFMDC4XoZpu51xk5B=Acp=L-JA@mail.gmail.com>
 <20201103142543.GP20201@alley>
 <CAFnufp1Uurxq=D6a-0SoFuRLuYJwU1+egrec3NTri8S6b+6ixg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp1Uurxq=D6a-0SoFuRLuYJwU1+egrec3NTri8S6b+6ixg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-03 16:43:59, Matteo Croce wrote:
> On Tue, Nov 3, 2020 at 3:25 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2020-11-03 12:43:32, Matteo Croce wrote:
> > > On Mon, Nov 2, 2020 at 12:01 PM Petr Mladek <pmladek@suse.com> wrote:
> > > >
> > > > On Sun 2020-11-01 02:57:40, Matteo Croce wrote:
> > > > > On Fri, Oct 30, 2020 at 3:30 PM Petr Mladek <pmladek@suse.com> wrote:
> > > > > >
> > > > > > On Tue 2020-10-27 14:35:45, Matteo Croce wrote:
> > > > > > > From: Matteo Croce <mcroce@microsoft.com>
> > > > > > >
> > > > > > > The kernel cmdline reboot= argument allows to specify the CPU used
> > > > > > > for rebooting, with the syntax `s####` among the other flags, e.g.
> > > > > > >
> > > > > > >   reboot=soft,s4
> > > > > > >   reboot=warm,s31,force
> > > > > > >
> > > > > > > In the early days the parsing was done with simple_strtoul(), later
> > > > > > > deprecated in favor of the safer kstrtoint() which handles overflow.
> > > > > > >
> > > > > > > But kstrtoint() returns -EINVAL if there are non-digit characters
> > > > > > > in a string, so if this flag is not the last given, it's silently
> > > > > > > ignored as well as the subsequent ones.
> > > > > > >
> > > > > > > To fix it, revert the usage of simple_strtoul(), which is no longer
> > > > > > > deprecated, and restore the old behaviour.
> > > > > > >
> > > > > > > While at it, merge two identical code blocks into one.
> > > > > >
> > > > > > > --- a/kernel/reboot.c
> > > > > > > +++ b/kernel/reboot.c
> > > > > > > @@ -552,25 +552,19 @@ static int __init reboot_setup(char *str)
> > > > > > >
> > > > > > >               case 's':
> > > > > > >               {
> > > > > > > -                     int rc;
> > > > > > > -
> > > > > > > -                     if (isdigit(*(str+1))) {
> > > > > > > -                             rc = kstrtoint(str+1, 0, &reboot_cpu);
> > > > > > > -                             if (rc)
> > > > > > > -                                     return rc;
> > > > > > > -                             if (reboot_cpu >= num_possible_cpus()) {
> > > > > > > -                                     reboot_cpu = 0;
> > > > > > > -                                     return -ERANGE;
> > > > > > > -                             }
> > > > > > > -                     } else if (str[1] == 'm' && str[2] == 'p' &&
> > > > > > > -                                isdigit(*(str+3))) {
> > > > > > > -                             rc = kstrtoint(str+3, 0, &reboot_cpu);
> > > > > > > -                             if (rc)
> > > > > > > -                                     return rc;
> > > > > > > -                             if (reboot_cpu >= num_possible_cpus()) {
> > > > > > > -                                     reboot_cpu = 0;
> > > > > >
> > > > > >                                                      ^^^^^^
> > > > > >
> > > > > > > +                     int cpu;
> > > > > > > +
> > > > > > > +                     /*
> > > > > > > +                      * reboot_cpu is s[mp]#### with #### being the processor
> > > > > > > +                      * to be used for rebooting. Skip 's' or 'smp' prefix.
> > > > > > > +                      */
> > > > > > > +                     str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
> > > > > > > +
> > > > > > > +                     if (isdigit(str[0])) {
> > > > > > > +                             cpu = simple_strtoul(str, NULL, 0);
> > > > > > > +                             if (cpu >= num_possible_cpus())
> > > > > > >                                       return -ERANGE;
> > > > > > > -                             }
> > > > > > > +                             reboot_cpu = cpu;
> > > > > >
> > > > > > The original value stays when the new one is out of range. It is
> > > > > > small functional change that should get mentioned in the commit
> > > > > > message or better fixed separately.
> > > >
> > > > Ah, I see. From some reason, I assumed that it was defined as
> > > > module_param() or core_param(). Then it would be possible to modify
> > > > it later via /sys.
> > > >
> > > > I am sorry for the noise.
> > > >
> > >
> > > Never mind :)
> > >
> > > So, is this an ack? Or I need to prepare a v3 with the revert as first patch?
> >
> > Good question ;-) It would be nice to do it the cleaner way but I do
> > not resist on it. Feel free to use:
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > Now, the question is who would actually push this upstream. These
> > patches often go via Andrew Morton. He actually committed both
> > changes that are fixed here.
> >
> > I suggest to resend the patchset with my Reviewed-by and
> > Cc: stable@vger.kernel.org lines. And put Andrew and Greg into Cc.
> >
> 
> I see that by doing the revert first, makes the patch very small.
> It's worth it.

Great.

> I'm thinking, what should be the right action to do when the supplied
> cpu number is too big?
> With my patch I stop the parsing, while the previous behavior (other
> than setting a wrong cpu number) was to continue parsing other fields.
> Maybe I should just continue the loop and continue the parsing?
> Maybe with a pr_warn "cpu X exceeds possible cpu number Y" etc.

Sounds good to me. Please, make it clear that the error message is
printed when parsing reboot= commandline option. For example:

pr_err("Ignoring CPU number in reboot= option. CPU X exceeds possible
cpu number Y", ...)

or something like this.

Best Regards,
Petr
