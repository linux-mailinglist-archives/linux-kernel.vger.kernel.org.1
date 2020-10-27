Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA529C6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827437AbgJ0SYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:24:03 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35574 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827430AbgJ0SYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:24:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id m188so2080782ybf.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZXpAj9f31rjCg9bdOOq+XC91MK5E98xJEzQSacCjz0=;
        b=QJp6n4vLoY03qLV5VzVxuEJZ8tDpc5F4rgdP8o8tOgzKZAtzV2kiVctxwm4KWpcYzt
         lOSodTj5QToOY2CTrJfCN1IBtsxmrQEIHLrShLiC2pwU9lJteD9etlJeb9TksJ3OFV6X
         hMftg9w7jfo3yC5Wn6tD0tk5eMb4p41/aQauxuXBP4vAT+9da1FYgHrWdr1r6HECZzn9
         Q//jgClOQ/Us2a0PCTnTyGISYOu1g2zzDW5G52AldJ4DH2HUvdPVFVSHeQHsQztRN0g3
         FAZWEgQL0YiGQfjn2zeIF0zSVqwdljrGlwi9ivW+zBY8Okhpd8Cucwlb0ENDfW/wp+B8
         me9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZXpAj9f31rjCg9bdOOq+XC91MK5E98xJEzQSacCjz0=;
        b=RpFIRROJfSOprswA/d3UL/PrKXp6Ojs2RJEG8cdNAKWn0QwTd+AWlfVT7a2UVVECgr
         F8w4RYbT8yuqfuj+2urmSBWxTC6MMnPeD9Y+vKc2HY/O2SWWBhSuFGITh22Hq4L8pwMz
         upLR9FTBR7w/skTIyLvN7VV3KtrG8KSAwPLV96NuhN2C2+Z755ke0qWYOrJrQspvBRDF
         tfv6MdHnCOn5RlieUxXfEJ6vnJB5Yasl43ZOjBbF/S2FAmlaQtORwl6AlAV5woaXtBzw
         nLvpA27jrdOLGkpABlgCqTtRajcBRZ567k2vRdjjJEkPikO1DMUDLi2rOaqc+vbhBYmp
         82CA==
X-Gm-Message-State: AOAM533J0t1E9f+o53qZiYphoFxq/0noliib2DE4q2/2HagTHPYk+26J
        KmeM0cwJwWzA/hn6IGNiPQE3qC2lDDP4NepJcVC/tw==
X-Google-Smtp-Source: ABdhPJxzfejoVOOmhsLnuvNMIljC6xtRqbyxPp5ikP6i3a6nLn+cF7CfpkYu+qJUfLWpw41hJqqharHAXp0bl07N41Q=
X-Received: by 2002:a25:d08e:: with SMTP id h136mr5606000ybg.20.1603823038261;
 Tue, 27 Oct 2020 11:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200901224842.1787825-1-saravanak@google.com>
 <CAMuHMdUcxX1Zvb7X+uxLa1u0WkOtS8hAZ000+Ta+7SCdkeJO8g@mail.gmail.com>
 <CAGETcx9MVi53Fp3sGXap8iyfHO5VMVpwe9BV7B7SLwmkxR4WOQ@mail.gmail.com> <CAMuHMdV43-mcMutEzjXZkC1DfJc4j8by3mSJUV+rd+UcjGxQfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV43-mcMutEzjXZkC1DfJc4j8by3mSJUV+rd+UcjGxQfQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 27 Oct 2020 11:23:22 -0700
Message-ID: <CAGETcx_gU=yonyHtNPuzMc5kxE8=DACGxf+byNu592unxi+CLA@mail.gmail.com>
Subject: Re: [PATCH v1] scripts/dev-needs: Add script to list device dependencies
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:09 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Oct 27, 2020 at 6:31 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Oct 27, 2020 at 3:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Sep 2, 2020 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > This script can be useful for:
> > > > - Figuring out the list of modules you need to pack in initrd
> > > > - Figuring out the list of drivers you need to modularize for a device
> > > >   to be fully functional without building in any dependencies.
> > > > - Figuring out which drivers to enable first, when porting drivers
> > > >   between kernels (say, to upstream).
> > > > - Plotting graphs of system dependencies, etc.
> > > >
> > > > Usage: dev-needs.sh [-c|-d|-m|-f] [filter options] <list of devices>
> > > >
> > > > This script needs to be run on the target device once it has booted to a
> > > > shell.
> > > >
> > > > The script takes as input a list of one or more device directories under
> > > > /sys/devices and then lists the probe dependency chain (suppliers and
> > > > parents) of these devices. It does a breadth first search of the dependency
> > > > chain, so the last entry in the output is close to the root of the
> > > > dependency chain.
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/scripts/dev-needs.sh
> > > > @@ -0,0 +1,315 @@
> > > > +#! /bin/sh
> > >
> > > On Debian, where /bin/sh -> dash:
> > >
> > >     dev-needs.sh: 6: dev-needs.sh: Syntax error: "(" unexpected
> >
> > dash doesn't like () after the function name maybe? If so, we could
> > drop it. I think it'll still work with toybox and bash.
>
> That's not sufficient:
>
>     ./dev-needs.sh: 47: ./dev-needs.sh: Syntax error: "}" unexpected

Ok, let's give up on dash for now. I've never used it.

> > > When using bash, I get:
> > >
> > > # ./dev-needs.sh /sys/devices/platform/soc/feb00000.display
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > >
> > > # ./dev-needs.sh -c /sys/devices/platform/soc/feb00000.display
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> > > ./dev-needs.sh: line 255: detail: command not found
> >
> > This is odd. bash definitely works with this script on my Debian x86 machine.
> >
> > This error happens when the "detail" alias is not "seen" by the shell
> > when it interprets detail_chosen function. Sigh, every shell seems to
> > want a different order. Can you try to debug it on your end?
>
> The bash man page says:
>
>     Aliases are not expanded when the shell is not interactive,
>     unless the expand_aliases shell option is set using shopt
>
> And adding "shopt -s expand_aliases" at the top makes it work.

Thanks for figuring this out.

> Nevertheless, the bash man page says "... do not use alias in
> compound commands".

I'm not a bash expert in any sense and I don't have a strong opinion on this.

Aliases were just a lazy way for me to deal with the parsing the
options to allow different "output formats". If someone wants to
rewrite it to avoid aliases, I'll happily test them on my end and
accept the patches if they don't break on toybox (I need this to
continue working on Android/embedded devices).

I'm also okay with just adding "shopt -s expand_aliases" and calling
it a day for now (I'd assume it works with toybox. I haven't tested it
yet).

-Saravana
