Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3A27AA54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgI1JK3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 05:10:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48679 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1JK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:10:29 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kMpAw-0001Pq-6h
        for linux-kernel@vger.kernel.org; Mon, 28 Sep 2020 09:10:26 +0000
Received: by mail-pf1-f199.google.com with SMTP id q2so380718pfc.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1Z4Ynk0YDXFBxI1+/Ju1b4BbhEAznZ0+BUQSH+xMqdU=;
        b=D0ilO/Rdvj7lE5FKwMXRfGDRwYoFAFjHX9mCxTFPNRpxp5rR/vNQ23NYGszkFl12Mq
         ht1VvBMWqybaslaFU77bLt+N2BW3norj7S6EdDbVMK8TWjZOP8j+vFXWc/JnJaDZZJbN
         Q1mQGpuZQEPTxfJ/S5wzHY+YjBeF1QSU2119ea2uZcNSr4Fd91jcZdkJWD4XpVID+IYo
         sbX++KomMzslK6pTHJdMcjnw+NfiqlnzXnp8a5xvdtBnqkkA5p8ddkB58EwUskscUkWC
         S/ofq1EB4q1ZcUJ1LOtJW3FoHasAEMZZxLiCQoLLFxeMbacokZ0k/MJ5/ssBhukwW1z4
         t9OA==
X-Gm-Message-State: AOAM533+Au/vDBd9omLIYpv9XfvMZqctp522wQlfr4RwBaezYqRE4eET
        92nVicCC7jOsZQLj037JbxfXGTT5O4wd/hlZji69IIEFvY6cfbZ32BGdvUO3zlgRkVlt5Uw2Miz
        v2rQD9Ii3KoosE1XruEkJYR9dUcryMj7cZyC+LFPWCQ==
X-Received: by 2002:a17:902:a987:b029:d2:8a38:5bbe with SMTP id bh7-20020a170902a987b02900d28a385bbemr704947plb.60.1601284224842;
        Mon, 28 Sep 2020 02:10:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx40c8Z3kL5j9XyTPIGfTiec3Mg2G7yjpHgKzTReaRCQuRkkkZ2x1cuXHYXS0pfYSc8YAVF5Q==
X-Received: by 2002:a17:902:a987:b029:d2:8a38:5bbe with SMTP id bh7-20020a170902a987b02900d28a385bbemr704929plb.60.1601284224525;
        Mon, 28 Sep 2020 02:10:24 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id j6sm757371pfi.129.2020.09.28.02.10.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 02:10:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v3] xhci: Prevent runtime suspend on Etron EJ168
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <0F26EE78-D4F4-4CCB-892B-999E203BF515@canonical.com>
Date:   Mon, 28 Sep 2020 17:10:22 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <14291E1B-6580-4C69-9EF8-3B30BC78B8D0@canonical.com>
References: <20200504171642.26947-1-kai.heng.feng@canonical.com>
 <0F26EE78-D4F4-4CCB-892B-999E203BF515@canonical.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 8, 2020, at 11:56, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On May 5, 2020, at 01:16, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> Etron EJ168 USB 3.0 Host Controller stops working after S3, if it was
>> runtime suspended previously:
>> [  370.080359] pci 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  370.080477] xhci_hcd 0000:04:00.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  370.080532] pcieport 0000:00:1c.0: DPC: containment event, status:0x1f05 source:0x0200
>> [  370.080533] pcieport 0000:00:1c.0: DPC: ERR_FATAL detected
>> [  370.080536] xhci_hcd 0000:04:00.0: can't change power state from D3hot to D0 (config space inaccessible)
>> [  370.080552] xhci_hcd 0000:04:00.0: AER: can't recover (no error_detected callback)
>> [  370.080566] usb usb3: root hub lost power or was reset
>> [  370.080566] usb usb4: root hub lost power or was reset
>> [  370.080572] xhci_hcd 0000:04:00.0: Host halt failed, -19
>> [  370.080574] xhci_hcd 0000:04:00.0: Host not accessible, reset failed.
>> [  370.080575] xhci_hcd 0000:04:00.0: PCI post-resume error -19!
>> [  370.080586] xhci_hcd 0000:04:00.0: HC died; cleaning up
>> 
>> This can be fixed by not runtime suspend the controller at all.
>> 
>> So disable runtime suspend for EJ168 xHCI device.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

Another gentle ping...

> 
>> ---
>> v3:
>> - Balance rpm refcount in remove callback.
>> 
>> v2:
>> - Use a new quirk to avoid changing existing behavior.
>> 
>> drivers/usb/host/xhci-pci.c | 7 ++++++-
>> drivers/usb/host/xhci.h     | 1 +
>> 2 files changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 766b74723e64..67b4b433a93e 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -227,6 +227,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>> 		xhci->quirks |= XHCI_RESET_ON_RESUME;
>> 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>> 		xhci->quirks |= XHCI_BROKEN_STREAMS;
>> +		xhci->quirks |= XHCI_DISABLE_RUNTIME_SUSPEND;
>> 	}
>> 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
>> 	    pdev->device == 0x0014) {
>> @@ -371,7 +372,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>> 		xhci->shared_hcd->can_do_streams = 1;
>> 
>> 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
>> -	pm_runtime_put_noidle(&dev->dev);
>> +	if (!(xhci->quirks & XHCI_DISABLE_RUNTIME_SUSPEND))
>> +		pm_runtime_put_noidle(&dev->dev);
>> 
>> 	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
>> 		pm_runtime_allow(&dev->dev);
>> @@ -397,6 +399,9 @@ static void xhci_pci_remove(struct pci_dev *dev)
>> 	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
>> 		pm_runtime_forbid(&dev->dev);
>> 
>> +	if (!(xhci->quirks & XHCI_DISABLE_RUNTIME_SUSPEND))
>> +		pm_runtime_get_noresume(&dev->dev);
>> +
>> 	if (xhci->shared_hcd) {
>> 		usb_remove_hcd(xhci->shared_hcd);
>> 		usb_put_hcd(xhci->shared_hcd);
>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>> index 86cfefdd6632..d9c209a10d3f 100644
>> --- a/drivers/usb/host/xhci.h
>> +++ b/drivers/usb/host/xhci.h
>> @@ -1873,6 +1873,7 @@ struct xhci_hcd {
>> #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
>> #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
>> #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
>> +#define XHCI_DISABLE_RUNTIME_SUSPEND    BIT_ULL(36)
>> 
>> 	unsigned int		num_active_eps;
>> 	unsigned int		limit_active_eps;
>> -- 
>> 2.17.1
>> 
> 

