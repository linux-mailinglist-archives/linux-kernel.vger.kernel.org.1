Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF025D34C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgIDIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbgIDIPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:15:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB7F220658;
        Fri,  4 Sep 2020 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599207336;
        bh=6LbibmYHGIh2PtRI9pQQqbFWcbpI+JkHaFjSfGbFrF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUbRG1Zq4eh//7RFW3eEJIsESupUPmHC2IisdBDrbgEasV1OtFDbfFHdsXYEkWx3b
         QwLz8T9h4dtAMNkmsCMOCKsoZpeOkAQRyXpAJjQFBcoKflhuvs0JksuQJYkZ81KRL6
         UfZKh7wMFyN908qlpHTDnVVJBrqAMdQCx83SWpbY=
Date:   Fri, 4 Sep 2020 10:15:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Penghao <penghao@uniontech.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, hdegoede@redhat.com, dlaz@chromium.org,
        stern@rowland.harvard.edu, kerneldev@karsmulder.nl,
        jonathan@jdcox.net, tomasz@meresinski.eu
Subject: Re: [PATCH v2] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk
 for BYD zhaoxin notebook
Message-ID: <20200904081557.GA2421285@kroah.com>
References: <20200904080654.19780-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904080654.19780-1-penghao@uniontech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:06:54PM +0800, Penghao wrote:
> Add a USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for the BYD zhaoxin notebook.
> This notebook come with usb touchpad. And we would like to disable touchpad
> wakeup on this notebook by default.
> 
> Signed-off-by: Penghao <penghao@uniontech.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)

What changed from v1?  Always put that below the --- line as documented
please.

thanks,

greg k-h
