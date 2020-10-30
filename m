Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48E92A0353
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgJ3KxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgJ3Kwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604055127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1EL/9Be6tly17XVpcb5msTAyiBBVJln1M0uiO+xToM=;
        b=SvRfyT8s8JI/G6/UFi/egFz0/UlmN/RKmcT4imbFovoWybpZlYerG81dV2dToznn+L6AXN
        TmH86JtdUaYrr6PEiR5PuRd6wc+u9DjzUUlcBruuTq+puesYoj+Xkyf1si1RcVqMNG/K0K
        S8aTZYHNex7d5TxzhQSgCdSkdInkCPc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Gvl5OqTKNR6jI6goubdRhg-1; Fri, 30 Oct 2020 06:52:05 -0400
X-MC-Unique: Gvl5OqTKNR6jI6goubdRhg-1
Received: by mail-pg1-f197.google.com with SMTP id y10so4351409pgq.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1EL/9Be6tly17XVpcb5msTAyiBBVJln1M0uiO+xToM=;
        b=XU5/ERlls88SoJDgX2QAoQx0k71UiCtiaxGIVqrbBKpLaXoGYIniaxspBM8I+CylOP
         OlvTcNarUnVXoQZ4H5MuK5DnxhXHQGMjm0mBHT4gqEkfMAkP3CgKyNAycYzbUoVaCqef
         oZvzJfdu4UO6YaC0SPAcfSjQ3kTb6amx0/r77gb9V8PKBK98ocG0sAyNhZLyHPeyxnzD
         Er3hQrdaXqkDA0uIJjCdR65Tp+r2BFcXrBZzhA/uuMALMKebcyFoVicGDrL+eTallKUU
         uiOwGGY1a3hxJBn4yoUlNIwJQvrOWpGo+T5yGeePci2FXMKk9WD2Vy/WRWqT/nq80ZP9
         3png==
X-Gm-Message-State: AOAM533ag3/d7a6pNmHlQRxLBu00XO8OkkFmT6gaY/GqX6xWNf4RVk2J
        ymVar04TcJGmFX8J+5/WHwyyGftgNv7X+ZklE9wQStaB2IFsY+mYPdLqAaWT3BLTfgnZzPdQMv0
        ++3eB4HyutqUKra9QEDrfpbhKT9EW+x96Mvc8wfq1
X-Received: by 2002:a17:90a:3d0f:: with SMTP id h15mr2123540pjc.234.1604055124704;
        Fri, 30 Oct 2020 03:52:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZm8Jjrt7RwQSmEXD6n0EGanX49bnWzOOT4SJxESfA9P6Q0Zin/X974quyCTlaFgiQZ0aiYXBGx0kCgB58FOk=
X-Received: by 2002:a17:90a:3d0f:: with SMTP id h15mr2123522pjc.234.1604055124441;
 Fri, 30 Oct 2020 03:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
In-Reply-To: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 30 Oct 2020 11:51:53 +0100
Message-ID: <CAO-hwJLn5XKV+cp+fCRY395uBWuX=JrxgiGSHUnJXFpTzFWu4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: HID: i2c-hid: Label this binding as deprecated
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        andrea@borgia.bo.it, Kai Heng Feng <kai.heng.feng@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Foreword: I was about to say "yeah, whatever" to please Rob for once.
But after re-reading this and more specifically patch 3 of the series,
that won't do. More comments inlined.

On Sat, Oct 24, 2020 at 1:23 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> As pointed out by Rob Herring [1], we should have a device-specific
> compatible string.  This means people shouldn't be using the
> "i2c-over-hid" compatible string anymore, or at least not without a
> more specific compatible string before it.  Specifically:
>
> 1. For newly added devices we should just have the device-specific
>    device string (no "hid-over-i2c" fallback) and infer the timings
>    and hid-descr-addr from there.

And that's a big NACK from a maintainer point of view. I know in the
device tree world these strings are important so that people can just
say "I have a device compatible with X", and go on, but in the HID
world that means we will have to implement one compatible struct per
vendor/device, which is not something I want to do.

You can think of it as if you are suddenly saying that because it
would be easier for a few particular USB devices that need a quirk,
you "just" need to add the list of *all* USB HID devices that are
around. i2c-hid should be a driver that doesn't change unless 2 things
happen:
- there is a change in the spec
- there is a specific quirk required for a device that doesn't follow the spec.

So if having device tree support for these means we suddenly need to
add every single device around in the compatible table, I would be
tempted to just drop the support for those new devices.

Again, you (or anyone else) have to understand that the descriptor
address is just a parameter which is known at the manufacturing time,
but that can vary with different vendors and or products. In the ACPI
world, this parameter is provided in the DSDT, and there is no reason
for it to not be provided in the DT.

The last thing I want to see is people using device tree having to
recompile i2c-hid to register their own device.

If this part of the Device Tree binding is so important for the DT
world, then we should split up the DT bindings from i2c-hid, and have
some platform driver that would handle a conversion between devicetree
and platform data. But this driver won't be maintained by me.

I agree adding the various sleep parameters in the platform data is
not good, but I prefer that over having to maintain an endless table
of parameters for every single i2c-hid device out there.

Cheers,
Benjamin


>
> 2. If there's a need for a device tree to be backward compatible, we
>    should list the device-specific compatible string and add the
>    "hid-over-i2c" fallback and the various timings.
>
> [1] https://lore.kernel.org/r/20201019211036.GA3595039@bogus
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - ("dt-bindings: HID: i2c-hid: Label this binding as deprecated") new in v2.
>
>  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> index c76bafaf98d2..733a5f053280 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> @@ -1,5 +1,8 @@
>  * HID over I2C Device-Tree bindings
>
> +WARNING: this binding is deprecated.  Instead of using this, create specific
> +bindings for each hid-over-i2c device.
> +
>  HID over I2C provides support for various Human Interface Devices over the
>  I2C bus. These devices can be for example touchpads, keyboards, touch screens
>  or sensors.
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>

