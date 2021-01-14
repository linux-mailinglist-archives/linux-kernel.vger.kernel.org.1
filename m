Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1C2F6A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbhANTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbhANTIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:08:48 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04CAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:08:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y128so2771706ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUCOJz/ZqmpeN2p1piWt0o8HDtV5bR2P5dOvMH/Op8g=;
        b=nuhPA816/Uvl7M7reNfTzmbgo375dBusvoHBhO39d0AsqCqDxJjbfgFbm6n5qxn2Rt
         Ujucgbu+Xv2LZINyfgd1dgX4nX7Xdp7IQiLj+CCiSySFOpP5eVUb/DhIpb7e/05ossoD
         0tc54XXDjwAQMWGcYfUvHoJIi7ablXFMJUPGrH3Rol+mmx0ate1xdb7njDET4+jc1cRr
         yFbpuIcZiEzMOb+7m9Ej7kHmEu/Qz5/rNJR0BRUjiSmCQVdm6VTvelBKmEVb83GghrL0
         kHcIV7qRbPcKCDXulDfEn+8xc/vuB7LuInnYL8/QL1ykWAHx9Cmy+YWU3pMoaiTF8e1T
         c1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUCOJz/ZqmpeN2p1piWt0o8HDtV5bR2P5dOvMH/Op8g=;
        b=pC7w2hWBuWsClP2fwzv+d7ey5DXxQK7a6X3Jt7d61TS4wthWJfmOfBPz2iuE0lOUJ7
         q33X1INnCvODWu4W6wzJS4BbFXMLQ98GvjjFgkik8TsBNZRam9RnU5SPRqQUxcLSC2/i
         zUxxefnHu8iJg58b2T1GyL1obwXOK8j7JaWNUnwxK/fDpGR7D+Q7XB8kji0gv8HHCs9X
         Zyd/B8b/pqkfyPYY7gPvL8QOrou+28XLETZvl8qM+L7UkNzVwVAriO1XfzHbwFyjumZE
         FQhxdEqIiAov5kMj8iEyEQaxeWskqCA5rTzYf94LZan7978gJbZ3gLgiKk/u0/pvUDNZ
         0Feg==
X-Gm-Message-State: AOAM5320LjlivJAllXYfGYCFd5Oc3MePmAiQM3XAuCgCXpc3ldO8k2zN
        RDjKmq+mUM1n5oxDtW4abvR4PnssCsABO6iqORnShA==
X-Google-Smtp-Source: ABdhPJzo3aCLs5/z0dpM579QaEyLQMQye0ID9U2++65JGzdmC3a/RHg2pnEVu4xFEJArFJTBpsfaBqWVg/ZneHH/oPg=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr6760882ybc.32.1610651286115;
 Thu, 14 Jan 2021 11:08:06 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210113110330eucas1p1e7efa719b5db55ccf3774450a8c1e452@eucas1p1.samsung.com>
 <20210113110320.13149-1-m.szyprowski@samsung.com> <CAGETcx9wJVnBAe6mKxfi9DC9YFf6DLzAyxBC8DxhQUqpfTDR3A@mail.gmail.com>
 <58e1cfb2-cd35-badf-0238-7c62122e2d05@samsung.com>
In-Reply-To: <58e1cfb2-cd35-badf-0238-7c62122e2d05@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Jan 2021 11:07:30 -0800
Message-ID: <CAGETcx_Q_FvdL7ghC9Z7p9RcoBRYHeyTB1PRYk==HMv+NzJBzw@mail.gmail.com>
Subject: Re: [PATCH] soc: samsung: pm_domains: Convert to regular platform driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:03 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 13.01.2021 21:27, Saravana Kannan wrote:
> > On Wed, Jan 13, 2021 at 3:03 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> When Exynos power domain driver was introduced, the only way to ensure
> >> that power domains will be instantiated before the devices which belongs
> >> to them was to initialize them early enough, before the devices are
> >> instantiated in the system. This in turn required not to use any platform
> >> device infrastructure at all, as there have been no way to ensure proper
> >> probe order between devices.
> >>
> >> This has been finally changed and patch e590474768f1 ("driver core: Set
> >> fw_devlink=on by default") ensures that each device will be probbed only
> >> when its resource providers are ready. This allows to convert Exynos
> >> power domain driver to regular platform driver.
> >>
> >> This is also required by the mentioned commit to enable probing any
> >> device which belongs to the Exynos power domains, as otherwise the core
> >> won't notice that the power domains are in fact available.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >> Some more comments are in the following thread:
> >> https://protect2.fireeye.com/v1/url?k=8ac052ac-d55b6ba4-8ac1d9e3-0cc47a31c8b4-9068b559b0fd155d&q=1&e=b393c3ff-16ba-48a4-9d72-6805d02971d5&u=https%3A%2F%2Flore.kernel.org%2Flkml%2F2556a69b-5da5-bf80-e051-df2d02fbc40f%40samsung.com%2F
> >> ---
> >> ...
> > Skimmed through this patch and at a high level, it looks good for what
> > it's trying to do. Thanks for doing this!
> >
> > Btw, I assume that this won't work with fw_devlink=off/permissive
> > (default since 5.10 or earlier)? My concern is that we might
> > temporarily set fw_devlink=permissive by default if the other
> > breakages aren't fixed in time for 5.12? How do you want to handle that?
>
> I've applied my patch on top of vanilla v5.10 and checked on my test
> boards. Surprisingly everything works fine, so something must have been
> changed during the last few years as the power domain driver in the
> current form has been written long time ago. I remember that the moment
> when platform devices are created from the of nodes has been change at
> some point, so maybe this is somehow related. Anyway, the platform
> driver for Exynos power domains registered from core_initcall works fine
> with v5.10 kernel.
>
> I have no strong opinion on the way of merging this fix. It can go via
> Samsung tree, so in the end the v5.12-rc1 will have both my fix and your
> change, but won't be fully bisectable in-between. Krzysztof, what's your
> opinion?

If it doesn't break anything without my changes, then let's try to get
it merged independent of my series. This is a good change even without
my changes.

-Saravana
