Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEC1AB57E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 03:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgDPB2K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Apr 2020 21:28:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:55540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbgDPB1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:27:48 -0400
IronPort-SDR: KhL4b3QUPzluE2oNEB2jGsmLexdoQZBoNovCW14pMTncchkHLLeMiWGa3+3L7g9Lo6+yG9Lp3Q
 T8M6SxCNlUYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 18:27:47 -0700
IronPort-SDR: Wk3nxhxHRz6SOJx4koO+5TLJ19Tk+Xep0f/M6EQz7uv9hWQFF1lTYEQhkp3EGAYA81lqyf9aPT
 wg4pqRCeUC5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="242491517"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2020 18:27:47 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 18:27:46 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 18:27:45 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 09:27:44 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIIAALvMAgAFssACAACIBAIABY/uQgAHtwgCAEWzRgIAAG8+AgABw0ICAALrWAIAAEIMAgABZOwCAAJqrwIAAhCAAgAEpdxA=
Date:   Thu, 16 Apr 2020 01:27:43 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D822943@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200326092316.GA31648@infradead.org>
        <20200326094442.5be042ce@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
        <20200327074702.GA27959@infradead.org>
        <20200327165335.397f24a3@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
        <20200330090746.23c5599c@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
        <20200331085444.44bee0bb@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
        <20200402113604.6eea1e6f@jacob-builder>
        <20200413134157.395981a6@jacob-builder> <20200413162129.313b3b5a@w520.home>
        <20200413220515.25a107b6@jacob-builder> <20200414101358.3ae66ac5@w520.home>
        <20200414101304.27e587eb@jacob-builder>
        <20200414153226.30d8cab3@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D81F901@SHSMSX104.ccr.corp.intel.com>
 <20200415083854.6fefac01@jacob-builder>
In-Reply-To: <20200415083854.6fefac01@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, April 15, 2020 11:39 PM
> 
> On Tue, 14 Apr 2020 23:47:40 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Wednesday, April 15, 2020 6:32 AM
> > >
> > > On Tue, 14 Apr 2020 10:13:04 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > >
> > > > > > >  In any of the proposed solutions, the
> > > > > > > IOMMU driver is ultimately responsible for validating the
> > > > > > > user data, so do we want vfio performing the
> > > > > > > copy_from_user() to an object that could later be assumed
> > > > > > > to be sanitized, or should vfio just pass a user pointer to
> > > > > > > make it obvious that the consumer is responsible for all
> > > > > > > the user protections?  Seems like the latter.
> > > > > > I like the latter as well.
> > > > > >
> > > On a second thought, I think the former is better. Two reasons:
> > >
> > > 1. IOMMU API such as page_response is also used in baremetal. So it
> > > is not suitable to pass a __user *.
> > > https://www.spinics.net/lists/arm-kernel/msg798677.html
> >
> > You can have a wrapped version accepting a __user* and an internal
> > version for kernel pointers.
> >
> I have thought about that also but the problem is that some of the
> flags are processed in the vendor IOMMU ops so it is hard to do that in
> a generic wrapper.

All vendor IOMMU ops are defined in the same header file, so they
can be verified in one common IOMMU wrapper, just like how you
dealt with it in VFIO originally...

> 
> > >
> > > 2. Some data are in the mandatory (fixed offset, never removed or
> > > extended) portion of the uAPI structure. It is simpler for VFIO to
> > > extract that and pass it to IOMMU API. For example, the PASID value
> > > used for unbind_gpasid(). VFIO also need to sanitize the PASID
> > > value to make sure it belongs to the same VM that did the
> > > allocation.
> >
> > I don't think this makes much difference. If anyway you still plan to
> > let IOMMU driver parse some user pointers, why not making a clear
> > split to have it sparse all IOMMU specific fields?
> >
> The plan is not to have IOMMU driver parse user pointers. This is the
> "former" case in Alex's comment. I.e. vfio performing the
> copy_from_user based on argsz in IOMMU uAPI.
> 

I'm confused. I thought Alex proposed the latter one:
---[quote]
> So, __user * will be passed to IOMMU driver if VFIO checks minsz
> include flags and they are valid.
> IOMMU driver can copy the rest based on the mandatory version/minsz and
> flags in the IOMMU uAPI structs.
> Does it sound right? This is really choice #2.

Sounds like each IOMMU UAPI struct just needs to have an embedded size
and flags field, but yes.
----

Thanks
Kevin
