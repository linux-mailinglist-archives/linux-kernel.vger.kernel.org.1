Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7627BA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgI2Bn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgI2Bn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:43:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4ACC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:43:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so3008188pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fo2RrYUf1cReiMQEx0TU5FOkDdexrCuS8Ny7Goxj60k=;
        b=CUmodB9nAQCcmCu41vOpT+Akx3puaskkx8AAA2/8c0KgerETOBMOFci90fs8Cmvxbt
         Fdo4NmGL9tdHAw35IQ4DTJNpRM8j2XDvXLPrQ3h1vnUt697xIEEmYIx6WRD1Q7mzd8wZ
         pm308NYBKMi7mYYY9gsKKTORP3CStWgbAmxBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fo2RrYUf1cReiMQEx0TU5FOkDdexrCuS8Ny7Goxj60k=;
        b=sfddys9nlQqNShFJ/DiQNsNUCpwn9vAz2V3gLHrlFJXk5bYZwbW14d1qyoOohyAjwx
         4idil6M/s3FUzjReOnh4H6bWFh1Bo5WGQi2nzPd0yDW+uNlEGw9HTERc1WhH5oPzQC9v
         /hpT5JjW+Et+Z9qElv3nMq3TJnjBmGf+8JjCsNFznpupume/2DFtvhSHCpH9j75lkH0c
         jeCHWIwEZOYH6cir3AW1PnlxlJWGFkTskljAgsWP4KdGV4NOeadSaypE96QzMZcSCdPU
         3whocHiApBAx5l259uZZD4DvTIF+iQpn9K6Kik8uCgi74yiJxhLVLwLSYOx9rMuOAP/1
         womw==
X-Gm-Message-State: AOAM533eVXPWr1j76yn0YGMcgmojRwY8+0AVTq+d2xdxJISQGg8d7OQP
        E4wQU6mxV4t7G4AxuGs/QtIxlQ==
X-Google-Smtp-Source: ABdhPJyEmEODYkMb0O/Ba/x4y/swdruOA3A4V8pF4WK7blH245iFVfeRTaXzLOGXI3gVm64nowNsHQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr1716338pjv.108.1601343837607;
        Mon, 28 Sep 2020 18:43:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id f4sm2903758pfa.125.2020.09.28.18.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 18:43:57 -0700 (PDT)
Date:   Mon, 28 Sep 2020 18:43:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200929014355.GA1099144@google.com>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200928101326.v4.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200928184759.GB142254@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928184759.GB142254@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 02:47:59PM -0400, Alan Stern wrote:
> On Mon, Sep 28, 2020 at 10:13:55AM -0700, Matthias Kaehlcke wrote:
> > The main issue this driver addresses is that a USB hub needs to be
> > powered before it can be discovered. For discrete onboard hubs (an
> > example for such a hub is the Realtek RTS5411) this is often solved
> > by supplying the hub with an 'always-on' regulator, which is kind
> > of a hack. Some onboard hubs may require further initialization
> > steps, like changing the state of a GPIO or enabling a clock, which
> > requires even more hacks. This driver creates a platform device
> > representing the hub which performs the necessary initialization.
> > Currently it only supports switching on a single regulator, support
> > for multiple regulators or other actions can be added as needed.
> > Different initialization sequences can be supported based on the
> > compatible string.
> > 
> > Besides performing the initialization the driver can be configured
> > to power the hub off during system suspend. This can help to extend
> > battery life on battery powered devices which have no requirements
> > to keep the hub powered during suspend. The driver can also be
> > configured to leave the hub powered when a wakeup capable USB device
> > is connected when suspending, and power it off otherwise.
> > 
> > Technically the driver consists of two drivers, the platform driver
> > described above and a very thin USB driver that subclasses the
> > generic driver. The purpose of this driver is to provide the platform
> > driver with the USB devices corresponding to the hub(s) (a hub
> > controller may provide multiple 'logical' hubs, e.g. one to support
> > USB 2.0 and another for USB 3.x).
> > 
> > Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> Minor cut & paste error:
> 
> > +static int onboard_hub_power_off(struct onboard_hub *hub)
> > +{
> > +	int err;
> > +
> > +	err = regulator_disable(hub->vdd);
> > +	if (err) {
> > +		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> 
> s/enable/disable/

yup, will fix

> Have you tried manually unbinding and rebinding the two drivers a few
> times to make sure they will still work?

I went through a few dozen bund/unbind cycles for both drivers and things
looked good overall, but then last minute I found that determining whether
wakeup capable devices are connected doesn't always work as (I) expected.
I didn't see this earlier, it seems to be reproduce more easily after
unbinding and rebinding the platform driver.

During development I already noticed that usb_wakeup_enabled_descendants()
returns a cached value, which was a problem for an earlier version of the
driver. The values are updated by hub_suspend(), my (flawed) assumption
was that the USB driver would always suspend before the platform driver.
This generally seems to be the case on my development platform after boot,
but not necessarily after unbinding and rebinding the driver. Using the
_suspend_late hook instead of _suspend seems to be a reliable workaround.

> I'm a little concerned about  all the devm_* stuff in here; does that
> get released when the driver is unbound from the device or when the device
> is unregistered?  And if the latter, what happens if you have multiple
> sysfs attribute groups going at the same time?

The memory gets released when the device is unbound:

device_release_driver
  device_release_driver_internal
    __device_release_driver
      devres_release_all

Anyway, if you prefer I can change the driver to use kmalloc/kfree.

> Apart from those worries and the typo, this looks pretty good to me.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Great, thanks for taking the time to review!
