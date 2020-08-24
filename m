Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61F24F964
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHXJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 05:44:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:21857 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgHXJoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:44:54 -0400
IronPort-SDR: yZGabS4joGdhwY7UJyKhiwt6MglXt2zkB/2DEH1iQLhvC7xaeu69YJcBAb2EcGTrgP3QgqfOTk
 w9Qp5UxxbVaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220138567"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="220138567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 02:44:53 -0700
IronPort-SDR: wRXI7XhK5QQaeSQpnPBnrStbcl8NxUyf6Oi3PSlxLixTjXiD8LZxoTcStAxuANtCDp83F56xNw
 DLqigSeyLtjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="402299045"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 02:44:49 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 12:44:48 +0300
Date:   Mon, 24 Aug 2020 12:44:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Message-ID: <20200824094448.GE1375436@lahna.fi.intel.com>
References: <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com>
 <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com>
 <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
 <20200824082227.GU1375436@lahna.fi.intel.com>
 <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
 <20200824091542.GC1375436@lahna.fi.intel.com>
 <CAK8P3a2ipcVLOzZ5jsDSmWkm=rsE7UQ8rgTU-o6me+vX+gVa9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ipcVLOzZ5jsDSmWkm=rsE7UQ8rgTU-o6me+vX+gVa9g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:31:40AM +0200, Arnd Bergmann wrote:
> On Mon, Aug 24, 2020 at 11:15 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Mon, Aug 24, 2020 at 11:08:33AM +0200, Arnd Bergmann wrote:
> > > On Mon, Aug 24, 2020 at 10:22 AM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > > On Sat, Aug 22, 2020 at 06:06:03PM +0200, Arnd Bergmann wrote:
> > > > > On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
> > > > >
> > > > > The mtd core just checks both the permissions on the device node (which
> > > > > default to 0600 without any special udev rules) and the MTD_WRITEABLE
> > > > > on the underlying device that is controlled by the module parameter
> > > > > in case of intel-spi{,-platform,-pci}.c.
> > > >
> > > > OK, thanks.
> > > >
> > > > Since we cannot really get rid of the module parameter (AFAIK there are
> > > > users for it), I still think we should just make the "writeable" to
> > > > apply to the PCI part as well. That should at least make it consistent,
> > > > and it also solves Daniel's case.
> > >
> > > Can you explain Daniel's case then? I still don't understand what he
> > > actually wants.
> > >
> > > As I keep repeating, the module parameter *does* apply to the pci
> > > driver front-end since it determines whether the driver will disallow
> > > writes to the mtd device without it. The only difference is that the pci
> > > driver will attempt to set the hardware bit without checking the
> > > module parameter first, while the platform driver does not. If the
> > > module parameter is not set however, the state of the hardware
> > > bit is never checked again.
> >
> > I think Daniel wants the PCI driver not to set the hardware bit by
> > default (same as the platform driver).
> 
> Sure, but *why*?

Because this is part of the platform firmware security check patch he is
also working on and, I guess making the flash chip writeable by default
is triggering some of the checks in that patch. Or something along those
lines ;-)
