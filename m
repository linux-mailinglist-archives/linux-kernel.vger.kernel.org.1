Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25D527EF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgI3QuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:50:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:26966 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgI3QuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:50:16 -0400
IronPort-SDR: aN1wGeLA+aeDar5oKadN3ZfoxG3Eowspzt1lihENPdSWi/rUXGultcI7etEtlUhh39EWaWkRff
 i9f8TfPFyz9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161722144"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="161722144"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 09:50:16 -0700
IronPort-SDR: tKGfD5O3mCHK23VKErmBNC6CAvp2WNrGSQ1hUKWZUGkin+21CXJED6SZxnWegYhV3r9hiwujla
 lgtNmmEQii8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="294088143"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2020 09:50:16 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id E802958033E;
        Wed, 30 Sep 2020 09:50:15 -0700 (PDT)
Message-ID: <47276f4aacbf4ec3729e674a573a28cd6399cfd6.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] mfd: intel_pmt: Add OOBMSM device ID
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com
Cc:     dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Wed, 30 Sep 2020 09:50:15 -0700
In-Reply-To: <20200930071250.GI6148@dell>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
         <20200911194549.12780-2-david.e.box@linux.intel.com>
         <20200929095106.GG6148@dell>
         <e23b255493c78d80558b9226920b3c7d54d7c84f.camel@linux.intel.com>
         <20200930071250.GI6148@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 08:12 +0100, Lee Jones wrote:
> On Tue, 29 Sep 2020, David E. Box wrote:
> 
> > On Tue, 2020-09-29 at 10:51 +0100, Lee Jones wrote:
> > > On Fri, 11 Sep 2020, David E. Box wrote:
> > > 
> > > > Add Out of Band Management Services Module device ID to Intel
> > > > PMT
> > > > driver.
> > > > 
> > > > Signed-off-by: Alexander Duyck <
> > > > alexander.h.duyck@linux.intel.com>
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > ---
> > > >  drivers/mfd/intel_pmt.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> > > > index 0e572b105101..8f9970ab3026 100644
> > > > --- a/drivers/mfd/intel_pmt.c
> > > > +++ b/drivers/mfd/intel_pmt.c
> > > > @@ -55,6 +55,8 @@ struct pmt_platform_info {
> > > >  	unsigned long quirks;
> > > >  };
> > > >  
> > > > +static const struct pmt_platform_info pmt_info;
> > > > +
> > > >  static const struct pmt_platform_info tgl_info = {
> > > >  	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG
> > > > |
> > > >  		  PMT_QUIRK_TABLE_SHIFT,
> > > > @@ -200,8 +202,10 @@ static void pmt_pci_remove(struct pci_dev
> > > > *pdev)
> > > >  	pm_runtime_get_sync(&pdev->dev);
> > > >  }
> > > >  
> > > > +#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
> > > >  #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
> > > >  static const struct pci_device_id pmt_pci_ids[] = {
> > > > +	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, &pmt_info) },
> > > 
> > > Why are you supplying an empty struct?
> > 
> > Because the OOBMSM device doesn't need code provided driver data,
> > but
> > info is dereferenced in several areas. We also use kmemdup to copy
> > driver_data under the assumption that it was provided. We could
> > allow
> > for NULL if driver_data is referenced directly.
> 
> Just check for NULL.  No need to create and send bogus data.

Sure. If you haven't already, please note that this patch was pulled
into the V6 series in the link below. You accepted V5 but Hans
suggested some late changes after reviewing the new crashlog driver in
this patchset. So rather than have separate patchsets with a
dependency, we bundled them all into the original. We'll make these
changes in V7 now.

https://lore.kernel.org/patchwork/patch/1313166/

David

