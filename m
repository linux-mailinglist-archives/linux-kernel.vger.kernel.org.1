Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B312F6955
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbhANSTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbhANSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E14C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:19:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v67so9402641lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5+Iu0D3KKU369AvPLEzIT1mfTbZwWzsPxK8gu9Bl3U=;
        b=Ff91w5SC7YAdLa8ezSNsw+RRCTfNQ4d2QEDtkSQDt2N+aVX3kEEH9+QV8TvQbzyAw0
         lo6eDRNx7M1CUkCJY1BoDLgFhbRbnBNflbmUtW7SIVVl1BgpQMHCyDx0S+0jSc08fv4B
         xXMMVGOMFGPPkUd/cNyLT+dOK11t00qbH2pfvCjleUI9ysgzNWUaJyUeJxba8ZwxRYwS
         sL8bytGGMSOkulopX6KYd8sWJ1qLtuqzPyXXcBMMvguvk3QIrQEHl5uzYmgkMW8s7FkO
         d4Ok9fhbZzlBJjWiXb1bpjJhBUJCqta6/DplSW4khyjdpQmysDW3phBuOM2MOxbCI7zb
         7KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5+Iu0D3KKU369AvPLEzIT1mfTbZwWzsPxK8gu9Bl3U=;
        b=ZB6pY74NPJ2BwnqRB3i7mh3DQoRRlVWqJqUMMRiYmWt+3gwNr4p7Fmik4bIuoLbzql
         POr6c++8nMsIIU213AO14/moLR5L0SGvUatKH1Hx/nP1Vkearw4U5cgiMywGwb053Kv9
         BX51uhuaGN3OeercBdfU13ubRiYundUUaV5OzQuI+60HFYiqP1XTHXPEV0aLBRLzuyJg
         TZGb70nudVIZ9rP66gsuVByzFWf21xdUF3udODVSBDoiJyt1W2Md50X0LBd36cRNeoA8
         N6zXsYk3Nm3tTXwhKHDhCMpy2eaYcgbqbFxIyg3iljlbYeJlIT9tnkRo2Dc5lMGtK7DT
         twWA==
X-Gm-Message-State: AOAM533nYFESIR7irWmiNOYSLygB3hgcd9rIYummppmcaccX/Hs5Nzub
        slaUeCEfckZXIaqqfx/MdNVigyjIrUTNCin10wfstA==
X-Google-Smtp-Source: ABdhPJzagQddRmcMWNu+seuYyLPsdgSvq2dS/tzP2KDnHeukIR+aZq3lJLfF2tN/SgIJ1wou0vbbHdP4d7Y8xqUjtDQ=
X-Received: by 2002:a19:ecb:: with SMTP id 194mr3631354lfo.70.1610648357986;
 Thu, 14 Jan 2021 10:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20201205004848.2541215-1-willmcvicker@google.com>
 <X9e5vl+nw4GQNYEw@google.com> <nycvar.YFH.7.76.2012171119240.25826@cbobk.fhfr.pm>
 <CABYd82Z-HJfn1Ts=k7RYrvWCHj=1578--9Y7A0giFn2=RRWcVA@mail.gmail.com>
In-Reply-To: <CABYd82Z-HJfn1Ts=k7RYrvWCHj=1578--9Y7A0giFn2=RRWcVA@mail.gmail.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Thu, 14 Jan 2021 10:19:01 -0800
Message-ID: <CABYd82bdoNDpHd3kH47eEyAV7JrxHPFRGd4eCO6Y55ZwzKz_JQ@mail.gmail.com>
Subject: Re: [PATCH v1] HID: make arrays usage and value to be the same
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        security@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Coster <willcoster@google.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

I noticed this hasn't merged yet. So just sending a friendly reminder.

Thanks,
Will

On Thu, Dec 17, 2020 at 10:42 AM Will McVicker <willmcvicker@google.com> wrote:
>
> Great! Thanks for the reply.
>
> --Will
>
> On Thu, Dec 17, 2020 at 2:19 AM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Mon, 14 Dec 2020, Will McVicker wrote:
> >
> > > > The HID subsystem allows an "HID report field" to have a different
> > > > number of "values" and "usages" when it is allocated. When a field
> > > > struct is created, the size of the usage array is guaranteed to be at
> > > > least as large as the values array, but it may be larger. This leads to
> > > > a potential out-of-bounds write in
> > > > __hidinput_change_resolution_multipliers() and an out-of-bounds read in
> > > > hidinput_count_leds().
> > > >
> > > > To fix this, let's make sure that both the usage and value arrays are
> > > > the same size.
> > > >
> > > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > > ---
> > > >  drivers/hid/hid-core.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > > index 56172fe6995c..8a8b2b982f83 100644
> > > > --- a/drivers/hid/hid-core.c
> > > > +++ b/drivers/hid/hid-core.c
> > > > @@ -90,7 +90,7 @@ EXPORT_SYMBOL_GPL(hid_register_report);
> > > >   * Register a new field for this report.
> > > >   */
> > > >
> > > > -static struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values)
> > > > +static struct hid_field *hid_register_field(struct hid_report *report, unsigned usages)
> > > >  {
> > > >     struct hid_field *field;
> > > >
> > > > @@ -101,7 +101,7 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
> > > >
> > > >     field = kzalloc((sizeof(struct hid_field) +
> > > >                      usages * sizeof(struct hid_usage) +
> > > > -                    values * sizeof(unsigned)), GFP_KERNEL);
> > > > +                    usages * sizeof(unsigned)), GFP_KERNEL);
> > > >     if (!field)
> > > >             return NULL;
> > > >
> > > > @@ -300,7 +300,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
> > > >     usages = max_t(unsigned, parser->local.usage_index,
> > > >                              parser->global.report_count);
> > > >
> > > > -   field = hid_register_field(report, usages, parser->global.report_count);
> > > > +   field = hid_register_field(report, usages);
> > > >     if (!field)
> > > >             return 0;
> > > >
> > > > --
> > > > 2.29.2.576.ga3fc446d84-goog
> > > >
> > >
> > > Hi Jiri and Benjamin,
> > >
> > > This is a friendly reminder in case this got lost in your inbox.
> >
> > Hi Will,
> >
> > I am planning to merge it once the merge window is over.
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
