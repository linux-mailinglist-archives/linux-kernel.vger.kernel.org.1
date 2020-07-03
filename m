Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B502134EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 09:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGCH1L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Jul 2020 03:27:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46473 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:27:11 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 26A0DCED23;
        Fri,  3 Jul 2020 09:37:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: add Realtek 8822CE to blacklist_table
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200703091124.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
Date:   Fri, 3 Jul 2020 09:27:09 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        josephsih@google.com,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5B5301EF-4C71-4EBC-8753-C872071D4DC5@holtmann.org>
References: <20200703091124.1.I63705bf6abab9cb79c14f7959a59b201af2b8827@changeid>
To:     Joseph Hwang <josephsih@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joseph,

> This patch adds the Realtek 8822CE controller to the blacklist_table
> to support the wideband speech capability.
> 
> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0e143c0cecf2a1..34a84c64e4c83e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -359,6 +359,10 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
> 	  .driver_info = BTUSB_IGNORE },
> 
> +	/* Realtek 8822CE Bluetooth devices */
> +	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +
> 	/* Realtek Bluetooth devices */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
> 	  .driver_info = BTUSB_REALTEK },

I rather not have to list these one-by-one. Can we just not globally declare support for this? Or can we have a Realtek vendor command to read this out?

Regards

Marcel

