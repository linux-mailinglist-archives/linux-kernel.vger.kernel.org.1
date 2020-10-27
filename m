Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295BA29CC80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 00:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507040AbgJ0XBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 19:01:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44234 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgJ0XBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:01:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id b1so4430548lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GG3UaJZA/uUQLU7mHf7NS9ozeUye78z/dtgMxwLZVbs=;
        b=gU0Y5uUXQhQkIq+clUzPRx+OUaLu+gAx3DRCwuq4B1OZDcn/cuQxE8TzHGnKx7/dod
         zgh0xGGvb69g40s1CSn25n90CNvks07IBlDy8ep9rycwxiqDOVX5PA7bxY8FerXY1bHW
         xkxt6DPh37axWXb/3QCqWiIKiegiVSHyg0LNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GG3UaJZA/uUQLU7mHf7NS9ozeUye78z/dtgMxwLZVbs=;
        b=a8fEF2CTy9s5YRnvLIl7+9BfxueB6o+RZIYh+ZFVixbUjTXf8Gdsh1TEi2JKPFJ6BF
         qz5lktAeJJrn6WDR8TdFrVWwr5JTXHIUPNQnG8d0n7o5CwozcSLyrOV0OUEOJEsTTzsT
         nVhA24DZdj+okyRu70kXtHRI7ipPcjkTwPTRijmoFDyUP3OaxYT6OiVbrS5QS0ziphgY
         +MPWq6WfmKgZ4CEDXM8AAqNl3UCCKWaHxj9Zyg+QyukS1SaJt78CWpOsYjX8lZcT1h9K
         nrEXKBd8XthoGbyuZY5S0W3iD/OrZPYXEryMVqgRhUw5aC8m/plLGMA/QjbCKdueYEyX
         1PPw==
X-Gm-Message-State: AOAM531iPjZ+roH6g2BcdhxipITVQN73QxNKJXjg4+Uw1u5s/6pxZ9jP
        dVwmMsFKMcjoqcETThDJtfo55UpDI0KgnQ==
X-Google-Smtp-Source: ABdhPJzr/BTFLHIeXuMjtKswHK7MdWopdMU67zSfmmQB/g4mmnLltre12pnC0DatDzTmVDsPZSbDhw==
X-Received: by 2002:a19:7719:: with SMTP id s25mr1553586lfc.521.1603839676415;
        Tue, 27 Oct 2020 16:01:16 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x14sm353737ljm.126.2020.10.27.16.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 16:01:15 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h20so3663464lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:01:15 -0700 (PDT)
X-Received: by 2002:a05:651c:207:: with SMTP id y7mr1891014ljn.99.1603839674753;
 Tue, 27 Oct 2020 16:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201016222523.364218-1-evgreen@chromium.org> <20201016152454.v3.2.Idef164c23d326f5e5edecfc5d3eb2a68fcf18be1@changeid>
 <CAHp75VfsM+ysz_tr_h0rJpspcZAToiV+H5KDCi7J=LCEO0sFxQ@mail.gmail.com> <CAE=gft5cd4v=THHuBPAeB5ApgH+TAPiEukZiG0pC33RsZ4AriQ@mail.gmail.com>
In-Reply-To: <CAE=gft5cd4v=THHuBPAeB5ApgH+TAPiEukZiG0pC33RsZ4AriQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 27 Oct 2020 16:00:37 -0700
X-Gmail-Original-Message-ID: <CAE=gft4hrvHm=ofmF_-hc3UQczqV_GSDQ9hL906bKW4WfbWHSg@mail.gmail.com>
Message-ID: <CAE=gft4hrvHm=ofmF_-hc3UQczqV_GSDQ9hL906bKW4WfbWHSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: i2c-mux-gpio: Enable this driver in ACPI land
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

On Mon, Oct 19, 2020 at 9:53 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Sun, Oct 18, 2020 at 11:58 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sat, Oct 17, 2020 at 8:30 AM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > Enable i2c-mux-gpio devices to be defined via ACPI. The idle-state
> > > property translates directly to a fwnode_property_*() call. The child
> > > reg property translates naturally into _ADR in ACPI.
> > >
> > > The i2c-parent binding is a relic from the days when the bindings
> > > dictated that all direct children of an I2C controller had to be I2C
> > > devices. These days that's no longer required. The i2c-mux can sit as a
> > > direct child of its parent controller, which is where it makes the most
> > > sense from a hardware description perspective. For the ACPI
> > > implementation we'll assume that's always how the i2c-mux-gpio is
> > > instantiated.
> >
> > Can you tell me if the following is relevant to what you are looking for?
> > https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-mux.c#L393
>
> I don't think so, but let me know if I'm reading between the lines incorrectly.
>
> The code you pointed to links the newly-minted fake i2c controller
> back together with its ACPI node. This is important, since I think
> that's how child I2C devices underneath the fake busses get populated
> in ACPI land. But the paragraph above is discussing how to identify
> the parent adapter (ie the real hardware) for an i2c-mux-gpio device.
>
> In DT-land, the i2c-mux-gpio floats at the top of the tree directly
> under /, and then uses a phandle to point to where transactions should
> be forwarded. I'm told the reason for this is historical limitations
> with the DT bindings. Rather than trying to translate the phandle over
> 1:1 into ACPI-land, I'm asserting that the mux device should live
> underneath the adapter it wants to forward traffic to.

Andy or Peter, Any other thoughts on this series?
-Evan
