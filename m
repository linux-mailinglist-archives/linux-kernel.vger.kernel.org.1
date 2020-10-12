Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741BC28B3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgJLLXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387635AbgJLLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:23:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3DE2076E;
        Mon, 12 Oct 2020 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602501811;
        bh=jdhiSa/uHBYzeEjlL6WbIoy8FQlJ0j0drF49kJlgass=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxqtEU3oOMkY3UYdnBtj4t2KBq88P1q3Sqr41dWKm6PbhT6ANUl+CbZcs78cn5sqJ
         wS4JJiu3qpvwW45Op0z6Xyv+KqRQH6Cwuk62vjLcvOn9sL3dMBDhRRYXXhjUBhqz3m
         08u3jBB+cTBSqVamUsplw+vS7oPYZOS3qNrmm554=
Date:   Mon, 12 Oct 2020 13:24:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rickyniu <rickyniu@google.com>
Cc:     balbi@kernel.org, astrachan@google.com, amit.pundir@linaro.org,
        lockwood@android.com, benoit@android.com, jackp@codeaurora.org,
        vvreddy@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kyletso@google.com
Subject: Re: [PATCH 1/3] ANDROID: usb: gadget: f_accessory: Add Android
 Accessory function
Message-ID: <20201012112410.GB356911@kroah.com>
References: <20201012111024.2259162-1-rickyniu@google.com>
 <20201012111024.2259162-2-rickyniu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012111024.2259162-2-rickyniu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 07:10:22PM +0800, rickyniu wrote:
> From: Benoit Goby <benoit@android.com>
> 
> USB accessory mode allows users to connect USB host hardware
> specifically designed for Android-powered devices. The accessories
> must adhere to the Android accessory protocol outlined in the
> http://accessories.android.com documentation. This allows
> Android devices that cannot act as a USB host to still interact with
> USB hardware. When an Android device is in USB accessory mode, the
> attached Android USB accessory acts as the host, provides power
> to the USB bus, and enumerates connected devices.
> 
> Signed-off-by: Mike Lockwood <lockwood@android.com>
> [AmitP: Folded following android-4.9 commit changes into this patch
>         ceb2f0aac624 ("ANDROID: usb: gadget: accessory: Fix section mismatch")
>         Parts of e27543931009 ("ANDROID: usb: gadget: Fixes and hacks to make android usb gadget compile on 3.8")
>         1b07ec751563 ("ANDROID: drivers: usb: gadget: 64-bit related type fixes")]
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> [astrachan: Folded the following changes into this patch:
>             9d5891d516e2 ("ANDROID: usb: gadget: f_accessory: Add ACCESSORY_SET_AUDIO_MODE control request and ioctl")
>             dc66cfce9622 ("ANDROID: usb: gadget: f_accessory: Add support for HID input devices")
>             5f1ac9c2871b ("ANDROID: usb: gadget: f_accessory: move userspace interface to uapi")
>             9a6241722cd8 ("ANDROID: usb: gadget: f_accessory: Enabled Zero Length Packet (ZLP) for acc_write")
>             31a0ecd5a825 ("ANDROID: usb: gadget: f_accessory: check for accessory device before disconnecting HIDs")
>             580721fa6cbc ("ANDROID: usb: gadget: f_accessory: Migrate to USB_FUNCTION API")
>             7f407172fb28 ("ANDROID: usb: gadget: f_accessory: Fix for UsbAccessory clean unbind.")
>             ebc98ac5a22f ("ANDROID: usb: gadget: f_accessory: fix false disconnect due to a signal sent to the reading process")
>             71c6dc5ffdab ("ANDROID: usb: gadget: f_accessory: assign no-op request complete callbacks")
>             675047ee68e9 ("ANDROID: usb: gadget: f_accessory: Move gadget functions code")
>             b2bedaa5c7df ("CHROMIUM: usb: gadget: f_accessory: add .raw_request callback")]

Those commit ids mean nothing to the linux kernel tree, right?

Please fix up.

greg k-h
