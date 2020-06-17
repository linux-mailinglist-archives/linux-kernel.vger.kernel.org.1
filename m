Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB9F1FCF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:26:59 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC1C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:26:59 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id j202so1365607ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzX4v+oLBf5O8lqgpF5zRd7IjiEGVcBy7Vd71Z957zk=;
        b=cGH0gIzTXuejB/jeDvKhr629HHkj0ZieSOhk/hOZ2BKybZ0Ip6wHkYRvlzL3dPMdcm
         C/d5YD627mr8jOLE62FtNy5UnaVR3XWNNGNDCCok4TZSmznYyoi2thyWgn7XnbOSZ5UB
         b+rqR5tRJu2Umc1iODhPi6vS5mHYXJCNbth5eIcEajqYZpbb6EJX/zQj7jSB1XigQTXR
         jKHg6v6rXhEFXKlqPXEkCxGxisXCLXBggkSwJtbdqfHw1OGBrN5xVCQSln92mEaktp18
         +0hbp1yLy8ywCg9ZYy8puUDqW0FlhglFDj35BlVt9oQ8fsXyfgJz37qc4sd3jUuaJ0MF
         d6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzX4v+oLBf5O8lqgpF5zRd7IjiEGVcBy7Vd71Z957zk=;
        b=SlISoyjHm+66ewVvYLgs9m2h5ywphpbzG9EOpjwbEDmLBeo4vtF+R+rIsf6QUazfmx
         GZgP+/0o7WURoJXuDtWHNITvmdJGaSqv/8YSR3ad29oVeLERYQ3g4fAEocWbXVsS7oT+
         Bl66sNhjzfMPCQSNJxERlDBNDorhRkObHPb/9dpbcAdrTh8DLxSG7dvC1qo717lbRzHP
         GeKskrWTDI8jkiyyPAo004NXxQ8Lv+9Z5FoXL6un/pdC4AY27AlXuGE2T3xHBWO9EyeJ
         dZSd1subZudX/l6yaDVeNnuVfpAnYG3g+z2qUbc60QAPl+TGulZEK5EjnlIf9GsqZ/dd
         zLwg==
X-Gm-Message-State: AOAM531S9Lkpt1hf0eMo5Kitrx5c+BwyFu9i9WEXXDw63D96c+qC0O7J
        xLcRC18r4nLwb7TPDKx0p+OqXFs4+i97ZnHFZ1/5sQ==
X-Google-Smtp-Source: ABdhPJzQpgG/KQ+DcWyygGI+nO0hw6gCf4p0NLEZm9PPUcYggYA+9WRDPaE2kWKOx2s2CC4E412fj7Q8QiZaN7nynuI=
X-Received: by 2002:a25:4cc6:: with SMTP id z189mr12449365yba.153.1592404018729;
 Wed, 17 Jun 2020 07:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616082907.GA2305431@jade>
In-Reply-To: <20200616082907.GA2305431@jade>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 17 Jun 2020 17:26:42 +0300
Message-ID: <CAD8XO3bY7tsEF29AoXtREQ=tYyAL34s2uHke5LiRaKPBx8Xm2A@mail.gmail.com>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 at 11:29, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Maxim and Jarkko,
>
> On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > ping.
> > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > were merged. These kernel patches look like they are hanging
> > somewhere...
>
> I'm almost OK with this patchset, except that
> Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
> for the new kernel version and TEE mailing list which we're changing right
> now.
>

What is the new mailing list address? I did git pull the latest
master and get_maintainer.pl still points to
tee-dev@lists.linaro.org.

Maxim.

> The last patch touches files I'm not maintainer of. That patch depends
> on the previous patches so it makes sense to keep them together.  If a
> TPM device driver maintainer would ack that patch I can take it via my
> tree. Or we can do it the other way around (with a v9 patchset),
> whichever is preferred.
>
> Cheers,
> Jens
>
> >
> > Thanks,
> > Maxim.
> >
> > On Thu, 4 Jun 2020 at 20:58, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > >
> > > v8: - fix v7 check.
> > > v7: - check return value of dev_set_name() (Jarkko Sakkinen)
> > > v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
> > > v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
> > >     - added missed kfree in optee_open()
> > > v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
> > >     - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
> > > v3: - support tee-suppicant restart (Jens Wiklander)
> > >     - description and comments (Jarkko Sakkinen)
> > >     - do not name optee drivers by index in sysfs (Sumit Garg)
> > > v2: - write TEE with capital letters.
> > >     - declare __optee_enumerate_device() as static.
> > >
> > > Maxim Uvarov (3):
> > >   optee: use uuid for sysfs driver entry
> > >   optee: enable support for multi-stage bus enumeration
> > >   tpm_ftpm_tee: register driver on TEE bus
> > >
> > >  .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
> > >  MAINTAINERS                                   |  1 +
> > >  drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
> > >  drivers/tee/optee/core.c                      | 27 ++++++-
> > >  drivers/tee/optee/device.c                    | 38 +++++-----
> > >  drivers/tee/optee/optee_private.h             | 10 ++-
> > >  6 files changed, 119 insertions(+), 35 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> > >
> > > --
> > > 2.17.1
> > >
