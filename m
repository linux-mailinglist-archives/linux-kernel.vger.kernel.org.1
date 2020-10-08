Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13E287AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbgJHRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:11:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35537 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgJHRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:11:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kQZSK-0006xf-1h; Thu, 08 Oct 2020 17:11:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: Fix sizeof() mismatch
Date:   Thu,  8 Oct 2020 18:11:51 +0100
Message-Id: <20201008171151.198996-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof() is being used, sizeof(rhub->ports) is not
correct, it should be sizeof(*rhub->ports).  This bug did not
cause any issues because it just so happens the sizes are the same.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: bcaa9d5c5900 ("xhci: Create new structures to store xhci port information")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/xhci-mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index fe405cd38dbc..138ba4528dd3 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2252,8 +2252,8 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
 
 	if (!rhub->num_ports)
 		return;
-	rhub->ports = kcalloc_node(rhub->num_ports, sizeof(rhub->ports), flags,
-			dev_to_node(dev));
+	rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
+			flags, dev_to_node(dev));
 	for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
 		if (xhci->hw_ports[i].rhub != rhub ||
 		    xhci->hw_ports[i].hcd_portnum == DUPLICATE_ENTRY)
-- 
2.27.0

