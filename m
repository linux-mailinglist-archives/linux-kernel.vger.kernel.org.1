Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303CF2F5610
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbhANBkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbhANBkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:40:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BD9C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:39:54 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q7so2689816pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=0v4ffsos0rapW38+1t0CY4y2xO4VTxoL80FfHQGQHck=;
        b=X7s9AnVbndF4RvTXQ8vTFmzEB1dtqOySA2TSPxuQDLtzuZoko9RNhzDwklcgUoZvHD
         HCF4ESox7Pbj/vHh1slDuHF5Vx/qM6zlYKuQq3FK/1mCyL/6LiLu8cafeDTKDGJ57mpH
         j2AytFr3UsnPvsCPaN+80cPgSMnkuL69RuICU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=0v4ffsos0rapW38+1t0CY4y2xO4VTxoL80FfHQGQHck=;
        b=eIrKU+OTBbHDB/tE38dI6iWC0Z8VGo+DW0UGx0zomT9Hcj2+QyyqOI6ZTi4hHHE4/J
         GijglNiLOI0hbVgMxPBTwraQu2Y7X3B4yKH8emAgYc83aQoeqYfNGtL9wrNb9H1bGz6I
         QwlPRWUh0Da6ldgNcuPFw8yONXL1rNF6zhl7nBBdsqOULOjSQleNbj7TgaxUTs5mLGh5
         CziWKNZaLAIhHyyafZYl+GCkW0Ixiuy0+maStKBwuFJ/MgxuZZBxc57VezK6zPhAiF/N
         47rm31JJl3bIrcx9OIExD9fQN06bPiiD2igGAwm+LpVhkWbf+UNHWpPxXfAWm1iPizHP
         CYpw==
X-Gm-Message-State: AOAM530OAmTmtB6jFdPv1gkwidXd4LOc83aR2eRqBN6M3lSrHEDXS6ww
        vhQ+mZ/5TQGJwtw0A6aCzBDZKyma/uQWnA==
X-Google-Smtp-Source: ABdhPJzG+fk+uWdlidBTt4vZOHuxgbfVDrkaQGxK7TVTc260Bc5HQzaLT4n9+LG5IBcC72Mc0YmYIw==
X-Received: by 2002:a63:5304:: with SMTP id h4mr4853326pgb.199.1610588393450;
        Wed, 13 Jan 2021 17:39:53 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id v11sm4012814pju.40.2021.01.13.17.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 17:39:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+cxXhmV_RxLupD18aOxLwaGGKSxihTY8ZZvQKzdd-dsYYf5dQ@mail.gmail.com>
References: <20210107154200.v4.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid> <20210107154200.v4.2.Ibe7d7d53c5b4fe72c60de90111ff763b53f38dbb@changeid> <161041827643.3661239.17919996906733477213@swboyd.mtv.corp.google.com> <CA+cxXhm45emyg-9j99U=UWY8QuhzWifh+VvsFBaTOTWs81tvUQ@mail.gmail.com> <161052058590.3661239.5654596152411573148@swboyd.mtv.corp.google.com> <CA+cxXhmZd0eeLjUwcTevZRNovbZWXNKQH5qOX_YFCKowxHNVfQ@mail.gmail.com> <161057967168.3661239.10329365279391431594@swboyd.mtv.corp.google.com> <CA+cxXhmV_RxLupD18aOxLwaGGKSxihTY8ZZvQKzdd-dsYYf5dQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Input: cros-ec-keyb - Expose function row physical map to userspace
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org
To:     Philip Chen <philipchen@chromium.org>
Date:   Wed, 13 Jan 2021 17:39:51 -0800
Message-ID: <161058839125.3661239.15252566946929589144@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-13 17:29:05)
> On Wed, Jan 13, 2021 at 3:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Philip Chen (2021-01-13 14:47:18)
> > > On Tue, Jan 12, 2021 at 10:49 PM Stephen Boyd <swboyd@chromium.org> w=
rote:
> > > >
> > > > Quoting Philip Chen (2021-01-12 15:55:28)
> > > > > On Mon, Jan 11, 2021 at 6:24 PM Stephen Boyd <swboyd@chromium.org=
> wrote:
> > > > > >
> > > > > > Is it documented in Documentation/ABI/?
> > > > > Not yet.
> > > > > Is it proper to add the documentation to `testing/sysfs-driver-in=
put-keyboard`?
> > > >
> > > > Somewhere in testing is fine. I'm not sure if it is a generic propr=
ty
> > > > for all keyboards though? What's the path in sysfs?
> > > I wouldn't say it's generic.
> > > It is available in the keyboard device node only when the board has a
> > > custom top-row keyboard design.
> > > The path in sysfs is something like:
> > > /sys/class/input/input0/device/function_row_physmap, where input0 is
> > > cros_ec.
> >
> > I see that atkbd already has this so at least it would be common to some
> > sort of keyboard device. I'm not sure where to document it though. I see
> > that atkbd has a handful of undocumented sysfs attributes so adding all
> > of those may lead to a common path. At the least it sounds OK to have a
> > sysfs-driver-input-keyboard file if input folks are OK with it.
> Since there are other undocumented sysfs attributes for input/keyboard
> anyway, we should probably leave the documentation to another patch?
> For now, let's move to patch v5, where I've addressed all of the
> comments so far.

Please document this one that's being introduced. We should document all
the sysfs attributes but we don't always do a good job at it.
