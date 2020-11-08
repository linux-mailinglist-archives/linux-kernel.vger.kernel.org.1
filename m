Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2825E2AAC8C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgKHRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:08:23 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:48957 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgKHRIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:08:19 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CTgYl4S1Tz74;
        Sun,  8 Nov 2020 18:08:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604855297; bh=elnvWS7IXp5QgmLJI68ZikB+DhWiK84NFXlg99WZ4XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Xqw0TBwjUIKUwXx31liJdbow08YYBH1SS0snw4mtIfi+YJD9BmCyOPqr9K84+32
         RD/dbmu5zk/frFAz+m9tVMmRy0YOZVKx/xJeaCgcQ5USx7IWCCoH4yK+stJBZ8QSHg
         Gsgsiv79eI+MIRqLUeE5KWBF/BX5iiNAdh2fbCT/xWp+5/aUmx1wWeMFqT9Bqyd6ew
         7IcmkR9zH8+kZOs7Tj9ZugkjM9N80I0KNTOcLIrEkx4mE3Ys8Cdhjzg8vtIJ+Kd3Gy
         h3AX161+QDlKRGiYp55Z0cT3Zh1N/XHAyJ/SN0t9IqkmWMFGnxnD5WEM6wDoWTvr1w
         OZfAgL03MkRMA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 8 Nov 2020 18:08:07 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, lgirdwood@gmail.com,
        mripard@kernel.org, linux-kernel@vger.kernel.org, wens@csie.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
Message-ID: <20201108170807.GA10914@qmqm.qmqm.pl>
References: <20201021183149.GA8436@Red>
 <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red>
 <20201024115307.GA2745@qmqm.qmqm.pl>
 <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
 <20201102202727.GA20042@qmqm.qmqm.pl>
 <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
 <20201105025706.GE17266@qmqm.qmqm.pl>
 <7edc2b69-b77b-3546-63d7-108dab95fc91@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7edc2b69-b77b-3546-63d7-108dab95fc91@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:11:30AM +0100, Ahmad Fatoum wrote:
> Hello,
> 
> On 11/5/20 3:57 AM, Micha³ Miros³aw wrote:
> >>> Can you catch debug logs for the bootup in question? I'm not sure what's
> >>> the failure mode in your case. I guess this is not a bypassed regulator?
> >>
> >> Boot up with v5.10-rc2 + your cf1ad559a2 ("regulator: defer probe when trying
> >> to get voltage from unresolved supply") hangs:
> >>
> >> [    1.151489] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
> >> [    1.180698] stpmic1 1-0033: PMIC Chip Version: 0x10
> >> [    1.189526] vddcore: supplied by regulator-dummy
> >> [    1.195633] vdd_ddr: supplied by regulator-dummy
> >> [    1.201672] vdd: supplied by regulator-dummy
> >> [    1.207452] v3v3: supplied by 5V2
> >> [    1.211997] v1v8_audio: supplied by v3v3
> >> [    1.218036] v3v3_hdmi: supplied by 5V2
> >> [    1.223626] vtt_ddr: supplied by regulator-dummy
> >> [    1.227107] vdd_usb: supplied by regulator-dummy
> >> [    1.234532] vdda: supplied by 5V2
> >> [    1.239497] v1v2_hdmi: supplied by v3v3
> > [...]
> > 
> > Can you try with the patches I just sent and with debug logs enabled?
> > 
> > The first one just plugs a memory leak, but if there is some state
> > changed/saved in the rdev->constraints (can't find that code, though),
> > this might prevent it from being overwritten.
> > 
> > The second patch will just tell us if you hit the early resolve case.
> 
> Problem still persists. Early resolve case not hit:
[...]
> [    1.594492] vref_ddr: at 500 mV, enabled
> [    1.597047] edt_ft5x06 0-0038: touchscreen probe failed
> [    1.597211] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
> [    1.612406] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
> 
>   [ snip - continues many times ]
> 
> [    6.699244] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
> [    6.713312] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree

It seems that final regulator_resolve_supply() is spinning recursively.
Is the regulator name the same as its supply_name? Can you try the patch
below to verify this?

Best Regards
Micha³ Miros³aw

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c84e3b0b63de..983a4bd3e98c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1798,6 +1798,8 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (rdev->supply)
 		return 0;
 
+	dev_dbg(dev, "Resolving supply %s for %s\n", rdev->supply_name, rdev->desc->name);
+
 	r = regulator_dev_lookup(dev, rdev->supply_name);
 	if (IS_ERR(r)) {
 		ret = PTR_ERR(r);
@@ -1816,6 +1818,12 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		}
 	}
 
+	if (r == rdev) {
+		dev_err(dev, "Supply for %s (%s) resolved to itself\n",
+			rdev->desc->name, rdev->supply_name);
+		return -EINVAL;
+	}
+
 	/*
 	 * If the supply's parent device is not the same as the
 	 * regulator's parent device, then ensure the parent device
