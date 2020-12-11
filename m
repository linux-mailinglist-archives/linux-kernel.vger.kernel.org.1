Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA082D76D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbgLKNpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:45:30 -0500
Received: from unlabelled-106-32-58-62.versatel.net ([87.213.235.106]:40128
        "EHLO unlabelled-106-32-58-62.versatel.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393278AbgLKNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:44:49 -0500
X-Greylist: delayed 1873 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2020 08:44:48 EST
X-Footer: ZGFwdGVjaG5vbG9neS5jb20=
Received: from [192.168.6.241] ([192.168.6.241])
        (authenticated user janjaap@daptechnology.com)
        by unlabelled-106-32-58-62.versatel.net with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 11 Dec 2020 14:12:27 +0100
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
From:   Jan-Jaap van der Heijden <janjaap@daptechnology.com>
Subject: [PATCH 1/1] firewire: ohci: enable SLLZ059 erratum with XIO2213 OHCI
 chip
Message-ID: <e86c724b-009b-9f3b-3c1e-0804ac4c7a2b@daptechnology.com>
Date:   Fri, 11 Dec 2020 14:12:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XIO2213 PCIe to 1394b OHCI controller can be used with an external
PHY chip instead of the built-in one. In order to support the combination
of the XIO2213 with a TSB41BA3D PHY chip, we need to enable the SLLZ059
erratum for the XIO2213 like we do for other TI 1394 link layer chips.

Signed-off-by: Jan-Jaap van der Heijden <janjaap@daptechnology.com>
Signed-off-by: Jeroen de Zoeten <jeroen@daptechnology.com>
---

  ohci.c |    4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 9811c40956e5..142511a57a05 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -267,6 +267,7 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
  #define PCI_DEVICE_ID_TI_TSB12LV22    0x8009
  #define PCI_DEVICE_ID_TI_TSB12LV26    0x8020
  #define PCI_DEVICE_ID_TI_TSB82AA2    0x8025
+#define PCI_DEVICE_ID_TI_XIO2213    0x823f
  #define PCI_DEVICE_ID_VIA_VT630X    0x3044
  #define PCI_REV_ID_VIA_VT6306        0x46
  #define PCI_DEVICE_ID_VIA_VT6315    0x3403
@@ -316,6 +317,9 @@ static const struct {
      {PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_TSB82AA2, PCI_ANY_ID,
          QUIRK_RESET_PACKET | QUIRK_TI_SLLZ059},

+    {PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_XIO2213, PCI_ANY_ID,
+        QUIRK_RESET_PACKET | QUIRK_TI_SLLZ059},
+
      {PCI_VENDOR_ID_TI, PCI_ANY_ID, PCI_ANY_ID,
          QUIRK_RESET_PACKET},



