Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518622AE355
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbgKJWZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKJWZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:25:23 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFCCC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:25:22 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id v16so86708uat.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nY2XXyY7Xq21Hxfj1LDgWWgmNedp6//ojAi+4msIvrM=;
        b=OSDQJmdFw/h0nsn3AcX7ryeNokKHr7gV5+/GoRP1SzO1iG3Ye9eX35+TL6TsRj8I3U
         ffb1nKO5oUiYNKsZphwZuNp5Y6x8C1z4hCabwRK2jYDPMvwWIBHGkG/CUIc69HJraUGS
         eWRFGaOcIMwjwNtlIivuQlQOmUbHZbtlvRGws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nY2XXyY7Xq21Hxfj1LDgWWgmNedp6//ojAi+4msIvrM=;
        b=RyuOc54QBV4VPt4vOoS2+KecihucBFcXnGChU2OZ3U2HXuGIF6uSvZve/wrGfLEPBt
         7mLZJ1XAFv/8e0+C4qufJyYuwutRixDFE2Uajr/ZUkRoAqBwcWYEldoUarI76QOYn9er
         uMDWJtgh5ZfT3WNqrau9GNsm5wP9uB5hXdFnGAoULj84bKAxyB6YlrZaB9FHP6khmdlP
         PeFaNaxtgzObfKkrH6VfQwnt/qFG2t/nErOoJK0NAWbXh8YN/EUw58iIcz7Spagxpjov
         wai2qmhPUWYlB4XOpdCoLa0K3ehQ/D/D/+bRepHzYIavRhGlBKfsTPiaB1/fYBcgMzdT
         IBug==
X-Gm-Message-State: AOAM532nfgDwBK7ZFUBG2hZudnzgpHXtaaTZLD7H/QErAvz60EJnGlsb
        tq/jqbnXCRKC/Lz9oAdOkSpscY8d6PMNOg==
X-Google-Smtp-Source: ABdhPJwFHD4Ya694ordb51ilkCZpzXbxTFtcEWA4gIiXhNvmREJAZOkth3qV0O5FRfQOYNERRtq8cA==
X-Received: by 2002:ab0:2109:: with SMTP id d9mr11424093ual.76.1605047121119;
        Tue, 10 Nov 2020 14:25:21 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id o12sm16465vke.22.2020.11.10.14.25.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 14:25:21 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id f7so28580vsh.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:25:20 -0800 (PST)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr13533069vsp.34.1605046659591;
 Tue, 10 Nov 2020 14:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20201109213636.1267536-1-dianders@chromium.org>
 <20201109133526.v5.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid> <d51318d1-5d26-f840-2651-42a1134d407b@redhat.com>
In-Reply-To: <d51318d1-5d26-f840-2651-42a1134d407b@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Nov 2020 14:17:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WL7C_OPOQqJY_9nDP4Riz6c4XMHXBBj7FkzMJPBVo9Nw@mail.gmail.com>
Message-ID: <CAD=FV=WL7C_OPOQqJY_9nDP4Riz6c4XMHXBBj7FkzMJPBVo9Nw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] HID: i2c-hid: Reorganize so ACPI and OF are
 separate modules
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Jiri Kosina <jikos@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pavel Balan <admin@kryma.net>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 10, 2020 at 1:01 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/9/20 10:36 PM, Douglas Anderson wrote:
> > This patch rejiggers the i2c-hid code so that the OF (Open Firmware
> > aka Device Tree) and ACPI support is separated out a bit.  The OF and
> > ACPI drivers are now separate modules that wrap the core module.
> >
> > Essentially, what we're doing here:
> > * Make "power up" and "power down" a function that can be (optionally)
> >   implemented by a given user of the i2c-hid core.
> > * The OF and ACPI modules are drivers on their own, so they implement
> >   probe / remove / suspend / resume / shutdown.  The core code
> >   provides implementations that OF and ACPI can call into.
> >
> > We'll organize this so that we now have 3 modules: the old i2c-hid
> > module becomes the "core" module and two new modules will depend on
> > it, handling probing the specific device.
> >
> > As part of this work, we'll remove the i2c-hid "platform data"
> > concept since it's not needed.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v5:
> > - Add shutdown_tail op and use it in ACPI.
> > - i2chid_subclass_data => i2chid_ops.
> > - power_up_device => power_up (same with power_down).
> > - subclass => ops.
> >
>
> Thanks this looks good to now, 2 small remarks below (since you are
> going to do a v6 anyways). Feel free to ignore these remarks if
> you prefer to keep things as is.
>
> And feel free to add my reviewed-by to v6 of this patch:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!


> > +static const struct i2c_device_id i2c_hid_acpi_id_table[] = {
> > +     { "hid", 0 },
> > +     { "hid-over-i2c", 0 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, i2c_hid_acpi_id_table);
>
> Hmm, I do not think these old-style i2c-ids are necessarry at
> all in this driver. I expect all use-cases to use either
> of or acpi matches.
>
> This was already present in the code before though, so
> please ignore this remark. This is just something which
> I noticed and thought was worth while pointing out as
> a future cleanup.

Yeah, I wasn't sure if there was anyone using them.

Hrm.  Thinking about it, though, is it really OK for two drivers to
both have the same table listed?  I'm not sure how that would work.
Do you know?

I don't know a ton about ACPI, but for device tree I know i2c has a
fallback mode.  Specifically having this table means that we'll match
compatible strings such as:

  "zipzapzing,hid"
  "kapowzers,hid-over-i2c"

In other words it'll ignore the vendor part and just match on the
second half.  Just to make sure I wasn't remembering that from a dream
I tried it and it worked.  I don't see any mainline device trees that
look like that, though.  I could delete it, though it doesn't really
take up much space and it seems nice to keep it working in case anyone
was relying on it?

For ACPI is there a similar fallback?  If not then it seems like it'd
be easy to remove it from there...


> <snip>
>
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> > index aeff1ffb0c8b..9551ba96dc49 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -35,12 +35,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/hid.h>
> >  #include <linux/mutex.h>
> > -#include <linux/acpi.h>
> > -#include <linux/of.h>
> >  #include <linux/regulator/consumer.h>
>
> I think you can drop this regulator include here now too ?

Good point.


> > diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
> > new file mode 100644
> > index 000000000000..15d533be2b24
> > --- /dev/null
> > +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> <snip>
>
> > +static const struct dev_pm_ops i2c_hid_of_pm = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(i2c_hid_core_suspend, i2c_hid_core_resume)
> > +};
>
> This dev_pm_ops struct is identical to the one in i2c-hid-acpi.c
> and the one which you introduce later in i2c-hid-of-goodix.c
> is also identical, so that is 3 copies.
>
> Maybe just put a shared dev_pm_ops struct in the i2c-core
> (and don't export the suspend/resume handlers) ?

Sounds good.

-Doug
