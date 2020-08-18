Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82639248B19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHRQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgHRQHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:07:21 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986662076E;
        Tue, 18 Aug 2020 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597766841;
        bh=8ux+d+uaWLAaS3wnrLl7L8xxh2Oagc5T4OMgiA7eC8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKdlhQ/U+DvbPiQnlbvb25VGtRzalsDl8L39DDh/FbzMXsqkiZyLj4niVqfRPIwik
         01k/5cpkRYMRHbAXRR7dIl2qtYxEr4ve8vFyPrjvZkEK8FfoL46SJf/xX7NphAyC9a
         PAiq2LpOkH8PNfl7ymOq1/4ZUI1BXlJ7OHZboyLo=
Date:   Tue, 18 Aug 2020 18:07:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Manivannan Sadhasivam <mani@kernel.org>, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        mauro.chehab@huawei.com
Subject: Re: [PATCH 1/6] staging: hikey9xx: fix Kconfig dependency chain
Message-ID: <20200818180716.4b9f981c@coco.lan>
In-Reply-To: <20200818150704.GA665815@kroah.com>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
        <1b7e23500e7449593393115cc0954af441b0c730.1597762400.git.mchehab+huawei@kernel.org>
        <20200818150704.GA665815@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 18 Aug 2020 17:07:04 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Tue, Aug 18, 2020 at 04:58:53PM +0200, Mauro Carvalho Chehab wrote:
> > Both the SPMI controller and the SPMI PMIC driver
> > depends on the SPMI bus support.
> > 
> > The dependency for the regulator is also wrong:
> > it should depends on the SPMI version of the HiSilicon 6421,
> > and not on the normal one.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/staging/hikey9xx/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
> > index 76267b9be562..a004839e8fa9 100644
> > --- a/drivers/staging/hikey9xx/Kconfig
> > +++ b/drivers/staging/hikey9xx/Kconfig
> > @@ -5,6 +5,7 @@ config SPMI_HISI3670
> >  	tristate "Hisilicon 3670 SPMI Controller"
> >  	select IRQ_DOMAIN_HIERARCHY
> >  	depends on HAS_IOMEM
> > +	depends on SPMI
> >  	help
> >  	  If you say yes to this option, support will be included for the
> >  	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
> > @@ -14,6 +15,7 @@ config SPMI_HISI3670
> >  config MFD_HI6421_SPMI
> >  	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
> >  	depends on OF
> > +	depends on SPMI
> >  	select MFD_CORE
> >  	help
> >  	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
> > @@ -28,7 +30,7 @@ config MFD_HI6421_SPMI
> >  # to be placed at drivers/regulator
> >  config REGULATOR_HI6421V600
> >  	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
> > -	depends on MFD_HI6421_PMIC && OF
> > +	depends on MFD_HI6421_SPMI && OF
> >  	help
> >  	  This driver provides support for the voltage regulators on
> >  	  HiSilicon Hi6421v600 PMU / Codec IC.  
> 
> Better, but now I get the following build error:
> 
> ERROR: modpost: "regulator_map_voltage_iterate" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
> ERROR: modpost: "regulator_list_voltage_table" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
> ERROR: modpost: "of_get_regulator_init_data" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
> ERROR: modpost: "regulator_register" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
> ERROR: modpost: "regulator_unregister" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
> ERROR: modpost: "rdev_get_drvdata" [drivers/staging/hikey9xx/hi6421v600-regulator.ko] undefined!
> 
> Someone need CONFIG_REGULATOR enabled?

Yep. Sorry for that!
> 
> Another follow-on patch?  :)

:)

Just to make sure, I did a clean compilation here, starting from
nomodconfig, and adding just CONFIG_ARCH* and the dependencies
needed by those symbols. It build fine here. So, I guess it
should be ok this time (famous last words...)

Thanks,
Mauro
