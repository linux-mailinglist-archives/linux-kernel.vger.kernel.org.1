Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FC2537A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHZS4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:56:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C95C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:56:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so1532701pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JWJKSAOuKtu/D3AHg+GKJrz4+nDMNdk0sVj0sJOy520=;
        b=aROh+Wr6ymo+6XlJaxOmYycsMN9aCBKU3gMUO1XgpABaQ4AYQMKL7M1Cr+4+b7HKZe
         NxSa0pqkt15wSspQIaJX7fXdcN/gNs/hMbvTRKlJkhQfAK/lhaePj4cEkguvIwh0WIzQ
         xppJtDqUhvzDJFqU4gUodWsUriunamj5bK0O1WKhNf3J1jaH6N/8Eh8Uo4cS5tG/Zxuz
         i92espbL8TJ9WVKeTAx5T/sRJGR07qtrPk9VYVZBA5e8APNS/AVyfftnwzIKfxU49o/C
         g/0OHu+3TJFA2IDbF3zCytnefOgiNraDSgMVOakHkZCUuH1l4TjxxPhsxFQmBBE0lbh6
         REDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JWJKSAOuKtu/D3AHg+GKJrz4+nDMNdk0sVj0sJOy520=;
        b=GxjDGpERFWAHMzEq+uXxWRQ+AmseIZKwnXHmGXVCVhWADsu9Bm+bWb/tM91cOl/jFa
         Y3XzNnyX1iA+pfqJgnBdEsrW0u91JN01Ph53WulEwtd7WGoVaNOwIHZwHFf1QbzhPVHj
         WK+U5tF37EUO7UcSu9Q59isdzx6Z+4qOwliMO+t4CMou5jx3vThYBugjTamx7uM6am2V
         Jw1/SW1+OGyF5ttwKyKGl4oM59Spastwyfv9gvBLwtfbgau3lbtGpYav4IcLZWuZa44T
         sd0yJbb8IgUbj8EyJiLCXlNFuzcBFCn9U4ShDy3KYaR7aLtXb++hQMPJTTWHRuJR6iVi
         9sPg==
X-Gm-Message-State: AOAM531Uwg9zrogpEgr9JRt8PiihmuNMWmDRVaO0ZlPNC5HOBgKuLxqU
        HwcBS8qDv+Dp6gj+3+JWvMA3pA==
X-Google-Smtp-Source: ABdhPJyrFh2QXS2NKYpk6YTAmbE13BpLZFCtimpXqJgexgLxG9DRzweuKzpop0Y5uHbeCkJX3Pd9WA==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr12057868pgl.235.1598468159507;
        Wed, 26 Aug 2020 11:55:59 -0700 (PDT)
Received: from arch-ashland-svkelley ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id b18sm2741353pjq.3.2020.08.26.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:55:58 -0700 (PDT)
Message-ID: <519210aae580daa5332463d22d22a37d1d398370.camel@intel.com>
Subject: Re: [PATCH v3 05/10] PCI/AER: Extend AER error handling to RCECs
From:   sean.v.kelley@intel.com
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rjw@rjwysocki.net,
        ashok.raj@intel.com, tony.luck@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 26 Aug 2020 11:55:33 -0700
In-Reply-To: <c235b1bb-4a2d-8959-d556-011620d5ae55@linux.intel.com>
References: <20200812164659.1118946-1-sean.v.kelley@intel.com>
         <20200812164659.1118946-6-sean.v.kelley@intel.com>
         <c235b1bb-4a2d-8959-d556-011620d5ae55@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathya,

On Wed, 2020-08-26 at 10:26 -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 8/12/20 9:46 AM, Sean V Kelley wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Currently the kernel does not handle AER errors for Root Complex
> > integrated End Points (RCiEPs)[0]. These devices sit on a root bus
> > within
> > the Root Complex (RC). AER handling is performed by a Root Complex
> > Event
> > Collector (RCEC) [1] which is a effectively a type of RCiEP on the
> > same
> > root bus.
> > 
> > For an RCEC (technically not a Bridge), error messages "received"
> > from
> > associated RCiEPs must be enabled for "transmission" in order to
> > cause a
> > System Error via the Root Control register or (when the Advanced
> > Error
> > Reporting Capability is present) reporting via the Root Error
> > Command
> > register and logging in the Root Error Status register and Error
> > Source
> > Identification register.
> > 
> > In addition to the defined OS level handling of the reset flow for
> > the
> > associated RCiEPs of an RCEC, it is possible to also have non-
> > native
> > handling. In that case there is no need to take any actions on the
> > RCEC
> > because the firmware is responsible for them. This is true where
> > APEI [2]
> > is used to report the AER errors via a GHES[v2] HEST entry [3] and
> > relevant AER CPER record [4] and non-native handling is in use.
> > 
> > We effectively end up with two different types of discovery for
> > purposes of handling AER errors:
> > 
> > 1) Normal bus walk - we pass the downstream port above a bus to
> > which
> > the device is attached and it walks everything below that point.
> > 
> > 2) An RCiEP with no visible association with an RCEC as there is no
> > need
> > to walk devices. In that case, the flow is to just call the
> > callbacks for
> > the actual device.
> > 
> > A new walk function pci_walk_dev_affected(), similar to
> > pci_bus_walk(),
> > is provided that takes a pci_dev instead of a bus. If that dev
> > corresponds
> > to a downstream port it will walk the subordinate bus of that
> > downstream
> > port. If the dev does not then it will call the function on that
> > device
> > alone.
> > 
> > [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex
> > Integrated Endpoint Rules.
> > [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling
> > and
> > Logging
> > [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface
> > (APEI)
> > [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
> > [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > ---
> >   drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++---
> > -----
> >   1 file changed, 44 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 14bb8f54723e..f4cfb37c26c1 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -146,38 +146,68 @@ static int report_resume(struct pci_dev *dev,
> > void *data)
> >   	return 0;
> >   }
> >   
> > +/**
> > + * pci_walk_dev_affected - walk devices potentially AER affected
> > + * @dev      device which may be an RCEC with associated RCiEPs,
> > + *           an RCiEP associated with an RCEC, or a Port.
> > + * @cb       callback to be called for each device found
> > + * @userdata arbitrary pointer to be passed to callback.
> > + *
> > + * If the device provided is a bridge, walk the subordinate bus,
> > + * including any bridged devices on buses under this bus.
> > + * Call the provided callback on each device found.
> > + *
> > + * If the device provided has no subordinate bus, call the
> > provided
> > + * callback on the device itself.
> > + */
> > +static void pci_walk_dev_affected(struct pci_dev *dev, int
> > (*cb)(struct pci_dev *, void *),
> > +				  void *userdata)
> > +{
> > +	if (dev->subordinate)
> > +		pci_walk_bus(dev->subordinate, cb, userdata);
> > +	else
> > +		cb(dev, userdata);
> > +}
> > +
> >   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >   			enum pci_channel_state state,
> >   			pci_ers_result_t (*reset_link)(struct pci_dev
> > *pdev))
> >   {
> >   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> > -	struct pci_bus *bus;
> >   
> >   	/*
> >   	 * Error recovery runs on all subordinates of the first
> > downstream port.
> >   	 * If the downstream port detected the error, it is cleared at
> > the end.
> > +	 * For RCiEPs we should reset just the RCiEP itself.
> >   	 */
> >   	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
> > +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
> >   		dev = dev->bus->self;
> > -	bus = dev->subordinate;
> >   
> >   	pci_dbg(dev, "broadcast error_detected message\n");
> >   	if (state == pci_channel_io_frozen) {
> > -		pci_walk_bus(bus, report_frozen_detected, &status);
> > +		pci_walk_dev_affected(dev, report_frozen_detected,
> > &status);
> > +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> > +			pci_warn(dev, "link reset not possible for
> > RCiEP\n");
> > +			status = PCI_ERS_RESULT_NONE;
> > +			goto failed;
> reset_link is not applicable for RC_END, but why do you want to fail
> it?


This patch is incorporated prior to the addition of the dev->rcec link
for actually handling the RC_END case.  This is the first part before I
bring in the rest and is the basis also of Jonathan's original work.

See subsequent patches on top of err.c in this v3 series.


> > +		}
> > +
> >   		status = reset_link(dev);
> >   		if (status != PCI_ERS_RESULT_RECOVERED) {
> >   			pci_warn(dev, "link reset failed\n");
> >   			goto failed;
> >   		}
> >   	} else {
> > -		pci_walk_bus(bus, report_normal_detected, &status);
> > +		pci_walk_dev_affected(dev, report_normal_detected,
> > &status);
> >   	}
> >   
> >   	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> >   		status = PCI_ERS_RESULT_RECOVERED;
> >   		pci_dbg(dev, "broadcast mmio_enabled message\n");
> > -		pci_walk_bus(bus, report_mmio_enabled, &status);
> > +		pci_walk_dev_affected(dev, report_mmio_enabled,
> > &status);
> >   	}
> >   
> >   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> > @@ -188,17 +218,21 @@ pci_ers_result_t pcie_do_recovery(struct
> > pci_dev *dev,
> >   		 */
> >   		status = PCI_ERS_RESULT_RECOVERED;
> >   		pci_dbg(dev, "broadcast slot_reset message\n");
> > -		pci_walk_bus(bus, report_slot_reset, &status);
> > +		pci_walk_dev_affected(dev, report_slot_reset, &status);
> >   	}
> >   
> >   	if (status != PCI_ERS_RESULT_RECOVERED)
> >   		goto failed;
> >   
> >   	pci_dbg(dev, "broadcast resume message\n");
> > -	pci_walk_bus(bus, report_resume, &status);
> > +	pci_walk_dev_affected(dev, report_resume, &status);
> >   
> > -	pci_aer_clear_device_status(dev);
> > -	pci_aer_clear_nonfatal_status(dev);
> you want to prevent clearing status for RC_END ? Can you explain?

It's the RC_EC of the associated RC_END which is to be cleared.
However, in this original patch from Jonathan prior to my subsequent
addition of dev->rcec it is not possible. The important thing is not to
attempt to clear the RC_END without the association.

See subsequent patches on top of err.c in this v3 series.

Thanks,

Sean

> > +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> > +		pci_aer_clear_device_status(dev);
> > +		pci_aer_clear_nonfatal_status(dev);
> > +	}
> >   	pci_info(dev, "device recovery successful\n");
> >   	return status;
> >   
> > 

