Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694872238CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 05:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQJ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:58:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9841520684;
        Fri, 17 Jul 2020 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594979882;
        bh=Zz2+ApO956fhXzUJmK96gy8OpESoWOBT3sYWqJtTRHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddLhCSVC58MMF4b1pgQZ0TOXAk5WBoBERnUXi9UeK4RAW6RZ5lswYhnJZbvupW21B
         /NUDLo3Zhfyw4+mACae/+svfvqlLyOAQwasY4vFWBUaE8Jla6d+eyI9x7B4uAlWXSe
         4t2e6jjv34ueMpGIuZHmV0p4FohouwzsvEcCM7Po=
Date:   Fri, 17 Jul 2020 11:57:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.8-rc4/5
Message-ID: <20200717095754.GA2461800@kroah.com>
References: <20200710170322.GA29124@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710170322.GA29124@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:03:22PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This pull request is for the next rc (rc4 or 5) and it contains:
> 
> 1. Important bug fix for the GAUDI command parsing code.
> 
> 2. Change in debugfs interface that is relevant only for GAUDI and
>    therefore can still be changed in this release.
> 
> 3. Workaround for a timeout problem in GOYA and GAUDI.
> 
> Details are in the tag message below.
> 
> Thanks,
> Oded
> 
> The following changes since commit 897c44f0bae574c5fb318c759b060bebf9dd6013:
> 
>   virtio: virtio_console: add missing MODULE_DEVICE_TABLE() for rproc serial (2020-07-10 15:12:48 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-07-10

Sorry for the delay, now pulled and pushed out.

greg k-h
