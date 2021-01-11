Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2952F125C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbhAKMfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:35:30 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:5621 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbhAKMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:35:29 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 Jan 2021 04:18:53 -0800
Received: from sc-dbc2115.eng.vmware.com (sc-dbc2115.eng.vmware.com [10.182.28.6])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 71E33209C1;
        Mon, 11 Jan 2021 04:18:55 -0800 (PST)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI: Stop log spew when qp allocation isn't possible
Date:   Mon, 11 Jan 2021 04:18:54 -0800
Message-ID: <1610367535-4463-2-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMCI queue pair allocation is disabled, if a VM is in FT mode. In
these cases, VMware Tools may still once in a while attempt to
create a vSocket stream connection, resulting in multiple
warnings in the kernel logs. Therefore downgrade the error log to
a debug log.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index c490658..a3691c1 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -1207,7 +1207,7 @@ static int qp_alloc_guest_work(struct vmci_handle *handle,
 	} else {
 		result = qp_alloc_hypercall(queue_pair_entry);
 		if (result < VMCI_SUCCESS) {
-			pr_warn("qp_alloc_hypercall result = %d\n", result);
+			pr_devel("qp_alloc_hypercall result = %d\n", result);
 			goto error;
 		}
 	}
-- 
2.6.2

