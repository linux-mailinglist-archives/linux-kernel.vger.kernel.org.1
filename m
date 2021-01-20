Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820672FD6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbhATRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404174AbhATRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:16:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F6CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:16:19 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x6so20178028ybr.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9wI5aOMK4QP7qEbl5k5jkAB+hpflm5UBU0G8oOa8LA=;
        b=bHQw89wbOV7Fyq9pJVIClifJ4R4XL+mAjZePqAM5wS6hckVNC8Gj1g5zDKKt2crNAb
         ZP0B5JPFtcowlxGooOulgculUU1EEoLo9TdPArv1F7VN9FD6sWiM4BBBc7NLN6MSUDIZ
         dPd8BuXJlNoZ7a3hIiXrfp2YY4gLoh/RMG4QlFl7HlenzNWXLFN4kQCMbglhkepu9i8Y
         GHZQ5He01i/kQQrbTRkI5/EBUWxeyEnsgs6r1vR6sgJlflH8Suj/FHuFnt2ZK7UTaJKo
         TdjskkEhZH83qZUxy1sCRbqhm7U+KL/fWL6LAtZs2bpJU/ViOyhmRQrwAfCF2kS86cWV
         /odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9wI5aOMK4QP7qEbl5k5jkAB+hpflm5UBU0G8oOa8LA=;
        b=q8tLe80QetOSE04hrvW0M63y0C7PclXgdUdcPgWL4asnSD9ktvSRSrcIa8ygCGeL3e
         7Zm9vUTVHtgPKP5QwB6aPaensYaatd/U6k0RDOqXzCf15dY1E46m3K51Q2dnbDS8wMbh
         Mu72BEKXHXy6Jbv7baejerPwyvZPiOtQ2m4bir8WNuyTBlkwJgi5KE7bsQFsxGQINVRW
         cI0RX2FDpMEaLFaojpturgKLkQRRpfLA8e9jX8tvG66KUNQBjGrRo5fNjkbiUIM9V+p2
         rtZ1tTIlSzBb+IXmuLSWSNHX/TTgK26AXKyCGEp4bvZa2S98kt99NNg8qp4qV3bv93Ew
         65Dg==
X-Gm-Message-State: AOAM5332A7SuD/Dy51zqE7SGU6od+dEljs5lRfm0wRzDALxSxh9zYFXF
        gVQUuS0im8CQb4iFn6j7N/VPYuN/xFHmxxsJBXq9HQ==
X-Google-Smtp-Source: ABdhPJwi1CKgasHlPWQ/KwwGM6Bb7GEe0fwT8QqGkXr5UjjZ4xi0ClwNOMIzy1N4g0aOxnt8VzEuLM+Y07LqYB0YZRE=
X-Received: by 2002:a25:288:: with SMTP id 130mr15326444ybc.412.1611162977999;
 Wed, 20 Jan 2021 09:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
 <CAMuHMdUpZELgL4qUCs1VH0UUeckpTwqYLrMy2ETPzrpuUwkLnQ@mail.gmail.com> <CAMuHMdWEOpbh8xS9W09xudpoym8=J4UzuWTDqF3L+yDuU3k2ZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWEOpbh8xS9W09xudpoym8=J4UzuWTDqF3L+yDuU3k2ZQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 09:15:42 -0800
Message-ID: <CAGETcx8ssLeiHYZcHzXC-mUd=KGxi=pZQqkt8iwcHY-EYOcCjw@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 6:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Jan 20, 2021 at 10:53 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Dec 18, 2020 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> > > Add support for creating device links out of interrupts property.
> > >
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch!
> >
> > This does not seem to add all links.  I see links being created to the
> > secondary interrupt controller (e61c0000 "renesas,irqc"), but not to
> > the primary interrupt controller (GIC)
> >
> > Which is good, as the GIC driver is not a platform_driver, and thus
> > creating links would break everything ;-)
>
> of_link_to_phandle() ignores device nodes where OF_POPULATED
> is set, and of_irq_init() sets that flag.  Hence the GIC is ignored.

Geert,

Yes, I know :)  I wrote it that way for GIC and some of the early
devices that can't use the driver core. And as Marc said in the other
email, it looks like GIC is going to be stuck as a non-device for a
while. But this patch and others that'll follow are all set up for
allowing non-root interrupt controllers to be implemented as platform
devices (or <anybus> device).

-Saravana
