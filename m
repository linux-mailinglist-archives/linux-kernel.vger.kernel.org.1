Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255F12F8982
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbhAOXmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOXml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:42:41 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B347C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:42:01 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id d8so10258260otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vf2mv3ce7DHbGNAfPAeihSYLyEs49+dxZFxLcYTSIQ=;
        b=mwaW8nNOAl8u79tznLUmzLCoYn+tAkwKbjawPCOTy/2e89WHtxaJYXaiaF1q5/k1Z6
         AKf3eKEWgDoPNifLjcxJPP555TzrsuyyjZgD+pN07LY4Hs/RfJ3J4DuNyhE20l7k9ApF
         3SM+nm1muKMISrAXxfXNtN8w6v8fpyiqRsEh/AeDR5CyUPzmhj2bYlaCGxlOmyCbAa9j
         gwYHQrrtobHjJCM0aYImiDG0KLkUCJYaZ4qJGWcFYPvyKYnHhlISGEcGxPwIMS0rqevs
         gRi1AYWpZTG2B5/pfH3wbYN1EUt00k7gmocENLwGs9+EatKpJPqrt3wCa3OEP37z56HY
         vq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vf2mv3ce7DHbGNAfPAeihSYLyEs49+dxZFxLcYTSIQ=;
        b=H9vlEmO5NYzyBkV2RvcDJZfKXkCj2uC/kipgwHO5bVtDmwpYNmPYrTZJq6+HxOCaaD
         fZVtW0tMRAv2lxP7mDUWZXOUAepKN9aIFmmEJGdACLfzoUK7+xG+aVBHLVMXDVeZx95t
         WVlcSdHR9q2Pu9edXwG51dsYvzfK3JaJScvs9vD63dTeIjgQG1aLi6C/qC1FDpcLpnQZ
         kDZtCXv9cga57uOlmrcP10Cw8QXe2rRP55cZJNoDvjwjRAYyTgloedqJvZADa2X8h71s
         wMKP8J8WiMzwc+nSpLGzw9EuMffJBg6ub5c3M1ulTGb1SqaGV6f2Pwwbv78AkrTsti9q
         c2Dw==
X-Gm-Message-State: AOAM531vkgFkkthYBN2Mw6WCkBWWS44cISkk+8HlOFOmRDIuLa1CIXEY
        sZ3OfNYqfBoh7zOO5TM2anKdPiB+q08nODdicc0t+Q==
X-Google-Smtp-Source: ABdhPJx0PWfCLKisV34XLGYfHHXHfm5FqCXcvkKncwz5zlb34VZAFqMCZcVtiWGrkIGquPq7nCnlPph/uqnBthe0hfU=
X-Received: by 2002:a9d:6199:: with SMTP id g25mr10230665otk.17.1610754120789;
 Fri, 15 Jan 2021 15:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20210115170953.3035153-1-elver@google.com> <20210115215817.GN2743@paulmck-ThinkPad-P72>
 <CANpmjNM9++GSuSHH+Lyfi23kW8v0aXLX+YbD20UX8k5jAAaSnA@mail.gmail.com> <20210115233156.GO2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210115233156.GO2743@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Sat, 16 Jan 2021 00:41:49 +0100
Message-ID: <CANpmjNPDkqULbPQZw29axaBaueWs-H8BeyDrEHSBn=xgtN7Lkg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Add missing license and copyright headers
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021 at 00:31, Paul E. McKenney <paulmck@kernel.org> wrote:
> On Sat, Jan 16, 2021 at 12:21:53AM +0100, Marco Elver wrote:
> > On Fri, 15 Jan 2021 at 22:58, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > This one seemed straightforward and I heard no objections to the previous
> > > two-patch series, so I queued them for the v5.13 merge window, thank you!
> > >
> > > If any of them need adjustment, please send me the updated patch and
> > > tell me which one it replaces.  Something about -rcu being in heavy
> > > experimental mode at the moment.  ;-)
> >
> > Thank you!
> >
> > I would have given the go-ahead for the other series next week Monday,
> > but I think that's a holiday anyway. :-)
>
> It is indeed!  I guess you had Wednesday last week, with next up being
> Friday April 2?  ;-)

We did, correct, and the next one is quite a while then. :-)

Happy holidays,
-- Marco
