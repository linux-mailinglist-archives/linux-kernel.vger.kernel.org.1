Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6D27D3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgI2QuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgI2QuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:50:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776CC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:50:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so4010225pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bx2mthXKRoHRDLfXsb2AnpwZtquJD0dlMq0Tm2f6pbo=;
        b=kL71NIMYdPjXj9LwpfUzVrCh5h7fD7Yv+zdFHSUfmLE1NPZJmaZ9wKG3Al+sHoom3Q
         X1mleMc2oSA+FU5O26kA2JqTSVi6W+1T9DFkBwi6uO6k3Ke/avrU0UB+RXjtolq7NVMh
         TWAfXr6KzhZB1btVxKac0lTeF1AzcRIFGCVYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bx2mthXKRoHRDLfXsb2AnpwZtquJD0dlMq0Tm2f6pbo=;
        b=JwCYe7aIOqw4+0+QQ7tNIN5QluNcYXTBzutwjJblMyeVNf3NrWDczVcI1HK7LuOj0e
         K9l2T38DLohFtTLgvKsLbLOjqISg47Nn02Kzlf698hih1JzC/3F2G/+oH3SBnZR6fpJl
         vQRDNb097NPE2PlUEGx2i0qwB85PY344XO4NDd2SWP0CsW/3jcbOawOPebmDUWtEsjq9
         9uUuDuiOyLf+iT5IFChGQfBZJG65YXU2VTXWH7INoCqLxUc0OYwgIbX1ZzqAbPZ7lwwV
         HD2uxHGnm91G0HhvEczmtLUYAqJaTmEFEv7/imVxZkYzQEHNHoZWI71D1sXLL4CIfdo0
         Htsg==
X-Gm-Message-State: AOAM533jjCOywbHX86uVZa/x52JUxMiCjn6SraX0UKyoYAT108IIKQnC
        6chdJ039Tuc2I4Yi6+lNxPOkIw==
X-Google-Smtp-Source: ABdhPJybp+vWW8POAUUihAVRXUIuN0KQCXkEsZZQnOy/LhF5uPULmb3JW82r6QxNFpQ9LMhQ70cZuA==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr4572388pjb.61.1601398209134;
        Tue, 29 Sep 2020 09:50:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 131sm6078036pfy.5.2020.09.29.09.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 09:50:08 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:50:07 -0700
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
Message-ID: <20200929165007.GA1621304@google.com>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200928101326.v4.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200928184759.GB142254@rowland.harvard.edu>
 <20200929014355.GA1099144@google.com>
 <20200929160036.GC173077@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929160036.GC173077@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:00:36PM -0400, Alan Stern wrote:
> On Mon, Sep 28, 2020 at 06:43:55PM -0700, Matthias Kaehlcke wrote:
> > > Have you tried manually unbinding and rebinding the two drivers a few
> > > times to make sure they will still work?
> > 
> > I went through a few dozen bund/unbind cycles for both drivers and things
> > looked good overall, but then last minute I found that determining whether
> > wakeup capable devices are connected doesn't always work as (I) expected.
> > I didn't see this earlier, it seems to be reproduce more easily after
> > unbinding and rebinding the platform driver.
> > 
> > During development I already noticed that usb_wakeup_enabled_descendants()
> > returns a cached value, which was a problem for an earlier version of the
> > driver. The values are updated by hub_suspend(), my (flawed) assumption
> > was that the USB driver would always suspend before the platform driver.
> > This generally seems to be the case on my development platform after boot,
> > but not necessarily after unbinding and rebinding the driver. Using the
> > _suspend_late hook instead of _suspend seems to be a reliable workaround.
> 
> Yes, for unrelated (i.e., not in a parent-child relation) devices, the 
> PM subsystem doesn't guarantee ordering of suspend and resume callbacks.  
> You can enforce the ordering by using device_pm_wait_for_dev().  But the 
> suspend_late approach seems like a better solution in this case.

Thanks for the confirmation. Good to know about device_pm_wait_for_dev(),
even if we are not going to use it in this case.

> > > I'm a little concerned about  all the devm_* stuff in here; does that
> > > get released when the driver is unbound from the device or when the device
> > > is unregistered?  And if the latter, what happens if you have multiple
> > > sysfs attribute groups going at the same time?
> > 
> > The memory gets released when the device is unbound:
> > 
> > device_release_driver
> >   device_release_driver_internal
> >     __device_release_driver
> >       devres_release_all
> > 
> > Anyway, if you prefer I can change the driver to use kmalloc/kfree.
> 
> No, that's fine.  I just wasn't sure about this and wanted to check.

I think the only concern would be a scenario where the USB devices are
unbound and rebound over and over again, which would result in a
struct udev_node being kept around for every bind until the platform
device is removed. It seems unlikely and shouldn't be a big problem
as long as the number of bind/unbind cycles is in the thousands rather
than millions.
