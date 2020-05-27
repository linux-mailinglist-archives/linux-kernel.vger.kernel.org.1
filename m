Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A936F1E4416
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbgE0Nnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:43:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0Nnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:43:31 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHVWT-1jrOix2p1t-00DWd3; Wed, 27 May 2020 15:43:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ehci: add struct entry for broadcom insnreg
Date:   Wed, 27 May 2020 15:43:04 +0200
Message-Id: <20200527134320.869042-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iTbJEaWywLf2mWLZVn8fMvVV4ZGFeQWRknpQL+LBsm8TuN1/Vy3
 PRdkOJArPLub4c5r7xCX6MDjcKaJr+OjIKhUim5J6EitfqibA9mja8GnHmjxjjluu9MRF8v
 265pV1iMcHPkyrEnaDcCXGmuGF/kCt3/Un4genigI7B98lloWFWYKVNV6aDS7Y6zi419NkD
 AO8HomIG4+s0EIeb9zL+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sRc5KvpM3r0=:OPRaEuFeB1zs97rG6nj3Gt
 ilk67Ulrv9ec7I6CHJYfDaAdth5yW2UMClZV4K53vqHrUfFkLCtAdBGQ31bGV1ngZ8mklzsKx
 q4SXvfQKtTUoEvrurbJZrudUrQvvwpJbl/4ynW33w2sztPlJ7SQHSYsvJ19SD1weYeO4haC58
 12PrYVpuzOiJV009FCH4ynO15sfBNsuV/jzSMVlhf6/Pvlb9DPO0R11HMQU1vhxgGjj4ZBf17
 /edtTaCvSj1d0By1rwSjAWYWyhJM+lyDys2B7fSwCsOHtu08855hH/FM7aWWFAMVJvegTVCn0
 h4cIhEvthT5NONp3YiJ+q/jjCoCXYWLDyFA9uNMQxA1yOX0uel5zhn+F+1iY8oRrUajGnvSBa
 mgrutL3k0sOhq5HlSVIllB0NJlBnmA6RAo8TSm/DV9OvfauaKE6buwCucjrMNIZFbku88kvuP
 ndiF+mVhbeWKhRLulr4AfwOfgzCM0v0aQHf5HKw5KIwcNBCiRPJ33BvrZQEDLnKTN042sNlWT
 QsCa+w8iyd5e72/UfteHtr9u75qOipOvJOAFuBl2bp84qtCd2nlcsoRecFV9c0AB/dwxr9cMe
 lRr06y9ZeKNk/8M1tea2e3V/3bzptTSu+7s8GZBV+AoJf+ij1Ap1sBj4A8GyqN1m6Eq+wLplf
 MNKPhngdHqmJHlJ6lp2Lhb0+RzmMS+WHWteTn2t9RRPY0ybz6uIEIlBwjU7FljeEqktaK2aQ7
 RFKmXyOqlP46LRNiw9fZW0p1OloQAF6SRtHh1sq7zL7zwts9b/qr9MABYRysjdlm06cHs7N3/
 Oeug/YOnHMIFWqzPJGZt3zmDVPlsKsV6CLcR78ShsfIevO/9+s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added broadcom ehci driver triggered another array
overflow warning after I had fixed up a bunch of others. In this
case, the driver intentionally abuses the port_status[] array
to access a register that does not have an official name:

drivers/usb/host/ehci-brcm.c:113:33: error: array index 16 is past the end of the array (which contains 15 elements) [-Werror,-Warray-bounds]
        ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
                                       ^                       ~~~~
include/linux/usb/ehci_def.h:131:3: note: array 'port_status' declared here
                u32             port_status[15]; /* up to N_PORTS */
                ^

There is already a hack for Intel specific registers at the same
location, so extend that hack to also cover the Broadcom registers.

I'm a little confused about the register offset, as the code comment
says @0x90 while the actual offset seems to be at offset 0x84, please
confirm that the behavior is still correct.

Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
Fixes: 88aa39691cea ("usb: ehci: avoid gcc-10 zero-length-bounds warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci-brcm.c | 13 ++++++-------
 include/linux/usb/ehci_def.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index 3e0ebe8cc649..bafb3f4db170 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -108,10 +108,10 @@ static int ehci_brcm_reset(struct usb_hcd *hcd)
 	/*
 	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
 	 *   bus usage
-	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
+	 * Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
 
 	return ehci_setup(hcd);
 }
@@ -223,11 +223,10 @@ static int __maybe_unused ehci_brcm_resume(struct device *dev)
 	/*
 	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
 	 *   bus usage
-	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
-	 * @ 0x90
+	 * Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
 	 */
-	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
-	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+	ehci_writel(ehci, 0x00800040, &ehci->regs->brcm_insnreg[0]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->brcm_insnreg[2]);
 
 	ehci_resume(hcd, false);
 
diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index 99481bbcc8f7..cf4bfbbdc8a3 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -190,6 +190,7 @@ struct ehci_regs {
 #define HOSTPC_PHCD	(1<<22)		/* Phy clock disable */
 #define HOSTPC_PSPD	(3<<25)		/* Port speed detection */
 
+		u32		brcm_insnreg[3]; /* Broadcom specific */
 		u32		reserved6[17];
 	};
 
-- 
2.26.2

