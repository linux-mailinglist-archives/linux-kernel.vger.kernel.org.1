Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4829C602
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371055AbgJ0SLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:11:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33288 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370876AbgJ0SJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:09:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id s21so2247377oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbtM77OT6aQe5O8Ox954GJxlxfD2p5sa6teRjX/1SN8=;
        b=pwhx2yL1CnKxx7CZib8/ETDnnTvrTzS75dqV0K56tlxVaJvk63RhZazHhkiKeHEoz+
         2zxW9auPsD28EafZG09Ism+tMdO+qwWauV6rnpZTaPu+NmZm3jfyRb60Bt1uKqanXUbU
         tdro4XI5ytvsYCoTB6kn6jJ55jZIydC7NYtZ4bVbt0In2HRa+3YFUQpJAKXnQUep6hU6
         yEKvhWL59GnbvbGDYjh+GkcglNRP14o7ffmTTIIReKt9o6gqzmm1y+4byl6li6lxD8Ru
         3yP1BBjz5FcJgA+ZaqWupFMhu0JlTOwRC737N2ZOGtEvvkHnjTRNu9zJ1Af7NHk8c/gi
         VDxA==
X-Gm-Message-State: AOAM530VumfifdUy0fTzK6PDgTzSJb4hX5t91apkmEjKCnuhEIR8yOYH
        MLaiK/0EsIXWc1VnOQeXCnmppsiLBpdngTljJWs=
X-Google-Smtp-Source: ABdhPJwZ4tzgLp/lQf+OQYf41GjeEiZ97xC3RsEV6LdRYmqwYR1dNOCn4YKnQCti8TJKFj9VQUQ9R9W0a5vVzeyFJGA=
X-Received: by 2002:aca:c490:: with SMTP id u138mr2429970oif.54.1603822193919;
 Tue, 27 Oct 2020 11:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200901224842.1787825-1-saravanak@google.com>
 <CAMuHMdUcxX1Zvb7X+uxLa1u0WkOtS8hAZ000+Ta+7SCdkeJO8g@mail.gmail.com> <CAGETcx9MVi53Fp3sGXap8iyfHO5VMVpwe9BV7B7SLwmkxR4WOQ@mail.gmail.com>
In-Reply-To: <CAGETcx9MVi53Fp3sGXap8iyfHO5VMVpwe9BV7B7SLwmkxR4WOQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 19:09:42 +0100
Message-ID: <CAMuHMdV43-mcMutEzjXZkC1DfJc4j8by3mSJUV+rd+UcjGxQfQ@mail.gmail.com>
Subject: Re: [PATCH v1] scripts/dev-needs: Add script to list device dependencies
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Tue, Oct 27, 2020 at 6:31 PM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Oct 27, 2020 at 3:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Sep 2, 2020 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> > > This script can be useful for:
> > > - Figuring out the list of modules you need to pack in initrd
> > > - Figuring out the list of drivers you need to modularize for a device
> > >   to be fully functional without building in any dependencies.
> > > - Figuring out which drivers to enable first, when porting drivers
> > >   between kernels (say, to upstream).
> > > - Plotting graphs of system dependencies, etc.
> > >
> > > Usage: dev-needs.sh [-c|-d|-m|-f] [filter options] <list of devices>
> > >
> > > This script needs to be run on the target device once it has booted to a
> > > shell.
> > >
> > > The script takes as input a list of one or more device directories under
> > > /sys/devices and then lists the probe dependency chain (suppliers and
> > > parents) of these devices. It does a breadth first search of the dependency
> > > chain, so the last entry in the output is close to the root of the
> > > dependency chain.
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/scripts/dev-needs.sh
> > > @@ -0,0 +1,315 @@
> > > +#! /bin/sh
> >
> > On Debian, where /bin/sh -> dash:
> >
> >     dev-needs.sh: 6: dev-needs.sh: Syntax error: "(" unexpected
>
> dash doesn't like () after the function name maybe? If so, we could
> drop it. I think it'll still work with toybox and bash.

That's not sufficient:

    ./dev-needs.sh: 47: ./dev-needs.sh: Syntax error: "}" unexpected

> > When using bash, I get:
> >
> > # ./dev-needs.sh /sys/devices/platform/soc/feb00000.display
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> >
> > # ./dev-needs.sh -c /sys/devices/platform/soc/feb00000.display
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
> > ./dev-needs.sh: line 255: detail: command not found
>
> This is odd. bash definitely works with this script on my Debian x86 machine.
>
> This error happens when the "detail" alias is not "seen" by the shell
> when it interprets detail_chosen function. Sigh, every shell seems to
> want a different order. Can you try to debug it on your end?

The bash man page says:

    Aliases are not expanded when the shell is not interactive,
    unless the expand_aliases shell option is set using shopt

And adding "shopt -s expand_aliases" at the top makes it work.

Nevertheless, the bash man page says "... do not use alias in
compound commands".

> This is the version I have:
> GNU bash, version 5.1.0(1)-rc1

# /bin/bash --version
GNU bash, version 5.0.3(1)-release (aarch64-unknown-linux-gnu)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
