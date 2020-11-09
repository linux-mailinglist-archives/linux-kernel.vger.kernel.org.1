Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5D2AB87D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgKIMnq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 07:43:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33027 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:43:45 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id B9328CECC5;
        Mon,  9 Nov 2020 13:50:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Bluetooth: hci_ll: add a small delay for wl1271 enable
 bt_en
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <PH0PR11MB5077A86EEA660BD3E7B2F7BE95100@PH0PR11MB5077.namprd11.prod.outlook.com>
Date:   Mon, 9 Nov 2020 13:43:43 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <93858CE1-A293-4331-8B72-48BBAF7821D3@holtmann.org>
References: <PH0PR11MB5077A86EEA660BD3E7B2F7BE95100@PH0PR11MB5077.namprd11.prod.outlook.com>
To:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

> When using the wl1271 Bluetooth function of am335x, it is found that the Bluetooth module cannot respond in time after Bluetooth is enabled, and a small delay is needed to work normally, so whether to add a small mdelay.
>  
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> drivers/bluetooth/hci_ll.c | 1 +
> 1 file changed, 1 insertion(+)
>  
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c index 8bfe024d1fcd..eb1e736efeeb 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -626,6 +626,7 @@ static int ll_setup(struct hci_uart *hu)
>                                gpiod_set_value_cansleep(lldev->enable_gpio, 0);
>                                msleep(5);
>                                gpiod_set_value_cansleep(lldev->enable_gpio, 1);
> +                             mdelay(100);
>                                err = serdev_device_wait_for_cts(serdev, true, 200);
>                                if (err) {
>                                                bt_dev_err(hu->hdev, "Failed to get CTS");

please submit patches in the proper format and encoding.

Regardes

Marcel

