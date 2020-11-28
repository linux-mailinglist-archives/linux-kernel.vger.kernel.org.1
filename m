Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A442C76CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 01:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgK2AKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 19:10:00 -0500
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:38267 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729000AbgK2AKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 19:10:00 -0500
X-Greylist: delayed 1042 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Nov 2020 19:09:59 EST
Received: from darkstar.musicnaut.iki.fi (85-76-71-224-nat.elisa-mobile.fi [85.76.71.224])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id b1c03620-31d4-11eb-ba24-005056bd6ce9;
        Sun, 29 Nov 2020 01:51:55 +0200 (EET)
Date:   Sun, 29 Nov 2020 01:51:54 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BISECTED REGRESSION] Broken USB/GPIO on OMAP1 OSK
Message-ID: <20201128235154.GF551434@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to upgrade my OMAP1 OSK board to v5.9, but the rootfs cannot
be accessed anymore due to broken USB. It fails to probe with the
following logs:

[    9.219940] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
[    9.250366] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
[    9.731445] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
[   10.342102] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
[   10.966430] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring

Bisected to:

commit 15d157e874437e381643c37a10922388d6e55b29
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Jul 20 15:55:24 2020 +0200

    usb: ohci-omap: Convert to use GPIO descriptors

I suspect one of the issues is the name "i2c-tps65010" vs "tps65010":

# cat /sys/devices/platform/omap_i2c.1/i2c-1/i2c-tps65010/gpio/gpiochip208/label
tps65010

However changing that in the lookup table still doesn't help much; I got rid
of the "deferring" message but the USB still doesn't work. So far the only
workaround I have is to revert the whole commit.

A.
