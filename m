Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45592ED787
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbhAGTfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGTfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:35:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC73F23441;
        Thu,  7 Jan 2021 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610048069;
        bh=0GubfiMHiB//8n/Be/BNqN0RqV4557ytXaKmIQ84fi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scFDswHssVvc5bFYvmnVKwNEWERuY4kdtJQiBjmXX621F/D6m8dyFygJ3N9kmHN1S
         v1ad81JzY+AgqxyIt42asq4J61YLuy+84reLZgD8gVOtOO5zFGhlqYIafTbRfGBC4u
         fYfjh9nHf1mEi6qDEHigB0jsqm1vAKffe7/sV3Vc=
Date:   Thu, 7 Jan 2021 20:35:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v8 01/20] dlb: add skeleton for DLB driver
Message-ID: <X/dilO0pQI3GVh6F@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-2-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105025839.23169-2-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:58:20PM -0600, Mike Ximing Chen wrote:
> +static int dlb_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id *pdev_id)
> +{
> +	struct dlb *dlb;
> +	int ret;
> +
> +	dlb = devm_kzalloc(&pdev->dev, sizeof(*dlb), GFP_KERNEL);
> +	if (!dlb)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, dlb);
> +
> +	dlb->pdev = pdev;
> +
> +	spin_lock(&dlb_ids_lock);
> +	dlb->id = idr_alloc(&dlb_ids,
> +			    (void *)dlb,
> +			    0,
> +			    DLB_MAX_NUM_DEVICES - 1,
> +			    GFP_KERNEL);
> +	spin_unlock(&dlb_ids_lock);
> +
> +	if (dlb->id < 0) {
> +		dev_err(&pdev->dev, "probe: device ID allocation failed\n");
> +
> +		ret = dlb->id;
> +		goto alloc_id_fail;
> +	}
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "pcim_enable_device() returned %d\n", ret);
> +
> +		goto pci_enable_device_fail;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev,
> +				 (1U << DLB_CSR_BAR) | (1U << DLB_FUNC_BAR),
> +				 "dlb");
> +	if (ret != 0) {
> +		dev_err(&pdev->dev,
> +			"pcim_iomap_regions(): returned %d\n", ret);
> +
> +		goto pci_enable_device_fail;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	if (pci_enable_pcie_error_reporting(pdev))
> +		dev_info(&pdev->dev, "[%s()] Failed to enable AER\n", __func__);

Shouldn't that be dev_err() and you fail here?

And no need for __func__ please, the driver name and device is listed,
that's all that is necessary.

thanks,

greg k-h
