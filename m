Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4738264A83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIJRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 13:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbgIJQ77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:59:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C5320C09;
        Thu, 10 Sep 2020 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599757194;
        bh=Q/e3hiHaPu3poZppk1c3ftJgjPBuy0Ukwxh4Gmcyk2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asliYRIbd39pJbuu62/Pfj+xB5cKoNxdpvCFYGwQB7KOzedbtjaIqAYtHyU7MXsol
         Hg8pi639TLU4OVwIf39leirjjN+dUir0riatVbr48vtYpiXsh+l4PjAZbLKt0RlD54
         AZ29/uLX3BsYdiK9fEZHoz0WGm9N5DT0A9Ny9wk4=
Date:   Thu, 10 Sep 2020 19:00:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200910170001.GA1621093@kroah.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
 <20200901191548.31646-2-gage.eads@intel.com>
 <20200907130150.GE2371705@kroah.com>
 <SN6PR11MB2574DA2AA215E9566BA4F410F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200910163208.GA1321670@kroah.com>
 <SN6PR11MB257475DF5F45FED24F4D4968F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB257475DF5F45FED24F4D4968F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:52:37PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, September 10, 2020 11:32 AM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
> > 
> > On Thu, Sep 10, 2020 at 04:24:31PM +0000, Eads, Gage wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Monday, September 7, 2020 8:02 AM
> > > > To: Eads, Gage <gage.eads@intel.com>
> > > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > > > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > > > Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
> > > >
> > > > On Tue, Sep 01, 2020 at 02:15:30PM -0500, Gage Eads wrote:
> > > > > --- /dev/null
> > > > > +++ b/drivers/misc/dlb2/dlb2_main.c
> > > > > @@ -0,0 +1,208 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/* Copyright(c) 2018-2020 Intel Corporation */
> > > > > +
> > > > > +#include <linux/aer.h>
> > > > > +#include <linux/cdev.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/fs.h>
> > > > > +#include <linux/init.h>
> > > > > +#include <linux/list.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/pci.h>
> > > > > +#include <linux/uaccess.h>
> > > > > +
> > > > > +#include "dlb2_main.h"
> > > > > +
> > > > > +static const char
> > > > > +dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";
> > > >
> > > > Why have this in a string and then:
> > > >
> > > > > +MODULE_LICENSE("GPL v2");
> > > > > +MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
> > > >
> > > > Not use it?
> > > >
> > > > It's probably not needed at all, right?
> > > >
> > > > Don't you get a build warning about this when applying and building this
> > > > patch?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > dlb2_driver_copyright was used in a pr_info() in the v1 patchset that was
> > > removed at Arnd's recommendation, and I forgot to remove the string.
> > Will fix.
> > > The unused warning variable was likely missed in the deluge of warnings
> > from
> > > included kernel headers.
> > 
> > You should not have any build warnings.  If you do, then something is
> > really wrong, the kernel builds cleanly today.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sorry, I worded that ambiguously. The driver builds without any warnings with
> my GCC (7.3.1) by default. The deluge from kernel headers only occurs after
> adding EXTRA_CFLAGS=-W. There shouldn't be any dlb2 warnings with -W enabled,
> but I'll double check.

You do know about "W=1", right?
