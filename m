Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1762214E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGOTNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 15:13:52 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:44324 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgGOTNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:13:12 -0400
Received: from [78.43.71.214] (helo=marius.localnet)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jvmps-0005GQ-BN; Wed, 15 Jul 2020 21:12:56 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-cpro: Change to HID driver
Date:   Wed, 15 Jul 2020 21:12:55 +0200
Message-ID: <51449356.7lugSRDzgr@marius>
In-Reply-To: <f17c4888-4f5f-0a51-304f-54efd601f00a@roeck-us.net>
References: <20200715151419.43134-1-mail@mariuszachmann.de> <f17c4888-4f5f-0a51-304f-54efd601f00a@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.20 at 17:35:08 CEST, Guenter Roeck wrote
> On 7/15/20 8:14 AM, Marius Zachmann wrote:
> > This changes corsair-cpro to a hid driver using hid reports.
> > 
> > Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> > 
> > ---
> 
...
> > -module_usb_driver(ccp_driver);
> > +static int __init ccp_init(void)
> > +{
> > +	return hid_register_driver(&ccp_driver);
> > +}
> > +
> > +static void __exit ccp_exit(void)
> > +{
> > +	hid_unregister_driver(&ccp_driver);
> > +}
> > +
> > +/* make sure it is loaded after hid */
> > +late_initcall(ccp_init);
> > +module_exit(ccp_exit);
> 
> Sorry for not noticing before, but can you use module_hid_driver() ?
> That seems to work for other hid drivers.
> 
> Thanks,
> Guenter
> 

When using module_hid_driver() and compiling the driver as built-in
the driver init function will get called before hid and fail registering
the driver. late_initcall forces it to be loaded after hid.

Greetings,
Marius


