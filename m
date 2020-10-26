Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AE2991E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785007AbgJZQIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784998AbgJZQIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:08:34 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAED2242A;
        Mon, 26 Oct 2020 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728512;
        bh=/R/OfLhHSwGQCkb4EbogjrEqJZQbKKeFxjYDkftH5u0=;
        h=From:To:Cc:Subject:Date:From;
        b=f0Qyqy4g0LL+X6i+b3W4vxhJxd3UN4bJ1VOiKzHk6oRNk6jvkvGPqxEZZdHUC7xFt
         ifs3SNJHPrclQZAEwSY5xTjF7rd0szZqeZb7O26AsCnLu4nw5FN5IXDWHb+ev93gEq
         fNYaEyZ5KBkDNtf/t78Je/gIhHBQ0i3VeoDP+k50=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, Zhang Li <li.zhang@bitmain.com>,
        Ding Z Nan <oshack@hotmail.com>,
        Tomer Tayar <ttayar@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dotan Barak <dbarak@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: fix kernel pointer type
Date:   Mon, 26 Oct 2020 17:08:06 +0100
Message-Id: <20201026160825.3706944-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All throughout the driver, normal kernel pointers are
stored as 'u64' struct members, which is kind of silly
and requires casting through a uintptr_t to void* every
time they are used.

There is one line that missed the intermediate uintptr_t
case, which leads to a compiler warning:

drivers/misc/habanalabs/common/command_buffer.c: In function 'hl_cb_mmap':
drivers/misc/habanalabs/common/command_buffer.c:512:44: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  512 |  rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,

Rather than adding one more cast, just fix the type and
remove all the other casts.

Fixes: 0db575350cb1 ("habanalabs: make use of dma_mmap_coherent")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../misc/habanalabs/common/command_buffer.c   |  9 +++--
 drivers/misc/habanalabs/common/habanalabs.h   | 14 ++++----
 drivers/misc/habanalabs/common/hw_queue.c     | 19 +++++------
 drivers/misc/habanalabs/common/irq.c          | 17 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c         | 33 ++++++++-----------
 drivers/misc/habanalabs/goya/goya.c           | 26 +++++++--------
 drivers/misc/habanalabs/goya/goyaP.h          |  2 +-
 7 files changed, 55 insertions(+), 65 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 901e213daf40..ada570f35a41 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -142,11 +142,10 @@ static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
 {
 	if (cb->is_internal)
 		gen_pool_free(hdev->internal_cb_pool,
-				cb->kernel_address, cb->size);
+				(uintptr_t)cb->kernel_address, cb->size);
 	else
 		hdev->asic_funcs->asic_dma_free_coherent(hdev, cb->size,
-				(void *) (uintptr_t) cb->kernel_address,
-				cb->bus_address);
+				cb->kernel_address, cb->bus_address);
 
 	kfree(cb);
 }
@@ -230,7 +229,7 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 		return NULL;
 	}
 
-	cb->kernel_address = (u64) (uintptr_t) p;
+	cb->kernel_address = p;
 	cb->size = cb_size;
 
 	return cb;
@@ -509,7 +508,7 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 
 	vma->vm_private_data = cb;
 
-	rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,
+	rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
 					cb->bus_address, cb->size);
 	if (rc) {
 		spin_lock(&cb->lock);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 80d4d7385ffe..6ed974d2def0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -452,7 +452,7 @@ struct hl_cb {
 	struct list_head	pool_list;
 	struct list_head	va_block_list;
 	u64			id;
-	u64			kernel_address;
+	void			*kernel_address;
 	dma_addr_t		bus_address;
 	u32			mmap_size;
 	u32			size;
@@ -515,7 +515,7 @@ struct hl_hw_queue {
 	struct hl_hw_sob	hw_sob[HL_RSVD_SOBS];
 	struct hl_cs_job	**shadow_queue;
 	enum hl_queue_type	queue_type;
-	u64			kernel_address;
+	void			*kernel_address;
 	dma_addr_t		bus_address;
 	u32			pi;
 	atomic_t		ci;
@@ -544,7 +544,7 @@ struct hl_hw_queue {
  */
 struct hl_cq {
 	struct hl_device	*hdev;
-	u64			kernel_address;
+	void			*kernel_address;
 	dma_addr_t		bus_address;
 	u32			cq_idx;
 	u32			hw_queue_id;
@@ -562,7 +562,7 @@ struct hl_cq {
  */
 struct hl_eq {
 	struct hl_device	*hdev;
-	u64			kernel_address;
+	void			*kernel_address;
 	dma_addr_t		bus_address;
 	u32			ci;
 };
@@ -757,7 +757,7 @@ struct hl_asic_funcs {
 	u32 (*get_dma_desc_list_size)(struct hl_device *hdev,
 					struct sg_table *sgt);
 	void (*add_end_of_cb_packets)(struct hl_device *hdev,
-					u64 kernel_address, u32 len,
+					void *kernel_address, u32 len,
 					u64 cq_addr, u32 cq_val, u32 msix_num,
 					bool eb);
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
@@ -1382,13 +1382,13 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	for (;;) { \
 		/* Verify we read updates done by other cores or by device */ \
 		mb(); \
-		(val) = *((u32 *) (uintptr_t) (addr)); \
+		(val) = *((u32 *)(addr)); \
 		if (mem_written_by_device) \
 			(val) = le32_to_cpu(*(__le32 *) &(val)); \
 		if (cond) \
 			break; \
 		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = *((u32 *) (uintptr_t) (addr)); \
+			(val) = *((u32 *)(addr)); \
 			if (mem_written_by_device) \
 				(val) = le32_to_cpu(*(__le32 *) &(val)); \
 			break; \
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 5e66c98fb0d3..250cf9cefc06 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -75,7 +75,7 @@ static void ext_and_hw_queue_submit_bd(struct hl_device *hdev,
 {
 	struct hl_bd *bd;
 
-	bd = (struct hl_bd *) (uintptr_t) q->kernel_address;
+	bd = q->kernel_address;
 	bd += hl_pi_2_offset(q->pi);
 	bd->ctl = cpu_to_le32(ctl);
 	bd->len = cpu_to_le32(len);
@@ -335,8 +335,7 @@ static void int_queue_schedule_job(struct hl_cs_job *job)
 	bd.len = cpu_to_le32(job->job_cb_size);
 	bd.ptr = cpu_to_le64((u64) (uintptr_t) job->user_cb);
 
-	pi = (__le64 *) (uintptr_t) (q->kernel_address +
-		((q->pi & (q->int_queue_len - 1)) * sizeof(bd)));
+	pi = q->kernel_address + (q->pi & (q->int_queue_len - 1)) * sizeof(bd);
 
 	q->pi++;
 	q->pi &= ((q->int_queue_len << 1) - 1);
@@ -630,7 +629,7 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 	if (!p)
 		return -ENOMEM;
 
-	q->kernel_address = (u64) (uintptr_t) p;
+	q->kernel_address = p;
 
 	q->shadow_queue = kmalloc_array(HL_QUEUE_LENGTH,
 					sizeof(*q->shadow_queue),
@@ -653,11 +652,11 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 	if (is_cpu_queue)
 		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
-					(void *) (uintptr_t) q->kernel_address);
+					q->kernel_address);
 	else
 		hdev->asic_funcs->asic_dma_free_coherent(hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
-					(void *) (uintptr_t) q->kernel_address,
+					q->kernel_address,
 					q->bus_address);
 
 	return rc;
@@ -676,7 +675,7 @@ static int int_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 		return -EFAULT;
 	}
 
-	q->kernel_address = (u64) (uintptr_t) p;
+	q->kernel_address = p;
 	q->pi = 0;
 	atomic_set(&q->ci, 0);
 
@@ -704,7 +703,7 @@ static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 	if (!p)
 		return -ENOMEM;
 
-	q->kernel_address = (u64) (uintptr_t) p;
+	q->kernel_address = p;
 
 	/* Make sure read/write pointers are initialized to start of queue */
 	atomic_set(&q->ci, 0);
@@ -839,11 +838,11 @@ static void queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
 	if (q->queue_type == QUEUE_TYPE_CPU)
 		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
-					(void *) (uintptr_t) q->kernel_address);
+					q->kernel_address);
 	else
 		hdev->asic_funcs->asic_dma_free_coherent(hdev,
 					HL_QUEUE_SIZE_IN_BYTES,
-					(void *) (uintptr_t) q->kernel_address,
+					q->kernel_address,
 					q->bus_address);
 }
 
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index d20e40a53d70..de53fb5f978a 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -90,7 +90,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 		return IRQ_HANDLED;
 	}
 
-	cq_base = (struct hl_cq_entry *) (uintptr_t) cq->kernel_address;
+	cq_base = cq->kernel_address;
 
 	while (1) {
 		bool entry_ready = ((le32_to_cpu(cq_base[cq->ci].data) &
@@ -152,7 +152,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 	struct hl_eq_entry *eq_base;
 	struct hl_eqe_work *handle_eqe_work;
 
-	eq_base = (struct hl_eq_entry *) (uintptr_t) eq->kernel_address;
+	eq_base = eq->kernel_address;
 
 	while (1) {
 		bool entry_ready =
@@ -221,7 +221,7 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
 		return -ENOMEM;
 
 	q->hdev = hdev;
-	q->kernel_address = (u64) (uintptr_t) p;
+	q->kernel_address = p;
 	q->hw_queue_id = hw_queue_id;
 	q->ci = 0;
 	q->pi = 0;
@@ -242,7 +242,8 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
 void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
 {
 	hdev->asic_funcs->asic_dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
-			(void *) (uintptr_t) q->kernel_address, q->bus_address);
+						 q->kernel_address,
+						 q->bus_address);
 }
 
 void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
@@ -259,7 +260,7 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
 	 * when the device is operational again
 	 */
 
-	memset((void *) (uintptr_t) q->kernel_address, 0, HL_CQ_SIZE_IN_BYTES);
+	memset(q->kernel_address, 0, HL_CQ_SIZE_IN_BYTES);
 }
 
 /**
@@ -282,7 +283,7 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 		return -ENOMEM;
 
 	q->hdev = hdev;
-	q->kernel_address = (u64) (uintptr_t) p;
+	q->kernel_address = p;
 	q->ci = 0;
 
 	return 0;
@@ -302,7 +303,7 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 
 	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
 					HL_EQ_SIZE_IN_BYTES,
-					(void *) (uintptr_t) q->kernel_address);
+					q->kernel_address);
 }
 
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
@@ -316,5 +317,5 @@ void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
 	 * when the device is operational again
 	 */
 
-	memset((void *) (uintptr_t) q->kernel_address, 0, HL_EQ_SIZE_IN_BYTES);
+	memset(q->kernel_address, 0, HL_EQ_SIZE_IN_BYTES);
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 5f65a1691551..b071965fa10a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -680,8 +680,7 @@ static int _gaudi_init_tpc_mem(struct hl_device *hdev,
 	if (!cb)
 		return -EFAULT;
 
-	init_tpc_mem_pkt = (struct packet_lin_dma *) (uintptr_t)
-					cb->kernel_address;
+	init_tpc_mem_pkt = cb->kernel_address;
 	cb_size = sizeof(*init_tpc_mem_pkt);
 	memset(init_tpc_mem_pkt, 0, cb_size);
 
@@ -3811,8 +3810,7 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 		u16 pkt_size;
 		struct gaudi_packet *user_pkt;
 
-		user_pkt = (struct gaudi_packet *) (uintptr_t)
-			(parser->user_cb->kernel_address + cb_parsed_length);
+		user_pkt = parser->user_cb->kernel_address + cb_parsed_length;
 
 		pkt_id = (enum packet_id) (
 				(le64_to_cpu(user_pkt->header) &
@@ -4035,11 +4033,9 @@ static int gaudi_patch_cb(struct hl_device *hdev,
 		u32 new_pkt_size = 0;
 		struct gaudi_packet *user_pkt, *kernel_pkt;
 
-		user_pkt = (struct gaudi_packet *) (uintptr_t)
-			(parser->user_cb->kernel_address + cb_parsed_length);
-		kernel_pkt = (struct gaudi_packet *) (uintptr_t)
-			(parser->patched_cb->kernel_address +
-					cb_patched_cur_length);
+		user_pkt = parser->user_cb->kernel_address + cb_parsed_length;
+		kernel_pkt = parser->patched_cb->kernel_address +
+					cb_patched_cur_length;
 
 		pkt_id = (enum packet_id) (
 				(le64_to_cpu(user_pkt->header) &
@@ -4155,8 +4151,8 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	 * The check that parser->user_cb_size <= parser->user_cb->size was done
 	 * in validate_queue_index().
 	 */
-	memcpy((void *) (uintptr_t) parser->patched_cb->kernel_address,
-		(void *) (uintptr_t) parser->user_cb->kernel_address,
+	memcpy(parser->patched_cb->kernel_address,
+		parser->user_cb->kernel_address,
 		parser->user_cb_size);
 
 	patched_cb_size = parser->patched_cb_size;
@@ -4290,7 +4286,7 @@ static int gaudi_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 }
 
 static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
-					u64 kernel_address, u32 len,
+					void *kernel_address, u32 len,
 					u64 cq_addr, u32 cq_val, u32 msi_vec,
 					bool eb)
 {
@@ -4298,8 +4294,7 @@ static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
 	struct packet_msg_prot *cq_pkt;
 	u32 tmp;
 
-	cq_pkt = (struct packet_msg_prot *) (uintptr_t)
-		(kernel_address + len - (sizeof(struct packet_msg_prot) * 2));
+	cq_pkt = kernel_address + len - (sizeof(struct packet_msg_prot) * 2);
 
 	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
 	tmp |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
@@ -4342,7 +4337,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	if (!cb)
 		return -EFAULT;
 
-	lin_dma_pkt = (struct packet_lin_dma *) (uintptr_t) cb->kernel_address;
+	lin_dma_pkt = cb->kernel_address;
 	memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
 	cb_size = sizeof(*lin_dma_pkt);
 
@@ -4954,8 +4949,8 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 
 	cb = job->patched_cb;
 
-	fence_pkt = (struct packet_msg_prot *) (uintptr_t) (cb->kernel_address +
-			job->job_cb_size - sizeof(struct packet_msg_prot));
+	fence_pkt = cb->kernel_address +
+			job->job_cb_size - sizeof(struct packet_msg_prot);
 
 	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
 	tmp |= FIELD_PREP(GAUDI_PKT_CTL_EB_MASK, 1);
@@ -6386,7 +6381,7 @@ static void gaudi_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id)
 	struct packet_msg_short *pkt;
 	u32 value, ctl;
 
-	pkt = (struct packet_msg_short *) (uintptr_t) cb->kernel_address;
+	pkt = cb->kernel_address;
 	memset(pkt, 0, sizeof(*pkt));
 
 	/* Inc by 1, Mode ADD */
@@ -6478,7 +6473,7 @@ static void gaudi_gen_wait_cb(struct hl_device *hdev, void *data, u16 sob_id,
 			u16 sob_val, u16 mon_id, u32 q_idx)
 {
 	struct hl_cb *cb = (struct hl_cb *) data;
-	void *buf = (void *) (uintptr_t) cb->kernel_address;
+	void *buf = cb->kernel_address;
 	u64 monitor_base, fence_addr = 0;
 	u32 size = 0;
 	u16 msg_addr_offset;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5db52064ed9e..235d47b2420f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2882,8 +2882,8 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 
 	cb = job->patched_cb;
 
-	fence_pkt = (struct packet_msg_prot *) (uintptr_t) (cb->kernel_address +
-			job->job_cb_size - sizeof(struct packet_msg_prot));
+	fence_pkt = cb->kernel_address +
+			job->job_cb_size - sizeof(struct packet_msg_prot);
 
 	tmp = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
 			(1 << GOYA_PKT_CTL_EB_SHIFT) |
@@ -3475,8 +3475,7 @@ static int goya_validate_cb(struct hl_device *hdev,
 		u16 pkt_size;
 		struct goya_packet *user_pkt;
 
-		user_pkt = (struct goya_packet *) (uintptr_t)
-			(parser->user_cb->kernel_address + cb_parsed_length);
+		user_pkt = parser->user_cb->kernel_address + cb_parsed_length;
 
 		pkt_id = (enum packet_id) (
 				(le64_to_cpu(user_pkt->header) &
@@ -3713,11 +3712,9 @@ static int goya_patch_cb(struct hl_device *hdev,
 		u32 new_pkt_size = 0;
 		struct goya_packet *user_pkt, *kernel_pkt;
 
-		user_pkt = (struct goya_packet *) (uintptr_t)
-			(parser->user_cb->kernel_address + cb_parsed_length);
-		kernel_pkt = (struct goya_packet *) (uintptr_t)
-			(parser->patched_cb->kernel_address +
-					cb_patched_cur_length);
+		user_pkt = parser->user_cb->kernel_address + cb_parsed_length;
+		kernel_pkt = parser->patched_cb->kernel_address +
+					cb_patched_cur_length;
 
 		pkt_id = (enum packet_id) (
 				(le64_to_cpu(user_pkt->header) &
@@ -3841,8 +3838,8 @@ static int goya_parse_cb_mmu(struct hl_device *hdev,
 	 * The check that parser->user_cb_size <= parser->user_cb->size was done
 	 * in validate_queue_index().
 	 */
-	memcpy((void *) (uintptr_t) parser->patched_cb->kernel_address,
-		(void *) (uintptr_t) parser->user_cb->kernel_address,
+	memcpy(parser->patched_cb->kernel_address,
+		parser->user_cb->kernel_address,
 		parser->user_cb_size);
 
 	patched_cb_size = parser->patched_cb_size;
@@ -3974,15 +3971,14 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 		return goya_parse_cb_no_mmu(hdev, parser);
 }
 
-void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
+void goya_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_address,
 				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
 				bool eb)
 {
 	struct packet_msg_prot *cq_pkt;
 	u32 tmp;
 
-	cq_pkt = (struct packet_msg_prot *) (uintptr_t)
-		(kernel_address + len - (sizeof(struct packet_msg_prot) * 2));
+	cq_pkt = kernel_address + len - (sizeof(struct packet_msg_prot) * 2);
 
 	tmp = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
 			(1 << GOYA_PKT_CTL_EB_SHIFT) |
@@ -4746,7 +4742,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 	if (!cb)
 		return -ENOMEM;
 
-	lin_dma_pkt = (struct packet_lin_dma *) (uintptr_t) cb->kernel_address;
+	lin_dma_pkt = cb->kernel_address;
 
 	do {
 		memset(lin_dma_pkt, 0, sizeof(*lin_dma_pkt));
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 09b4006d4dc3..def86c75e035 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -217,7 +217,7 @@ int goya_resume(struct hl_device *hdev);
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
 void *goya_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size);
 
-void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
+void goya_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_address,
 				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
 				bool eb);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
-- 
2.27.0

