Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4562C8D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbgK3Sny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbgK3Sny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:54 -0500
Received: from mail-oo1-xc63.google.com (mail-oo1-xc63.google.com [IPv6:2607:f8b0:4864:20::c63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C7C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:13 -0800 (PST)
Received: by mail-oo1-xc63.google.com with SMTP id t23so2914475oov.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mLEf4T1TZCo9zCIEREMm1Y3wfyCfXwfP5sPhXv4ndU=;
        b=J8HN5QMvv+3jqkcZ28xXOZcmZdntas0uzM0Iw+rFwZH9oW/gSIDFOIQnaEDZYBg6yI
         N2ckajnbEM7d+Zr0WzK7gxl2NU500Pn2cpTmssbWANvrHGc9SD172/BELxKtISw75Khl
         nehv5shTT9AthachYm9Ev6uB8rQ+XuGGVwtlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mLEf4T1TZCo9zCIEREMm1Y3wfyCfXwfP5sPhXv4ndU=;
        b=mdpm0LWi+sy7mr6pXTCiJbDYqpzxc2BQoTWZ19O6Wv5VvyBWP9tFBBcBopV0wUfTaM
         P2q8fhnlKDNXTUX/2i9KW0ytf909GInXxtLnSsKLrl6HZEXJAhp4XPQGWQ07xHWjZPOl
         iunzbul3i+EsgxFmiDqSIDDT5OVrbFnG8Qy8cyJXtBhc4Qnc9K7oDRETSsVfLr8S+b0J
         XTfWSRGIVP1YjcWcztoVkJEKKANABsCVCGO+ZnhVyPfQOnEgp1RuqPkiOjFUzgagb8Ii
         bcn+akFWD+nToQcsGY+QV2D/CellO/fNKlUMcq1E90LcU4KVuA6YFFtAdGOuzoSspssL
         SREQ==
X-Gm-Message-State: AOAM5334XJJ03pjHJWFGuqjXf3F4VxtGbAucaSzztgWWze7QCkJzZAoB
        F41EaNuWskvMAYYKeV3XJiCG3am9MND5EtVC7/VoQ0mmsQRG
X-Google-Smtp-Source: ABdhPJz8wGh8r+/YwiMc29cS7N0Y342LBUIc5cKd42moPKMTjvQlk+qaSmxzLL+3Ej5EoELjCuWEb1iYP9W+
X-Received: by 2002:a4a:91de:: with SMTP id e30mr16582006ooh.58.1606761791674;
        Mon, 30 Nov 2020 10:43:11 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:43:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 09/13] misc: bcm-vk: add VK messaging support
Date:   Mon, 30 Nov 2020 10:41:56 -0800
Message-Id: <20201130184200.5095-10-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add message support in order to be able to communicate
to VK card via message queues.

This info is used for debug purposes via collection of logs via direct
read of BAR space and by sysfs access (in a follow on commit).

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/Makefile     |    3 +-
 drivers/misc/bcm-vk/bcm_vk.h     |  123 ++++
 drivers/misc/bcm-vk/bcm_vk_dev.c |  309 +++++++-
 drivers/misc/bcm-vk/bcm_vk_msg.c | 1187 ++++++++++++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h |  132 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.c  |  275 +++++++
 drivers/misc/bcm-vk/bcm_vk_sg.h  |   61 ++
 7 files changed, 2087 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h

diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
index a2ae79858409..79b4e365c9e6 100644
--- a/drivers/misc/bcm-vk/Makefile
+++ b/drivers/misc/bcm-vk/Makefile
@@ -6,5 +6,6 @@
 obj-$(CONFIG_BCM_VK) += bcm_vk.o
 bcm_vk-objs := \
 	bcm_vk_dev.o \
-	bcm_vk_msg.o
+	bcm_vk_msg.o \
+	bcm_vk_sg.o
 
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 50f2a0cd6e13..d847a512d0ed 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -6,11 +6,13 @@
 #ifndef BCM_VK_H
 #define BCM_VK_H
 
+#include <linux/atomic.h>
 #include <linux/firmware.h>
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/poll.h>
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/misc/bcm_vk.h>
@@ -93,14 +95,53 @@
 #define MAJOR_SOC_REV(_chip_id)		(((_chip_id) >> 20) & 0xf)
 
 #define BAR_CARD_TEMPERATURE		0x45c
+/* defines for all temperature sensor */
+#define BCM_VK_TEMP_FIELD_MASK		0xff
+#define BCM_VK_CPU_TEMP_SHIFT		0
+#define BCM_VK_DDR0_TEMP_SHIFT		8
+#define BCM_VK_DDR1_TEMP_SHIFT		16
 
 #define BAR_CARD_VOLTAGE		0x460
+/* defines for voltage rail conversion */
+#define BCM_VK_VOLT_RAIL_MASK		0xffff
+#define BCM_VK_3P3_VOLT_REG_SHIFT	16
 
 #define BAR_CARD_ERR_LOG		0x464
+/* Error log register bit definition - register for error alerts */
+#define ERR_LOG_UECC			BIT(0)
+#define ERR_LOG_SSIM_BUSY		BIT(1)
+#define ERR_LOG_AFBC_BUSY		BIT(2)
+#define ERR_LOG_HIGH_TEMP_ERR		BIT(3)
+#define ERR_LOG_WDOG_TIMEOUT		BIT(4)
+#define ERR_LOG_SYS_FAULT		BIT(5)
+#define ERR_LOG_RAMDUMP			BIT(6)
+#define ERR_LOG_COP_WDOG_TIMEOUT	BIT(7)
+/* warnings */
+#define ERR_LOG_MEM_ALLOC_FAIL		BIT(8)
+#define ERR_LOG_LOW_TEMP_WARN		BIT(9)
+#define ERR_LOG_ECC			BIT(10)
+#define ERR_LOG_IPC_DWN			BIT(11)
+
+/* Alert bit definitions detectd on host */
+#define ERR_LOG_HOST_INTF_V_FAIL	BIT(13)
+#define ERR_LOG_HOST_HB_FAIL		BIT(14)
+#define ERR_LOG_HOST_PCIE_DWN		BIT(15)
 
 #define BAR_CARD_ERR_MEM		0x468
+/* defines for mem err, all fields have same width */
+#define BCM_VK_MEM_ERR_FIELD_MASK	0xff
+#define BCM_VK_ECC_MEM_ERR_SHIFT	0
+#define BCM_VK_UECC_MEM_ERR_SHIFT	8
+/* threshold of event occurrence and logs start to come out */
+#define BCM_VK_ECC_THRESHOLD		10
+#define BCM_VK_UECC_THRESHOLD		1
 
 #define BAR_CARD_PWR_AND_THRE		0x46c
+/* defines for power and temp threshold, all fields have same width */
+#define BCM_VK_PWR_AND_THRE_FIELD_MASK	0xff
+#define BCM_VK_LOW_TEMP_THRE_SHIFT	0
+#define BCM_VK_HIGH_TEMP_THRE_SHIFT	8
+#define BCM_VK_PWR_STATE_SHIFT		16
 
 #define BAR_CARD_STATIC_INFO		0x470
 
@@ -143,6 +184,11 @@
 #define BAR_FIRMWARE_TAG_SIZE		50
 #define FIRMWARE_STATUS_PRE_INIT_DONE	0x1f
 
+/* VK MSG_ID defines */
+#define VK_MSG_ID_BITMAP_SIZE		4096
+#define VK_MSG_ID_BITMAP_MASK		(VK_MSG_ID_BITMAP_SIZE - 1)
+#define VK_MSG_ID_OVERFLOW		0xffff
+
 /*
  * BAR1
  */
@@ -197,6 +243,10 @@
 /* VK device supports a maximum of 3 bars */
 #define MAX_BAR	3
 
+/* default number of msg blk for inband SGL */
+#define BCM_VK_DEF_IB_SGL_BLK_LEN	 16
+#define BCM_VK_IB_SGL_BLK_MAX		 24
+
 enum pci_barno {
 	BAR_0 = 0,
 	BAR_1,
@@ -267,9 +317,27 @@ struct bcm_vk_proc_mon_info {
 	struct bcm_vk_proc_mon_entry_t entries[BCM_VK_PROC_MON_MAX];
 };
 
+struct bcm_vk_hb_ctrl {
+	struct timer_list timer;
+	u32 last_uptime;
+	u32 lost_cnt;
+};
+
+struct bcm_vk_alert {
+	u16 flags;
+	u16 notfs;
+};
+
+/* some alert counters that the driver will keep track */
+struct bcm_vk_alert_cnts {
+	u16 ecc;
+	u16 uecc;
+};
+
 struct bcm_vk {
 	struct pci_dev *pdev;
 	void __iomem *bar[MAX_BAR];
+	int num_irqs;
 
 	struct bcm_vk_card_info card_info;
 	struct bcm_vk_proc_mon_info proc_mon_info;
@@ -283,9 +351,17 @@ struct bcm_vk {
 	/* Reference-counting to handle file operations */
 	struct kref kref;
 
+	spinlock_t msg_id_lock; /* Spinlock for msg_id */
+	u16 msg_id;
+	DECLARE_BITMAP(bmap, VK_MSG_ID_BITMAP_SIZE);
 	spinlock_t ctx_lock; /* Spinlock for component context */
 	struct bcm_vk_ctx ctx[VK_CMPT_CTX_MAX];
 	struct bcm_vk_ht_entry pid_ht[VK_PID_HT_SZ];
+	pid_t reset_pid; /* process that issue reset */
+
+	atomic_t msgq_inited; /* indicate if info has been synced with vk */
+	struct bcm_vk_msg_chan to_v_msg_chan;
+	struct bcm_vk_msg_chan to_h_msg_chan;
 
 	struct workqueue_struct *wq_thread;
 	struct work_struct wq_work; /* work queue for deferred job */
@@ -294,6 +370,15 @@ struct bcm_vk {
 	dma_addr_t tdma_addr; /* test dma segment bus addr */
 
 	struct notifier_block panic_nb;
+	u32 ib_sgl_size; /* size allocated for inband sgl insertion */
+
+	/* heart beat mechanism control structure */
+	struct bcm_vk_hb_ctrl hb_ctrl;
+	/* house-keeping variable of error logs */
+	spinlock_t host_alert_lock; /* protection to access host_alert struct */
+	struct bcm_vk_alert host_alert;
+	struct bcm_vk_alert peer_alert; /* bits set by the card */
+	struct bcm_vk_alert_cnts alert_cnts;
 
 	/* offset of the peer log control in BAR2 */
 	u32 peerlog_off;
@@ -306,8 +391,26 @@ struct bcm_vk {
 enum bcm_vk_wq_offload_flags {
 	BCM_VK_WQ_DWNLD_PEND = 0,
 	BCM_VK_WQ_DWNLD_AUTO = 1,
+	BCM_VK_WQ_NOTF_PEND  = 2,
 };
 
+/* a macro to get an individual field with mask and shift */
+#define BCM_VK_EXTRACT_FIELD(_field, _reg, _mask, _shift) \
+		(_field = (((_reg) >> (_shift)) & (_mask)))
+
+struct bcm_vk_entry {
+	const u32 mask;
+	const u32 exp_val;
+	const char *str;
+};
+
+/* alerts that could be generated from peer */
+#define BCM_VK_PEER_ERR_NUM 12
+extern struct bcm_vk_entry const bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM];
+/* alerts detected by the host */
+#define BCM_VK_HOST_ERR_NUM 3
+extern struct bcm_vk_entry const bcm_vk_host_err[BCM_VK_HOST_ERR_NUM];
+
 /*
  * check if PCIe interface is down on read.  Use it when it is
  * certain that _val should never be all ones.
@@ -354,8 +457,28 @@ static inline bool bcm_vk_msgq_marker_valid(struct bcm_vk *vk)
 }
 
 int bcm_vk_open(struct inode *inode, struct file *p_file);
+ssize_t bcm_vk_read(struct file *p_file, char __user *buf, size_t count,
+		    loff_t *f_pos);
+ssize_t bcm_vk_write(struct file *p_file, const char __user *buf,
+		     size_t count, loff_t *f_pos);
+__poll_t bcm_vk_poll(struct file *p_file, struct poll_table_struct *wait);
 int bcm_vk_release(struct inode *inode, struct file *p_file);
 void bcm_vk_release_data(struct kref *kref);
+irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
+irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
+int bcm_vk_msg_init(struct bcm_vk *vk);
+void bcm_vk_msg_remove(struct bcm_vk *vk);
+int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync);
+void bcm_vk_blk_drv_access(struct bcm_vk *vk);
+s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk);
+int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
+			     const pid_t pid, const u32 q_num);
+void bcm_to_v_q_doorbell(struct bcm_vk *vk, u32 q_num, u32 db_val);
 int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
+void bcm_vk_hb_init(struct bcm_vk *vk);
+void bcm_vk_hb_deinit(struct bcm_vk *vk);
+void bcm_vk_handle_notf(struct bcm_vk *vk);
+bool bcm_vk_drv_access_ok(struct bcm_vk *vk);
+void bcm_vk_set_host_alert(struct bcm_vk *vk, u32 bit_mask);
 
 #endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a63208513c64..5d82f02c0f27 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -8,6 +8,7 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/interrupt.h>
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -102,6 +103,54 @@ static uint nr_scratch_pages = VK_BAR1_SCRATCH_DEF_NR_PAGES;
 module_param(nr_scratch_pages, uint, 0444);
 MODULE_PARM_DESC(nr_scratch_pages,
 		 "Number of pre allocated DMAable coherent pages.\n");
+static uint nr_ib_sgl_blk = BCM_VK_DEF_IB_SGL_BLK_LEN;
+module_param(nr_ib_sgl_blk, uint, 0444);
+MODULE_PARM_DESC(nr_ib_sgl_blk,
+		 "Number of in-band msg blks for short SGL.\n");
+
+/*
+ * alerts that could be generated from peer
+ */
+const struct bcm_vk_entry bcm_vk_peer_err[BCM_VK_PEER_ERR_NUM] = {
+	{ERR_LOG_UECC, ERR_LOG_UECC, "uecc"},
+	{ERR_LOG_SSIM_BUSY, ERR_LOG_SSIM_BUSY, "ssim_busy"},
+	{ERR_LOG_AFBC_BUSY, ERR_LOG_AFBC_BUSY, "afbc_busy"},
+	{ERR_LOG_HIGH_TEMP_ERR, ERR_LOG_HIGH_TEMP_ERR, "high_temp"},
+	{ERR_LOG_WDOG_TIMEOUT, ERR_LOG_WDOG_TIMEOUT, "wdog_timeout"},
+	{ERR_LOG_SYS_FAULT, ERR_LOG_SYS_FAULT, "sys_fault"},
+	{ERR_LOG_RAMDUMP, ERR_LOG_RAMDUMP, "ramdump"},
+	{ERR_LOG_COP_WDOG_TIMEOUT, ERR_LOG_COP_WDOG_TIMEOUT,
+	 "cop_wdog_timeout"},
+	{ERR_LOG_MEM_ALLOC_FAIL, ERR_LOG_MEM_ALLOC_FAIL, "malloc_fail warn"},
+	{ERR_LOG_LOW_TEMP_WARN, ERR_LOG_LOW_TEMP_WARN, "low_temp warn"},
+	{ERR_LOG_ECC, ERR_LOG_ECC, "ecc"},
+	{ERR_LOG_IPC_DWN, ERR_LOG_IPC_DWN, "ipc_down"},
+};
+
+/* alerts detected by the host */
+const struct bcm_vk_entry bcm_vk_host_err[BCM_VK_HOST_ERR_NUM] = {
+	{ERR_LOG_HOST_PCIE_DWN, ERR_LOG_HOST_PCIE_DWN, "PCIe_down"},
+	{ERR_LOG_HOST_HB_FAIL, ERR_LOG_HOST_HB_FAIL, "hb_fail"},
+	{ERR_LOG_HOST_INTF_V_FAIL, ERR_LOG_HOST_INTF_V_FAIL, "intf_ver_fail"},
+};
+
+irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id)
+{
+	struct bcm_vk *vk = dev_id;
+
+	if (!bcm_vk_drv_access_ok(vk)) {
+		dev_err(&vk->pdev->dev,
+			"Interrupt %d received when msgq not inited\n", irq);
+		goto skip_schedule_work;
+	}
+
+	/* if notification is not pending, set bit and schedule work */
+	if (test_and_set_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload) == 0)
+		queue_work(vk->wq_thread, &vk->wq_work);
+
+skip_schedule_work:
+	return IRQ_HANDLED;
+}
 
 static int bcm_vk_intf_ver_chk(struct bcm_vk *vk)
 {
@@ -126,6 +175,7 @@ static int bcm_vk_intf_ver_chk(struct bcm_vk *vk)
 		dev_err(dev,
 			"Intf major.minor=%d.%d rejected - drv %d.%d\n",
 			major, minor, SEMANTIC_MAJOR, SEMANTIC_MINOR);
+		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_INTF_V_FAIL);
 		ret = -EPFNOSUPPORT;
 	} else {
 		dev_dbg(dev,
@@ -135,6 +185,154 @@ static int bcm_vk_intf_ver_chk(struct bcm_vk *vk)
 	return ret;
 }
 
+static void bcm_vk_log_notf(struct bcm_vk *vk,
+			    struct bcm_vk_alert *alert,
+			    struct bcm_vk_entry const *entry_tab,
+			    const u32 table_size)
+{
+	u32 i;
+	u32 masked_val, latched_val;
+	struct bcm_vk_entry const *entry;
+	u32 reg;
+	u16 ecc_mem_err, uecc_mem_err;
+	struct device *dev = &vk->pdev->dev;
+
+	for (i = 0; i < table_size; i++) {
+		entry = &entry_tab[i];
+		masked_val = entry->mask & alert->notfs;
+		latched_val = entry->mask & alert->flags;
+
+		if (masked_val == ERR_LOG_UECC) {
+			/*
+			 * if there is difference between stored cnt and it
+			 * is greater than threshold, log it.
+			 */
+			reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
+			BCM_VK_EXTRACT_FIELD(uecc_mem_err, reg,
+					     BCM_VK_MEM_ERR_FIELD_MASK,
+					     BCM_VK_UECC_MEM_ERR_SHIFT);
+			if ((uecc_mem_err != vk->alert_cnts.uecc) &&
+			    (uecc_mem_err >= BCM_VK_UECC_THRESHOLD))
+				dev_info(dev,
+					 "ALERT! %s.%d uecc RAISED - ErrCnt %d\n",
+					 DRV_MODULE_NAME, vk->devid,
+					 uecc_mem_err);
+			vk->alert_cnts.uecc = uecc_mem_err;
+		} else if (masked_val == ERR_LOG_ECC) {
+			reg = vkread32(vk, BAR_0, BAR_CARD_ERR_MEM);
+			BCM_VK_EXTRACT_FIELD(ecc_mem_err, reg,
+					     BCM_VK_MEM_ERR_FIELD_MASK,
+					     BCM_VK_ECC_MEM_ERR_SHIFT);
+			if ((ecc_mem_err != vk->alert_cnts.ecc) &&
+			    (ecc_mem_err >= BCM_VK_ECC_THRESHOLD))
+				dev_info(dev, "ALERT! %s.%d ecc RAISED - ErrCnt %d\n",
+					 DRV_MODULE_NAME, vk->devid,
+					 ecc_mem_err);
+			vk->alert_cnts.ecc = ecc_mem_err;
+		} else if (masked_val != latched_val) {
+			/* print a log as info */
+			dev_info(dev, "ALERT! %s.%d %s %s\n",
+				 DRV_MODULE_NAME, vk->devid, entry->str,
+				 masked_val ? "RAISED" : "CLEARED");
+		}
+	}
+}
+
+static void bcm_vk_dump_peer_log(struct bcm_vk *vk)
+{
+	struct bcm_vk_peer_log log;
+	struct bcm_vk_peer_log *log_info = &vk->peerlog_info;
+	char loc_buf[BCM_VK_PEER_LOG_LINE_MAX];
+	int cnt;
+	struct device *dev = &vk->pdev->dev;
+	unsigned int data_offset;
+
+	memcpy_fromio(&log, vk->bar[BAR_2] + vk->peerlog_off, sizeof(log));
+
+	dev_dbg(dev, "Peer PANIC: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
+		log.buf_size, log.mask, log.rd_idx, log.wr_idx);
+
+	if (!log_info->buf_size) {
+		dev_err(dev, "Peer log dump disabled - skipped!\n");
+		return;
+	}
+
+	/* perform range checking for rd/wr idx */
+	if ((log.rd_idx > log_info->mask) ||
+	    (log.wr_idx > log_info->mask) ||
+	    (log.buf_size != log_info->buf_size) ||
+	    (log.mask != log_info->mask)) {
+		dev_err(dev,
+			"Corrupted Ptrs: Size 0x%x(0x%x) Mask 0x%x(0x%x) [Rd Wr] = [%d %d], skip log dump.\n",
+			log_info->buf_size, log.buf_size,
+			log_info->mask, log.mask,
+			log.rd_idx, log.wr_idx);
+		return;
+	}
+
+	cnt = 0;
+	data_offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log);
+	loc_buf[BCM_VK_PEER_LOG_LINE_MAX - 1] = '\0';
+	while (log.rd_idx != log.wr_idx) {
+		loc_buf[cnt] = vkread8(vk, BAR_2, data_offset + log.rd_idx);
+
+		if ((loc_buf[cnt] == '\0') ||
+		    (cnt == (BCM_VK_PEER_LOG_LINE_MAX - 1))) {
+			dev_err(dev, "%s", loc_buf);
+			cnt = 0;
+		} else {
+			cnt++;
+		}
+		log.rd_idx = (log.rd_idx + 1) & log.mask;
+	}
+	/* update rd idx at the end */
+	vkwrite32(vk, log.rd_idx, BAR_2,
+		  vk->peerlog_off + offsetof(struct bcm_vk_peer_log, rd_idx));
+}
+
+void bcm_vk_handle_notf(struct bcm_vk *vk)
+{
+	u32 reg;
+	struct bcm_vk_alert alert;
+	bool intf_down;
+	unsigned long flags;
+
+	/* handle peer alerts and then locally detected ones */
+	reg = vkread32(vk, BAR_0, BAR_CARD_ERR_LOG);
+	intf_down = BCM_VK_INTF_IS_DOWN(reg);
+	if (!intf_down) {
+		vk->peer_alert.notfs = reg;
+		bcm_vk_log_notf(vk, &vk->peer_alert, bcm_vk_peer_err,
+				ARRAY_SIZE(bcm_vk_peer_err));
+		vk->peer_alert.flags = vk->peer_alert.notfs;
+	} else {
+		/* turn off access */
+		bcm_vk_blk_drv_access(vk);
+	}
+
+	/* check and make copy of alert with lock and then free lock */
+	spin_lock_irqsave(&vk->host_alert_lock, flags);
+	if (intf_down)
+		vk->host_alert.notfs |= ERR_LOG_HOST_PCIE_DWN;
+
+	alert = vk->host_alert;
+	vk->host_alert.flags = vk->host_alert.notfs;
+	spin_unlock_irqrestore(&vk->host_alert_lock, flags);
+
+	/* call display with copy */
+	bcm_vk_log_notf(vk, &alert, bcm_vk_host_err,
+			ARRAY_SIZE(bcm_vk_host_err));
+
+	/*
+	 * If it is a sys fault or heartbeat timeout, we would like extract
+	 * log msg from the card so that we would know what is the last fault
+	 */
+	if (!intf_down &&
+	    ((vk->host_alert.flags & ERR_LOG_HOST_HB_FAIL) ||
+	     (vk->peer_alert.flags & ERR_LOG_SYS_FAULT)))
+		bcm_vk_dump_peer_log(vk);
+}
+
 static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
 			      u64 offset, u32 mask, u32 value,
 			      unsigned long timeout_ms)
@@ -301,6 +499,31 @@ static int bcm_vk_sync_card_info(struct bcm_vk *vk)
 	return 0;
 }
 
+void bcm_vk_blk_drv_access(struct bcm_vk *vk)
+{
+	int i;
+
+	/*
+	 * kill all the apps
+	 */
+	spin_lock(&vk->ctx_lock);
+
+	/* set msgq_inited to 0 so that all rd/wr will be blocked */
+	atomic_set(&vk->msgq_inited, 0);
+
+	for (i = 0; i < VK_PID_HT_SZ; i++) {
+		struct bcm_vk_ctx *ctx;
+
+		list_for_each_entry(ctx, &vk->pid_ht[i].head, node) {
+			dev_dbg(&vk->pdev->dev,
+				"Send kill signal to pid %d\n",
+				ctx->pid);
+			kill_pid(find_vpid(ctx->pid), SIGKILL, 1);
+		}
+	}
+	spin_unlock(&vk->ctx_lock);
+}
+
 static void bcm_vk_buf_notify(struct bcm_vk *vk, void *bufp,
 			      dma_addr_t host_buf_addr, u32 buf_size)
 {
@@ -518,6 +741,17 @@ static int bcm_vk_load_image_by_type(struct bcm_vk *vk, u32 load_type,
 				goto err_firmware_out;
 			}
 
+			/*
+			 * Next, initialize Message Q if we are loading boot2.
+			 * Do a force sync
+			 */
+			ret = bcm_vk_sync_msgq(vk, true);
+			if (ret) {
+				dev_err(dev, "Boot2 Error reading comm msg Q info\n");
+				ret = -EIO;
+				goto err_firmware_out;
+			}
+
 			/* sync & channel other info */
 			ret = bcm_vk_sync_card_info(vk);
 			if (ret) {
@@ -668,12 +902,20 @@ static int bcm_vk_trigger_autoload(struct bcm_vk *vk)
 }
 
 /*
- * deferred work queue for auto download.
+ * deferred work queue for draining and auto download.
  */
 static void bcm_vk_wq_handler(struct work_struct *work)
 {
 	struct bcm_vk *vk = container_of(work, struct bcm_vk, wq_work);
+	struct device *dev = &vk->pdev->dev;
+	s32 ret;
 
+	/* check wq offload bit map to perform various operations */
+	if (test_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload)) {
+		/* clear bit right the way for notification */
+		clear_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload);
+		bcm_vk_handle_notf(vk);
+	}
 	if (test_bit(BCM_VK_WQ_DWNLD_AUTO, vk->wq_offload)) {
 		bcm_vk_auto_load_all_images(vk);
 
@@ -684,6 +926,14 @@ static void bcm_vk_wq_handler(struct work_struct *work)
 		clear_bit(BCM_VK_WQ_DWNLD_AUTO, vk->wq_offload);
 		clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
 	}
+
+	/* next, try to drain */
+	ret = bcm_to_h_msg_dequeue(vk);
+
+	if (ret == 0)
+		dev_dbg(dev, "Spurious trigger for workqueue\n");
+	else if (ret < 0)
+		bcm_vk_blk_drv_access(vk);
 }
 
 static long bcm_vk_load_image(struct bcm_vk *vk,
@@ -837,6 +1087,9 @@ static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations bcm_vk_fops = {
 	.owner = THIS_MODULE,
 	.open = bcm_vk_open,
+	.read = bcm_vk_read,
+	.write = bcm_vk_write,
+	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
 	.unlocked_ioctl = bcm_vk_ioctl,
 };
@@ -869,6 +1122,12 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 
 	kref_init(&vk->kref);
+	if (nr_ib_sgl_blk > BCM_VK_IB_SGL_BLK_MAX) {
+		dev_warn(dev, "Inband SGL blk %d limited to max %d\n",
+			 nr_ib_sgl_blk, BCM_VK_IB_SGL_BLK_MAX);
+		nr_ib_sgl_blk = BCM_VK_IB_SGL_BLK_MAX;
+	}
+	vk->ib_sgl_size = nr_ib_sgl_blk * VK_MSGQ_BLK_SIZE;
 	mutex_init(&vk->mutex);
 
 	err = pci_enable_device(pdev);
@@ -932,11 +1191,34 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	for (vk->num_irqs = 0;
+	     vk->num_irqs < VK_MSIX_MSGQ_MAX;
+	     vk->num_irqs++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
+				       bcm_vk_msgq_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, vk);
+		if (err) {
+			dev_err(dev, "failed to request msgq IRQ %d for MSIX %d\n",
+				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
+			goto err_irq;
+		}
+	}
+	/* one irq for notification from VK */
+	err = devm_request_irq(dev, pci_irq_vector(pdev, vk->num_irqs),
+			       bcm_vk_notf_irqhandler,
+			       IRQF_SHARED, DRV_MODULE_NAME, vk);
+	if (err) {
+		dev_err(dev, "failed to request notf IRQ %d for MSIX %d\n",
+			pdev->irq + vk->num_irqs, vk->num_irqs + 1);
+		goto err_irq;
+	}
+	vk->num_irqs++;
+
 	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "unable to get id\n");
-		goto err_iounmap;
+		goto err_irq;
 	}
 
 	vk->devid = id;
@@ -966,6 +1248,12 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_misc_deregister;
 	}
 
+	err = bcm_vk_msg_init(vk);
+	if (err) {
+		dev_err(dev, "failed to init msg queue info\n");
+		goto err_destroy_workqueue;
+	}
+
 	/* sync other info */
 	bcm_vk_sync_card_info(vk);
 
@@ -994,6 +1282,9 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	/* enable hb */
+	bcm_vk_hb_init(vk);
+
 	dev_dbg(dev, "BCM-VK:%u created\n", id);
 
 	return 0;
@@ -1015,6 +1306,13 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_ida_remove:
 	ida_simple_remove(&bcm_vk_ida, id);
 
+err_irq:
+	for (i = 0; i < vk->num_irqs; i++)
+		devm_free_irq(dev, pci_irq_vector(pdev, i), vk);
+
+	pci_disable_msix(pdev);
+	pci_disable_msi(pdev);
+
 err_iounmap:
 	for (i = 0; i < MAX_BAR; i++) {
 		if (vk->bar[i])
@@ -1053,6 +1351,8 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	struct bcm_vk *vk = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &vk->miscdev;
 
+	bcm_vk_hb_deinit(vk);
+
 	/*
 	 * Trigger a reset to card and wait enough time for UCODE to rerun,
 	 * which re-initialize the card into its default state.
@@ -1076,6 +1376,11 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 		kfree(misc_device->name);
 		ida_simple_remove(&bcm_vk_ida, vk->devid);
 	}
+	for (i = 0; i < vk->num_irqs; i++)
+		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
+
+	pci_disable_msix(pdev);
+	pci_disable_msi(pdev);
 
 	cancel_work_sync(&vk->wq_work);
 	destroy_workqueue(vk->wq_thread);
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 2d9a6b4e5f61..b05e20a72a8b 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -3,8 +3,200 @@
  * Copyright 2018-2020 Broadcom.
  */
 
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/hash.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/sizes.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+
 #include "bcm_vk.h"
 #include "bcm_vk_msg.h"
+#include "bcm_vk_sg.h"
+
+/* functions to manipulate the transport id in msg block */
+#define BCM_VK_MSG_Q_SHIFT	 4
+#define BCM_VK_MSG_Q_MASK	 0xF
+#define BCM_VK_MSG_ID_MASK	 0xFFF
+
+#define BCM_VK_DMA_DRAIN_MAX_MS	  2000
+
+/* number x q_size will be the max number of msg processed per loop */
+#define BCM_VK_MSG_PROC_MAX_LOOP 2
+
+/* module parameter */
+static bool hb_mon = true;
+module_param(hb_mon, bool, 0444);
+MODULE_PARM_DESC(hb_mon, "Monitoring heartbeat continuously.\n");
+static int batch_log = 1;
+module_param(batch_log, int, 0444);
+MODULE_PARM_DESC(batch_log, "Max num of logs per batch operation.\n");
+
+static bool hb_mon_is_on(void)
+{
+	return hb_mon;
+}
+
+static u32 get_q_num(const struct vk_msg_blk *msg)
+{
+	u32 q_num = msg->trans_id & BCM_VK_MSG_Q_MASK;
+
+	if (q_num >= VK_MSGQ_PER_CHAN_MAX)
+		q_num = VK_MSGQ_NUM_DEFAULT;
+	return q_num;
+}
+
+static void set_q_num(struct vk_msg_blk *msg, u32 q_num)
+{
+	msg->trans_id = (msg->trans_id & ~BCM_VK_MSG_Q_MASK) |
+		(q_num >= VK_MSGQ_PER_CHAN_MAX) ? VK_MSGQ_NUM_DEFAULT : q_num;
+}
+
+static u32 get_msg_id(const struct vk_msg_blk *msg)
+{
+	return ((msg->trans_id >> BCM_VK_MSG_Q_SHIFT) & BCM_VK_MSG_ID_MASK);
+}
+
+static void set_msg_id(struct vk_msg_blk *msg, u32 val)
+{
+	msg->trans_id = (val << BCM_VK_MSG_Q_SHIFT) | get_q_num(msg);
+}
+
+static u32 msgq_inc(const struct bcm_vk_sync_qinfo *qinfo, u32 idx, u32 inc)
+{
+	return ((idx + inc) & qinfo->q_mask);
+}
+
+static
+struct vk_msg_blk __iomem *msgq_blk_addr(const struct bcm_vk_sync_qinfo *qinfo,
+					 u32 idx)
+{
+	return qinfo->q_start + (VK_MSGQ_BLK_SIZE * idx);
+}
+
+static u32 msgq_occupied(const struct bcm_vk_msgq __iomem *msgq,
+			 const struct bcm_vk_sync_qinfo *qinfo)
+{
+	u32 wr_idx, rd_idx;
+
+	wr_idx = readl_relaxed(&msgq->wr_idx);
+	rd_idx = readl_relaxed(&msgq->rd_idx);
+
+	return ((wr_idx - rd_idx) & qinfo->q_mask);
+}
+
+static
+u32 msgq_avail_space(const struct bcm_vk_msgq __iomem *msgq,
+		     const struct bcm_vk_sync_qinfo *qinfo)
+{
+	return (qinfo->q_size - msgq_occupied(msgq, qinfo) - 1);
+}
+
+/* number of retries when enqueue message fails before returning EAGAIN */
+#define BCM_VK_H2VK_ENQ_RETRY 10
+#define BCM_VK_H2VK_ENQ_RETRY_DELAY_MS 50
+
+bool bcm_vk_drv_access_ok(struct bcm_vk *vk)
+{
+	return (!!atomic_read(&vk->msgq_inited));
+}
+
+void bcm_vk_set_host_alert(struct bcm_vk *vk, u32 bit_mask)
+{
+	struct bcm_vk_alert *alert = &vk->host_alert;
+	unsigned long flags;
+
+	/* use irqsave version as this maybe called inside timer interrupt */
+	spin_lock_irqsave(&vk->host_alert_lock, flags);
+	alert->notfs |= bit_mask;
+	spin_unlock_irqrestore(&vk->host_alert_lock, flags);
+
+	if (test_and_set_bit(BCM_VK_WQ_NOTF_PEND, vk->wq_offload) == 0)
+		queue_work(vk->wq_thread, &vk->wq_work);
+}
+
+/*
+ * Heartbeat related defines
+ * The heartbeat from host is a last resort.  If stuck condition happens
+ * on the card, firmware is supposed to detect it.  Therefore, the heartbeat
+ * values used will be more relaxed on the driver, which need to be bigger
+ * than the watchdog timeout on the card.  The watchdog timeout on the card
+ * is 20s, with a jitter of 2s => 22s.  We use a value of 27s here.
+ */
+#define BCM_VK_HB_TIMER_S 3
+#define BCM_VK_HB_TIMER_VALUE (BCM_VK_HB_TIMER_S * HZ)
+#define BCM_VK_HB_LOST_MAX (27 / BCM_VK_HB_TIMER_S)
+
+static void bcm_vk_hb_poll(struct timer_list *t)
+{
+	u32 uptime_s;
+	struct bcm_vk_hb_ctrl *hb = container_of(t, struct bcm_vk_hb_ctrl,
+						 timer);
+	struct bcm_vk *vk = container_of(hb, struct bcm_vk, hb_ctrl);
+
+	if (bcm_vk_drv_access_ok(vk) && hb_mon_is_on()) {
+		/* read uptime from register and compare */
+		uptime_s = vkread32(vk, BAR_0, BAR_OS_UPTIME);
+
+		if (uptime_s == hb->last_uptime)
+			hb->lost_cnt++;
+		else /* reset to avoid accumulation */
+			hb->lost_cnt = 0;
+
+		dev_dbg(&vk->pdev->dev, "Last uptime %d current %d, lost %d\n",
+			hb->last_uptime, uptime_s, hb->lost_cnt);
+
+		/*
+		 * if the interface goes down without any activity, a value
+		 * of 0xFFFFFFFF will be continuously read, and the detection
+		 * will be happened eventually.
+		 */
+		hb->last_uptime = uptime_s;
+	} else {
+		/* reset heart beat lost cnt */
+		hb->lost_cnt = 0;
+	}
+
+	/* next, check if heartbeat exceeds limit */
+	if (hb->lost_cnt > BCM_VK_HB_LOST_MAX) {
+		dev_err(&vk->pdev->dev, "Heartbeat Misses %d times, %d s!\n",
+			BCM_VK_HB_LOST_MAX,
+			BCM_VK_HB_LOST_MAX * BCM_VK_HB_TIMER_S);
+
+		bcm_vk_blk_drv_access(vk);
+		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_HB_FAIL);
+	}
+	/* re-arm timer */
+	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
+}
+
+void bcm_vk_hb_init(struct bcm_vk *vk)
+{
+	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
+
+	timer_setup(&hb->timer, bcm_vk_hb_poll, 0);
+	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
+}
+
+void bcm_vk_hb_deinit(struct bcm_vk *vk)
+{
+	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
+
+	del_timer(&hb->timer);
+}
+
+static void bcm_vk_msgid_bitmap_clear(struct bcm_vk *vk,
+				      unsigned int start,
+				      unsigned int nbits)
+{
+	spin_lock(&vk->msg_id_lock);
+	bitmap_clear(vk->bmap, start, nbits);
+	spin_unlock(&vk->msg_id_lock);
+}
 
 /*
  * allocate a ctx per file struct
@@ -39,12 +231,47 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 	/* increase kref */
 	kref_get(&vk->kref);
 
+	/* clear counter */
+	atomic_set(&ctx->pend_cnt, 0);
+	atomic_set(&ctx->dma_cnt, 0);
+	init_waitqueue_head(&ctx->rd_wq);
+
 all_in_use_exit:
 	spin_unlock(&vk->ctx_lock);
 
 	return ctx;
 }
 
+static u16 bcm_vk_get_msg_id(struct bcm_vk *vk)
+{
+	u16 rc = VK_MSG_ID_OVERFLOW;
+	u16 test_bit_count = 0;
+
+	spin_lock(&vk->msg_id_lock);
+	while (test_bit_count < (VK_MSG_ID_BITMAP_SIZE - 1)) {
+		/*
+		 * first time come in this loop, msg_id will be 0
+		 * and the first one tested will be 1.  We skip
+		 * VK_SIMPLEX_MSG_ID (0) for one way host2vk
+		 * communication
+		 */
+		vk->msg_id++;
+		if (vk->msg_id == VK_MSG_ID_BITMAP_SIZE)
+			vk->msg_id = 1;
+
+		if (test_bit(vk->msg_id, vk->bmap)) {
+			test_bit_count++;
+			continue;
+		}
+		rc = vk->msg_id;
+		bitmap_set(vk->bmap, vk->msg_id, 1);
+		break;
+	}
+	spin_unlock(&vk->msg_id_lock);
+
+	return rc;
+}
+
 static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
 {
 	u32 idx;
@@ -82,6 +309,636 @@ static int bcm_vk_free_ctx(struct bcm_vk *vk, struct bcm_vk_ctx *ctx)
 	return count;
 }
 
+static void bcm_vk_free_wkent(struct device *dev, struct bcm_vk_wkent *entry)
+{
+	int proc_cnt;
+
+	bcm_vk_sg_free(dev, entry->dma, VK_DMA_MAX_ADDRS, &proc_cnt);
+	if (proc_cnt)
+		atomic_dec(&entry->ctx->dma_cnt);
+
+	kfree(entry->to_h_msg);
+	kfree(entry);
+}
+
+static void bcm_vk_drain_all_pend(struct device *dev,
+				  struct bcm_vk_msg_chan *chan,
+				  struct bcm_vk_ctx *ctx)
+{
+	u32 num;
+	struct bcm_vk_wkent *entry, *tmp;
+	struct bcm_vk *vk;
+	struct list_head del_q;
+
+	if (ctx)
+		vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+
+	INIT_LIST_HEAD(&del_q);
+	spin_lock(&chan->pendq_lock);
+	for (num = 0; num < chan->q_nr; num++) {
+		list_for_each_entry_safe(entry, tmp, &chan->pendq[num], node) {
+			if ((!ctx) || (entry->ctx->idx == ctx->idx)) {
+				list_del(&entry->node);
+				list_add_tail(&entry->node, &del_q);
+			}
+		}
+	}
+	spin_unlock(&chan->pendq_lock);
+
+	/* batch clean up */
+	num = 0;
+	list_for_each_entry_safe(entry, tmp, &del_q, node) {
+		list_del(&entry->node);
+		num++;
+		if (ctx) {
+			struct vk_msg_blk *msg;
+			int bit_set;
+			bool responded;
+			u32 msg_id;
+
+			/* if it is specific ctx, log for any stuck */
+			msg = entry->to_v_msg;
+			msg_id = get_msg_id(msg);
+			bit_set = test_bit(msg_id, vk->bmap);
+			responded = entry->to_h_msg ? true : false;
+			if (num <= batch_log)
+				dev_info(dev,
+					 "Drained: fid %u size %u msg 0x%x(seq-%x) ctx 0x%x[fd-%d] args:[0x%x 0x%x] resp %s, bmap %d\n",
+					 msg->function_id, msg->size,
+					 msg_id, entry->seq_num,
+					 msg->context_id, entry->ctx->idx,
+					 msg->cmd, msg->arg,
+					 responded ? "T" : "F", bit_set);
+			if (responded)
+				atomic_dec(&ctx->pend_cnt);
+			else if (bit_set)
+				bcm_vk_msgid_bitmap_clear(vk, msg_id, 1);
+		}
+		bcm_vk_free_wkent(dev, entry);
+	}
+	if (num && ctx)
+		dev_info(dev, "Total drained items %d [fd-%d]\n",
+			 num, ctx->idx);
+}
+
+/*
+ * Function to sync up the messages queue info that is provided by BAR1
+ */
+int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync)
+{
+	struct bcm_vk_msgq __iomem *msgq;
+	struct device *dev = &vk->pdev->dev;
+	u32 msgq_off;
+	u32 num_q;
+	struct bcm_vk_msg_chan *chan_list[] = {&vk->to_v_msg_chan,
+					       &vk->to_h_msg_chan};
+	struct bcm_vk_msg_chan *chan;
+	int i, j;
+	int ret = 0;
+
+	/*
+	 * If the driver is loaded at startup where vk OS is not up yet,
+	 * the msgq-info may not be available until a later time.  In
+	 * this case, we skip and the sync function is supposed to be
+	 * called again.
+	 */
+	if (!bcm_vk_msgq_marker_valid(vk)) {
+		dev_info(dev, "BAR1 msgq marker not initialized.\n");
+		return -EAGAIN;
+	}
+
+	msgq_off = vkread32(vk, BAR_1, VK_BAR1_MSGQ_CTRL_OFF);
+
+	/* each side is always half the total  */
+	num_q = vkread32(vk, BAR_1, VK_BAR1_MSGQ_NR) / 2;
+	if (!num_q || (num_q > VK_MSGQ_PER_CHAN_MAX)) {
+		dev_err(dev,
+			"Advertised msgq %d error - max %d allowed\n",
+			num_q, VK_MSGQ_PER_CHAN_MAX);
+		return -EINVAL;
+	}
+
+	vk->to_v_msg_chan.q_nr = num_q;
+	vk->to_h_msg_chan.q_nr = num_q;
+
+	/* first msgq location */
+	msgq = vk->bar[BAR_1] + msgq_off;
+
+	/*
+	 * if this function is called when it is already inited,
+	 * something is wrong
+	 */
+	if (bcm_vk_drv_access_ok(vk) && !force_sync) {
+		dev_err(dev, "Msgq info already in sync\n");
+		return -EPERM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(chan_list); i++) {
+		chan = chan_list[i];
+		memset(chan->sync_qinfo, 0, sizeof(chan->sync_qinfo));
+
+		for (j = 0; j < num_q; j++) {
+			struct bcm_vk_sync_qinfo *qinfo;
+			u32 msgq_start;
+			u32 msgq_size;
+			u32 msgq_nxt;
+			u32 msgq_db_offset, q_db_offset;
+
+			chan->msgq[j] = msgq;
+			msgq_start = readl_relaxed(&msgq->start);
+			msgq_size = readl_relaxed(&msgq->size);
+			msgq_nxt = readl_relaxed(&msgq->nxt);
+			msgq_db_offset = readl_relaxed(&msgq->db_offset);
+			q_db_offset = (msgq_db_offset & ((1 << DB_SHIFT) - 1));
+			if (q_db_offset  == (~msgq_db_offset >> DB_SHIFT))
+				msgq_db_offset = q_db_offset;
+			else
+				/* fall back to default */
+				msgq_db_offset = VK_BAR0_Q_DB_BASE(j);
+
+			dev_info(dev,
+				 "MsgQ[%d] type %d num %d, @ 0x%x, db_offset 0x%x rd_idx %d wr_idx %d, size %d, nxt 0x%x\n",
+				 j,
+				 readw_relaxed(&msgq->type),
+				 readw_relaxed(&msgq->num),
+				 msgq_start,
+				 msgq_db_offset,
+				 readl_relaxed(&msgq->rd_idx),
+				 readl_relaxed(&msgq->wr_idx),
+				 msgq_size,
+				 msgq_nxt);
+
+			qinfo = &chan->sync_qinfo[j];
+			/* formulate and record static info */
+			qinfo->q_start = vk->bar[BAR_1] + msgq_start;
+			qinfo->q_size = msgq_size;
+			/* set low threshold as 50% or 1/2 */
+			qinfo->q_low = qinfo->q_size >> 1;
+			qinfo->q_mask = qinfo->q_size - 1;
+			qinfo->q_db_offset = msgq_db_offset;
+
+			msgq++;
+		}
+	}
+	atomic_set(&vk->msgq_inited, 1);
+
+	return ret;
+}
+
+static int bcm_vk_msg_chan_init(struct bcm_vk_msg_chan *chan)
+{
+	u32 i;
+
+	mutex_init(&chan->msgq_mutex);
+	spin_lock_init(&chan->pendq_lock);
+	for (i = 0; i < VK_MSGQ_MAX_NR; i++)
+		INIT_LIST_HEAD(&chan->pendq[i]);
+
+	return 0;
+}
+
+static void bcm_vk_append_pendq(struct bcm_vk_msg_chan *chan, u16 q_num,
+				struct bcm_vk_wkent *entry)
+{
+	struct bcm_vk_ctx *ctx;
+
+	spin_lock(&chan->pendq_lock);
+	list_add_tail(&entry->node, &chan->pendq[q_num]);
+	if (entry->to_h_msg) {
+		ctx = entry->ctx;
+		atomic_inc(&ctx->pend_cnt);
+		wake_up_interruptible(&ctx->rd_wq);
+	}
+	spin_unlock(&chan->pendq_lock);
+}
+
+static u32 bcm_vk_append_ib_sgl(struct bcm_vk *vk,
+				struct bcm_vk_wkent *entry,
+				struct _vk_data *data,
+				unsigned int num_planes)
+{
+	unsigned int i;
+	unsigned int item_cnt = 0;
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_msg_chan *chan = &vk->to_v_msg_chan;
+	struct vk_msg_blk *msg = &entry->to_v_msg[0];
+	struct bcm_vk_msgq __iomem *msgq;
+	struct bcm_vk_sync_qinfo *qinfo;
+	u32 ib_sgl_size = 0;
+	u8 *buf = (u8 *)&entry->to_v_msg[entry->to_v_blks];
+	u32 avail;
+	u32 q_num;
+
+	/* check if high watermark is hit, and if so, skip */
+	q_num = get_q_num(msg);
+	msgq = chan->msgq[q_num];
+	qinfo = &chan->sync_qinfo[q_num];
+	avail = msgq_avail_space(msgq, qinfo);
+	if (avail < qinfo->q_low) {
+		dev_dbg(dev, "Skip inserting inband SGL, [0x%x/0x%x]\n",
+			avail, qinfo->q_size);
+		return 0;
+	}
+
+	for (i = 0; i < num_planes; i++) {
+		if (data[i].address &&
+		    (ib_sgl_size + data[i].size) <= vk->ib_sgl_size) {
+			item_cnt++;
+			memcpy(buf, entry->dma[i].sglist, data[i].size);
+			ib_sgl_size += data[i].size;
+			buf += data[i].size;
+		}
+	}
+
+	dev_dbg(dev, "Num %u sgl items appended, size 0x%x, room 0x%x\n",
+		item_cnt, ib_sgl_size, vk->ib_sgl_size);
+
+	/* round up size */
+	ib_sgl_size = (ib_sgl_size + VK_MSGQ_BLK_SIZE - 1)
+		       >> VK_MSGQ_BLK_SZ_SHIFT;
+
+	return ib_sgl_size;
+}
+
+void bcm_to_v_q_doorbell(struct bcm_vk *vk, u32 q_num, u32 db_val)
+{
+	struct bcm_vk_msg_chan *chan = &vk->to_v_msg_chan;
+	struct bcm_vk_sync_qinfo *qinfo = &chan->sync_qinfo[q_num];
+
+	vkwrite32(vk, db_val, BAR_0, qinfo->q_db_offset);
+}
+
+static int bcm_to_v_msg_enqueue(struct bcm_vk *vk, struct bcm_vk_wkent *entry)
+{
+	static u32 seq_num;
+	struct bcm_vk_msg_chan *chan = &vk->to_v_msg_chan;
+	struct device *dev = &vk->pdev->dev;
+	struct vk_msg_blk *src = &entry->to_v_msg[0];
+
+	struct vk_msg_blk __iomem *dst;
+	struct bcm_vk_msgq __iomem *msgq;
+	struct bcm_vk_sync_qinfo *qinfo;
+	u32 q_num = get_q_num(src);
+	u32 wr_idx; /* local copy */
+	u32 i;
+	u32 avail;
+	u32 retry;
+
+	if (entry->to_v_blks != src->size + 1) {
+		dev_err(dev, "number of blks %d not matching %d MsgId[0x%x]: func %d ctx 0x%x\n",
+			entry->to_v_blks,
+			src->size + 1,
+			get_msg_id(src),
+			src->function_id,
+			src->context_id);
+		return -EMSGSIZE;
+	}
+
+	msgq = chan->msgq[q_num];
+	qinfo = &chan->sync_qinfo[q_num];
+
+	mutex_lock(&chan->msgq_mutex);
+
+	avail = msgq_avail_space(msgq, qinfo);
+
+	/* if not enough space, return EAGAIN and let app handles it */
+	retry = 0;
+	while ((avail < entry->to_v_blks) &&
+	       (retry++ < BCM_VK_H2VK_ENQ_RETRY)) {
+		mutex_unlock(&chan->msgq_mutex);
+
+		msleep(BCM_VK_H2VK_ENQ_RETRY_DELAY_MS);
+		mutex_lock(&chan->msgq_mutex);
+		avail = msgq_avail_space(msgq, qinfo);
+	}
+	if (retry > BCM_VK_H2VK_ENQ_RETRY) {
+		mutex_unlock(&chan->msgq_mutex);
+		return -EAGAIN;
+	}
+
+	/* at this point, mutex is taken and there is enough space */
+	entry->seq_num = seq_num++; /* update debug seq number */
+	wr_idx = readl_relaxed(&msgq->wr_idx);
+
+	if (wr_idx >= qinfo->q_size) {
+		dev_crit(dev, "Invalid wr_idx 0x%x => max 0x%x!",
+			 wr_idx, qinfo->q_size);
+		bcm_vk_blk_drv_access(vk);
+		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_PCIE_DWN);
+		goto idx_err;
+	}
+
+	dst = msgq_blk_addr(qinfo, wr_idx);
+	for (i = 0; i < entry->to_v_blks; i++) {
+		memcpy_toio(dst, src, sizeof(*dst));
+
+		src++;
+		wr_idx = msgq_inc(qinfo, wr_idx, 1);
+		dst = msgq_blk_addr(qinfo, wr_idx);
+	}
+
+	/* flush the write pointer */
+	writel(wr_idx, &msgq->wr_idx);
+
+	/* log new info for debugging */
+	dev_dbg(dev,
+		"MsgQ[%d] [Rd Wr] = [%d %d] blks inserted %d - Q = [u-%d a-%d]/%d\n",
+		readl_relaxed(&msgq->num),
+		readl_relaxed(&msgq->rd_idx),
+		wr_idx,
+		entry->to_v_blks,
+		msgq_occupied(msgq, qinfo),
+		msgq_avail_space(msgq, qinfo),
+		readl_relaxed(&msgq->size));
+	/*
+	 * press door bell based on queue number. 1 is added to the wr_idx
+	 * to avoid the value of 0 appearing on the VK side to distinguish
+	 * from initial value.
+	 */
+	bcm_to_v_q_doorbell(vk, q_num, wr_idx + 1);
+idx_err:
+	mutex_unlock(&chan->msgq_mutex);
+	return 0;
+}
+
+int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
+			     const pid_t pid, const u32 q_num)
+{
+	int rc = 0;
+	struct bcm_vk_wkent *entry;
+	struct device *dev = &vk->pdev->dev;
+
+	/*
+	 * check if the marker is still good.  Sometimes, the PCIe interface may
+	 * have gone done, and if so and we ship down thing based on broken
+	 * values, kernel may panic.
+	 */
+	if (!bcm_vk_msgq_marker_valid(vk)) {
+		dev_info(dev, "PCIe comm chan - invalid marker (0x%x)!\n",
+			 vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY));
+		return -EINVAL;
+	}
+
+	entry = kzalloc(sizeof(*entry) +
+			sizeof(struct vk_msg_blk), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	/* fill up necessary data */
+	entry->to_v_msg[0].function_id = VK_FID_SHUTDOWN;
+	set_q_num(&entry->to_v_msg[0], q_num);
+	set_msg_id(&entry->to_v_msg[0], VK_SIMPLEX_MSG_ID);
+	entry->to_v_blks = 1; /* always 1 block */
+
+	entry->to_v_msg[0].cmd = shut_type;
+	entry->to_v_msg[0].arg = pid;
+
+	rc = bcm_to_v_msg_enqueue(vk, entry);
+	if (rc)
+		dev_err(dev,
+			"Sending shutdown message to q %d for pid %d fails.\n",
+			get_q_num(&entry->to_v_msg[0]), pid);
+
+	kfree(entry);
+
+	return rc;
+}
+
+static int bcm_vk_handle_last_sess(struct bcm_vk *vk, const pid_t pid,
+				   const u32 q_num)
+{
+	int rc = 0;
+	struct device *dev = &vk->pdev->dev;
+
+	/*
+	 * don't send down or do anything if message queue is not initialized
+	 */
+	if (!bcm_vk_drv_access_ok(vk))
+		return -EPERM;
+
+	dev_dbg(dev, "No more sessions, shut down pid %d\n", pid);
+
+	rc = bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_PID, pid, q_num);
+
+	return rc;
+}
+
+static struct bcm_vk_wkent *bcm_vk_dequeue_pending(struct bcm_vk *vk,
+						   struct bcm_vk_msg_chan *chan,
+						   u16 q_num,
+						   u16 msg_id)
+{
+	bool found = false;
+	struct bcm_vk_wkent *entry;
+
+	spin_lock(&chan->pendq_lock);
+	list_for_each_entry(entry, &chan->pendq[q_num], node) {
+		if (get_msg_id(&entry->to_v_msg[0]) == msg_id) {
+			list_del(&entry->node);
+			found = true;
+			bcm_vk_msgid_bitmap_clear(vk, msg_id, 1);
+			break;
+		}
+	}
+	spin_unlock(&chan->pendq_lock);
+	return ((found) ? entry : NULL);
+}
+
+s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_msg_chan *chan = &vk->to_h_msg_chan;
+	struct vk_msg_blk *data;
+	struct vk_msg_blk __iomem *src;
+	struct vk_msg_blk *dst;
+	struct bcm_vk_msgq __iomem *msgq;
+	struct bcm_vk_sync_qinfo *qinfo;
+	struct bcm_vk_wkent *entry;
+	u32 rd_idx, wr_idx;
+	u32 q_num, msg_id, j;
+	u32 num_blks;
+	s32 total = 0;
+	int cnt = 0;
+	int msg_processed = 0;
+	int max_msg_to_process;
+	bool exit_loop;
+
+	/*
+	 * drain all the messages from the queues, and find its pending
+	 * entry in the to_v queue, based on msg_id & q_num, and move the
+	 * entry to the to_h pending queue, waiting for user space
+	 * program to extract
+	 */
+	mutex_lock(&chan->msgq_mutex);
+
+	for (q_num = 0; q_num < chan->q_nr; q_num++) {
+		msgq = chan->msgq[q_num];
+		qinfo = &chan->sync_qinfo[q_num];
+		max_msg_to_process = BCM_VK_MSG_PROC_MAX_LOOP * qinfo->q_size;
+
+		rd_idx = readl_relaxed(&msgq->rd_idx);
+		wr_idx = readl_relaxed(&msgq->wr_idx);
+		msg_processed = 0;
+		exit_loop = false;
+		while ((rd_idx != wr_idx) && !exit_loop) {
+			u8 src_size;
+
+			/*
+			 * Make a local copy and get pointer to src blk
+			 * The rd_idx is masked before getting the pointer to
+			 * avoid out of bound access in case the interface goes
+			 * down.  It will end up pointing to the last block in
+			 * the buffer, but subsequent src->size check would be
+			 * able to catch this.
+			 */
+			src = msgq_blk_addr(qinfo, rd_idx & qinfo->q_mask);
+			src_size = readb(&src->size);
+
+			if ((rd_idx >= qinfo->q_size) ||
+			    (src_size > (qinfo->q_size - 1))) {
+				dev_crit(dev,
+					 "Invalid rd_idx 0x%x or size 0x%x => max 0x%x!",
+					 rd_idx, src_size, qinfo->q_size);
+				bcm_vk_blk_drv_access(vk);
+				bcm_vk_set_host_alert(vk,
+						      ERR_LOG_HOST_PCIE_DWN);
+				goto idx_err;
+			}
+
+			num_blks = src_size + 1;
+			data = kzalloc(num_blks * VK_MSGQ_BLK_SIZE, GFP_KERNEL);
+			if (data) {
+				/* copy messages and linearize it */
+				dst = data;
+				for (j = 0; j < num_blks; j++) {
+					memcpy_fromio(dst, src, sizeof(*dst));
+
+					dst++;
+					rd_idx = msgq_inc(qinfo, rd_idx, 1);
+					src = msgq_blk_addr(qinfo, rd_idx);
+				}
+				total++;
+			} else {
+				/*
+				 * if we could not allocate memory in kernel,
+				 * that is fatal.
+				 */
+				dev_crit(dev, "Kernel mem allocation failure.\n");
+				return -ENOMEM;
+			}
+
+			/* flush rd pointer after a message is dequeued */
+			writel(rd_idx, &msgq->rd_idx);
+
+			/* log new info for debugging */
+			dev_dbg(dev,
+				"MsgQ[%d] [Rd Wr] = [%d %d] blks extracted %d - Q = [u-%d a-%d]/%d\n",
+				readl_relaxed(&msgq->num),
+				rd_idx,
+				wr_idx,
+				num_blks,
+				msgq_occupied(msgq, qinfo),
+				msgq_avail_space(msgq, qinfo),
+				readl_relaxed(&msgq->size));
+
+			/*
+			 * No need to search if it is an autonomous one-way
+			 * message from driver, as these messages do not bear
+			 * a to_v pending item. Currently, only the shutdown
+			 * message falls into this category.
+			 */
+			if (data->function_id == VK_FID_SHUTDOWN) {
+				kfree(data);
+				continue;
+			}
+
+			msg_id = get_msg_id(data);
+			/* lookup original message in to_v direction */
+			entry = bcm_vk_dequeue_pending(vk,
+						       &vk->to_v_msg_chan,
+						       q_num,
+						       msg_id);
+
+			/*
+			 * if there is message to does not have prior send,
+			 * this is the location to add here
+			 */
+			if (entry) {
+				entry->to_h_blks = num_blks;
+				entry->to_h_msg = data;
+				bcm_vk_append_pendq(&vk->to_h_msg_chan,
+						    q_num, entry);
+
+			} else {
+				if (cnt++ < batch_log)
+					dev_info(dev,
+						 "Could not find MsgId[0x%x] for resp func %d bmap %d\n",
+						 msg_id, data->function_id,
+						 test_bit(msg_id, vk->bmap));
+				kfree(data);
+			}
+			/* Fetch wr_idx to handle more back-to-back events */
+			wr_idx = readl(&msgq->wr_idx);
+
+			/*
+			 * cap the max so that even we try to handle more back-to-back events,
+			 * so that it won't hold CPU too long or in case rd/wr idexes are
+			 * corrupted which triggers infinite looping.
+			 */
+			if (++msg_processed >= max_msg_to_process) {
+				dev_warn(dev, "Q[%d] Per loop processing exceeds %d\n",
+					 q_num, max_msg_to_process);
+				exit_loop = true;
+			}
+		}
+	}
+idx_err:
+	mutex_unlock(&chan->msgq_mutex);
+	dev_dbg(dev, "total %d drained from queues\n", total);
+
+	return total;
+}
+
+/*
+ * init routine for all required data structures
+ */
+static int bcm_vk_data_init(struct bcm_vk *vk)
+{
+	int i;
+
+	spin_lock_init(&vk->ctx_lock);
+	for (i = 0; i < ARRAY_SIZE(vk->ctx); i++) {
+		vk->ctx[i].in_use = false;
+		vk->ctx[i].idx = i;	/* self identity */
+		vk->ctx[i].miscdev = NULL;
+	}
+	spin_lock_init(&vk->msg_id_lock);
+	spin_lock_init(&vk->host_alert_lock);
+	vk->msg_id = 0;
+
+	/* initialize hash table */
+	for (i = 0; i < VK_PID_HT_SZ; i++)
+		INIT_LIST_HEAD(&vk->pid_ht[i].head);
+
+	return 0;
+}
+
+irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id)
+{
+	struct bcm_vk *vk = dev_id;
+
+	if (!bcm_vk_drv_access_ok(vk)) {
+		dev_err(&vk->pdev->dev,
+			"Interrupt %d received when msgq not inited\n", irq);
+		goto skip_schedule_work;
+	}
+
+	queue_work(vk->wq_thread, &vk->wq_work);
+
+skip_schedule_work:
+	return IRQ_HANDLED;
+}
+
 int bcm_vk_open(struct inode *inode, struct file *p_file)
 {
 	struct bcm_vk_ctx *ctx;
@@ -112,16 +969,346 @@ int bcm_vk_open(struct inode *inode, struct file *p_file)
 	return rc;
 }
 
+ssize_t bcm_vk_read(struct file *p_file,
+		    char __user *buf,
+		    size_t count,
+		    loff_t *f_pos)
+{
+	ssize_t rc = -ENOMSG;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
+					 miscdev);
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_msg_chan *chan = &vk->to_h_msg_chan;
+	struct bcm_vk_wkent *entry = NULL;
+	u32 q_num;
+	u32 rsp_length;
+	bool found = false;
+
+	if (!bcm_vk_drv_access_ok(vk))
+		return -EPERM;
+
+	dev_dbg(dev, "Buf count %zu\n", count);
+	found = false;
+
+	/*
+	 * search through the pendq on the to_h chan, and return only those
+	 * that belongs to the same context.  Search is always from the high to
+	 * the low priority queues
+	 */
+	spin_lock(&chan->pendq_lock);
+	for (q_num = 0; q_num < chan->q_nr; q_num++) {
+		list_for_each_entry(entry, &chan->pendq[q_num], node) {
+			if (entry->ctx->idx == ctx->idx) {
+				if (count >=
+				    (entry->to_h_blks * VK_MSGQ_BLK_SIZE)) {
+					list_del(&entry->node);
+					atomic_dec(&ctx->pend_cnt);
+					found = true;
+				} else {
+					/* buffer not big enough */
+					rc = -EMSGSIZE;
+				}
+				goto read_loop_exit;
+			}
+		}
+	}
+read_loop_exit:
+	spin_unlock(&chan->pendq_lock);
+
+	if (found) {
+		/* retrieve the passed down msg_id */
+		set_msg_id(&entry->to_h_msg[0], entry->usr_msg_id);
+		rsp_length = entry->to_h_blks * VK_MSGQ_BLK_SIZE;
+		if (copy_to_user(buf, entry->to_h_msg, rsp_length) == 0)
+			rc = rsp_length;
+
+		bcm_vk_free_wkent(dev, entry);
+	} else if (rc == -EMSGSIZE) {
+		struct vk_msg_blk tmp_msg = entry->to_h_msg[0];
+
+		/*
+		 * in this case, return just the first block, so
+		 * that app knows what size it is looking for.
+		 */
+		set_msg_id(&tmp_msg, entry->usr_msg_id);
+		tmp_msg.size = entry->to_h_blks - 1;
+		if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
+			dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
+			rc = -EFAULT;
+		}
+	}
+	return rc;
+}
+
+ssize_t bcm_vk_write(struct file *p_file,
+		     const char __user *buf,
+		     size_t count,
+		     loff_t *f_pos)
+{
+	ssize_t rc;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk,
+					 miscdev);
+	struct bcm_vk_msgq __iomem *msgq;
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_wkent *entry;
+	u32 sgl_extra_blks;
+	u32 q_num;
+	u32 msg_size;
+	u32 msgq_size;
+
+	if (!bcm_vk_drv_access_ok(vk))
+		return -EPERM;
+
+	dev_dbg(dev, "Msg count %zu\n", count);
+
+	/* first, do sanity check where count should be multiple of basic blk */
+	if (count & (VK_MSGQ_BLK_SIZE - 1)) {
+		dev_err(dev, "Failure with size %zu not multiple of %zu\n",
+			count, VK_MSGQ_BLK_SIZE);
+		rc = -EINVAL;
+		goto write_err;
+	}
+
+	/* allocate the work entry + buffer for size count and inband sgl */
+	entry = kzalloc(sizeof(*entry) + count + vk->ib_sgl_size,
+			GFP_KERNEL);
+	if (!entry) {
+		rc = -ENOMEM;
+		goto write_err;
+	}
+
+	/* now copy msg from user space, and then formulate the work entry */
+	if (copy_from_user(&entry->to_v_msg[0], buf, count)) {
+		rc = -EFAULT;
+		goto write_free_ent;
+	}
+
+	entry->to_v_blks = count >> VK_MSGQ_BLK_SZ_SHIFT;
+	entry->ctx = ctx;
+
+	/* do a check on the blk size which could not exceed queue space */
+	q_num = get_q_num(&entry->to_v_msg[0]);
+	msgq = vk->to_v_msg_chan.msgq[q_num];
+	msgq_size = readl_relaxed(&msgq->size);
+	if (entry->to_v_blks + (vk->ib_sgl_size >> VK_MSGQ_BLK_SZ_SHIFT)
+	    > (msgq_size - 1)) {
+		dev_err(dev, "Blk size %d exceed max queue size allowed %d\n",
+			entry->to_v_blks, msgq_size - 1);
+		rc = -EINVAL;
+		goto write_free_ent;
+	}
+
+	/* Use internal message id */
+	entry->usr_msg_id = get_msg_id(&entry->to_v_msg[0]);
+	rc = bcm_vk_get_msg_id(vk);
+	if (rc == VK_MSG_ID_OVERFLOW) {
+		dev_err(dev, "msg_id overflow\n");
+		rc = -EOVERFLOW;
+		goto write_free_ent;
+	}
+	set_msg_id(&entry->to_v_msg[0], rc);
+	ctx->q_num = q_num;
+
+	dev_dbg(dev,
+		"[Q-%d]Message ctx id %d, usr_msg_id 0x%x sent msg_id 0x%x\n",
+		ctx->q_num, ctx->idx, entry->usr_msg_id,
+		get_msg_id(&entry->to_v_msg[0]));
+
+	if (entry->to_v_msg[0].function_id == VK_FID_TRANS_BUF) {
+		/* Convert any pointers to sg list */
+		unsigned int num_planes;
+		int dir;
+		struct _vk_data *data;
+
+		num_planes = entry->to_v_msg[0].cmd & VK_CMD_PLANES_MASK;
+		if ((entry->to_v_msg[0].cmd & VK_CMD_MASK) == VK_CMD_DOWNLOAD)
+			dir = DMA_FROM_DEVICE;
+		else
+			dir = DMA_TO_DEVICE;
+
+		/* Calculate vk_data location */
+		/* Go to end of the message */
+		msg_size = entry->to_v_msg[0].size;
+		if (msg_size > entry->to_v_blks) {
+			rc = -EMSGSIZE;
+			goto write_free_msgid;
+		}
+
+		data = (struct _vk_data *)&entry->to_v_msg[msg_size + 1];
+
+		/* Now back up to the start of the pointers */
+		data -= num_planes;
+
+		/* Convert user addresses to DMA SG List */
+		rc = bcm_vk_sg_alloc(dev, entry->dma, dir, data, num_planes);
+		if (rc)
+			goto write_free_msgid;
+
+		atomic_inc(&ctx->dma_cnt);
+		/* try to embed inband sgl */
+		sgl_extra_blks = bcm_vk_append_ib_sgl(vk, entry, data,
+						      num_planes);
+		entry->to_v_blks += sgl_extra_blks;
+		entry->to_v_msg[0].size += sgl_extra_blks;
+	} else if (entry->to_v_msg[0].function_id == VK_FID_INIT &&
+		   entry->to_v_msg[0].context_id == VK_NEW_CTX) {
+		/*
+		 * Init happens in 2 stages, only the first stage contains the
+		 * pid that needs translating.
+		 */
+		pid_t org_pid, pid;
+
+		/*
+		 * translate the pid into the unique host space as user
+		 * may run sessions inside containers or process
+		 * namespaces.
+		 */
+#define VK_MSG_PID_MASK 0xffffff00
+#define VK_MSG_PID_SH   8
+		org_pid = (entry->to_v_msg[0].arg & VK_MSG_PID_MASK)
+			   >> VK_MSG_PID_SH;
+
+		pid = task_tgid_nr(current);
+		entry->to_v_msg[0].arg =
+			(entry->to_v_msg[0].arg & ~VK_MSG_PID_MASK) |
+			(pid << VK_MSG_PID_SH);
+		if (org_pid != pid)
+			dev_dbg(dev, "In PID 0x%x(%d), converted PID 0x%x(%d)\n",
+				org_pid, org_pid, pid, pid);
+	}
+
+	/*
+	 * store work entry to pending queue until a response is received.
+	 * This needs to be done before enqueuing the message
+	 */
+	bcm_vk_append_pendq(&vk->to_v_msg_chan, q_num, entry);
+
+	rc = bcm_to_v_msg_enqueue(vk, entry);
+	if (rc) {
+		dev_err(dev, "Fail to enqueue msg to to_v queue\n");
+
+		/* remove message from pending list */
+		entry = bcm_vk_dequeue_pending
+			       (vk,
+				&vk->to_v_msg_chan,
+				q_num,
+				get_msg_id(&entry->to_v_msg[0]));
+		goto write_free_ent;
+	}
+
+	return count;
+
+write_free_msgid:
+	bcm_vk_msgid_bitmap_clear(vk, get_msg_id(&entry->to_v_msg[0]), 1);
+write_free_ent:
+	kfree(entry);
+write_err:
+	return rc;
+}
+
+__poll_t bcm_vk_poll(struct file *p_file, struct poll_table_struct *wait)
+{
+	__poll_t ret = 0;
+	int cnt;
+	struct bcm_vk_ctx *ctx = p_file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	struct device *dev = &vk->pdev->dev;
+
+	poll_wait(p_file, &ctx->rd_wq, wait);
+
+	cnt = atomic_read(&ctx->pend_cnt);
+	if (cnt) {
+		ret = (__force __poll_t)(POLLIN | POLLRDNORM);
+		if (cnt < 0) {
+			dev_err(dev, "Error cnt %d, setting back to 0", cnt);
+			atomic_set(&ctx->pend_cnt, 0);
+		}
+	}
+
+	return ret;
+}
+
 int bcm_vk_release(struct inode *inode, struct file *p_file)
 {
 	int ret;
 	struct bcm_vk_ctx *ctx = p_file->private_data;
 	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	struct device *dev = &vk->pdev->dev;
+	pid_t pid = ctx->pid;
+	int dma_cnt;
+	unsigned long timeout, start_time;
+
+	/*
+	 * if there are outstanding DMA transactions, need to delay long enough
+	 * to ensure that the card side would have stopped touching the host buffer
+	 * and its SGL list.  A race condition could happen if the host app is killed
+	 * abruptly, eg kill -9, while some DMA transfer orders are still inflight.
+	 * Nothing could be done except for a delay as host side is running in a
+	 * completely async fashion.
+	 */
+	start_time = jiffies;
+	timeout = start_time + msecs_to_jiffies(BCM_VK_DMA_DRAIN_MAX_MS);
+	do {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(dev, "%d dma still pending for [fd-%d] pid %d\n",
+				 dma_cnt, ctx->idx, pid);
+			break;
+		}
+		dma_cnt = atomic_read(&ctx->dma_cnt);
+		cpu_relax();
+		cond_resched();
+	} while (dma_cnt);
+	dev_dbg(dev, "Draining for [fd-%d] pid %d - delay %d ms\n",
+		ctx->idx, pid, jiffies_to_msecs(jiffies - start_time));
+
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->to_v_msg_chan, ctx);
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->to_h_msg_chan, ctx);
 
 	ret = bcm_vk_free_ctx(vk, ctx);
+	if (ret == 0)
+		ret = bcm_vk_handle_last_sess(vk, pid, ctx->q_num);
+	else
+		ret = 0;
 
 	kref_put(&vk->kref, bcm_vk_release_data);
 
 	return ret;
 }
 
+int bcm_vk_msg_init(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	int ret;
+
+	if (bcm_vk_data_init(vk)) {
+		dev_err(dev, "Error initializing internal data structures\n");
+		return -EINVAL;
+	}
+
+	if (bcm_vk_msg_chan_init(&vk->to_v_msg_chan) ||
+	    bcm_vk_msg_chan_init(&vk->to_h_msg_chan)) {
+		dev_err(dev, "Error initializing communication channel\n");
+		return -EIO;
+	}
+
+	/* read msgq info if ready */
+	ret = bcm_vk_sync_msgq(vk, false);
+	if (ret && (ret != -EAGAIN)) {
+		dev_err(dev, "Error reading comm msg Q info\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void bcm_vk_msg_remove(struct bcm_vk *vk)
+{
+	bcm_vk_blk_drv_access(vk);
+
+	/* drain all pending items */
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->to_v_msg_chan, NULL);
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->to_h_msg_chan, NULL);
+}
+
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
index 32516abcaf89..4eaad84825d6 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.h
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
@@ -6,6 +6,78 @@
 #ifndef BCM_VK_MSG_H
 #define BCM_VK_MSG_H
 
+#include <uapi/linux/misc/bcm_vk.h>
+#include "bcm_vk_sg.h"
+
+/* Single message queue control structure */
+struct bcm_vk_msgq {
+	u16 type;	/* queue type */
+	u16 num;	/* queue number */
+	u32 start;	/* offset in BAR1 where the queue memory starts */
+
+	u32 rd_idx; /* read idx */
+	u32 wr_idx; /* write idx */
+
+	u32 size;	/*
+			 * size, which is in number of 16byte blocks,
+			 * to align with the message data structure.
+			 */
+	u32 nxt;	/*
+			 * nxt offset to the next msg queue struct.
+			 * This is to provide flexibity for alignment purposes.
+			 */
+
+/* Least significant 16 bits in below field hold doorbell register offset */
+#define DB_SHIFT 16
+
+	u32 db_offset; /* queue doorbell register offset in BAR0 */
+
+	u32 rsvd;
+};
+
+/*
+ * Structure to record static info from the msgq sync.  We keep local copy
+ * for some of these variables for both performance + checking purpose.
+ */
+struct bcm_vk_sync_qinfo {
+	void __iomem *q_start;
+	u32 q_size;
+	u32 q_mask;
+	u32 q_low;
+	u32 q_db_offset;
+};
+
+#define VK_MSGQ_MAX_NR 4 /* Maximum number of message queues */
+
+/*
+ * message block - basic unit in the message where a message's size is always
+ *		   N x sizeof(basic_block)
+ */
+struct vk_msg_blk {
+	u8 function_id;
+#define VK_FID_TRANS_BUF	5
+#define VK_FID_SHUTDOWN		8
+#define VK_FID_INIT		9
+	u8 size; /* size of the message in number of vk_msg_blk's */
+	u16 trans_id; /* transport id, queue & msg_id */
+	u32 context_id;
+#define VK_NEW_CTX		0
+	u32 cmd;
+#define VK_CMD_PLANES_MASK	0x000f /* number of planes to up/download */
+#define VK_CMD_UPLOAD		0x0400 /* memory transfer to vk */
+#define VK_CMD_DOWNLOAD		0x0500 /* memory transfer from vk */
+#define VK_CMD_MASK		0x0f00 /* command mask */
+	u32 arg;
+};
+
+/* vk_msg_blk is 16 bytes fixed */
+#define VK_MSGQ_BLK_SIZE   (sizeof(struct vk_msg_blk))
+/* shift for fast division of basic msg blk size */
+#define VK_MSGQ_BLK_SZ_SHIFT 4
+
+/* use msg_id 0 for any simplex host2vk communication */
+#define VK_SIMPLEX_MSG_ID 0
+
 /* context per session opening of sysfs */
 struct bcm_vk_ctx {
 	struct list_head node; /* use for linkage in Hash Table */
@@ -13,7 +85,11 @@ struct bcm_vk_ctx {
 	bool in_use;
 	pid_t pid;
 	u32 hash_idx;
+	u32 q_num; /* queue number used by the stream */
 	struct miscdevice *miscdev;
+	atomic_t pend_cnt; /* number of items pending to be read from host */
+	atomic_t dma_cnt; /* any dma transaction outstanding */
+	wait_queue_head_t rd_wq;
 };
 
 /* pid hash table entry */
@@ -21,6 +97,55 @@ struct bcm_vk_ht_entry {
 	struct list_head head;
 };
 
+#define VK_DMA_MAX_ADDRS 4 /* Max 4 DMA Addresses */
+/* structure for house keeping a single work entry */
+struct bcm_vk_wkent {
+	struct list_head node; /* for linking purpose */
+	struct bcm_vk_ctx *ctx;
+
+	/* Store up to 4 dma pointers */
+	struct bcm_vk_dma dma[VK_DMA_MAX_ADDRS];
+
+	u32 to_h_blks; /* response */
+	struct vk_msg_blk *to_h_msg;
+
+	/*
+	 * put the to_v_msg at the end so that we could simply append to_v msg
+	 * to the end of the allocated block
+	 */
+	u32 usr_msg_id;
+	u32 to_v_blks;
+	u32 seq_num;
+	struct vk_msg_blk to_v_msg[0];
+};
+
+/* queue stats counters */
+struct bcm_vk_qs_cnts {
+	u32 cnt; /* general counter, used to limit output */
+	u32 acc_sum;
+	u32 max_occ; /* max during a sampling period */
+	u32 max_abs; /* the abs max since reset */
+};
+
+/* control channel structure for either to_v or to_h communication */
+struct bcm_vk_msg_chan {
+	u32 q_nr;
+	/* Mutex to access msgq */
+	struct mutex msgq_mutex;
+	/* pointing to BAR locations */
+	struct bcm_vk_msgq __iomem *msgq[VK_MSGQ_MAX_NR];
+	/* Spinlock to access pending queue */
+	spinlock_t pendq_lock;
+	/* for temporary storing pending items, one for each queue */
+	struct list_head pendq[VK_MSGQ_MAX_NR];
+	/* static queue info from the sync */
+	struct bcm_vk_sync_qinfo sync_qinfo[VK_MSGQ_MAX_NR];
+};
+
+/* totol number of message q allowed by the driver */
+#define VK_MSGQ_PER_CHAN_MAX	3
+#define VK_MSGQ_NUM_DEFAULT	(VK_MSGQ_PER_CHAN_MAX - 1)
+
 /* total number of supported ctx, 32 ctx each for 5 components */
 #define VK_CMPT_CTX_MAX		(32 * 5)
 
@@ -28,4 +153,11 @@ struct bcm_vk_ht_entry {
 #define VK_PID_HT_SHIFT_BIT	7 /* 128 */
 #define VK_PID_HT_SZ		BIT(VK_PID_HT_SHIFT_BIT)
 
+/* The following are offsets of DDR info provided by the vk card */
+#define VK_BAR0_SEG_SIZE	(4 * SZ_1K) /* segment size for BAR0 */
+
+/* shutdown types supported */
+#define VK_SHUTDOWN_PID		1
+#define VK_SHUTDOWN_GRACEFUL	2
+
 #endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.c b/drivers/misc/bcm-vk/bcm_vk_sg.c
new file mode 100644
index 000000000000..2e9daaf3e492
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_sg.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/pgtable.h>
+#include <linux/vmalloc.h>
+
+#include <asm/page.h>
+#include <asm/unaligned.h>
+
+#include <uapi/linux/misc/bcm_vk.h>
+
+#include "bcm_vk.h"
+#include "bcm_vk_msg.h"
+#include "bcm_vk_sg.h"
+
+/*
+ * Valkyrie has a hardware limitation of 16M transfer size.
+ * So limit the SGL chunks to 16M.
+ */
+#define BCM_VK_MAX_SGL_CHUNK SZ_16M
+
+static int bcm_vk_dma_alloc(struct device *dev,
+			    struct bcm_vk_dma *dma,
+			    int dir,
+			    struct _vk_data *vkdata);
+static int bcm_vk_dma_free(struct device *dev, struct bcm_vk_dma *dma);
+
+/* Uncomment to dump SGLIST */
+/* #define BCM_VK_DUMP_SGLIST */
+
+static int bcm_vk_dma_alloc(struct device *dev,
+			    struct bcm_vk_dma *dma,
+			    int direction,
+			    struct _vk_data *vkdata)
+{
+	dma_addr_t addr, sg_addr;
+	int err;
+	int i;
+	int offset;
+	u32 size;
+	u32 remaining_size;
+	u32 transfer_size;
+	u64 data;
+	unsigned long first, last;
+	struct _vk_data *sgdata;
+
+	/* Get 64-bit user address */
+	data = get_unaligned(&vkdata->address);
+
+	/* offset into first page */
+	offset = offset_in_page(data);
+
+	/* Calculate number of pages */
+	first = (data & PAGE_MASK) >> PAGE_SHIFT;
+	last  = ((data + vkdata->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	dma->nr_pages = last - first + 1;
+
+	/* Allocate DMA pages */
+	dma->pages = kmalloc_array(dma->nr_pages,
+				   sizeof(struct page *),
+				   GFP_KERNEL);
+	if (!dma->pages)
+		return -ENOMEM;
+
+	dev_dbg(dev, "Alloc DMA Pages [0x%llx+0x%x => %d pages]\n",
+		data, vkdata->size, dma->nr_pages);
+
+	dma->direction = direction;
+
+	/* Get user pages into memory */
+	err = get_user_pages_fast(data & PAGE_MASK,
+				  dma->nr_pages,
+				  direction == DMA_FROM_DEVICE,
+				  dma->pages);
+	if (err != dma->nr_pages) {
+		dma->nr_pages = (err >= 0) ? err : 0;
+		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
+			err, dma->nr_pages);
+		return err < 0 ? err : -EINVAL;
+	}
+
+	/* Max size of sg list is 1 per mapped page + fields at start */
+	dma->sglen = (dma->nr_pages * sizeof(*sgdata)) +
+		     (sizeof(u32) * SGLIST_VKDATA_START);
+
+	/* Allocate sglist */
+	dma->sglist = dma_alloc_coherent(dev,
+					 dma->sglen,
+					 &dma->handle,
+					 GFP_KERNEL);
+	if (!dma->sglist)
+		return -ENOMEM;
+
+	dma->sglist[SGLIST_NUM_SG] = 0;
+	dma->sglist[SGLIST_TOTALSIZE] = vkdata->size;
+	remaining_size = vkdata->size;
+	sgdata = (struct _vk_data *)&dma->sglist[SGLIST_VKDATA_START];
+
+	/* Map all pages into DMA */
+	size = min_t(size_t, PAGE_SIZE - offset, remaining_size);
+	remaining_size -= size;
+	sg_addr = dma_map_page(dev,
+			       dma->pages[0],
+			       offset,
+			       size,
+			       dma->direction);
+	transfer_size = size;
+	if (unlikely(dma_mapping_error(dev, sg_addr))) {
+		__free_page(dma->pages[0]);
+		return -EIO;
+	}
+
+	for (i = 1; i < dma->nr_pages; i++) {
+		size = min_t(size_t, PAGE_SIZE, remaining_size);
+		remaining_size -= size;
+		addr = dma_map_page(dev,
+				    dma->pages[i],
+				    0,
+				    size,
+				    dma->direction);
+		if (unlikely(dma_mapping_error(dev, addr))) {
+			__free_page(dma->pages[i]);
+			return -EIO;
+		}
+
+		/*
+		 * Compress SG list entry when pages are contiguous
+		 * and transfer size less or equal to BCM_VK_MAX_SGL_CHUNK
+		 */
+		if ((addr == (sg_addr + transfer_size)) &&
+		    ((transfer_size + size) <= BCM_VK_MAX_SGL_CHUNK)) {
+			/* pages are contiguous, add to same sg entry */
+			transfer_size += size;
+		} else {
+			/* pages are not contiguous, write sg entry */
+			sgdata->size = transfer_size;
+			put_unaligned(sg_addr, (u64 *)&sgdata->address);
+			dma->sglist[SGLIST_NUM_SG]++;
+
+			/* start new sg entry */
+			sgdata++;
+			sg_addr = addr;
+			transfer_size = size;
+		}
+	}
+	/* Write last sg list entry */
+	sgdata->size = transfer_size;
+	put_unaligned(sg_addr, (u64 *)&sgdata->address);
+	dma->sglist[SGLIST_NUM_SG]++;
+
+	/* Update pointers and size field to point to sglist */
+	put_unaligned((u64)dma->handle, &vkdata->address);
+	vkdata->size = (dma->sglist[SGLIST_NUM_SG] * sizeof(*sgdata)) +
+		       (sizeof(u32) * SGLIST_VKDATA_START);
+
+#ifdef BCM_VK_DUMP_SGLIST
+	dev_dbg(dev,
+		"sgl 0x%llx handle 0x%llx, sglen: 0x%x sgsize: 0x%x\n",
+		(u64)dma->sglist,
+		dma->handle,
+		dma->sglen,
+		vkdata->size);
+	for (i = 0; i < vkdata->size / sizeof(u32); i++)
+		dev_dbg(dev, "i:0x%x 0x%x\n", i, dma->sglist[i]);
+#endif
+
+	return 0;
+}
+
+int bcm_vk_sg_alloc(struct device *dev,
+		    struct bcm_vk_dma *dma,
+		    int dir,
+		    struct _vk_data *vkdata,
+		    int num)
+{
+	int i;
+	int rc = -EINVAL;
+
+	/* Convert user addresses to DMA SG List */
+	for (i = 0; i < num; i++) {
+		if (vkdata[i].size && vkdata[i].address) {
+			/*
+			 * If both size and address are non-zero
+			 * then DMA alloc.
+			 */
+			rc = bcm_vk_dma_alloc(dev,
+					      &dma[i],
+					      dir,
+					      &vkdata[i]);
+		} else if (vkdata[i].size ||
+			   vkdata[i].address) {
+			/*
+			 * If one of size and address are zero
+			 * there is a problem.
+			 */
+			dev_err(dev,
+				"Invalid vkdata %x 0x%x 0x%llx\n",
+				i, vkdata[i].size, vkdata[i].address);
+			rc = -EINVAL;
+		} else {
+			/*
+			 * If size and address are both zero
+			 * don't convert, but return success.
+			 */
+			rc = 0;
+		}
+
+		if (rc)
+			goto fail_alloc;
+	}
+	return rc;
+
+fail_alloc:
+	while (i > 0) {
+		i--;
+		if (dma[i].sglist)
+			bcm_vk_dma_free(dev, &dma[i]);
+	}
+	return rc;
+}
+
+static int bcm_vk_dma_free(struct device *dev, struct bcm_vk_dma *dma)
+{
+	dma_addr_t addr;
+	int i;
+	int num_sg;
+	u32 size;
+	struct _vk_data *vkdata;
+
+	dev_dbg(dev, "free sglist=%p sglen=0x%x\n", dma->sglist, dma->sglen);
+
+	/* Unmap all pages in the sglist */
+	num_sg = dma->sglist[SGLIST_NUM_SG];
+	vkdata = (struct _vk_data *)&dma->sglist[SGLIST_VKDATA_START];
+	for (i = 0; i < num_sg; i++) {
+		size = vkdata[i].size;
+		addr = get_unaligned(&vkdata[i].address);
+
+		dma_unmap_page(dev, addr, size, dma->direction);
+	}
+
+	/* Free allocated sglist */
+	dma_free_coherent(dev, dma->sglen, dma->sglist, dma->handle);
+
+	/* Release lock on all pages */
+	for (i = 0; i < dma->nr_pages; i++)
+		put_page(dma->pages[i]);
+
+	/* Free allocated dma pages */
+	kfree(dma->pages);
+	dma->sglist = NULL;
+
+	return 0;
+}
+
+int bcm_vk_sg_free(struct device *dev, struct bcm_vk_dma *dma, int num,
+		   int *proc_cnt)
+{
+	int i;
+
+	*proc_cnt = 0;
+	/* Unmap and free all pages and sglists */
+	for (i = 0; i < num; i++) {
+		if (dma[i].sglist) {
+			bcm_vk_dma_free(dev, &dma[i]);
+			*proc_cnt += 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.h b/drivers/misc/bcm-vk/bcm_vk_sg.h
new file mode 100644
index 000000000000..81b3d0976ddb
--- /dev/null
+++ b/drivers/misc/bcm-vk/bcm_vk_sg.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef BCM_VK_SG_H
+#define BCM_VK_SG_H
+
+#include <linux/dma-mapping.h>
+
+struct bcm_vk_dma {
+	/* for userland buffer */
+	struct page **pages;
+	int nr_pages;
+
+	/* common */
+	dma_addr_t handle;
+	/*
+	 * sglist is of the following LE format
+	 * [U32] num_sg  = number of sg addresses (N)
+	 * [U32] totalsize = totalsize of data being transferred in sglist
+	 * [U32] size[0] = size of data in address0
+	 * [U32] addr_l[0] = lower 32-bits of address0
+	 * [U32] addr_h[0] = higher 32-bits of address0
+	 * ..
+	 * [U32] size[N-1] = size of data in addressN-1
+	 * [U32] addr_l[N-1] = lower 32-bits of addressN-1
+	 * [U32] addr_h[N-1] = higher 32-bits of addressN-1
+	 */
+	u32 *sglist;
+#define SGLIST_NUM_SG		0
+#define SGLIST_TOTALSIZE	1
+#define SGLIST_VKDATA_START	2
+
+	int sglen; /* Length (bytes) of sglist */
+	int direction;
+};
+
+struct _vk_data {
+	u32 size;    /* data size in bytes */
+	u64 address; /* Pointer to data     */
+} __packed;
+
+/*
+ * Scatter-gather DMA buffer API.
+ *
+ * These functions provide a simple way to create a page list and a
+ * scatter-gather list from userspace address and map the memory
+ * for DMA operation.
+ */
+int bcm_vk_sg_alloc(struct device *dev,
+		    struct bcm_vk_dma *dma,
+		    int dir,
+		    struct _vk_data *vkdata,
+		    int num);
+
+int bcm_vk_sg_free(struct device *dev, struct bcm_vk_dma *dma, int num,
+		   int *proc_cnt);
+
+#endif
+
-- 
2.17.1

