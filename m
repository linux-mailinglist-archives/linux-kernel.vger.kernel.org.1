Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443032D4E79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgLIXEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgLIXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:04:51 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5864C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 15:04:10 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so4496319ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMO74Hau3qL0zw1EsJlNy+Kf0E35Zr9dtC9lm7X7hVs=;
        b=RuTn6HCiV9nNg4HIQMkZc4/Qu4UsvOhRfwgqizxlXSto+yYPbP8PLgrAl0ZzDQCf8t
         dxarwTv0ijUCm6uugEAW7/IeTe3opsFB+6KzhTA6r8maxSDRrX5ui6ZbnsPzGDu8nWvz
         UsjXrsT9uvsY2yC/soUD60lQo4t5m9SKfRsE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMO74Hau3qL0zw1EsJlNy+Kf0E35Zr9dtC9lm7X7hVs=;
        b=WGLx3EaXBmFKn7y80BV7w3kzF8yvczCpMGf9yym3OTQ9eqrWBFtuRwCtVLHBs01tSe
         7vajcCxOYcVNCrrec3XYXh620SyMZrx0EXxKACc8QJduyPRTvASU5U9lHP2mGbqdzI/v
         Mpnu3oX2BpZ3dRx204l1rxACqDW6R8Ib+y/GIxmGPfaJmeZnk2Wv5w8QSbe8jjZbPVPt
         gCBOmVh74i9tftJLJvgU7TWXzEwyW+znY4LZLrcVF8jtQnfQSbbQhT8ZPqUV1nt+8bAp
         ATUXwZTAmT3DjjIld+Wx3NeTsfZj6IvudbdoNgkCH2EQXEy7X8Si+NelXUMgmkUODdmv
         seRQ==
X-Gm-Message-State: AOAM533Vt7D4+XcqDWwthjHc5fw97Stv60KyVWuCjJz0W2J4zYOM7etG
        HkXQyJfUVFVTPxBtg7/mCNYftGDrKKhy9Q==
X-Google-Smtp-Source: ABdhPJxoTYd+r/qxrxuTeVAHS631LheK5OYdD4d1aYY+TB/oJSZa6TdysUbl9FPLVIUEsIrMKnjGGA==
X-Received: by 2002:a2e:98d9:: with SMTP id s25mr1804696ljj.476.1607555048465;
        Wed, 09 Dec 2020 15:04:08 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h22sm306150lfj.302.2020.12.09.15.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 15:04:08 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id a8so5467760lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 15:04:07 -0800 (PST)
X-Received: by 2002:a19:488:: with SMTP id 130mr1622914lfe.124.1607555046503;
 Wed, 09 Dec 2020 15:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20201118234025.376412-1-evgreen@chromium.org> <20201118153951.RESEND.v3.2.Idef164c23d326f5e5edecfc5d3eb2a68fcf18be1@changeid>
 <CAHp75VdtwyCj7emc7Bk87q7kMQA0sSX81-aK-fMq4qTfTF-c_g@mail.gmail.com>
 <CAE=gft4OW7_pWfco4+kY65tbUGUDzXXDfsVMCP8MN93inVem4A@mail.gmail.com> <CAE=gft4LDh7TmvMgL4_eov5=1Nh0PYVRDxn4eCLsDd5JJyCwAw@mail.gmail.com>
In-Reply-To: <CAE=gft4LDh7TmvMgL4_eov5=1Nh0PYVRDxn4eCLsDd5JJyCwAw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Dec 2020 15:03:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft6_YYszA8k8zALEcDR9LbEtUG8RQKRB793vPgDqdGd7Fw@mail.gmail.com>
Message-ID: <CAE=gft6_YYszA8k8zALEcDR9LbEtUG8RQKRB793vPgDqdGd7Fw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] i2c: i2c-mux-gpio: Enable this driver in
 ACPI land
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very sorry to ping. Is there anything I can do to help get this reviewed?
-Evan

On Mon, Nov 30, 2020 at 11:11 AM Evan Green <evgreen@chromium.org> wrote:
>
> Hi Andy, Peter,
>
> On Fri, Nov 20, 2020 at 10:59 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Thu, Nov 19, 2020 at 7:24 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Nov 19, 2020 at 1:40 AM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > Enable i2c-mux-gpio devices to be defined via ACPI. The idle-state
> > > > property translates directly to a fwnode_property_*() call. The child
> > > > reg property translates naturally into _ADR in ACPI.
> > > >
> > > > The i2c-parent binding is a relic from the days when the bindings
> > > > dictated that all direct children of an I2C controller had to be I2C
> > > > devices. These days that's no longer required. The i2c-mux can sit as a
> > > > direct child of its parent controller, which is where it makes the most
> > > > sense from a hardware description perspective. For the ACPI
> > > > implementation we'll assume that's always how the i2c-mux-gpio is
> > > > instantiated.
> > >
> > > ...
> > >
> > > > +#ifdef CONFIG_ACPI
> > > > +
> > > > +static int i2c_mux_gpio_get_acpi_adr(struct device *dev,
> > > > +                                    struct fwnode_handle *fwdev,
> > > > +                                    unsigned int *adr)
> > > > +
> > > > +{
> > > > +       unsigned long long adr64;
> > > > +       acpi_status status;
> > > > +
> > > > +       status = acpi_evaluate_integer(ACPI_HANDLE_FWNODE(fwdev),
> > > > +                                      METHOD_NAME__ADR,
> > > > +                                      NULL, &adr64);
> > > > +
> > > > +       if (!ACPI_SUCCESS(status)) {
> > > > +               dev_err(dev, "Cannot get address\n");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       *adr = adr64;
> > > > +       if (*adr != adr64) {
> > > > +               dev_err(dev, "Address out of range\n");
> > > > +               return -ERANGE;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +#else
> > > > +
> > > > +static int i2c_mux_gpio_get_acpi_adr(struct device *dev,
> > > > +                                    struct fwnode_handle *fwdev,
> > > > +                                    unsigned int *adr)
> > > > +{
> > > > +       return -EINVAL;
> > > > +}
> > > > +
> > > > +#endif
> > >
> > > I'm wondering if you may use acpi_find_child_device() here.
> > > Or is it a complementary function?
> >
> > I think it's complementary. The code above is "I have a device, I want
> > its _ADR". whereas acpi_find_child_device() is "I have an _ADR, I want
> > its device". I could flip things around to use this, but it would turn
> > the code from linear into quadratic. I'd have to scan each possible
> > address and call acpi_find_child_device() with that _ADR to see if
> > there's a child device there.
> >
> > >
> > > ...
> > >
> > > > +       device_for_each_child_node(dev, child) {
> > > > +               if (is_of_node(child)) {
> > > > +                       fwnode_property_read_u32(child, "reg", values + i);
> > > > +
> > > > +               } else if (is_acpi_node(child)) {
> > > > +                       rc = i2c_mux_gpio_get_acpi_adr(dev, child, values + i);
> > > > +                       if (rc)
> > > > +                               return rc;
> > > > +               }
> > > > +
> > > >                 i++;
> > > >         }
> > >
> > > And for this I already told in two different threads with similar code
> > > that perhaps we need common helper that will check reg followed by
> > > _ADR.
> >
> > Oh, I'm not aware of those threads. I'd need some advice: I guess a
> > new fwnode_* API would make sense for this, but I had trouble coming
> > up with a generic interface. _ADR is just a blobbo 64 bit int, but
> > DT's "reg" is a little more flexible, having a length, and potentially
> > being an array. I suppose it would have to be something like:
> >
> > int fwnode_property_read_reg(const struct fwnode_handle *fwnode,
> >                                  size_t index, uint64_t *addr, uint64_t *len);
> >
> > But then ACPI would always return 0 for length, and only index 0 would
> > ever work? I'm worried I'm designing an API that's only useful to me.
> >
> > I tried to look around for other examples of this specific pattern of
> > _ADR then "reg", but struggled to turn up much.
>
> Any thoughts on this?
>
> > -Evan
> >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
