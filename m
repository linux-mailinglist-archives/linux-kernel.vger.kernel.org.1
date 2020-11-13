Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8372B1B56
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgKMMvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMMvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:51:31 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E135FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:51:30 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so7543348pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlSweQC/vbr6vVyH3NIdsAt2yYJjWCSYyoY0OD4IcB8=;
        b=dwLawQ2R+OOwSH39oYEUA0iMfpYt3lw8v8lDpkj5TykedwuvLf/Qztt0VfKGbkAEEB
         Gznivr2/m060TEu3G24XrivgpxgsG0uQzwkIGZu6Eu7mmZuNUMVsuIKXwGxVQIqkG98J
         l6roqTW+fSOCMqmiCgpGo2JgL0HfMLv8p8sK+n+ZlIuckzq9xCHMMmc87ZRU/GpdP95T
         msLeaiSIaEtj7dLOEPmxl8xtpejQBB6Vgn9kB1jHPrTznciwzJjR4H7om7sc9sptmrvz
         T1b6gqZlKU3cqJ/5/PdIeD4MeJbb6xsRAu69CupSSrEd+BaDocLySEyud/Lv97wiHyZM
         /bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlSweQC/vbr6vVyH3NIdsAt2yYJjWCSYyoY0OD4IcB8=;
        b=DPUm8JBTEuxe/tUbJuNn005rl8khdwMaMhH9ZCIvXl1vscOU+KhJmKHQOz/+eUq9VH
         Sxqn6EnwVcsMytLqZD3ldEJPldhpxP0NT0s/SxlZFCTCZo6KQXCx0aXJYsV80A9+ZvV2
         LTw2JoBi4wWcg7Gxx04rWvTWEGIiJyvx7ywtvC9gt5hrxbe0ZsX/3AmA8UCyMenod2Gl
         HZljsYkUlklfz1x0eVki9v4V2Mj8dv9mlc1xE0i8Ach7IekVEln+t+HnklvvIWAYLoL4
         HOeZddlLd3Sy80TcG49Kn6aUANIAeAqfsx3ddaVHr9gp09pnI0/4kuXY4jUibiWyEL8o
         l2RA==
X-Gm-Message-State: AOAM530UENAGznPMKtfDsP7WZ+yWLTz3LJNaz7YofsUqTOOvZxX3rF5/
        y1SnQzLQOUsVpSiern+zX0iZ2esREWzkGdCLOqYtDw==
X-Google-Smtp-Source: ABdhPJwlHODXN1Li2PDm3D3teyG41NzlM71F1W15YU+kTJo10kkqtHjKM1w5zGh+JoDND4NYH/NRz+Gu59EF7AM/AlM=
X-Received: by 2002:a17:90b:300b:: with SMTP id hg11mr1217625pjb.41.1605271890393;
 Fri, 13 Nov 2020 04:51:30 -0800 (PST)
MIME-Version: 1.0
References: <f3a7a153f0719cb53ec385b16e912798bd3e4cf9.1602856358.git.andreyknvl@google.com>
 <20201113123035.tjllvijjzd54npsf@linutronix.de>
In-Reply-To: <20201113123035.tjllvijjzd54npsf@linutronix.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 13 Nov 2020 13:51:19 +0100
Message-ID: <CAAeHK+zd0ucaj8EJ8ro+0ekubrxp5GiBMaBULHJB05dDrzpQGw@mail.gmail.com>
Subject: Re: [PATCH v4] kcov, usb: only collect coverage from
 __usb_hcd_giveback_urb in softirq
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 1:30 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-10-16 15:57:45 [+0200], Andrey Konovalov wrote:
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -1646,9 +1646,16 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
> >
> >       /* pass ownership to the completion handler */
> >       urb->status = status;
> > -     kcov_remote_start_usb((u64)urb->dev->bus->busnum);
> > +     /*
> > +      * This function can be called in task context inside another remote
> > +      * coverage collection section, but KCOV doesn't support that kind of
> > +      * recursion yet. Only collect coverage in softirq context for now.
> > +      */
> > +     if (in_serving_softirq())
>
> Could this in_serving_softirq() usage be replaced, please?

Hi Sebastian,

Replaced with what and why?

Thanks!
