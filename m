Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCB2FB767
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391038AbhASKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731918AbhASKZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:25:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 175F823121;
        Tue, 19 Jan 2021 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611051918;
        bh=rJ1uCicSSQ5/QeLcb18MjtBsaOZqSMFDCFq0yZetY5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB7K0NHSjmHrAKf8s6td3w+KUc6daSeEdRFYyfNGIuWHEP2y8BAvt/TTlRUiIWkUI
         SSk+yCqsmtp85Tc25Qr/I5dc1DAwGQHKoJvtjKACnHukZMY5bIx/TDGzavzUsrOV0l
         mOdvSV4TULndwGlVYyAmai06rf29xq+K0zwkWdQQ=
Date:   Tue, 19 Jan 2021 11:25:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Howard Yen <howardyen@google.com>
Cc:     robh+dt@kernel.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] add xhci hooks for USB offload
Message-ID: <YAaziw6VGKY4eNgY@kroah.com>
References: <20210119101044.1637023-1-howardyen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119101044.1637023-1-howardyen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:10:40PM +0800, Howard Yen wrote:
> To let the xhci driver support USB offload, add hooks for vendor to have
> customized behavior for the initialization, memory allocation, irq work, and 
> device context synchronization. Detail is in each patch commit message.
> 
> Howard Yen (4):
>   usb: host: add xhci hooks for USB offload
>   usb: host: export symbols for xhci hooks usage
>   usb: xhci-plat: add xhci_plat_priv_overwrite
>   dt-bindings: usb: usb-xhci: add USB offload support
> 
>  .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
>  drivers/usb/host/xhci-hub.c                   |  5 +
>  drivers/usb/host/xhci-mem.c                   | 99 ++++++++++++++++---
>  drivers/usb/host/xhci-plat.c                  | 45 ++++++++-
>  drivers/usb/host/xhci-plat.h                  |  9 ++
>  drivers/usb/host/xhci-ring.c                  | 19 +++-
>  drivers/usb/host/xhci.c                       | 89 +++++++++++++++++
>  drivers/usb/host/xhci.h                       | 38 +++++++
>  8 files changed, 289 insertions(+), 16 deletions(-)

Thanks so much for posting this.

A bit of background for the lists.  I helped review previous versions of
this patchset from Howard as he worked to convert the hacks from a
previous vendor into something that would be semi-sane.  It would be
great if we can take the previously-submitted Samsung usb-audio hooks
(as published in their kernel sources for their last-year phones) and
get it into something mergable with this scheme as well, as this is the
"correct" way to do what they were wanting to do.

Although I know that is outside of the work you probably have time for,
maybe I will work on that over the next few weeks...

thanks,

greg k-h
