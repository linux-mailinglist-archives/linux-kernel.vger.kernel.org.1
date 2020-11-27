Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF72C68DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgK0Pjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:39:49 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:57841 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730980AbgK0Pjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:39:49 -0500
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id EA3AA1E075C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:39:42 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id ifqYkAOKJeMJHifqYkHiYE; Fri, 27 Nov 2020 08:39:42 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=ad5PYygt c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=uChsZFC9AAAA:8
 a=Ovdl18BBkjGoSiywgLoA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=ULtXvzFHYWHLyBAuiDia:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hFn/RzVG2lFUyJJ+QRtM2nQrMEynjkjuLykqFCNHOBU=; b=068b0pIzmwIhU8w/Plq7VyPw/Y
        qeTC4hbML/4kWBjLL0BZmzQs6BJwBYUrKW6UKVm0uzu66iCf9nK/ucDv4wlTW7YAW0i+OI0vtLxi2
        T4ODoQq7GcfXXs3HrtYN1BHWRi1HpuyUi2RwdS57eHu4jQtr06ABcMzKLgggGjSqBFHrBJWqN4F0R
        0qL/dmRUxRPrD6+edusn8NPTl0IOcv5d0FgW2Jm3CYt6k9mJ8R4UcfF01nSrVpYKPJIMpWMcJcQNI
        zDE+FMTrhlHNwUCyHS3CugCRc2zTtcRm5l5IbIhlCxozxTaH3LfTF36JwpFCfdfmcZsyGhkQQ/mn1
        3n7Gv4rA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43364 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kifqX-002axQ-TT; Fri, 27 Nov 2020 15:39:42 +0000
Date:   Fri, 27 Nov 2020 07:39:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
Message-ID: <20201127153941.GA9158@roeck-us.net>
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kifqX-002axQ-TT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:43364
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 12:40:16PM +0100, Wilken Gottwalt wrote:
> Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
> AX1500i and AX1600i. The first 3 power supplies are supported through
> the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
> converter especially made for the COM ports of these power supplies.
> There are 3 known revisions of these adapters. The AX1500i power supply
> has revision 3 built into the case and AX1600i is the only one in that
> series, which has an unique usb hid id like the RM/RX series.
> 
> The patch also changes the usb hid ids to use upper case letters to be
> consistent with the rest of the hex numbers in the driver and updates
> the hwmon documentation.
> 
> This patch adds:
> - hwmon/corsair-psu documentation update
> - corsair-psu driver update
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/corsair-psu.rst | 10 +++++++++
>  drivers/hwmon/Kconfig               |  7 +++---
>  drivers/hwmon/corsair-psu.c         | 33 +++++++++++++++++++----------
>  3 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index 396b95c9a76a..6227e9046d73 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -7,6 +7,16 @@ Supported devices:
>  
>  * Corsair Power Supplies
>  
> +  Corsair AX760i (by Corsair Link USB Dongle)
> +
> +  Corsair AX860i (by Corsair Link USB Dongle)
> +
> +  Corsair AX1200i (by Corsair Link USB Dongle)
> +
> +  Corsair AX1500i (by builtin Corsair Link USB Dongle)
> +
> +  Corsair AX1600i
> +
>    Corsair HX550i
>  
>    Corsair HX650i
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 716df51edc87..3c059fc23cd6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -453,11 +453,12 @@ config SENSORS_CORSAIR_PSU
>  	tristate "Corsair PSU HID controller"
>  	depends on HID
>  	help
> -	  If you say yes here you get support for Corsair PSUs with a HID
> +	  If you say yes here you get support for Corsair PSUs with an USB HID
>  	  interface.
>  	  Currently this driver supports the (RM/HX)550i, (RM/HX)650i,
> -	  (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i and HX1200i power supplies
> -	  by Corsair.
> +	  (RM/HX)750i, (RM/HX)850i, (RM/HX)1000i, HX1200i and AX1600i power
> +	  supplies by Corsair. The AX760i, AX860i, AX1200i and AX1500i
> +	  power supplies are supported through the Corsair Link USB Dongle.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called corsair-psu.
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 99494056f4bd..0146dda3e2c3 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -571,17 +571,28 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *repo
>  }
>  
>  static const struct hid_device_id corsairpsu_idtable[] = {
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> +	/*
> +	 * The Corsair USB/COM Dongles appear in at least 3 different revisions, where rev 1 and 2
> +	 * are commonly used with the AX760i, AX860i and AX1200i, while rev3 is rarely seen with
> +	 * these PSUs. Rev3 is also build into the AX1500i, while the AX1600i is the first PSU of
> +	 * this series which has an unique usb hid id. Though, the actual device name is part of
> +	 * the HID message protocol, so it doesn't matter which dongle is connected.
> +	 */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair Link USB/COM Dongle rev1 */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C01) }, /* Corsair Link USB/COM Dongle rev2 */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C02) }, /* Corsair Link USB/COM Dongle rev3 (AX1500i) */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C03) }, /* Corsair HX550i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C04) }, /* Corsair HX650i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C05) }, /* Corsair HX750i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C06) }, /* Corsair HX850i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C07) }, /* Corsair HX1000i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C08) }, /* Corsair HX1200i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C09) }, /* Corsair RM550i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C0A) }, /* Corsair RM650i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C0B) }, /* Corsair RM750i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C0C) }, /* Corsair RM850i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C0D) }, /* Corsair RM1000i */
> +	{ HID_USB_DEVICE(0x1B1C, 0x1C11) }, /* Corsair AX1600i */
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
