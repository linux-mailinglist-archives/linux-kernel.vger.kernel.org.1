Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E6294230
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437508AbgJTSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:35:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48151 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437497AbgJTSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:35:54 -0400
Received: from marcel-macbook.fritz.box (p5b3d236a.dip0.t-ipconnect.de [91.61.35.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id BABCCCED0F;
        Tue, 20 Oct 2020 20:42:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for LG LGSBWAC92/TWCM-K505D
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201016030238.1033559-1-cyrozap@gmail.com>
Date:   Tue, 20 Oct 2020 20:35:52 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EE190DCC-85ED-4370-81A7-C239EE193083@holtmann.org>
References: <20201016030238.1033559-1-cyrozap@gmail.com>
To:     Forest Crossman <cyrozap@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Forest,

> The LG LGSBWAC92/TWCM-K505D/EAT64454801/EAT64454802 (it goes by many
> names) is a combo WiFi/Bluetooth module that's used in several models of
> LG TVs. It uses the MediaTek MT7668AUN, which is already supported in
> btusb, but this device has a non-MediaTek USB VID so to get it to work
> we just need to add it to the list of devices to probe.
> 
> Signed-off-by: Forest Crossman <cyrozap@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5f022e9cf667..58259b6a43c7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -366,6 +366,7 @@ static const struct usb_device_id blacklist_table[] = {
> 	/* MediaTek Bluetooth devices */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
> 	  .driver_info = BTUSB_MEDIATEK },
> +	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK },
> 
> 	/* Additional Realtek 8723AE Bluetooth devices */
> 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },

please include the content of /sys/kernel/debug/usb/devices in the commit
message.

Regards

Marcel

