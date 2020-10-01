Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5327FEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgJAMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731888AbgJAMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:24:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C09C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 05:24:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so6386023ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akvyyUxuhjWRDCUB2lTKcqgP2Az3Cod92ZdzN8kBfmI=;
        b=akyrB7L9PdgJwPMXl49tDyta/opvrLvAcOh6D2PtBsJJDPgdb5rhyQ8Dj4isflfOri
         aP1OSp0tpcj3cONvfzb+GeIc7pUkKJhHYIe/qp8pz88zYsTRvxycBz5FN+gG+ZmXks98
         LjdqhBCGO2QDntBCBtm2WJtIqBVaALJTR/J9Trf+/1YpQD6ewKpOCEMHxhPDE1/VD8L6
         toHCB1+6iafUFxjdw/tcJokqxXcQM4OY+2Id1ey6WxkmWAQeKCZ0aDfdpBx4bOAIvB9J
         PjX3xc1QH9LDOrCzgCzc0HyFQS5C3RDW+FzpCWQou95ew2fyIn4OKBAKz2Yk1DfupLgK
         ePaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akvyyUxuhjWRDCUB2lTKcqgP2Az3Cod92ZdzN8kBfmI=;
        b=QJVfSMwBEpvTMY08VNcBAH0RdUiW/5af51TYidEehuGOWpQTR5sUSCh+auZtYZCb7N
         ugiQmHy+fFwGahODNEO/HpxKGHKF2+b9E+eeLOK9RKx+CHgMp0VLhe2et9pwtl1Xfn4n
         wRVbk67kbADD/lDzuBU6Izi5/mH+kLtNZn73AZtGVmdikmQos07qOgxRf0J3iRnW5OCr
         t4RzQRElyXtqU9+K67mZVPo6KXgxlY6SbGZ2vPymPw9ozEuMBg+3nBt0vkY/VZxnR1FJ
         oDmfqSZYMWq8HxQiE8B7DftFR6Eegvart1VjB4qsq9j67mJEipI0PwFjjlzAkHS25JTt
         Wueg==
X-Gm-Message-State: AOAM5333u0q38JyjnnTF4wDLd6TzB14V0wAVjljW0K9hkcTf08hw0s0V
        GTSX+Rxdr8SNEC0oCK724Gvvv/7aV+nG+g7Zfq81yw==
X-Google-Smtp-Source: ABdhPJz+edA3rfBGq6+sE0dd/GpZjCKzMT9YWEd2MXLCtUNmACjhuwcGQYYh8mKDUJ9HzpAZSfbOiI6hZOMRQGfbwjo=
X-Received: by 2002:a05:6602:21cc:: with SMTP id c12mr5022461ioc.81.1601555094381;
 Thu, 01 Oct 2020 05:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201001012810.4172-1-scott.branden@broadcom.com> <e5855e95-dcae-351e-3351-ed1ba9170f7e@gmail.com>
In-Reply-To: <e5855e95-dcae-351e-3351-ed1ba9170f7e@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 1 Oct 2020 14:24:43 +0200
Message-ID: <CAOesGMjoCw9fP+z_2Cc=jUrFc2GA8DEErBZWpTsFbibPZFQzkg@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Add Broadcom VK driver
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 1, 2020 at 4:38 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 9/30/2020 6:27 PM, Scott Branden wrote:
> > This patch series drops previous patches in [1]
> > that were incorporated by Kees Cook into patch series
> > "Introduce partial kernel_read_file() support" [2].
> >
> > Remaining patches are contained in this series to add Broadcom VK driver.
> > (which depends on request_firmware_into_buf API addition in
> > other patch series [2] being applied first).
> >
> > Please note this patch series will not compile without [2].
> >
> > [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> > [2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/
>
> Disclaimer: I am well aware that it is the complete wild west right now
> as far as accelerators go and that every vendor (that I happen to work
> for, just not in the same group as Scott) is just seeking to get their
> drivers included upstream and hopefully for good reasons.

I'm not sure there are ever bad reasons to get code upstreamed?

I've mentioned this before, but until we see the code and
implementations we can guess where the likely commonality is, but
we'll always miss some of it and overdesign other parts of it. The
path of allowing some entropy to later be refactored and made common
is something we've done pretty much everywhere, and it's an approach
that's been proven to work. While those who have already taken that
journey think it's "just a matter of jumping to the end state and just
do things the way they did in the end" is shortsighted: They're not at
a static endpoint and futureproof solution themselves. Some of these
things just need to play out naturally over time.

Luckily, most kernel-facing interfaces are fairly simple and sit as
isolated drivers today, so it doesn't add maintainer burden across the
rest of the kernel so the cost of letting some of this code in isn't
huge. For a few things such as the hwmon and tty aspects it makes
sense to integrate better just as you suggested, but the "subdrivers"
for that are fairly simple and don't add a lot of dependencies on
intricate or complex subsystem features.

Some devices, such as Habana's latest one, is looking at more complex
integrations with other subsystems (RDMA/networking), and there's
plenty of discussion going on there.

>  From a cursory look however, it sounds like there could be a little
> better re-utilization of standards, standard framework and interfaces:

I think most of these points are valid, but also not dealbreakers.
I'll add my opinions on a couple of them below.

> - about 2/3 of your sysfs attributes should incline you to implement a
> HWMON device, not a complicated one, but anything that indicates
> current, power, temperature, alerts etc. should be considered

This likely makes sense, and hopefully isn't too much work to move.
Just like with TTY below, if it needs more time it might make sense to
take it out of this patchset and follow up with it, since it's useful
but not strictly required functionality for the rest of the
driver/device.

> - cannot the firmware loading be supported over remoteproc somehow?

remoteproc is really useful for devices living in a shared SoC,
needing memory carveout, and run control of the coprocessor. In this
case the programming model is different, there's a normal/regular PCIe
host/device relationship and the process of loading firmware onto a
device is something we do in lots of drivers without using remoteproc.
I don't think we need to bring that framework into these kind of
drivers, unless there are tighter coupling between the host/device to
consider for some reason.

> - could not the TTY interface be using virtio or an existing UART?

hvc is super convenient to integrate with since all you need is a
getchar and putchar implementation, but the others would work as well.
I don't have a strong opinion on path forward on this, and if TTY ends
up holding up the rest of the driver it might make sense to leave that
piece out and merge the rest. I'm not sure we're at that junction
quite yet though?

> - what is the format of the message over BAR2 that you expose in patch 13?
>
> Is there a reference user-space implementation that you can link to this
> patch submission in case people are curious?


-Olof
