Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFB2AEF26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKKLHR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Nov 2020 06:07:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37586 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgKKLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:07:16 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 43AA6CECFD;
        Wed, 11 Nov 2020 12:14:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/3] Bluetooth: hci_bcm: Ignore deprecated command fail
 case
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201014054746.2507-1-amitesh.chandra@gmail.com>
Date:   Wed, 11 Nov 2020 12:07:13 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        amitesh.chandra@broadcom.com, ravi.nagarajan@broadcom.com,
        cheneyni@google.com, Manoj Babulal <manoj.babulal@broadcom.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <53807E62-2444-46EA-A2C8-30442263B101@holtmann.org>
References: <20201014054746.2507-1-amitesh.chandra@gmail.com>
To:     Amitesh Chandra <amitesh.chandra@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amitesh,

> Broadcom VSC uart_clock_setting is deprecated in
> newer controllers. Ignore error if the controller
> returns invalid or bad request error code.
> 
> Signed-off-by: Amitesh Chandra <amitesh.chandra@broadcom.com>
> Signed-off-by: Manoj Babulal <manoj.babulal@broadcom.com>
> ---
> drivers/bluetooth/hci_bcm.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 680478f..d316788 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -158,15 +158,18 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
> 		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
> 		if (IS_ERR(skb)) {
> 			int err = PTR_ERR(skb);
> -			bt_dev_err(hdev, "BCM: failed to write clock (%d)",
> -				   err);
> -			return err;
> +			/* Ignore err if command is deprecated in controller */
> +			if (err != -EBADRQC) {
> +				bt_dev_err(hdev, "BCM: failed to write "
> +						"clock (%d)", err);
> +				return err;
> +			}
> +		} else {
> +			kfree_skb(skb);
> 		}
> -
> -		kfree_skb(skb);
> 	}

So I really disliked try-and-error of HCI commands. Can we know up-front
somehow if the controller supports a command or not. It is a total waste of
time to send a command that might fail. So we better know this before
sending it.

Regards

Marcel

