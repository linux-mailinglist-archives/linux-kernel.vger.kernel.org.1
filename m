Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596442FD5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbhATQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:36:45 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:46510 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391260AbhATQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:34:59 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 20 Jan 2021 08:33:37 -0800
Received: from sc-dbc2115.eng.vmware.com (sc-dbc2115.eng.vmware.com [10.182.28.6])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 699272086F;
        Wed, 20 Jan 2021 08:33:40 -0800 (PST)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        <nslusarek@gmx.net>, Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH v2 3/3] VMCI: Enforce queuepair max size for IOCTL_VMCI_QUEUEPAIR_ALLOC
Date:   Wed, 20 Jan 2021 08:33:40 -0800
Message-ID: <1611160420-30573-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When create the VMCI queue pair tracking data structures on the host
side, the IOCTL for creating the VMCI queue pair didn't validate
the queue pair size parameters. This change adds checks for this.

This avoids a memory allocation issue in qp_host_alloc_queue, as
reported by nslusarek@gmx.net. The check in qp_host_alloc_queue
has also been updated to enforce the maximum queue pair size
as defined by VMCI_MAX_GUEST_QP_MEMORY.

The fix has been verified using sample code supplied by
nslusarek@gmx.net.

Reported-by: nslusarek@gmx.net
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++----
 include/linux/vmw_vmci_defs.h           |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 525ef96..d787dde 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -237,7 +237,9 @@ static struct qp_list qp_guest_endpoints = {
 #define QPE_NUM_PAGES(_QPE) ((u32) \
 			     (DIV_ROUND_UP(_QPE.produce_size, PAGE_SIZE) + \
 			      DIV_ROUND_UP(_QPE.consume_size, PAGE_SIZE) + 2))
-
+#define QP_SIZES_ARE_VALID(_prod_qsize, _cons_qsize) \
+	((_prod_qsize) + (_cons_qsize) >= max(_prod_qsize, _cons_qsize) && \
+	 (_prod_qsize) + (_cons_qsize) <= VMCI_MAX_GUEST_QP_MEMORY)
 
 /*
  * Frees kernel VA space for a given queue and its queue header, and
@@ -528,7 +530,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
 	u64 num_pages;
 	const size_t queue_size = sizeof(*queue) + sizeof(*(queue->kernel_if));
 
-	if (size > SIZE_MAX - PAGE_SIZE)
+	if (size > min_t(size_t, VMCI_MAX_GUEST_QP_MEMORY, SIZE_MAX - PAGE_SIZE))
 		return NULL;
 	num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
 	if (num_pages > (SIZE_MAX - queue_size) /
@@ -1929,6 +1931,9 @@ int vmci_qp_broker_alloc(struct vmci_handle handle,
 			 struct vmci_qp_page_store *page_store,
 			 struct vmci_ctx *context)
 {
+	if (!QP_SIZES_ARE_VALID(produce_size, consume_size))
+		return VMCI_ERROR_NO_RESOURCES;
+
 	return qp_broker_alloc(handle, peer, flags, priv_flags,
 			       produce_size, consume_size,
 			       page_store, context, NULL, NULL, NULL, NULL);
@@ -2685,8 +2690,7 @@ int vmci_qpair_alloc(struct vmci_qp **qpair,
 	 * used by the device is NO_RESOURCES, so use that here too.
 	 */
 
-	if (produce_qsize + consume_qsize < max(produce_qsize, consume_qsize) ||
-	    produce_qsize + consume_qsize > VMCI_MAX_GUEST_QP_MEMORY)
+	if (!QP_SIZES_ARE_VALID(produce_qsize, consume_qsize))
 		return VMCI_ERROR_NO_RESOURCES;
 
 	retval = vmci_route(&src, &dst, false, &route);
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index be0afe6..e36cb11 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -66,7 +66,7 @@ enum {
  * consists of at least two pages, the memory limit also dictates the
  * number of queue pairs a guest can create.
  */
-#define VMCI_MAX_GUEST_QP_MEMORY (128 * 1024 * 1024)
+#define VMCI_MAX_GUEST_QP_MEMORY ((size_t)(128 * 1024 * 1024))
 #define VMCI_MAX_GUEST_QP_COUNT  (VMCI_MAX_GUEST_QP_MEMORY / PAGE_SIZE / 2)
 
 /*
@@ -80,7 +80,7 @@ enum {
  * too much kernel memory (especially on vmkernel).  We limit a queuepair to
  * 32 KB, or 16 KB per queue for symmetrical pairs.
  */
-#define VMCI_MAX_PINNED_QP_MEMORY (32 * 1024)
+#define VMCI_MAX_PINNED_QP_MEMORY ((size_t)(32 * 1024))
 
 /*
  * We have a fixed set of resource IDs available in the VMX.
-- 
2.6.2

