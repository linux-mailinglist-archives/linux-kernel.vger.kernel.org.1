Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00992B9403
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgKSN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgKSN6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:58:49 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9256E246D3;
        Thu, 19 Nov 2020 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605794329;
        bh=vL9FMK10jyhD5Do2SCSHwQNqu8UxDPPPWe9jB9xQQ9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbOEuoizZo7NxWl5zLYh8y3JPPgT+R/9Li7sJlWvaO2jB9aKvISMBWL6uCA2hK7+v
         rpWUZNU8DgePKASs+40x18d8vEep6o1g6zcKUeeN4/A+s0Ry2qGEcz83oTPeiEcOZm
         PY5TuhXFX+G/OgN2fAi2BvrHDrPoiojIYjFCY4zg=
Date:   Thu, 19 Nov 2020 14:59:32 +0100
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
Message-ID: <X7Z6RKu4T5IrhUFB@kroah.com>
References: <20201118123039.11696-1-penghao@uniontech.com>
 <49219711-84BE-44FC-BBFE-DD8D609CA26D@canonical.com>
 <1892790617.185900.1605788248261.JavaMail.xmail@bj-wm-cp-6>
 <7D73C39C-C3E2-4C08-A773-3D7582A6AA7D@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7D73C39C-C3E2-4C08-A773-3D7582A6AA7D@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:41:32PM +0800, Kai-Heng Feng wrote:
> Hi penghao,
> 
> > On Nov 19, 2020, at 20:17, 彭浩 <penghao@uniontech.com> wrote:
> > 
> > root@uos-PC:/sys/bus/usb/devices/usb7# dmesg
> > [ 0.000000] Linux version 4.19.0-6-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Uos 4.19.67-11eagle (2020-03-21)
> 
> Thanks for the dmesg. But would it be possible to use mainline kernel enable dynamic debug?
> 
> But anyway, this is not a regular AMD or Intel platform, so I guess we can merge the quirk as is...
> 
> Kai-Heng
> 
> > [ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.19.0-6-amd64 root=UUID=e5a40c4f-d88e-4a4d-9414-a27892a31be7 ro splash console=ttyS0,115200n8 loglevel=7 DEEPIN_GFXMODE=0,1920x1080,1600x1200,1280x1024,1024x768
> > [ 0.000000] Zhaoxin Linux Patch Version is V3.0.2 
> > [ 0.000000] With Zhaoxin Shanghai CPU patch V2.0.0

What do you mean "not a regular"?  This is an x86-variant chip platform,
but what does that have to do with the USB quirk detection?

thanks,

greg k-h
