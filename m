Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C425374B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHZSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgHZShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:37:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEDC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:37:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so1445932pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HWwMg7wLtO/jS4ZCdT6Z4Slvmcz2bXgfE9LdWuY0+xU=;
        b=A37eH+VGhA1dwlcHdL7E5ccfC4Ea2FVTSpfG5rZ4zBFEsUJw9bjwDuQpv0SgP/yA9+
         U/pDImEb/eMS4xmhFGDNMWx3YJM/5lpBoxwZ6JACf8su0Sh3UsF31mjJPPFcE6v+yKK4
         h35Py9Nt3xAUqspVXJfe+zI4vq211obP43Wzl/A8Rizv4R8UuX1LgU3NogD6r89B4Kwv
         hX3OxMrAQAQpB0DkbaMtwcHndkL3WVH8rtgv3LTTGxvNas11HtHV8NlJgjTN3+LU2anq
         4DnE5/3WtHYM97IDxXpR/nYhQHyvBBqmdgN0dpX/REXM7Cnstey9EiPiFKx0jIHpRRU6
         s7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HWwMg7wLtO/jS4ZCdT6Z4Slvmcz2bXgfE9LdWuY0+xU=;
        b=c7hnPcGlXYRHWIfilZ7uxtIS21sFPszxx2Ktz94omblC/kasJLQSgXQvsdGmuuu41W
         NcPGpaCLy8zDa7875VIfZLS3xwv3b7sY3Wsh5m5+EXjGqfqdRRsfs46goL46cJ8TJqld
         xqa8q7LJ+olb5F3/kVyizWCRqQD9MS1Aq+ImxElJAGNpgnBFDJUZLA+oNDm8/mr8HCjD
         JQCqZbYvn4kyC998Y3SSo2AO6s5AC90qAOkErTaXvAp9MnUKJpo1adhlijgLxRweC7Nq
         /w6oDQL4+f4+YB97WEeuXYXgm28UgV1XHVj1xYnEaV2BAJ3jjRLpmS/P1PGXxxbkrmQE
         p3sA==
X-Gm-Message-State: AOAM5335P5H+bPKLU/IXN42r1qzzu2mMuUMsrEP/6yyAjUX94kSI0BN4
        3WsKPVU1KMl6mnfK/+2jpxn1SdmQSBhx5g==
X-Google-Smtp-Source: ABdhPJxcC6THxYL340bBZSG7Z18W6j4yItjG6tdud12IdJv2cFHQ01K/9K0SMbtPyjYHZjMtMNw3BA==
X-Received: by 2002:a63:342:: with SMTP id 63mr11984354pgd.134.1598467072940;
        Wed, 26 Aug 2020 11:37:52 -0700 (PDT)
Received: from arch-ashland-svkelley ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id j14sm3033847pgj.3.2020.08.26.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:37:52 -0700 (PDT)
Message-ID: <faa5535d194d0238217aaed118d1db40e841ee3a.camel@intel.com>
Subject: Re: [PATCH V2 3/9] PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs
 associated with RCEC
From:   sean.v.kelley@intel.com
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rjw@rjwysocki.net,
        ashok.raj@intel.com, tony.luck@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Date:   Wed, 26 Aug 2020 11:37:27 -0700
In-Reply-To: <139d4c34-7e5e-8867-a016-4a5bc737b804@linux.intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
         <20200804194052.193272-4-sean.v.kelley@intel.com>
         <139d4c34-7e5e-8867-a016-4a5bc737b804@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathya,


On Wed, 2020-08-26 at 09:20 -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 8/4/20 12:40 PM, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > When an RCEC device signals error(s) to a CPU core, the CPU core
> > needs to walk all the RCiEPs associated with that RCEC to check
> > errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> > associated with the RCEC device.
> I think its better if you merge the usage patch and API
> (pcie_walk_rcec) patch together.

Good suggestion, I'll have a look to see if that works well merged.

> 
> Did you not get unused function warning with this patch?

The latest patches are below (v3) and they were built on top of
pci/master (prior to the release of 5.9.0-rc1 btw).  I did not get a
warning with that but will double check...

https://lore.kernel.org/linux-pci/20200812164659.1118946-1-sean.v.kelley@intel.com/

Thanks!

Sean

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   drivers/pci/pcie/portdrv.h      |  2 +
> >   drivers/pci/pcie/portdrv_core.c | 82
> > +++++++++++++++++++++++++++++++++
> >   2 files changed, 84 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/portdrv.h
> > b/drivers/pci/pcie/portdrv.h
> > index af7cf237432a..c11d5ecbad76 100644
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -116,6 +116,8 @@ void pcie_port_service_unregister(struct
> > pcie_port_service_driver *new);
> >   
> >   extern struct bus_type pcie_port_bus_type;
> >   int pcie_port_device_register(struct pci_dev *dev);
> > +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev
> > *, void *),
> > +		    void *userdata);
> >   #ifdef CONFIG_PM
> >   int pcie_port_device_suspend(struct device *dev);
> >   int pcie_port_device_resume_noirq(struct device *dev);
> > diff --git a/drivers/pci/pcie/portdrv_core.c
> > b/drivers/pci/pcie/portdrv_core.c
> > index 5d4a400094fc..daa2dfa83a0b 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/pm_runtime.h>
> >   #include <linux/string.h>
> >   #include <linux/slab.h>
> > +#include <linux/bitops.h>
> >   #include <linux/aer.h>
> >   
> >   #include "../pci.h"
> > @@ -365,6 +366,87 @@ int pcie_port_device_register(struct pci_dev
> > *dev)
> >   	return status;
> >   }
> >   
> > +static int pcie_walk_rciep_devfn(struct pci_bus *pbus, int
> > (*cb)(struct pci_dev *, void *),
> > +				 void *userdata, unsigned long bitmap)
> > +{
> > +	unsigned int dev, fn;
> > +	struct pci_dev *pdev;
> > +	int retval;
> > +
> > +	for_each_set_bit(dev, &bitmap, 32) {
> > +		for (fn = 0; fn < 8; fn++) {
> > +			pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
> > +
> > +			if (!pdev || pci_pcie_type(pdev) !=
> > PCI_EXP_TYPE_RC_END)
> > +				continue;
> > +
> > +			retval = cb(pdev, userdata);
> > +			if (retval)
> > +				return retval;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and
> > call callback.
> > + * @rcec     RCEC whose RCiEP devices should be walked.
> > + * @cb       Callback to be called for each RCiEP device found.
> > + * @userdata Arbitrary pointer to be passed to callback.
> > + *
> > + * Walk the given RCEC. Call the provided callback on each RCiEP
> > device found.
> > + *
> > + * We check the return of @cb each time. If it returns anything
> > + * other than 0, we break out.
> > + */
> > +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev
> > *, void *),
> > +		    void *userdata)
> > +{
> > +	u32 pos, bitmap, hdr, busn;
> > +	u8 ver, nextbusn, lastbusn;
> > +	struct pci_bus *pbus;
> > +	unsigned int bnr;
> > +
> > +	pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
> > +	if (!pos)
> > +		return;
> > +
> > +	pbus = pci_find_bus(pci_domain_nr(rcec->bus), rcec->bus-
> > >number);
> > +	if (!pbus)
> > +		return;
> > +
> > +	pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP,
> > &bitmap);
> > +
> > +	/* Find RCiEP devices on the same bus as the RCEC */
> > +	if (pcie_walk_rciep_devfn(pbus, cb, userdata, (unsigned
> > long)bitmap))
> > +		return;
> > +
> > +	/* Check whether RCEC BUSN register is present */
> > +	pci_read_config_dword(rcec, pos, &hdr);
> > +	ver = PCI_EXT_CAP_VER(hdr);
> > +	if (ver < PCI_RCEC_BUSN_REG_VER)
> > +		return;
> > +
> > +	pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
> > +	nextbusn = PCI_RCEC_BUSN_NEXT(busn);
> > +	lastbusn = PCI_RCEC_BUSN_LAST(busn);
> > +
> > +	/* All RCiEP devices are on the same bus as the RCEC */
> > +	if (nextbusn == 0xff && lastbusn == 0x00)
> > +		return;
> > +
> > +	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
> > +		pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> > +		if (!pbus)
> > +			continue;
> > +
> > +		/* Find RCiEP devices on the given bus */
> > +		if (pcie_walk_rciep_devfn(pbus, cb, userdata,
> > 0xffffffff))
> > +			return;
> > +	}
> > +}
> > +
> >   #ifdef CONFIG_PM
> >   typedef int (*pcie_pm_callback_t)(struct pcie_device *);
> >   
> > 

