Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2571327D33F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgI2QAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:00:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51239 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728570AbgI2QAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:00:37 -0400
Received: (qmail 175276 invoked by uid 1000); 29 Sep 2020 12:00:36 -0400
Date:   Tue, 29 Sep 2020 12:00:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <20200929160036.GC173077@rowland.harvard.edu>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200928101326.v4.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200928184759.GB142254@rowland.harvard.edu>
 <20200929014355.GA1099144@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929014355.GA1099144@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:43:55PM -0700, Matthias Kaehlcke wrote:
> > Have you tried manually unbinding and rebinding the two drivers a few
> > times to make sure they will still work?
> 
> I went through a few dozen bund/unbind cycles for both drivers and things
> looked good overall, but then last minute I found that determining whether
> wakeup capable devices are connected doesn't always work as (I) expected.
> I didn't see this earlier, it seems to be reproduce more easily after
> unbinding and rebinding the platform driver.
> 
> During development I already noticed that usb_wakeup_enabled_descendants()
> returns a cached value, which was a problem for an earlier version of the
> driver. The values are updated by hub_suspend(), my (flawed) assumption
> was that the USB driver would always suspend before the platform driver.
> This generally seems to be the case on my development platform after boot,
> but not necessarily after unbinding and rebinding the driver. Using the
> _suspend_late hook instead of _suspend seems to be a reliable workaround.

Yes, for unrelated (i.e., not in a parent-child relation) devices, the 
PM subsystem doesn't guarantee ordering of suspend and resume callbacks.  
You can enforce the ordering by using device_pm_wait_for_dev().  But the 
suspend_late approach seems like a better solution in this case.

> > I'm a little concerned about  all the devm_* stuff in here; does that
> > get released when the driver is unbound from the device or when the device
> > is unregistered?  And if the latter, what happens if you have multiple
> > sysfs attribute groups going at the same time?
> 
> The memory gets released when the device is unbound:
> 
> device_release_driver
>   device_release_driver_internal
>     __device_release_driver
>       devres_release_all
> 
> Anyway, if you prefer I can change the driver to use kmalloc/kfree.

No, that's fine.  I just wasn't sure about this and wanted to check.

Alan Stern
