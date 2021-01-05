Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A32EAC39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbhAENqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbhAENqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:46:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1821C229C4;
        Tue,  5 Jan 2021 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609854373;
        bh=UJNgfrZ1/h7ksEDl8gwA5+JdzuA1EC8iTPwpYFQzm6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxaNaAWrzRFhh3x1zXwLO0HVTJCBxDwhz3lR4UXYoVSZAQQGbK3mvFgXMQlGbN6GZ
         B2zI5XtlEXMqEtCf53JHVbLnfxIWQx5nSx3XMRVKEIS2kpMMQVncGjku+Cygo4M+ln
         RE3fnRnZ1pFVkch6a2pnBBa319/d45+TdohZatmk=
Date:   Tue, 5 Jan 2021 14:47:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus
 variant for USB)
Message-ID: <X/Rt+bUJ9Hs2F8nF@kroah.com>
References: <20201213170503.59017-1-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213170503.59017-1-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 07:05:03PM +0200, eli.billauer@gmail.com wrote:
> From: Eli Billauer <eli.billauer@gmail.com>
> 
> The XillyUSB driver is the USB variant for the Xillybus FPGA IP core.
> Even though it presents a nearly identical API on the FPGA and host,
> it's almost a complete rewrite of the driver: The framework for exchanging
> data on a USB bus is fundamentally different from doing the same with a
> PCIe interface, which leaves very little in common between the existing
> driver and the new one for XillyUSB.

But in this one you are talking to userspace directly through a char
node, why not use the same interface that the xillybus_core.c code uses?
Creating yet-another-class-device feels odd when you already have one
that is in use.

Try to merge them together to use the same framework, or document the
heck out of why this is somehow different, yet looks the same...

thanks,

greg k-h
