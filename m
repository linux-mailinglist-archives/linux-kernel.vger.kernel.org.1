Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86A2C8DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgK3TGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:06:25 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:33010 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgK3TGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606763012;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Message-Id:Cc:Date:From:Subject:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=y20xJFPXm8Gb2N864xUBrhI95XSZqquGZTefxAuTL0k=;
        b=UCG/WS/nKw0B5Wh20zImSLJDmsU+tIsvhuFZ57al6wBdjxpgssOBuBrjyqMqckyNym
        x+UixQBIdPtAhm/10g3J/+jZ+LrQPZEMlcqsS5ddz/UfgNhSzGSbQjIogYth2coy/iAZ
        OEdKRQJoaGh8KOOdMXOHRCgl98iUWMQPOdDY0iVusRwhElgoPn1P5PiTtpX7oJDsMhH4
        zfDHZfxcOzRVqYz5dObtYDJu25xCiV6ZZ+1FE40LVv0jsRrnVAmctn3DbNwBQWGH62FN
        0JHxifA1YeHZy28HW7ENhye1RosMRu80s0wyLNbq4dWcg8Fd/8Y7KSt/VxZp5sXXsK2W
        AELQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vgwDCqtd0="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id N02faawAUJ3OQl6
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Nov 2020 20:03:24 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [BUG] SPI broken for SPI based panel drivers
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Mon, 30 Nov 2020 20:03:23 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
starting from v5.10-rc5 the SPI based panel of the GTA04 device is =
broken. It uses
compatible =3D "spi-gpio"; [1] i.e. gpio descriptors very indirectly.

Bisect shows that it is commit

766c6b63aa04 ("spi: fix client driver breakages when using GPIO =
descriptors")

The commit description tells about a problematic pattern and indeed the =
driver is
using it - like ca. 15 other spi based panel drivers in =
drivers/gpu/drm/panel/

I understood that it wants to fix the spi system to handle that =
correctly again.
But reverting your patch brings back the display. So it appears as if it =
does not
fix a breakage, rather breaks a previously working setup.

What should we do?

BR and thanks,
Nikolaus

[1]: =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/arm/boot/dts/omap3-gta04.dtsi?h=3Dv5.10-rc6#n107

