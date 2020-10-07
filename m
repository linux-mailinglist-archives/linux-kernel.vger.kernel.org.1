Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2E2861FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJGPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:23:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05816C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:23:37 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u74so1376260vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97+yjlANsi6ZBekO7EX7bWHy21i3TSycRzcla1VOi3I=;
        b=qL+vW84wgR4taPVJZFNbV0h3t8avcfxTQaUp7QM22U+kXgEf72a+0sY1pZ6dH7H/zX
         O/APo8e+fKFdxbzFopIPsdmrUxt88zcV4Ejr1POKFxzQif5Syr8DAQwnkhC9nd1GptK3
         AAb1aBKW4BjUpTVjIPRJNs+o4LPDFPEHNzs+Bl1rv4gTMuz6NJtXcPN4edHr122Ioz29
         W7Nj3U4Pd9oao29RzM2+3xU4jIhNxUdsFbHT4Y1lu1taGIJLj4OLHrSgb26O61UGU4km
         q6MkqJ8ed2k2k23nggwrHN8P05YJLGsg5wHP33b+ltec71FQnDDPh/149Z86pECgbZpF
         1TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97+yjlANsi6ZBekO7EX7bWHy21i3TSycRzcla1VOi3I=;
        b=CnGhC6z/9DHWqFG5sLSr5bBxdL6I1DelR18/rHfzPJeANr8NQKVrhX6ByFeB4ZdiYw
         bvynoOdsTJ5E+HsN6zt2rFFMRCEcGpdgs1MKH7cXqLTQVk2hq5H8tsMSluaONJLgz+EO
         MS6c3XzXhNWiDWji0xYCRLki+VVDGwsYiKYoHtl82FvMijooORfDVzaBgAZVyhf1jvA3
         b7ayKo/IQhjxq6qxpS7AjG9Y66D8CZSMTOJnpK6WVki+I9FoWbZrRSzhpibEXaw+WNwp
         MaVIsKjvV0HonhV6x8lH9W/oLtkIuE4Sdsmye5xoIAmT2NgiV0sGs5Pl/O24PkK6QbZH
         2VWg==
X-Gm-Message-State: AOAM531OZxlkIwUthBiH5xH6npd5roXGXKb4Dl1763LSf/ukI9O/gNvE
        D0AXqbaNWjt1aPmHeLe2LcQLv/VrMCZ+wthRFnGHmQ==
X-Google-Smtp-Source: ABdhPJyjZIK+mRfuzb1XXhqOeASTuH0E1h5WcasqMLtQOTEn6n0cqki1LNVLq6jS/KED3Ghd5xzgqN0dGhJHWzqzwfA=
X-Received: by 2002:a67:6c86:: with SMTP id h128mr1982196vsc.42.1602084216162;
 Wed, 07 Oct 2020 08:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201006160516.319830-1-ulf.hansson@linaro.org> <CAJZ5v0iNQ51C5WYUy-ZhzpFGMLxSAVV8=xxYBfMX9ia6FOpg1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iNQ51C5WYUy-ZhzpFGMLxSAVV8=xxYBfMX9ia6FOpg1Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Oct 2020 17:23:00 +0200
Message-ID: <CAPDyKFrLTsYWVhR03hQgRJGGEkmTk5etGR5RcKgMW+Nj60+vhQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] power: avs: Move drivers to the soc directories and
 drop avs
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd

On Wed, 7 Oct 2020 at 17:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 6, 2020 at 6:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > The avs drivers in drivers/power/avs/* are all SoC specific drivers that
> > doesn't share any code. Instead they are located in a directory, mostly to keep
> > similar functionality together. From a maintenance point of view, it makes
> > better sense to collect SoC specific drivers like these, into the SoC specific
> > directories.
> >
> > Therefore, this series moves the drivers, one by one - and in the end, it
> > deletes the empty avs directory.
> >
> > It seems best to me, if this can be funneled via Rafael's linux-pm tree. Then
> > when going forward, each driver should be managed through the SoC maintainer's
> > trees.
>
> That's fine by me.
>
> I'd like to get an ACK from the arm-soc side on this, though.

I have looped in Arnd, to get his opinion on this.

Although, I think the people on cc already send pull requests to the
arm-soc maintainers (or perhaps it was these people you were referring
to), so just awaiting their acks should be fine, I guess.

Kind regards
Uffe
