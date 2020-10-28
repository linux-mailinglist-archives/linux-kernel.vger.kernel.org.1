Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE629F458
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJ2S6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:58:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:54656 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgJ2S6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:58:00 -0400
IronPort-SDR: i4s4dyfQJldxuIR9ph6WqlOpyOYUAvqh/YFfI5a3P5GzVs3mtfh03lTRXkVWrWeLfWz6Bdl69O
 ODnPtG9UxwXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="147773401"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="147773401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 11:57:59 -0700
IronPort-SDR: UK3Qydu0Rriw2Lo7rkzAIGtS40oJzJ0upAjn3JZf5bTC0ARUmAatHXnZVsbxQ8rN4RTn4Tniwb
 2NOiBB1j0uxg==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="536780539"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 11:57:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kYD8W-001S2D-Ve; Thu, 29 Oct 2020 20:59:00 +0200
Date:   Wed, 28 Oct 2020 18:27:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH v1 4/5] misc: pvpanic: Combine ACPI and platform drivers
Message-ID: <20201028162727.GX4077@smile.fi.intel.com>
References: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
 <20201027175806.20305-4-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3XgTD2bFej0=WsD3a=uMur36_C71EiOvw3wb5A9QPAfQ@mail.gmail.com>
 <CAK8P3a2L2FWj2z6w_cgz41sg=AXJJ2gEC8Z+wC8FUY6Uq9TdDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2L2FWj2z6w_cgz41sg=AXJJ2gEC8Z+wC8FUY6Uq9TdDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:51:19PM +0100, Arnd Bergmann wrote:
> (resending from the kernel.org address because of bounces)
> 
> On Tue, Oct 27, 2020 at 11:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Oct 27, 2020 at 6:58 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > >  static int pvpanic_mmio_probe(struct platform_device *pdev)
> > >  {
> > > -       base = devm_platform_ioremap_resource(pdev, 0);
> > > +       struct device *dev = &pdev->dev;
> > > +       struct resource *res;
> > > +
> > > +       res = platform_get_mem_or_io_resource(pdev, 0);
> > > +       if (res && resource_type(res) == IORESOURCE_IO)
> > > +               base = devm_ioport_map(dev, res->start, resource_size(res));
> > > +       else
> > > +               base = devm_ioremap_resource(dev, res);
> >
> > Maybe this could already be combined into a devm_platform_iomap_resource()
> > similar to pci_iomap()?

Why not as a next iteration, because I don't see right now many users of this.

-- 
With Best Regards,
Andy Shevchenko


