Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3262CA528
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391644AbgLAOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391358AbgLAOJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:09:46 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61BC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:09:06 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id x4so948877vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d53CrRsuKFphGM0Ukf26idzqPR8FDHjnWAcVRccas1I=;
        b=gd0h+UVMpnRlERqZSy4ZoI7yNpwNZeBMLcq1+3ThevcQjCevGt+rEFnpKwWxOTg7c/
         ssG84Q6/luF3lsB8owsaQhCO41dTc02NVV5sbmk1n+H/pBg5eke0HE4fglKZBLid6B4r
         tJoETbGKWhU6ucVAhUQd3zKEOdjiP7Ehh5slPukj9fiKinVliooSZxwBaTXwVsYLrbHW
         Japrf34VaRnQizRXgTvx9FMxWKZWL40Y1VoDNIuk5BUNMr4Q9W7uQB6bFDrW3/cuW0bn
         kqiFN6S80So1r2kvEDwGAb+OaQQwWGMVNRTyAfsC0Ph1P9d1eJLia0uqnNylDpL4nNlq
         My7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d53CrRsuKFphGM0Ukf26idzqPR8FDHjnWAcVRccas1I=;
        b=kJS4Zt7sEYYPa1dXOCKjGVSjRJ6EdXR1gGmsh3mwiH9JwDAd000oRdI8Rt3cuQHpMd
         KnVwNMWUU+VVXw9OwHpaVf9OSdLYn+d6RlvjT3MzA8Z0MEvJkU5uQq1yHUdDO5O2l7bB
         OINrgRzxn6nQseKtyl30HFXim1UZCDeLNfBwJOWQSndsZJk+8Ai8xUsbjNIe8ZI4pA4h
         0U1JVsgrQLLwpm6tGApus3WqV85KbCWctAqZELqPguC4oQ54QI3lxpkJz8FfEPv29hak
         eGciW4t/aqAuJN2PG27B2GfSKA22//Kte13xjq8agIPnrN/Y77sAGq+o6vO4q4sRK0iQ
         CP4w==
X-Gm-Message-State: AOAM533YzXy27T2swfETOcRj02m4stI/npoZEsew3ffoxlpXlW1nCPgB
        Qgb9BijZ9UyQUWCh04GbNAFxKbkdoUvWHWgjE4g=
X-Google-Smtp-Source: ABdhPJx66nUh33kQIjJN8jGim1W210QOZOU1rDIRUdVx+dBdedc3HJE9QjDx9FMybhP6AnjfTQl3GAMqz9iqins3KHA=
X-Received: by 2002:a05:6102:2148:: with SMTP id h8mr2584022vsg.12.1606831728725;
 Tue, 01 Dec 2020 06:08:48 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <CAGngYiVoj4Gpid5W10pJfiE1FWY=294TJ4fE=CDG4=HwH0WrJw@mail.gmail.com>
 <460191B6-EDD3-46DE-A1ED-47F758F111E8@goldelico.com>
In-Reply-To: <460191B6-EDD3-46DE-A1ED-47F758F111E8@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 09:08:34 -0500
Message-ID: <CAGngYiVU5Udm6zUzrJPNF-V+uchhiv0-tWbUzb+_aSYVF=Dpug@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 8:36 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Well I only complain because you wrote that you knew that it may
> break something else. So it is known to induces a regression.

We knew that it would fix an important, common problem, but
we also knew that there is always a possibility of breaking
something else when making a change to the core.

>
> Maybe printing a "please check your spi setup" in spi_setup() with
> a comment hinting at your patch would have saved me a lot of time.
>

You could ask the maintainer for such a policy, but I fear that soon
the code would emit too many "please check" messages.

>
> Well, I am sort of maintainer of a vendor kernel that tries to
> follow linus/master and fix things before we release an LTS.

Makes sense, I understand your situation better now.

>
> Anyways, there is still time until v5.10.0 to fix it better than by
> a revert.

When we find a fix, it'll have a Fixes: tag, which means it'll
automatically be applied to every supported kernel, including
v5.10 even if already released.

>
> Hope that you have an idea soon. I am happy to test any suggestions/patches/alternatives
> better than a simple revert.
>

Thank you, that's great. I may come back with a few suggestions
for you to test this week.
