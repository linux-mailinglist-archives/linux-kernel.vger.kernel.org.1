Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1516B2F1261
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbhAKMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:36:17 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25448 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbhAKMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:36:16 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 Jan 2021 04:18:54 -0800
Received: from sc-dbc2115.eng.vmware.com (sc-dbc2115.eng.vmware.com [10.182.28.6])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 7652F209C4;
        Mon, 11 Jan 2021 04:18:55 -0800 (PST)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI: Use set_page_dirty_lock() when unregistering guest memory
Date:   Mon, 11 Jan 2021 04:18:55 -0800
Message-ID: <1610367535-4463-3-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the VMCI host support releases guest memory in the case where
the VM was killed, the pinned guest pages aren't locked. Use
set_page_dirty_lock() instead of set_page_dirty().

Testing done: Killed VM while having an active VMCI based vSocket
connection and observed warning from ext4. With this fix, no
warning was observed. Ran various vSocket tests without issues.

Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index a3691c1..525ef96 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -630,7 +630,7 @@ static void qp_release_pages(struct page **pages,
 
 	for (i = 0; i < num_pages; i++) {
 		if (dirty)
-			set_page_dirty(pages[i]);
+			set_page_dirty_lock(pages[i]);
 
 		put_page(pages[i]);
 		pages[i] = NULL;
-- 
2.6.2

