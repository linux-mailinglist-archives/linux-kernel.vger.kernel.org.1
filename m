Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1551F23CF22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgHETOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgHESHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:07:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D32C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:07:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so25721535pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=zpo8fvjD48Dm75nsWepImhJQhFxGByfp3GGAhgmeGXA=;
        b=xLb/YVFnYsJNIevhaGNo/MDYWAWf1X+sBBo9D/mPZqR4LMwyIpe2NUx8fLmn1Lsr0q
         YWTrS7Q8RJPPhGnMjHadV151imo97L/0VWf6nX6pWpdR21wWDwHBmvcKjyUur9WXbfYs
         Iu0ZKaq154btVvEBYD+4lUtVrLwFSdRAQV9706dG8CxgdYoV+FkQF5emWs8H09Wax0sS
         1mCaRqHX2s3A042Oki4d19/GP0QF2j/zY9WQCZzAp40ICgR2z8CsJY/W530dyVHeu8o7
         7XqqOVKxMGfG3nsChAglHifE3gTae5cXxOcXVEo/MIJC4JOpImL0p3P/7OJBQlfFn67x
         5RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=zpo8fvjD48Dm75nsWepImhJQhFxGByfp3GGAhgmeGXA=;
        b=l62E5AVKOpHXTV7Y9t/rkSW+h1xVDVs3mlPDur1OQBHOg2zN8DbSpweHRwQ8qpXdLZ
         p8l1/mWLLpWIxvsL/DvKsZ6WaLgWfG+sbJW0lN9Gr/T+fvzjltHGGGDdwNR9X4ulKpLN
         CQFIjEJpAAzoiV7v+6JbSqhLMJmsXh1QAzvXV+Kd/GzlHy9kKN41IEiCwLh2CnvAvoiI
         2wG7ZjXMEFKwzScJBvP14mi+roDXzu63RujXmP0rRzffBmcesznXh+OwYnmkyj9u+wtX
         vycGZGs9cUXWcuUMkKWqgJinU6QqVCI7qUJvVUCLjtSxYTJF90yLjwwP9DPn9s0OoA55
         61SQ==
X-Gm-Message-State: AOAM5334RFHxw9M0IJ07yHSjWHhG85S2QBGnSD4ni8iaZExbdbfV5FGN
        TUDzmp4Y6wGGuhawLBE9E7cIFQ==
X-Google-Smtp-Source: ABdhPJzi9zL+yoWdH6nNznZgJoPEDhs83nZyG4vafU69Fvg/ZwMhndKnYwpE3hAsHU5BgtBLWw/QDA==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr4632709pjb.229.1596650859622;
        Wed, 05 Aug 2020 11:07:39 -0700 (PDT)
Received: from [10.213.170.159] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id s22sm4291758pfh.16.2020.08.05.11.07.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:07:38 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 3/9] PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs
 associated with RCEC
Date:   Wed, 05 Aug 2020 11:07:36 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <05418D9C-89AF-426B-9209-90607109B9CC@intel.com>
In-Reply-To: <20200805174301.GA514577@bjorn-Precision-5520>
References: <20200805174301.GA514577@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Aug 2020, at 10:43, Bjorn Helgaas wrote:

> On Tue, Aug 04, 2020 at 12:40:46PM -0700, Sean V Kelley wrote:
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> When an RCEC device signals error(s) to a CPU core, the CPU core
>> needs to walk all the RCiEPs associated with that RCEC to check
>> errors. So add the function pcie_walk_rcec() to walk all RCiEPs
>> associated with the RCEC device.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/pci/pcie/portdrv.h      |  2 +
>>  drivers/pci/pcie/portdrv_core.c | 82 
>> +++++++++++++++++++++++++++++++++
>>  2 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index af7cf237432a..c11d5ecbad76 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -116,6 +116,8 @@ void pcie_port_service_unregister(struct 
>> pcie_port_service_driver *new);
>>
>>  extern struct bus_type pcie_port_bus_type;
>>  int pcie_port_device_register(struct pci_dev *dev);
>> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev 
>> *, void *),
>> +		    void *userdata);
>>  #ifdef CONFIG_PM
>>  int pcie_port_device_suspend(struct device *dev);
>>  int pcie_port_device_resume_noirq(struct device *dev);
>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>> b/drivers/pci/pcie/portdrv_core.c
>> index 5d4a400094fc..daa2dfa83a0b 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/string.h>
>>  #include <linux/slab.h>
>> +#include <linux/bitops.h>
>>  #include <linux/aer.h>
>>
>>  #include "../pci.h"
>> @@ -365,6 +366,87 @@ int pcie_port_device_register(struct pci_dev 
>> *dev)
>>  	return status;
>>  }
>>
>> +static int pcie_walk_rciep_devfn(struct pci_bus *pbus, int 
>> (*cb)(struct pci_dev *, void *),
>
> In drivers/pci, the typical name for a "struct pci_bus *" is "bus",
> and for a "struct pci_dev *" is "dev" (below).
>
>> +				 void *userdata, unsigned long bitmap)

Will correct.

>
> Use "u32 bitmap" so the width is explicit.  Looks like this would also
> get rid of the cast in the caller.  So maybe you used "unsigned long"
> here for some reason?

Will correct. Somehow one cast led to another.  Should have been u32.

>
>> +{
>> +	unsigned int dev, fn;
>> +	struct pci_dev *pdev;
>> +	int retval;
>> +
>> +	for_each_set_bit(dev, &bitmap, 32) {
>> +		for (fn = 0; fn < 8; fn++) {
>> +			pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
>
> This needs a matching pci_dev_put(), according to the pci_get_slot()
> function comment.

Will add.

>
>> +
>> +			if (!pdev || pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
>> +				continue;
>> +
>> +			retval = cb(pdev, userdata);
>> +			if (retval)
>> +				return retval;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and 
>> call callback.
>> + * @rcec     RCEC whose RCiEP devices should be walked.
>> + * @cb       Callback to be called for each RCiEP device found.
>> + * @userdata Arbitrary pointer to be passed to callback.
>> + *
>> + * Walk the given RCEC. Call the provided callback on each RCiEP 
>> device found.
>> + *
>> + * We check the return of @cb each time. If it returns anything
>> + * other than 0, we break out.
>> + */
>> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev 
>> *, void *),
>> +		    void *userdata)
>> +{
>> +	u32 pos, bitmap, hdr, busn;
>> +	u8 ver, nextbusn, lastbusn;
>> +	struct pci_bus *pbus;
>> +	unsigned int bnr;
>> +
>> +	pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
>> +	if (!pos)
>> +		return;
>
> I think all the registers you care about here are read-only.  If so, 
> we
> should find the capability, read the registers (bitmap & bus numbers),
> and save them at enumeration-time, e.g., in pci_init_capabilities().
> I hope we don't have to dig all this out every time we process an
> error.

I originally went that way by caching the rcec cap (pos) in pci_dev on 
probe. Will make changes to cache at enumeration time.

>
>> +	pbus = pci_find_bus(pci_domain_nr(rcec->bus), rcec->bus->number);
>> +	if (!pbus)
>> +		return;
>
> This seems like a really complicated way to write:
>
>   pbus = rcec->bus;
>
> "rcec->bus" cannot be NULL, so there's no need to check.

For some reason, at the time it appeared I needed to call pci_find_bus.  
But that makes sense if it is always valid. Will correct.

>
>> +	pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP, &bitmap);
>> +
>> +	/* Find RCiEP devices on the same bus as the RCEC */
>> +	if (pcie_walk_rciep_devfn(pbus, cb, userdata, (unsigned 
>> long)bitmap))
>> +		return;
>> +
>> +	/* Check whether RCEC BUSN register is present */
>> +	pci_read_config_dword(rcec, pos, &hdr);
>> +	ver = PCI_EXT_CAP_VER(hdr);
>> +	if (ver < PCI_RCEC_BUSN_REG_VER)
>> +		return;
>> +
>> +	pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
>> +	nextbusn = PCI_RCEC_BUSN_NEXT(busn);
>> +	lastbusn = PCI_RCEC_BUSN_LAST(busn);
>> +
>> +	/* All RCiEP devices are on the same bus as the RCEC */
>> +	if (nextbusn == 0xff && lastbusn == 0x00)
>> +		return;
>> +
>> +	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
>> +		pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
>> +		if (!pbus)
>> +			continue;
>> +
>> +		/* Find RCiEP devices on the given bus */
>> +		if (pcie_walk_rciep_devfn(pbus, cb, userdata, 0xffffffff))
>> +			return;
>> +	}
>> +}
>> +
>>  #ifdef CONFIG_PM
>>  typedef int (*pcie_pm_callback_t)(struct pcie_device *);
>>
>> -- 
>> 2.27.0
>>
