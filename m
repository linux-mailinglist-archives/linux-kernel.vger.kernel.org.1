Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5F2CEEEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgLDNmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:42:18 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38355 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLDNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:42:18 -0500
X-Originating-IP: 93.34.118.233
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9428220012;
        Fri,  4 Dec 2020 13:41:34 +0000 (UTC)
Date:   Fri, 4 Dec 2020 14:41:41 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     driverdevel <devel@driverdev.osuosl.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH] staging: bcm2835: fix vchiq_mmal dependencies
Message-ID: <20201204134141.bsxbcojpcs6kyhui@uno.localdomain>
References: <20201203223836.1362313-1-arnd@kernel.org>
 <20201204104456.hhu76as6ruf5vmqq@uno.localdomain>
 <CAK8P3a0PzyP9L5zYvfTCmAtCSxZBBjg6Pzc6Ta91gWH_HXVmNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0PzyP9L5zYvfTCmAtCSxZBBjg6Pzc6Ta91gWH_HXVmNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Dec 04, 2020 at 01:49:39PM +0100, Arnd Bergmann wrote:
> On Fri, Dec 4, 2020 at 11:44 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Hi Arnd,
> >
> > On Thu, Dec 03, 2020 at 11:38:30PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When the MMAL code is built-in but the vchiq core config is
> > > set to =m, the mmal code never gets built, which in turn can
> > > lead to link errors:
> >
> > My bad, I repetedly ignored the error report received from the 'kernel
> > test robot' about this. Thanks for fixing.
> >
> > For my eduction, why would the vchiq-mmal code not get build if
> > vchiq-core is set to M ? I mean, that configuration is indeed wrong,
> > as vchiq-mmal uses symbols from vchiq-core and I would expect that to
> > fail when building the kernel image, not have the other modules (as
> > bcm2835-camera) fail as a consequence when building modules.
>
>
> drivers/staging/Makefile has this line:

My bad, I only looked into drivers/staging/vc04_services/

>
> obj-$(CONFIG_BCM2835_VCHIQ)     += vc04_services/
>
> when CONFIG_BCM2835_VCHIQ=m, the kbuild infrastructure
> only enters the subdirectory while building modules, but a built-in
> mmal driver is not a loadable module, so it does not get built
> at that time. When compiling the built-in code, the subdirectory is
> not entered.

Thanks, all clear now!

>
> > > Fixes: b18ee53ad297 ("staging: bcm2835: Break MMAL support out from camera")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Acked-by: Jacopo Mondi <jacopo@jmondi.org>
> >
> > If you noticed this from the same error notification I recevied it
> > might be fair to report:
> > Reported-by: kernel test robot <lkp@intel.com>
>
> I had not seen that report but found it during my own testing,
> thanks for adding.
>
>       Arnd
