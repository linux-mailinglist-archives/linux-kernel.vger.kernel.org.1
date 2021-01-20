Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3610A2FCE26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbhATKSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:15 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35826 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbhATJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:54:14 -0500
Received: by mail-oo1-f51.google.com with SMTP id r199so1303583oor.2;
        Wed, 20 Jan 2021 01:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKdmrPjDxDkC7kebTHfXZMY5mmdlyQC5d4C8G3I8zG4=;
        b=uHOkLhhchh3wrnMBFfuNJP28pECScdezZPwZ3X0sN27yBU2zdn2GiXEuo4WC9mPk6Q
         ACyoy9myqo4KwXV5ApTo9wbh832+wcox6eXjSffFlLT7rOJUZd85k7KrJT/d+kuKJGaA
         b7Fst8xVOXEaybAUmvvUBtxi6zZVQzrkEKRucPDapkgN5utUc9HAgbuLwJKA/Z2GjH2C
         nU+c/CMMSKhla0ZJUf9uR5FMmXYNNwxcfGvib3+EGlKWXFwSi6FoCj3n9AzsU5qHWeuy
         K1G+889wqYr8lxDmTZs1lDJTFF8GVSzrSYsAUW/t5zhIztXt/HkZqVDxioLgWT9z25up
         AVhw==
X-Gm-Message-State: AOAM531ijdAGHmNab/N3/QIrbwpmHmHPryI3qy+O1A9g7axvY5yc882b
        9AbX/T2MbpJ4Txl3oDtqDYdIGZvDUQGilu+DVJI=
X-Google-Smtp-Source: ABdhPJzqyqCGlwNNy6t/pIDGXQ5rPXt7f2gx7FFa8gCWaBjw+sB/bUn6h3qsOvhkpph+WN3oar0pl9utYUMNwmYDJIE=
X-Received: by 2002:a4a:96b3:: with SMTP id s48mr4016275ooi.11.1611136414408;
 Wed, 20 Jan 2021 01:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20201218210750.3455872-1-saravanak@google.com>
In-Reply-To: <20201218210750.3455872-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jan 2021 10:53:23 +0100
Message-ID: <CAMuHMdUpZELgL4qUCs1VH0UUeckpTwqYLrMy2ETPzrpuUwkLnQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
To:     Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Fri, Dec 18, 2020 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> Add support for creating device links out of interrupts property.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

This does not seem to add all links.  I see links being created to the
secondary interrupt controller (e61c0000 "renesas,irqc"), but not to
the primary interrupt controller (GIC)

Which is good, as the GIC driver is not a platform_driver, and thus
creating links would break everything ;-)

BTW, I'd _love_ the GIC driver to be a platform_driver, as the GIC is
part of a power/and or clock domain on Renesas SoCs...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
