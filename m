Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6229E2B948E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgKSOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:23:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbgKSOXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:23:10 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21BDE2222A;
        Thu, 19 Nov 2020 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605795789;
        bh=P9U0+AiYZ1j6MYp8T9AkJ7YQKwTSGN1e2U2URWeskQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=znA916Tob8+E0QcTLDETsD0WDyq7TW+FM+luH1LnQnhLtBeuO1chHkew8SpT7RFVp
         HTm+j223Pelx78jUU5eubmfVjnDdOeL8UdLptQP52PQPedww5zncSQ+ocQGdC8WLJf
         0dTmeN1IW2XLrmV+aS/DRHX7pzCnFIWNBlTm44e0=
Date:   Thu, 19 Nov 2020 15:23:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>,
        johan <johan@kernel.org>, jonathan <jonathan@jdcox.net>,
        tomasz <tomasz@meresinski.eu>,
        Hans de Goede <hdegoede@redhat.com>,
        dlaz <dlaz@chromium.org>,
        "richard.o.dodd" <richard.o.dodd@gmail.com>,
        kerneldev <kerneldev@karsmulder.nl>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk
 forLenovo A630Z TIO built-in usb-audio card
Message-ID: <X7Z/+Tehbmx54Fzb@kroah.com>
References: <20201118123039.11696-1-penghao@uniontech.com>
 <49219711-84BE-44FC-BBFE-DD8D609CA26D@canonical.com>
 <1892790617.185900.1605788248261.JavaMail.xmail@bj-wm-cp-6>
 <7D73C39C-C3E2-4C08-A773-3D7582A6AA7D@canonical.com>
 <X7Z6RKu4T5IrhUFB@kroah.com>
 <FB40A0E5-5E3C-4FC6-B690-02F9785EC7D5@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FB40A0E5-5E3C-4FC6-B690-02F9785EC7D5@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:12:02PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On Nov 19, 2020, at 21:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Nov 19, 2020 at 09:41:32PM +0800, Kai-Heng Feng wrote:
> >> Hi penghao,
> >> 
> >>> On Nov 19, 2020, at 20:17, 彭浩 <penghao@uniontech.com> wrote:
> >>> 
> >>> root@uos-PC:/sys/bus/usb/devices/usb7# dmesg
> >>> [ 0.000000] Linux version 4.19.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Uos 4.19.67-11eagle (2020-03-21)
> >> 
> >> Thanks for the dmesg. But would it be possible to use mainline kernel enable dynamic debug?
> >> 
> >> But anyway, this is not a regular AMD or Intel platform, so I guess we can merge the quirk as is...
> >> 
> >> Kai-Heng
> >> 
> >>> [ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> >>> [ 0.000000] Zhaoxin Linux Patch Version is V3.0.2 
> >>> [ 0.000000] With Zhaoxin Shanghai CPU patch V2.0.0
> > 
> > What do you mean "not a regular"?  This is an x86-variant chip platform,
> > but what does that have to do with the USB quirk detection?
> 
> USB quirk detection should work fine. I was trying to find the root cause, but seeing it's a Zhaoxin CPU, that could be the reason why mainline kernel, which has many USB power management fixes, wasn't used.
> 
> penghao, is it possible to boot mainline kernel on Zhaoxin CPU?

There have been a number of small patches for this type of CPU merged
over the past months, so I hope a mainline kernel works here :)

That being said, why would the platform matter for a USB device quirk?

thanks,

greg k-h
