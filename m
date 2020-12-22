Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7C2E07B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgLVJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:09:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D895C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:08:28 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1krdec-0001OJ-Na; Tue, 22 Dec 2020 10:08:26 +0100
Subject: Re: Correct ordering of phy_init and phy_power_on
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        linux-usb@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jules Maselbas <jmaselbas@kalray.eu>
References: <6cd01e79-fdc0-3bd4-32b5-a85142533f8a@pengutronix.de>
 <014e75a5-ab7b-55be-e554-14ef7550b360@ti.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d9311d93-76bb-7671-cc3e-04e7c7db2ff8@pengutronix.de>
Date:   Tue, 22 Dec 2020 10:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <014e75a5-ab7b-55be-e554-14ef7550b360@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kishon,

On 21.12.20 04:15, Kishon Vijay Abraham I wrote:
>> So how was it meant to be?
> 
> It is intended to be ->init() and then ->power_on(). So ideally it
> should be the way dwc3 is.

Thanks. Should we do something about the inconsistency?

Amend documentation and maybe print a warning when order is wrong,
so users are encouraged to fix their drivers?

The way it is, you can't properly mix some of the PHY and USB controller drivers.

Cheers,
Ahmad

> 
> Thanks,
> Kishon
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
