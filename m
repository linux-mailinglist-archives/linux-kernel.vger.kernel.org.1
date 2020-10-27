Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640329C23B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820177AbgJ0Rd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:33:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44054 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1819932AbgJ0RbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:31:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id h6so1914091ybi.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roUOEIZ14Sav6aUOKIQPgQku8t+cyAqv92YI7rNzChY=;
        b=gpO+U8OCkFbyPIOY244ysr/oB5D1L71A2FWw2D/0ce304geRy5KM1/8WD/fvsg5cx6
         L0P+0aWdKDSXZaAm8LLVOzCDAFno4gQP/YfPkzQt1VwQj0cun6G3eW5ZAjsaYUKPElnj
         oqH6kCi744gJK8FUey3Ebj2yL3jfqQ0RclZMLYSmjGh8CBQSH6se5sQcZ/wY6nojKJk5
         EuZcZ0zgLNS8rq1ogY4tWEIe7Dw86I2UZoefqSyi2NqBRchgcPVfXdriSgdSGQ+g371S
         +CWXQbw/PApSMPn6enuJPCKxUpZqIZFQbwQVev5H9+0jdLuZ61smiQoeAPwDlTmkZ/yx
         Qu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roUOEIZ14Sav6aUOKIQPgQku8t+cyAqv92YI7rNzChY=;
        b=V3HJLb2ors/5x7REOUCgZN27e5xliVdCyx7mosv8ucmtHZII2F/Xt5kzlqNBbk35LD
         U+7SyjINeNxzDfb92jkqGg0YsVG54NJjggsttOX9EbmFR5b0hr5vpHFP1UaivKV8AnM+
         8p36W2rdsr2BusvKibqQYFsxZOa6CbppF8cj8qxgEDbkE0iD7ICuiT0Nq9ocAnE1htaA
         ixWhYgJcFdsH/OAS/ElGNt4LFcB1m4uXvzKlFbl+KYRPEL2aY8cLDDF2OXc+eiNkrtQz
         jVpvnao1xRMv79WWPjvSo/OGyn5KsqNlFQvNgl/0oFNHoJCZdBkJojvtho8hMQzLIded
         e+OQ==
X-Gm-Message-State: AOAM530pLSB0JhU3sfFokX9OKnAPdf5zMVSRGYgKeSjfx+skJ2c/7EbR
        1PkfLiaog6PP5X8IEBYaVdXCMdxp0aOAIkTFnt7mJw==
X-Google-Smtp-Source: ABdhPJxTFCnLihotEEdPcj8FEA/A4XcCFIg/UmM2jGljYJ4wSN+nBXrHXzTB6nRGSYXgXYh9vRz3B9PByWq0i5qm/ig=
X-Received: by 2002:a25:3:: with SMTP id 3mr4903331yba.412.1603819880190; Tue,
 27 Oct 2020 10:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200901224842.1787825-1-saravanak@google.com> <CAMuHMdUcxX1Zvb7X+uxLa1u0WkOtS8hAZ000+Ta+7SCdkeJO8g@mail.gmail.com>
In-Reply-To: <CAMuHMdUcxX1Zvb7X+uxLa1u0WkOtS8hAZ000+Ta+7SCdkeJO8g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 27 Oct 2020 10:30:44 -0700
Message-ID: <CAGETcx9MVi53Fp3sGXap8iyfHO5VMVpwe9BV7B7SLwmkxR4WOQ@mail.gmail.com>
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

On Tue, Oct 27, 2020 at 3:12 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Sep 2, 2020 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> > This script can be useful for:
> > - Figuring out the list of modules you need to pack in initrd
> > - Figuring out the list of drivers you need to modularize for a device
> >   to be fully functional without building in any dependencies.
> > - Figuring out which drivers to enable first, when porting drivers
> >   between kernels (say, to upstream).
> > - Plotting graphs of system dependencies, etc.
> >
> > Usage: dev-needs.sh [-c|-d|-m|-f] [filter options] <list of devices>
> >
> > This script needs to be run on the target device once it has booted to a
> > shell.
> >
> > The script takes as input a list of one or more device directories under
> > /sys/devices and then lists the probe dependency chain (suppliers and
> > parents) of these devices. It does a breadth first search of the dependency
> > chain, so the last entry in the output is close to the root of the
> > dependency chain.
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/scripts/dev-needs.sh
> > @@ -0,0 +1,315 @@
> > +#! /bin/sh
>
> On Debian, where /bin/sh -> dash:
>
>     dev-needs.sh: 6: dev-needs.sh: Syntax error: "(" unexpected

dash doesn't like () after the function name maybe? If so, we could
drop it. I think it'll still work with toybox and bash.

>
> When using bash, I get:
>
> # ./dev-needs.sh /sys/devices/platform/soc/feb00000.display
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
>
> # ./dev-needs.sh -c /sys/devices/platform/soc/feb00000.display
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found
> ./dev-needs.sh: line 255: detail: command not found

This is odd. bash definitely works with this script on my Debian x86 machine.

This error happens when the "detail" alias is not "seen" by the shell
when it interprets detail_chosen function. Sigh, every shell seems to
want a different order. Can you try to debug it on your end?

This is the version I have:
GNU bash, version 5.1.0(1)-rc1

> Which shell should I use?

I've tested with toybox and bash.

-Saravana
