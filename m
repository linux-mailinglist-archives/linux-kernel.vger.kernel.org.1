Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8FC2CADFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbgLAVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLAVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:01:52 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:01:06 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id r23so1050758uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWYVSLoMbHTMBYXNZeA1jDQCPhRLUCzYMMW57m2xkJc=;
        b=dNmi4nRyPM2wRJRGonutC+zgIyr66kWdax56icmne/Z0wivDKzLX/ICd2nHQHlClGT
         3mr6iu8pvafMB7o/B9BZmlE96NPBGn6Jaf75OERBl6VuKu1z0ZEd0+BvGftZCp2edQAX
         5OPQ7mvMfTkYFVtwpcvMp1XlX/2ebq3CKnu9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWYVSLoMbHTMBYXNZeA1jDQCPhRLUCzYMMW57m2xkJc=;
        b=W6S7JqxvWd9T6beYmSGq5fjMiZM0tVgJjUVejkIrtydCfz5QZLk1EzuXfcM3qBX2jn
         YfShtFaWsaUH0Q9cB3T7PLYX1olED1SMFjW0AKqtdYFz+ACoGcJ5J7Si5N081O2y3Okb
         wiOFSBHQs9kb4pyxGcjR04DA0wCwGXcP8m0IOibXvpI8326U2ZXnp/TcKUsk1GyZX98a
         zNa03bF/49R+yilTIyXRQkCQriM/fhSH7eU7TUPFo/O4Qaxxk1n4Yo8ZDMzmPnXQ+2D4
         IQq/+dYz6TtneyTTb5wbZhah7ewcNfJKaQCq/OHgG8TwXqgppEBxcaYLCYwXeRh43pe9
         RSuw==
X-Gm-Message-State: AOAM532ZHd4SiU76rvGsaakMWdINP4Ct+UxrtZ2JT2mxQJ9Qc6lu2ZhX
        C352yFh1uOU+SYfUJmXwH6SJppSYxK5i/g==
X-Google-Smtp-Source: ABdhPJzJrOg9DB3t6NEmUivlBfDm1BzBjmRKnsjVkflSAGXHMiu3H3refe0ebI5HvM8QofLA3sJn7w==
X-Received: by 2002:ab0:23d5:: with SMTP id c21mr4522640uan.129.1606856465174;
        Tue, 01 Dec 2020 13:01:05 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id x20sm80905vso.19.2020.12.01.13.01.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:01:04 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id p7so1707757vsf.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:01:04 -0800 (PST)
X-Received: by 2002:a67:8c41:: with SMTP id o62mr4909937vsd.49.1606856463746;
 Tue, 01 Dec 2020 13:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20201109170018.v4.1.Icaa86f0a4ca45a9a7184da4bc63386b29792d613@changeid>
 <20201129221047.GH1162850@ravnborg.org>
In-Reply-To: <20201129221047.GH1162850@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Dec 2020 13:00:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X=qA9jB9KJZopWM5qmW5XYonX7LVQdmQ1cqoajcsBGUg@mail.gmail.com>
Message-ID: <CAD=FV=X=qA9jB9KJZopWM5qmW5XYonX7LVQdmQ1cqoajcsBGUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drm: panel: simple: Fixup the struct panel_desc
 kernel doc
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 29, 2020 at 2:10 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas,
> On Mon, Nov 09, 2020 at 05:00:55PM -0800, Douglas Anderson wrote:
> > When I run:
> >   scripts/kernel-doc -rst drivers/gpu/drm/panel/panel-simple.c
> >
> > I see that several of the kernel-doc entries aren't showing up because
> > they don't specify the full path down the hierarchy.  Let's fix that
> > and also move to inline kernel docs.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks, applied to drm-misc-next.
>
> Could you do a follow-up patch that moves the rest as inline comments
> and verify that all fields are described.  (W=1 should show no warnings).
> That would be appreciated!

Ah, I hadn't realized that you wanted it all moved and thought
originally you just wanted the deeply nested stuff.  See if:

https://lore.kernel.org/r/20201201125822.1.I3c4191336014bd57364309439e56f600c94bb12b@changeid

...looks like what you want.  :-)

-Doug
