Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E07282590
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgJCR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 13:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgJCR0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 13:26:53 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA24220691;
        Sat,  3 Oct 2020 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601746013;
        bh=xyXlkDatGk7HQaFOj8oSxzh4ezSoWCEOUtSJbDGPeEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=le2vb6UvULotIthmHf3oyBSZg95Qaz3FFw9IQcb5vNqaBBq8fCsCAdDLj5xyIKDVX
         CCbGjbS4AYfWCsdeUCBT0bNl5k15Vt1lwSdJPSS8xkjG+SdO/Ogrp6g7rm67n6H7a3
         bSJJvaBvtX6vzr6AsVc8Sdqfj2x/5zXFLW4/r//U=
Date:   Sat, 3 Oct 2020 19:27:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: USBIP is claiming all my USB devices - Commit 7a2f2974f265 is
 broken
Message-ID: <20201003172738.GA1526548@kroah.com>
References: <alpine.LNX.2.23.451.2010031259080.4257@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.23.451.2010031259080.4257@winds.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 01:18:36PM -0400, Byron Stanoszek wrote:
> All,
> 
> I was testing Linux 5.9-rc7 today when I realized that none of my USB devices
> were responding anymore. For instance, my mouse does not respond and its usual
> red LED is not on.
> 
> Reverting git commit 7a2f2974f265 solved the problem for me.
> 
> I have USBIP enabled in my kernel config. Alternatively, removing the following
> CONFIG variables also resolved the problem for me:
> 
> -CONFIG_USBIP_CORE=y
> -CONFIG_USBIP_HOST=y
> -CONFIG_USBIP_VHCI_HCD=y
> -CONFIG_USBIP_VHCI_HC_PORTS=8
> -CONFIG_USBIP_VHCI_NR_HCS=1
> 
> I do not have any userland usbip daemons running on this PC.
> 
> I attached before-and-after versions of my "dmesg", "lsusb", and "lsusb -t"
> outputs to demonstrate the problem. Versions marked .1 are with commit
> 7a2f2974f265 reverted. Versions marked .2 are without any changes to usbip.
> 
> # grep usbip dmesg.1
> dmesg.1:usbcore: registered new device driver usbip-host
> 
> # grep usbip dmesg.2
> dmesg.2:usbcore: registered new device driver usbip-host
> dmesg.2:usbip-host 1-8: 1-8 is not in match_busid table... skip!
> dmesg.2:usbip-host 1-13: 1-13 is not in match_busid table... skip!
> 
> > From lsusb_t.1:
> 
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
>     |__ Port 8: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
>     |__ Port 13: Dev 3, If 1, Class=Wireless, Driver=btusb, 12M
>     |__ Port 13: Dev 3, If 0, Class=Wireless, Driver=btusb, 12M
> 
> > From lsusb_t.2:
> 
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
> 
> (no devices are listed when they should be)
> 
> I also attached my .config for review.

Can you try the patches listed here:
	https://lore.kernel.org/r/20201003142651.GA794077@kroah.com

As this issue should be solved with them.  Hopefully :)

thanks,

greg k-h
