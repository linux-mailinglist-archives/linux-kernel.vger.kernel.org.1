Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197D423CDC9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgHERww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 13:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgHERuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:50:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00229C0617A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:50:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so1327682pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=oBdD6rRWI+T9jKksJrFJOL2jYdtDQqCdiB69lf285xE=;
        b=EDlMSQtqUUplTi58aA6yI0+v4zXQZv1PXUD1l9IlXGHW8M3Fia75Hu/yinUgOlSETY
         BUZQ7V5JVYjurc+L+z3Zr59CC4TFDE8m+HW7VTfgsumFpE4XvNhU8IAV8tcjUhgiy8me
         3IJptePbQIyKsRHtDujQN5b6lnMyagtmvTE3ncKlmsZL5CrIQ/uXETCwMPaIFxDIrv2C
         FtYXeRwJSqa4jJXMgKM0AyqgWXlUQqblJN/Z3WMdQpWUAGn92SvlBTFyZSaQJQDR7uJp
         Ze0bsfrltgAGb4jH3qfpRy4+u9mkUjWrGFXOK4C7N/CRyHcsCzAalxEu1LfQQ6Roc16b
         FBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=oBdD6rRWI+T9jKksJrFJOL2jYdtDQqCdiB69lf285xE=;
        b=GlRr7YXTFTYyOpvp1nlGhhTWhQ39eDVp4dWf32FxKqWSA6HJZ/aYnTRZYNnCUATv1X
         qGVy7+x9tsPFEsHuKB7pMctHHJuS52iGrrFBVwTyJGQnYb6D32TYxTq2HFBOahUw2zqi
         ff4y+2PUHGKsh/pB0Q+uPuuejKU+7mCv0sXmD633U4dDQs1hXUvYawu7xeljhaYNEiGW
         Rl9jd13acikJMX1pSGyTTIEhLTmtVrDfVzVoSwptVsZSjMYbHRCUaVAVb13lc5ys8d6Y
         px9zpD+jaVeuM0mR41Qzu9/W89qbVPmGGF8BoOty3iQ3IU/LYmC2qlUOaDvrjP3B14vN
         SD4g==
X-Gm-Message-State: AOAM530QGsGZ4p5xnbsBynD9wi1BCtaYWBQME0oPy0LFb8J8isVtcEVg
        nCiNtKNUToY3Npae6wT4HAqgrA==
X-Google-Smtp-Source: ABdhPJwfDOwWLiPyuKjaVkxQEYZVOiS2sYRHBJQYnEnXUtI1bPDedUVEsEH2nkjixph1a+ghekQPuQ==
X-Received: by 2002:a62:1a49:: with SMTP id a70mr4601300pfa.297.1596649809478;
        Wed, 05 Aug 2020 10:50:09 -0700 (PDT)
Received: from [10.213.170.159] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id h5sm4391192pfq.146.2020.08.05.10.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:50:08 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 2/9] PCI: Extend Root Port Driver to support RCEC
Date:   Wed, 05 Aug 2020 10:50:06 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <A0EBCB85-21ED-479A-9C95-3E27F8192F0A@intel.com>
In-Reply-To: <20200805184535.00005711@Huawei.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
 <20200804194052.193272-3-sean.v.kelley@intel.com>
 <20200805184535.00005711@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Aug 2020, at 10:45, Jonathan Cameron wrote:

> On Tue, 4 Aug 2020 12:40:45 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors 
>> may
>> optionally be sent to a corresponding Root Complex Event Collector 
>> (RCEC).
>> Each RCiEP must be associated with no more than one RCEC. Interface 
>> errors
>> are reported to the OS by RCECs.
>>
>> For an RCEC (technically not a Bridge), error messages "received" 
>> from
>> associated RCiEPs must be enabled for "transmission" in order to 
>> cause a
>> System Error via the Root Control register or (when the Advanced 
>> Error
>> Reporting Capability is present) reporting via the Root Error Command
>> register and logging in the Root Error Status register and Error 
>> Source
>> Identification register.
>>
>> Given the commonality with Root Ports and the need to also support 
>> AER
>> and PME services for RCECs, extend the Root Port driver to support 
>> RCEC
>> devices through the addition of the RCEC Class ID to the driver
>> structure.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> One trivial thing inline.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
>> ---
>>  drivers/pci/pcie/portdrv_core.c | 8 ++++----
>>  drivers/pci/pcie/portdrv_pci.c  | 5 ++++-
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>> b/drivers/pci/pcie/portdrv_core.c
>> index 50a9522ab07d..5d4a400094fc 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -234,11 +234,11 @@ static int get_port_device_capability(struct 
>> pci_dev *dev)
>>  #endif
>>
>>  	/*
>> -	 * Root ports are capable of generating PME too.  Root Complex
>> -	 * Event Collectors can also generate PMEs, but we don't handle
>> -	 * those yet.
>> +	 * Root ports and Root Complex Event Collectors are capable
>> +	 * of generating PME too.
>
> I'm not sure what the 'too' refers to.   I'd just drop it and avoid
> any possible confusion!

Paste error of text.  Will correct.

Thanks,

Sean

>
>>  	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>>  	    (pcie_ports_native || host->native_pme)) {
>>  		services |= PCIE_PORT_SERVICE_PME;
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>> b/drivers/pci/pcie/portdrv_pci.c
>> index 3a3ce40ae1ab..4d880679b9b1 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev 
>> *dev,
>>  	if (!pci_is_pcie(dev) ||
>>  	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> -	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
>> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
>> +	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>>  		return -ENODEV;
>>
>>  	status = pcie_port_device_register(dev);
>> @@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] 
>> = {
>>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
>>  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
>>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
>> +	/* handle any Root Complex Event Collector */
>> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
>>  	{ },
>>  };
>>
