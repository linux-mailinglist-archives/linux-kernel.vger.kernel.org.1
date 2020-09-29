Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80427DD15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgI2Xvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgI2Xvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:51:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:51:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so52395pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=B2V6sZUXdoa+HJ8oaQ/uggTq/89zG7SIXBmJ4ZG9irk=;
        b=Jsid35ugdHZ1g1JA0TvQ49HoNBoLD0B+UK2xUmKb2IESuHcAnFS0S9tTf8NvGhh1/Q
         SyAfF85mVI0AId1J6G2jbhgRiBMIiYlL9mgfrSz9F7jjNyGVpb1xiQKOAr52N+M/IfJE
         +ziutaGVIJn+rzHaLZV/nIvaRSF9emVKwGfJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=B2V6sZUXdoa+HJ8oaQ/uggTq/89zG7SIXBmJ4ZG9irk=;
        b=s3Yp7gnrauKbhIp5npiaSY67eNQ2Xu8+6l46oE4rgXXbnKATlx9Wz/fPFB5wirfeil
         YkgVzXNex1YfpfYI4vV4+2gzolY7YGre+a2mxKWaKD1IcE/kW2Poaf5i1KlpXd6EzKD5
         77RYKXazsiD0MueXJJ9ZAIm0PJjzplWZ2NPAA4Hv0IrlRrtgiafDuPDxtFYsPKPUCZh8
         AxcFXwYI3O18jZ6X5Xws86Vjan3FW0qM715ZbFp0d5LmZrL5aqRVe5PI6h5eu0MmwzAM
         nZVcLBD5I7EA6sr4DnxBgcN9BsJY1C6rkhkKBmfuxApqNXPEHQ6oo5YLufp5zuvFkGaR
         BNgA==
X-Gm-Message-State: AOAM530fIttCyXIbzE/4gao5pZX8aJHT2Hac/nji/LBRFNssu0V6nMd4
        FGLm3DHGX6ocQskUf6gAIbmcCg==
X-Google-Smtp-Source: ABdhPJxnIFA3cBoCLroX3/RmL7uLBjcDGfPBmfNNDBFD6uhC0JWntJ1Up2dPBOQSU2eCkJCkzLZctQ==
X-Received: by 2002:a17:90b:88d:: with SMTP id bj13mr19908pjb.80.1601423509551;
        Tue, 29 Sep 2020 16:51:49 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 34sm1935721pgp.5.2020.09.29.16.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 16:51:48 -0700 (PDT)
Subject: Re: [PATCH v4 02/16] misc: bcm-vk: add Broadcom VK driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200929001209.16393-1-scott.branden@broadcom.com>
 <20200929001209.16393-3-scott.branden@broadcom.com>
 <20200929102821.GC951772@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <2c0bd222-a0d1-377e-766b-e44afc90d5d3@broadcom.com>
Date:   Tue, 29 Sep 2020 16:51:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929102821.GC951772@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000075285105b07c77d4"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000075285105b07c77d4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA

Hi Greg,

On 2020-09-29 3:28 a.m., Greg Kroah-Hartman wrote:
> On Mon, Sep 28, 2020 at 05:11:55PM -0700, Scott Branden wrote:
>> Add initial version of Broadcom VK driver to enumerate PCI device IDs
>> of Valkyrie and Viper device IDs.
>>
>> VK based cards provide real-time high performance, high throughput,
>> low latency offload compute engine operations.
>> They are used for multiple parallel offload tasks as:
>> audio, video and image processing and crypto operations.
> As we have had this come up for other offload engine devices, we need a
> pointer to the userspace code for this as well, so that we can properly
> review the whole thing together.  Otherwise this is just one half, the
> other is a black-box that is pretty impossible to understand :)
We've been meaning to publish the userspace code.
Here is the vk interface library, vkil, and associated unittest and
card utilities.

https://github.com/Broadcom/vkil/
>
>
>> Further commits add additional features to driver beyond probe/remove.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/misc/Kconfig             |   1 +
>>  drivers/misc/Makefile            |   1 +
>>  drivers/misc/bcm-vk/Kconfig      |  15 ++++
>>  drivers/misc/bcm-vk/Makefile     |   8 ++
>>  drivers/misc/bcm-vk/bcm_vk.h     |  29 +++++++
>>  drivers/misc/bcm-vk/bcm_vk_dev.c | 137 +++++++++++++++++++++++++++++++
>>  6 files changed, 191 insertions(+)
>>  create mode 100644 drivers/misc/bcm-vk/Kconfig
>>  create mode 100644 drivers/misc/bcm-vk/Makefile
>>  create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
>>  create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index ce136d685d14..9d42b5def81b 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -469,6 +469,7 @@ source "drivers/misc/genwqe/Kconfig"
>>  source "drivers/misc/echo/Kconfig"
>>  source "drivers/misc/cxl/Kconfig"
>>  source "drivers/misc/ocxl/Kconfig"
>> +source "drivers/misc/bcm-vk/Kconfig"
>>  source "drivers/misc/cardreader/Kconfig"
>>  source "drivers/misc/habanalabs/Kconfig"
>>  source "drivers/misc/uacce/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index c7bd01ac6291..766837e4b961 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -52,6 +52,7 @@ obj-$(CONFIG_ECHO)		+= echo/
>>  obj-$(CONFIG_CXL_BASE)		+= cxl/
>>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>>  obj-$(CONFIG_OCXL)		+= ocxl/
>> +obj-$(CONFIG_BCM_VK)		+= bcm-vk/
>>  obj-y				+= cardreader/
>>  obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
>> new file mode 100644
>> index 000000000000..2272e47655ed
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Broadcom VK device
>> +#
>> +config BCM_VK
>> +	tristate "Support for Broadcom VK Accelerators"
>> +	depends on PCI_MSI
>> +	help
>> +	  Select this option to enable support for Broadcom
>> +	  VK Accelerators.  VK is used for performing
>> +	  specific offload processing.
>> +	  This driver enables userspace programs to access these
>> +	  accelerators via /dev/bcm-vk.N devices.
>> +
>> +	  If unsure, say N.
>> diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
>> new file mode 100644
>> index 000000000000..f8a7ac4c242f
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/Makefile
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for Broadcom VK driver
>> +#
>> +
>> +obj-$(CONFIG_BCM_VK) += bcm_vk.o
>> +bcm_vk-objs := \
>> +	bcm_vk_dev.o
>> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
>> new file mode 100644
>> index 000000000000..9152785199ab
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef BCM_VK_H
>> +#define BCM_VK_H
>> +
>> +#include <linux/pci.h>
>> +
>> +#define DRV_MODULE_NAME		"bcm-vk"
>> +
>> +/* VK device supports a maximum of 3 bars */
>> +#define MAX_BAR	3
>> +
>> +enum pci_barno {
>> +	BAR_0 = 0,
>> +	BAR_1,
>> +	BAR_2
>> +};
>> +
>> +#define BCM_VK_NUM_TTY 2
>> +
>> +struct bcm_vk {
>> +	struct pci_dev *pdev;
>> +	void __iomem *bar[MAX_BAR];
>> +};
>> +
>> +#endif
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
>> new file mode 100644
>> index 000000000000..bb24efb1b9fb
>> --- /dev/null
>> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
>> @@ -0,0 +1,137 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci_regs.h>
>> +
>> +#include "bcm_vk.h"
>> +
>> +#define PCI_DEVICE_ID_VALKYRIE	0x5e87
>> +#define PCI_DEVICE_ID_VIPER	0x5e88
>> +
>> +/* MSIX usages */
>> +#define VK_MSIX_MSGQ_MAX		3
>> +#define VK_MSIX_NOTF_MAX		1
>> +#define VK_MSIX_TTY_MAX			BCM_VK_NUM_TTY
>> +#define VK_MSIX_IRQ_MAX			(VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX + \
>> +					 VK_MSIX_TTY_MAX)
>> +#define VK_MSIX_IRQ_MIN_REQ             (VK_MSIX_MSGQ_MAX + VK_MSIX_NOTF_MAX)
>> +
>> +/* Number of bits set in DMA mask*/
>> +#define BCM_VK_DMA_BITS			64
>> +
>> +static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +	int err;
>> +	int i;
>> +	int irq;
>> +	struct bcm_vk *vk;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	vk = kzalloc(sizeof(*vk), GFP_KERNEL);
>> +	if (!vk)
>> +		return -ENOMEM;
>> +
>> +	err = pci_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(dev, "Cannot enable PCI device\n");
>> +		return err;
> You just leaked memory :(
Yes, missing kfree(vk).
>
> That was a short review, I didn't get all that far...
>
>> +	}
>> +	vk->pdev = pci_dev_get(pdev);
>> +
>> +	err = pci_request_regions(pdev, DRV_MODULE_NAME);
>> +	if (err) {
>> +		dev_err(dev, "Cannot obtain PCI resources\n");
>> +		goto err_disable_pdev;
>> +	}
>> +
>> +	/* make sure DMA is good */
>> +	err = dma_set_mask_and_coherent(&pdev->dev,
>> +					DMA_BIT_MASK(BCM_VK_DMA_BITS));
>> +	if (err) {
>> +		dev_err(dev, "failed to set DMA mask\n");
>> +		goto err_disable_pdev;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +	pci_set_drvdata(pdev, vk);
>> +
>> +	irq = pci_alloc_irq_vectors(pdev,
>> +				    1,
>> +				    VK_MSIX_IRQ_MAX,
>> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
>> +
>> +	if (irq < VK_MSIX_IRQ_MIN_REQ) {
>> +		dev_err(dev, "failed to get min %d MSIX interrupts, irq(%d)\n",
>> +			VK_MSIX_IRQ_MIN_REQ, irq);
>> +		err = (irq >= 0) ? -EINVAL : irq;
>> +		goto err_disable_pdev;
>> +	}
>> +
>> +	dev_info(dev, "Number of IRQs %d allocated - requested(%d).\n",
>> +		 irq, VK_MSIX_IRQ_MAX);
> Drivers are quiet when all works properly.
Will change to dev_warn when number allocated != number requested
and dev_dbg otherwise.
>
>> +
>> +	for (i = 0; i < MAX_BAR; i++) {
>> +		/* multiple by 2 for 64 bit BAR mapping */
>> +		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
>> +		if (!vk->bar[i]) {
>> +			dev_err(dev, "failed to remap BAR%d\n", i);
>> +			goto err_iounmap;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err_iounmap:
>> +	for (i = 0; i < MAX_BAR; i++) {
>> +		if (vk->bar[i])
>> +			pci_iounmap(pdev, vk->bar[i]);
>> +	}
>> +	pci_release_regions(pdev);
>> +
>> +err_disable_pdev:
>> +	pci_free_irq_vectors(pdev);
>> +	pci_disable_device(pdev);
>> +	pci_dev_put(pdev);
>> +
>> +	return err;
> Again, memory is leaked :(
Yes, will kfree.
>
> thanks,
>
> greg k-h


--00000000000075285105b07c77d4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I/3RRboOeC9M13VNr5feU91O0iDoMreAgPQJ0Lo7YrodKYug0Tt/fFDjkW3v3VIbEr2liUN69U0C
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUWOK7
qiyDSt/IDm/SRcNi/sTEiyswDQYJKoZIhvcNAQELBQADggEBAEe2edd4F9tpp0GPmrFrQ+xp9kY7
uxBzPdCw588bgVrPemjLwiwV37XTT4iWJtNhPfEpaguM6jeLm58LCvHq5/IBjcyHyf4URQVwAg7B
pqkH8/M+IBstu4/D+znPHB59X+c+au3Q8D+xoNFd7I30kaE+oJuBuFsGXRBc0Ci+FM86x9k7SF8U
aui1E7Y9wDfsRSCL2TSwU773f09WkrvVdlKxNqQZj2z7bQUUn+yfXdFfBz0LqlYNfn7xJOpQE3HI
H4jq6U9+b0Qf+J0n0wyysjXPSeQ7EKXVkT8dM2KSpIN86v5dd9LkAz3C1dmjuPRGEC8ZhI1IjMBt
0itrn6C23NsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgfLzf8gpa
Dt4fmH4qQFF7lxKFg22cirrdtwz63hxa+0IwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAwOTI5MjM1MTUwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKvgcjIKKmLdCE6pvD6ox8dq2rXn
BYrYfGcFOoVUqm8WmjmrTGU1KkjRs+vX5yXGvhEEWvB85+QgDF5WXrQfwXmsJBdsHQrl/D2o+dm2
jv5EWMKwj3+9TkHlDjJFaabSdCCG4TPJ+2VxHcceX+qVG9XZCEWAKXdNuEJkq2vnwcBvnqCo35t4
k+yGYPXQx/7Rb5Vk48FNNHYGvwbpuQ092Bi9zqBgSVxssR7Ph/xxYqqdBajxms6EqUDbJgArSkDY
fUtfTaHSkTS9sKONP62reu0wysx/01TSaT3XXQ2BW1m0mi90+RkI1H73/Moz1ndpztuwl6ikM0bQ
DekRw4TW0pQ=
--00000000000075285105b07c77d4--
