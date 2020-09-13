Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0C268193
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgIMV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 17:59:36 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51057 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:59:34 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9D8748364F;
        Mon, 14 Sep 2020 09:59:30 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1600034370;
        bh=ZjWQGtSyO0kEk9NqvK9evB+O0jozNr23w3ubWZ7l71E=;
        h=From:To:Cc:Subject:Date;
        b=UhBk9scmYbdl/hg/DhTenluoKLbbIvMiM2C92q00CQJMjXhb7Vxqq1rn6PivDfzBj
         mMY4k6WdUHH0EXD9IgavaGk+rgWXpeLb/GSaEqVmjjZvRqV50I9BlCaLdd5m24GtT0
         0jzVRdkLNrxu1SHrc34+A+bTT2LvcxWOKZGihLrSdkAZHR3/NRMGg0R7MyrpK/mvC1
         olzjIm3u6TocPOprtKXsnZCIxGxZ5miDUq9BiYuwEQ1QIzRfqmVRCmHjSFUwTy8JpF
         jv0pilA9oEHakjn69UPsinBeOkwS/cPnFnNafbiXcjfQCSi1aLHkaHru+z0EXll+SF
         TwUGH090fOZuA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5e96410001>; Mon, 14 Sep 2020 09:59:31 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id BB17F13EED0;
        Mon, 14 Sep 2020 09:59:28 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E148228008F; Mon, 14 Sep 2020 09:59:28 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     stern@rowland.harvard.edu, linux@prisktech.co.nz,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] usb: host: ehci-platform: Add workaround for brcm,xgs-iproc-ehci
Date:   Mon, 14 Sep 2020 09:59:26 +1200
Message-Id: <20200913215926.29880-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ehci controller found in some Broadcom switches with integrated SoCs
has an issue which causes a soft lockup with large transfers like you
see when running ext4 on USB3 flash drive.

Port the fix from the Broadcom XLDK to increase the OUT_THRESHOLD to
avoid the problem.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

I don't have much data on what this change does. I can say it is needed t=
o
avoid a soft lockup when using a USB3 Flash drive formatted has ext4 (USB=
2 +
ext4 is OK, USB3 + fat is OK). I presume the affected combination ends up=
 using
larger transfers triggering the problem.

The equivalent change in the Broadcom XLDK is

	if (IS_ENABLED(CONFIG_USB_EHCI_XGS_IPROC))
		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
				&ehci->regs->reserved4[6]);

This is problematic because it would unconditionally apply to all ehci
controllers whenever CONFIG_USB_EHCI_XGS_IPROC is enabled (also reserved4=
 only
goes to 6 so technically it's indexing off the end of the array).

I wasn't sure if I should add a new property or somehow detect the affect=
ed
host controller. I settled on using of_device_is_compatible() as that see=
med
the simplest thing to do.

Changes in v2:
- move workaround to ehci_platform_reset
- cosmetic changes suggested by Alan

 drivers/usb/host/ehci-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index 006c4f6188a5..9804ffa9e67f 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -42,6 +42,9 @@
 #define EHCI_MAX_CLKS 4
 #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)=
->priv)
=20
+#define BCM_USB_FIFO_THRESHOLD	0x00800040
+#define bcm_iproc_insnreg01	hostpc[0]
+
 struct ehci_platform_priv {
 	struct clk *clks[EHCI_MAX_CLKS];
 	struct reset_control *rsts;
@@ -75,6 +78,11 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
=20
 	if (pdata->no_io_watchdog)
 		ehci->need_io_watchdog =3D 0;
+
+	if (of_device_is_compatible(pdev->dev.of_node, "brcm,xgs-iproc-ehci"))
+		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
+			    &ehci->regs->bcm_iproc_insnreg01);
+
 	return 0;
 }
=20
--=20
2.28.0

