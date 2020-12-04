Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C452CEE5A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgLDMui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbgLDMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:50:37 -0500
X-Gm-Message-State: AOAM532OB6EaSL94UApSkyKm+DwosENhWG2RFxpwgHjZGfSwRdMqmAmH
        8vSjqmxAXo1n5uocfSp+KdD6ToYdeTOhsumc52U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607086196;
        bh=SCXDMZeVgXBiYgVyKgyRTs9OROoKgEN6O5lqo1xultU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k0tBhHt37W64R82XOTYLCEOW9TKm5xlToou1Xwm2cwrHRSEXoM6KvQgU/47GquCYF
         AopO4nM/SfkQ3z4xBboop8Zvcyb8/nHmjv/HVhYsEtKS3qQ4U6C34ONZ6mPK79kYrJ
         EbHZm+25pnRs3x1DPYSpUE1k7DtbgPk6LGUr2kU/7AtSQmhVjCyefxj4dkxGy8DnWc
         tO8ZZjDtcHsERZdJdafwk119U15xwn5v1MCfimF85mvn0YxqdRoMd/jPqC++8GjDGF
         4QJzR1TyPHS5VDklkNjv82Gh4hd2Z9Uki7KDhoclhHADFyy6YQ6Ce/fOxTZqyAzvKQ
         j3bkXS3h0A5QQ==
X-Google-Smtp-Source: ABdhPJzLJsPP6X76kIsw8diIwzUdJladshIAUH8jWe7Lsz6t5eMIeHR928VTeF+NzXpAc0SAxhJ8TMUp0o0cO8eOlmQ=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr3555296oth.210.1607086196167;
 Fri, 04 Dec 2020 04:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20201203223836.1362313-1-arnd@kernel.org> <20201204104456.hhu76as6ruf5vmqq@uno.localdomain>
In-Reply-To: <20201204104456.hhu76as6ruf5vmqq@uno.localdomain>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 13:49:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0PzyP9L5zYvfTCmAtCSxZBBjg6Pzc6Ta91gWH_HXVmNw@mail.gmail.com>
Message-ID: <CAK8P3a0PzyP9L5zYvfTCmAtCSxZBBjg6Pzc6Ta91gWH_HXVmNw@mail.gmail.com>
Subject: Re: [PATCH] staging: bcm2835: fix vchiq_mmal dependencies
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     driverdevel <devel@driverdev.osuosl.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 11:44 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Hi Arnd,
>
> On Thu, Dec 03, 2020 at 11:38:30PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When the MMAL code is built-in but the vchiq core config is
> > set to =m, the mmal code never gets built, which in turn can
> > lead to link errors:
>
> My bad, I repetedly ignored the error report received from the 'kernel
> test robot' about this. Thanks for fixing.
>
> For my eduction, why would the vchiq-mmal code not get build if
> vchiq-core is set to M ? I mean, that configuration is indeed wrong,
> as vchiq-mmal uses symbols from vchiq-core and I would expect that to
> fail when building the kernel image, not have the other modules (as
> bcm2835-camera) fail as a consequence when building modules.


drivers/staging/Makefile has this line:

obj-$(CONFIG_BCM2835_VCHIQ)     += vc04_services/

when CONFIG_BCM2835_VCHIQ=m, the kbuild infrastructure
only enters the subdirectory while building modules, but a built-in
mmal driver is not a loadable module, so it does not get built
at that time. When compiling the built-in code, the subdirectory is
not entered.

> > Fixes: b18ee53ad297 ("staging: bcm2835: Break MMAL support out from camera")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Jacopo Mondi <jacopo@jmondi.org>
>
> If you noticed this from the same error notification I recevied it
> might be fair to report:
> Reported-by: kernel test robot <lkp@intel.com>

I had not seen that report but found it during my own testing,
thanks for adding.

      Arnd
