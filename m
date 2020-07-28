Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E91230872
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgG1LQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 07:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgG1LQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:16:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE00205CB;
        Tue, 28 Jul 2020 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595934967;
        bh=HiW5GZ9EjuCvcBJQUd6El6hJn/dJ4M2iEn6pgpFkOks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBJlwVz/yulXo3nfeePJQRJ7gapiDCcecn2E5YzHZ3pmG8VzCf9/idbt+CPVn3TZe
         Nl3Ar/nGdfQ+4LaltIvfJ9ntQ3jvRUy+fy3I+FjzJaGXKf/jda332De/hT8KCgzLIY
         eBwbJczwmMpz3U2jEpDQ1ZyRpexKSdmeRo9x4nDI=
Date:   Tue, 28 Jul 2020 13:16:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Forest Crossman <cyrozap@gmail.com>
Cc:     linux-usb@vger.kernel.org, mathias.nyman@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Small fixes for ASMedia host controllers
Message-ID: <20200728111600.GA2950299@kroah.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
 <20200728042408.180529-1-cyrozap@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728042408.180529-1-cyrozap@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:24:06PM -0500, Forest Crossman wrote:
> The first patch just defines some host controller device IDs to make the
> code a bit easier to read (since the controller part number is not
> always the same as the DID) and to prepare for the next patch.
> 
> The second patch defines a new device ID for the ASM1142 and enables the
> XHCI_NO_64BIT_SUPPORT quirk for that device, since it has the same
> problem with truncating the higher bits as the ASM2142/ASM3142.
> 
> 
> Changes since v1:
>  - Added changelog text to the first patch.
> 
> 
> Forest Crossman (2):
>   usb: xhci: define IDs for various ASMedia host controllers
>   usb: xhci: Fix ASMedia ASM1142 DMA addressing
> 
>  drivers/usb/host/xhci-pci.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Mathias, any objection for me just taking these now?

thanks,

greg k-h
