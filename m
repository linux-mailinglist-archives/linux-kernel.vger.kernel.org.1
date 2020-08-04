Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5057723B999
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgHDLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 07:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgHDLed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:34:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653182086A;
        Tue,  4 Aug 2020 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596540873;
        bh=PdL7dmBcGVuTWu4ybcpV6t4DvW7WSlxwwBQKJaRjvBg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QxCfIxE4JI3HoeOCBjew2jm2grr9RL1ZWpwzTwpn4OV+o4IH335ItqMKfOQy440Uh
         LMF2MmzShTVtP6PJk+z43xl9tTGkT5ZAlaynPNI3t+dSKsge3OxDWqkncWckxWLieM
         bm/l2Ls9ff6IxvbTTfH+qggloAKYc9Z8JKkAc/QE=
Date:   Tue, 4 Aug 2020 13:34:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804113413.GA181242@kroah.com>
References: <20200804111332.dex7jobmabifdzw5@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804111332.dex7jobmabifdzw5@function>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:13:32PM +0200, Samuel Thibault wrote:
> Drivers using serialio are already made available in Kconfig only under
> the ISA condition.
> 
> This solves warnings in inb/outb macros on platform that do not have 
> support for ISA.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Index: linux-2.6/drivers/accessibility/speakup/Makefile
> ===================================================================
> --- linux-2.6.orig/drivers/accessibility/speakup/Makefile
> +++ linux-2.6/drivers/accessibility/speakup/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_SPEAKUP_SYNTH_TXPRT) += spe
>  obj-$(CONFIG_SPEAKUP_SYNTH_DUMMY) += speakup_dummy.o
>  
>  obj-$(CONFIG_SPEAKUP) += speakup.o
> +obj-$(CONFIG_ISA) += serialio.o
>  speakup-y := \
>  	buffers.o \
>  	devsynth.o \
> @@ -25,7 +26,6 @@ speakup-y := \
>  	keyhelp.o \
>  	kobjects.o \
>  	selection.o \
> -	serialio.o \
>  	spk_ttyio.o \
>  	synth.o \
>  	thread.o \

Oops, no, I get the following build errors with this patch:

ERROR: modpost: "spk_wait_for_xmitr" [drivers/accessibility/speakup/speakup.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_dtlk.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_dtlk.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_decpc.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_decpc.ko] undefined!
ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_acntpc.ko] undefined!
ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_acntpc.ko] undefined!


So something else needs to change here, sorry, dropping this patch for
now.

thanks,

greg k-h
