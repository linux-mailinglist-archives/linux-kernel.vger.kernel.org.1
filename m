Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E921023B993
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgHDLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 07:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgHDLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:32:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 735C22086A;
        Tue,  4 Aug 2020 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596540773;
        bh=FBsxtJfVMNm7CuMkZIKzdfcn4YB7zQSE6q15iyaOl3U=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ju/t+Bh4ukOpzDtxROjnoQv3L6bH7lHOCy/84n7M8/5F/D7GMhcrtYmgqqJm2A5yt
         n4aorx3YXGZTcCCA7cWD6Pm97cX77PHA0Apa/skvPo9IsmUWMWiYfG4ZU0jHzRrL4l
         8jAE8BE7tAK11BCkwjwubxM1B6lFSxMDwRTgRf3Q=
Date:   Tue, 4 Aug 2020 13:32:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804113232.GA164292@kroah.com>
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

Nice, this should fix the riscv build issues.

I'll go merge this now, and hold on to the first patch until this round
gets merged with Linus.

thanks,

greg k-h
