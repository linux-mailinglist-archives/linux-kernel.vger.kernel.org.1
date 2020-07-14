Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0265F21E89B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGNGur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgGNGur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:50:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:50:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so19993369wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ie2tKNIUSpXCL8eMuklhkWV+j7ugwvMUxgU/Elr/mDw=;
        b=gObMIzelreR+mXyuBevVcUQKJUctMo8LVwfa0bj5ta43Wr42DmhZWTLmBQGCgGERVv
         AeLl7z5mEURf1W1Nhb+OozrxYR7OOQNTSuS+ptMbWu5kD4xLsde2yE9ZQZBM1yEnzkf9
         nfCbuqVS957NAe64H5iCwhGA6S5Hfr7pxoGLfauDooh9UnWfd6uepVEsN60thJyFV/0s
         8gONykUOGVrmtppFVqfLmuaQTyUSGAD3i1Nt/FnNxyXJ11NbL70RE+CaojFOyRH+IBiv
         pQhj5ebYR0dOGoaEqzBWGPDOYdeLBrnFLYtOgaq567/ge4OxjgmvBYtwadWdLGCZRSJ5
         Fy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ie2tKNIUSpXCL8eMuklhkWV+j7ugwvMUxgU/Elr/mDw=;
        b=KhfOLkhk/515lR9ioqkl4C4wnoYlbGWuYbLB0PjaVaBMXBDXCr9T6yLnU9ez2thumS
         kn01J8tP16CwTAuYPQUu8rfVqul2WE8v6XafF6mCB1FRR3jGY3Fn6RJwQoSRd3ZiKpiA
         ATeMesKtIZ48ryprZ47SxUDPIq9nZ7Sg0X8j4FJMqT6IvfPBllQgebS/SacC3RMog3TN
         IDqZ4DoRrWQ7p9pr+j3b7rmnej47fwDjYkaat2AzsGr7Yjywo+6kecKCJDnseu7rGw1q
         Opls13vma9WBSvC7nXtZa3rWYWZL/hVEQmlTOsJvlVWdwUlgeMpxwdqtQBZBUhIjCHOS
         fh6w==
X-Gm-Message-State: AOAM530eDxk9FzOMaIMrXlkKyWNM+Fe7OrCXzJZmNysz5x+SVcvEfn1K
        nGgdzV7Fcz3l028zmOtWkZHsCVuHnWk=
X-Google-Smtp-Source: ABdhPJz2Q//5iT6QHu6Gf0Je+AZKXd6XtWxRUGp+dxNVwjbuyLgSXOed3tCVHC/lEjCV3QrtZT+fqw==
X-Received: by 2002:adf:f888:: with SMTP id u8mr3483694wrp.18.1594709445639;
        Mon, 13 Jul 2020 23:50:45 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id p25sm2721548wmg.39.2020.07.13.23.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 23:50:45 -0700 (PDT)
Date:   Tue, 14 Jul 2020 07:50:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 1/2] mfd: intel-m10-bmc: add Max10 BMC chip support for
 Intel FPGA PAC
Message-ID: <20200714065043.GF3500@dell>
References: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
 <1594614896-16606-2-git-send-email-yilun.xu@intel.com>
 <20200713091708.GC3500@dell>
 <20200714060520.GA27975@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714060520.GA27975@yilunxu-OptiPlex-7050>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Xu Yilun wrote:

> On Mon, Jul 13, 2020 at 10:17:08AM +0100, Lee Jones wrote:
> > On Mon, 13 Jul 2020, Xu Yilun wrote:
> > 
> > > This patch implements the basic functions of the BMC chip for some Intel
> > > FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> > > intel max10 CPLD.
> > > 
> > > This BMC chip is connected to FPGA by a SPI bus. To provide reliable
> > > register access from FPGA, an Avalon Memory-Mapped (Avmm) transaction
> > > protocol over the SPI bus is used between host and slave.
> > > 
> > > This driver implements the basic register access with the regmap framework.
> > > The mfd cells array is empty now as a placeholder.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
> > >  drivers/mfd/Kconfig                                |  13 +
> > >  drivers/mfd/Makefile                               |   3 +
> > >  drivers/mfd/intel-m10-bmc-main.c                   | 176 ++++
> > 
> > >  drivers/mfd/intel-spi-avmm.c                       | 904 +++++++++++++++++++++
> > 
> > This does not belong in MFD.
> > 
> > Please consider moving it to drivers/spi.
> 
> OK, I could make the intel-spi-avmm.c as a separate module in other
> folder.
> 
> Since it is an implementation of regmap, is it better we move it to
> drivers/base/regmap?

Either way, you need to speak to Mark Brown.

> > >  drivers/mfd/intel-spi-avmm.h                       |  35 +
> > >  include/linux/mfd/intel-m10-bmc.h                  |  57 ++
> > >  7 files changed, 1203 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > >  create mode 100644 drivers/mfd/intel-m10-bmc-main.c
> > >  create mode 100644 drivers/mfd/intel-spi-avmm.c
> > >  create mode 100644 drivers/mfd/intel-spi-avmm.h
> > >  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
