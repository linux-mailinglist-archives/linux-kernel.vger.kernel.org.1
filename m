Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785BA1D0DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbgEMJ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 05:57:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:47470 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388265AbgEMJza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:55:30 -0400
IronPort-SDR: QFGLHX2S53ZsYnCR5k3nCWC/Tb38LNJqnf5Al3vWdHchNSj5QiZZBxGDTFlfxBRTnteoji+xP3
 Wzv9n5U48mPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 02:55:30 -0700
IronPort-SDR: gC+pYm8Y2Su1s1hokdXXBZl+u9QTcwlmo/mBaoP7ZbaEoSOexzUYwWpXd8gSXfb3tuggCXzbmi
 PBL8IJkObAMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="409633448"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2020 02:55:28 -0700
Date:   Wed, 13 May 2020 17:52:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, bhu@redhat.com, Luwei Kang <luwei.kang@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v5 2/7] fpga: dfl: pci: add irq info for feature devices
  enumeration
Message-ID: <20200513095222.GB25114@yilunxu-OptiPlex-7050>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
 <1587370303-25568-3-git-send-email-yilun.xu@intel.com>
 <20200512041301.GB110219@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512041301.GB110219@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:13:01PM -0700, Moritz Fischer wrote:
> On Mon, Apr 20, 2020 at 04:11:38PM +0800, Xu Yilun wrote:
> > Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
> > Card) support MSI-X based interrupts. This patch allows PCIe driver
> > to prepare and pass interrupt resources to DFL via enumeration API.
> > These interrupt resources could then be assigned to actual features
> > which use them.
> > 
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > ----
> > v2: put irq resources init code inside cce_enumerate_feature_dev()
> >     Some minor changes for Hao's comments.
> > v3: Some minor fix for Hao's comments for v2.
> > v4: Some minor fix for Hao's comments for v3.
> > v5: No change.
> > ---
> >  drivers/fpga/dfl-pci.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 71 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index a78c409..2ff1274 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -39,6 +39,27 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
> >  	return pcim_iomap_table(pcidev)[bar];
> >  }
> >  
> > +static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> > +{
> > +	int ret, nvec = pci_msix_vec_count(pcidev);
> > +
> > +	if (nvec <= 0) {
> > +		dev_dbg(&pcidev->dev, "fpga interrupt not supported\n");
> > +		return 0;
> > +	}
> > +
> > +	ret = pci_alloc_irq_vectors(pcidev, nvec, nvec, PCI_IRQ_MSIX);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return nvec;
> > +}
> > +
> > +static void cci_pci_free_irq(struct pci_dev *pcidev)
> > +{
> > +	pci_free_irq_vectors(pcidev);
> > +}
> > +
> >  /* PCI Device ID */
> >  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> >  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> > @@ -78,17 +99,38 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
> >  
> >  	/* remove all children feature devices */
> >  	dfl_fpga_feature_devs_remove(drvdata->cdev);
> > +	cci_pci_free_irq(pcidev);
> > +}
> > +
> > +static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
> > +{
> > +	unsigned int i;
> > +	int *table;
> > +
> > +	table = kcalloc(nvec, sizeof(int), GFP_KERNEL);
> > +	if (table) {
> > +		for (i = 0; i < nvec; i++)
> > +			table[i] = pci_irq_vector(pcidev, i);
> > +	}
> 
> Have you considered:
> 	if (!table)
> 		return table;
> 
> 	for (i = 0; i < nvec; i++)
> 		table[i] = pci_irq_vector(pcidev, i);
> 
> 	return table;

I'm fine with this. I'll change it.

> > +
> > +	return table;
> > +}
> > +
> > +static void cci_pci_free_irq_table(int *table)
> > +{
> > +	kfree(table);
> >  }
> 
> Have you considered just using kfree()?

I thought there is a cci_pci_create_irq_table(), and a symmetric
xx_free_xx() function would make the code easier to understand.

How about we keep this?

Thanks,
Yilun.

> >  
> >  /* enumerate feature devices under pci device */
> >  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  {
> >  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > +	int port_num, bar, i, nvec, ret = 0;
> >  	struct dfl_fpga_enum_info *info;
> >  	struct dfl_fpga_cdev *cdev;
> >  	resource_size_t start, len;
> > -	int port_num, bar, i, ret = 0;
> >  	void __iomem *base;
> > +	int *irq_table;
> >  	u32 offset;
> >  	u64 v;
> >  
> > @@ -97,11 +139,30 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	if (!info)
> >  		return -ENOMEM;
> >  
> > +	/* add irq info for enumeration if the device support irq */
> > +	nvec = cci_pci_alloc_irq(pcidev);
> > +	if (nvec < 0) {
> > +		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
> > +		ret = nvec;
> > +		goto enum_info_free_exit;
> > +	} else if (nvec) {
> > +		irq_table = cci_pci_create_irq_table(pcidev, nvec);
> > +		if (!irq_table) {
> > +			ret = -ENOMEM;
> > +			goto irq_free_exit;
> > +		}
> > +
> > +		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
> > +		cci_pci_free_irq_table(irq_table);
> > +		if (ret)
> > +			goto irq_free_exit;
> > +	}
> > +
> >  	/* start to find Device Feature List from Bar 0 */
> >  	base = cci_pci_ioremap_bar(pcidev, 0);
> >  	if (!base) {
> >  		ret = -ENOMEM;
> > -		goto enum_info_free_exit;
> > +		goto irq_free_exit;
> >  	}
> >  
> >  	/*
> > @@ -154,7 +215,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> >  	} else {
> >  		ret = -ENODEV;
> > -		goto enum_info_free_exit;
> > +		goto irq_free_exit;
> >  	}
> >  
> >  	/* start enumeration with prepared enumeration information */
> > @@ -162,11 +223,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  	if (IS_ERR(cdev)) {
> >  		dev_err(&pcidev->dev, "Enumeration failure\n");
> >  		ret = PTR_ERR(cdev);
> > -		goto enum_info_free_exit;
> > +		goto irq_free_exit;
> >  	}
> >  
> >  	drvdata->cdev = cdev;
> >  
> > +irq_free_exit:
> > +	if (ret)
> > +		cci_pci_free_irq(pcidev);
> >  enum_info_free_exit:
> >  	dfl_fpga_enum_info_free(info);
> >  
> > @@ -211,12 +275,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >  	}
> >  
> >  	ret = cci_enumerate_feature_devs(pcidev);
> > -	if (ret) {
> > -		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> > -		goto disable_error_report_exit;
> > -	}
> > +	if (!ret)
> > +		return ret;
> >  
> > -	return ret;
> > +	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
> >  
> >  disable_error_report_exit:
> >  	pci_disable_pcie_error_reporting(pcidev);
> > -- 
> > 2.7.4
> > 
> 
> Thanks,
> Moritz
