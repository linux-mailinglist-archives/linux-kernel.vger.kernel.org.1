Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F421CA12
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgGLP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 11:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgGLP6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F622068F;
        Sun, 12 Jul 2020 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594569493;
        bh=T50MoUDXCTgUobnkzSCiggjgrR6/+SkklTXlLKXrfnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXvJSsggwPMy7Y3puVS98YxQihy52sRicDRsD/d4da0d1hbL9oiae8cSgkr7J84P7
         1NYOLr1STd7dfl4QbnHE6uazOIuzyhqCUdeecWAkkV0A6xHCQ9pPJZOyTCKOnOStJj
         WjpWYKKMXrMT44UG18ign8QOKm5OX5UAOr+LIWmw=
Date:   Sun, 12 Jul 2020 17:58:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gage Eads <gage.eads@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200712155810.GC186665@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712134331.8169-2-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> +static int dlb2_probe(struct pci_dev *pdev,
> +		      const struct pci_device_id *pdev_id)
> +{
> +	struct dlb2_dev *dlb2_dev;
> +	int ret;
> +
> +	dev_dbg(&pdev->dev, "probe\n");

ftrace is your friend.  Remove all of your debugging code now, you don't
need it anymore, especially for stuff like this where you didn't even
need it in the first place :(

Same for everywhere else in all of these patches.  I'll stop reviewing
now, someone at Intel should have caught basic stuff like this before
now, sad...

greg k-h
