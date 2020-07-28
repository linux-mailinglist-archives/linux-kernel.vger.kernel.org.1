Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820CF231204
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbgG1Sw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 14:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgG1Sw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:52:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD27207F5;
        Tue, 28 Jul 2020 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595962346;
        bh=rsFGSYZoh2bZszC7RRw3GX0SpaEAw/9n5VERca7iaR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIoxyRfq2KfJp3DBWrKjo1N9oI8C6DYlxtytnW1DDEOWwveOGMmBhJJ3uVwlw9IMF
         JNbWB6gzqycGRaLOw0CSjhWmSavONkchpZ7e/3XQcfhD3BfOYxnPln11kSqlZV364m
         rjNJ6hgowqgMwxp4epeHla5Srxj9/MPQyo/VqqRU=
Date:   Tue, 28 Jul 2020 20:52:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next V2] mei: add device kind to sysfs
Message-ID: <20200728185219.GA332869@kroah.com>
References: <20200728182836.3112138-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728182836.3112138-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 09:28:36PM +0300, Tomas Winkler wrote:
> +/**
> + * kind_show - display device kind
> + *
> + * @device: device pointer
> + * @attr: attribute pointer
> + * @buf: char out buffer
> + *
> + * Return: number of the bytes printed into buf or error

No need for kernel doc for static sysfs attributes, but ok...

> + */
> +static ssize_t kind_show(struct device *device,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +	ssize_t ret = 0;

No need to initialize this.

> +
> +	mutex_lock(&dev->device_lock);
> +	if (dev->kind)
> +		ret = sprintf(buf, "%s\n", dev->kind);
> +	else
> +		ret = sprintf(buf, "%s\n", "mei");
> +	mutex_unlock(&dev->device_lock);

Why do you need a lock?  kind can not change, so what are you trying to
protect from?

thanks,

greg k-h
