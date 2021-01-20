Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850A2FD834
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404468AbhATSW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:22:28 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:41000 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404230AbhATSIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:08:47 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 770B4361A3;
        Wed, 20 Jan 2021 09:58:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 770B4361A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611165518;
        bh=dZLaK3N2BN99Xs/Hv9en2iUXR3WA35ZdGwM+BSFWbmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYE+q6Yn+HXLGwgxDy5P7gvFXgCiEgNADPoRSEOesAlRdKrpupAAumYqwe2N6NBd4
         9mSSdBueTDeZ5QeZOyh0A6R7HndNk2S6Qk53czS2xYdoGMTgtiNSNOL99oWd9ekN/e
         OK4FGguNWfodEylro70NW40ip4IoNWRqLwmfxAHc=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v9 10/13] misc: bcm-vk: reset_pid support
Date:   Wed, 20 Jan 2021 09:58:24 -0800
Message-Id: <20210120175827.14820-11-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210120175827.14820-1-scott.branden@broadcom.com>
References: <20210120175827.14820-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset support via ioctl.
Kill user processes that are open when VK card is reset.
If a particular PID has issued the reset request do not kill that process
as it issued the ioctl.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/misc/bcm-vk/bcm_vk.h     |   1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c | 158 +++++++++++++++++++++++++++++--
 drivers/misc/bcm-vk/bcm_vk_msg.c |  40 +++++++-
 3 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index d847a512d0ed..a1d0bf6e694c 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -468,6 +468,7 @@ irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
 irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
 int bcm_vk_msg_init(struct bcm_vk *vk);
 void bcm_vk_msg_remove(struct bcm_vk *vk);
+void bcm_vk_drain_msg_on_reset(struct bcm_vk *vk);
 int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync);
 void bcm_vk_blk_drv_access(struct bcm_vk *vk);
 s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk);
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 5d82f02c0f27..e572a7b18fab 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -504,7 +504,9 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 	int i;
 
 	/*
-	 * kill all the apps
+	 * kill all the apps except for the process that is resetting.
+	 * If not called during reset, reset_pid will be 0, and all will be
+	 * killed.
 	 */
 	spin_lock(&vk->ctx_lock);
 
@@ -515,10 +517,12 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 		struct bcm_vk_ctx *ctx;
 
 		list_for_each_entry(ctx, &vk->pid_ht[i].head, node) {
-			dev_dbg(&vk->pdev->dev,
-				"Send kill signal to pid %d\n",
-				ctx->pid);
-			kill_pid(find_vpid(ctx->pid), SIGKILL, 1);
+			if (ctx->pid != vk->reset_pid) {
+				dev_dbg(&vk->pdev->dev,
+					"Send kill signal to pid %d\n",
+					ctx->pid);
+				kill_pid(find_vpid(ctx->pid), SIGKILL, 1);
+			}
 		}
 	}
 	spin_unlock(&vk->ctx_lock);
@@ -1001,6 +1005,49 @@ static long bcm_vk_load_image(struct bcm_vk *vk,
 	return ret;
 }
 
+static int bcm_vk_reset_successful(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	u32 fw_status, reset_reason;
+	int ret = -EAGAIN;
+
+	/*
+	 * Reset could be triggered when the card in several state:
+	 *   i)   in bootROM
+	 *   ii)  after boot1
+	 *   iii) boot2 running
+	 *
+	 * i) & ii) - no status bits will be updated.  If vkboot1
+	 * runs automatically after reset, it  will update the reason
+	 * to be unknown reason
+	 * iii) - reboot reason match + deinit done.
+	 */
+	fw_status = vkread32(vk, BAR_0, VK_BAR_FWSTS);
+	/* immediate exit if interface goes down */
+	if (BCM_VK_INTF_IS_DOWN(fw_status)) {
+		dev_err(dev, "PCIe Intf Down!\n");
+		goto reset_exit;
+	}
+
+	reset_reason = (fw_status & VK_FWSTS_RESET_REASON_MASK);
+	if ((reset_reason == VK_FWSTS_RESET_MBOX_DB) ||
+	    (reset_reason == VK_FWSTS_RESET_UNKNOWN))
+		ret = 0;
+
+	/*
+	 * if some of the deinit bits are set, but done
+	 * bit is not, this is a failure if triggered while boot2 is running
+	 */
+	if ((fw_status & VK_FWSTS_DEINIT_TRIGGERED) &&
+	    !(fw_status & VK_FWSTS_RESET_DONE))
+		ret = -EAGAIN;
+
+reset_exit:
+	dev_dbg(dev, "FW status = 0x%x ret %d\n", fw_status, ret);
+
+	return ret;
+}
+
 static void bcm_to_v_reset_doorbell(struct bcm_vk *vk, u32 db_val)
 {
 	vkwrite32(vk, db_val, BAR_0, VK_BAR0_RESET_DB_BASE);
@@ -1010,12 +1057,16 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 {
 	u32 i;
 	u32 value, boot_status;
+	bool is_stdalone, is_boot2;
 	static const u32 bar0_reg_clr_list[] = { BAR_OS_UPTIME,
 						 BAR_INTF_VER,
 						 BAR_CARD_VOLTAGE,
 						 BAR_CARD_TEMPERATURE,
 						 BAR_CARD_PWR_AND_THRE };
 
+	/* clean up before pressing the door bell */
+	bcm_vk_drain_msg_on_reset(vk);
+	vkwrite32(vk, 0, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
 	/* make tag '\0' terminated */
 	vkwrite32(vk, 0, BAR_1, VK_BAR1_BOOT1_VER_TAG);
 
@@ -1026,6 +1077,11 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	for (i = 0; i < VK_BAR1_SOTP_REVID_MAX; i++)
 		vkwrite32(vk, 0, BAR_1, VK_BAR1_SOTP_REVID_ADDR(i));
 
+	memset(&vk->card_info, 0, sizeof(vk->card_info));
+	memset(&vk->peerlog_info, 0, sizeof(vk->peerlog_info));
+	memset(&vk->proc_mon_info, 0, sizeof(vk->proc_mon_info));
+	memset(&vk->alert_cnts, 0, sizeof(vk->alert_cnts));
+
 	/*
 	 * When boot request fails, the CODE_PUSH_OFFSET stays persistent.
 	 * Allowing us to debug the failure. When we call reset,
@@ -1046,17 +1102,103 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	}
 	vkwrite32(vk, value, BAR_0, BAR_CODEPUSH_SBL);
 
+	/* special reset handling */
+	is_stdalone = boot_status & BOOT_STDALONE_RUNNING;
+	is_boot2 = (boot_status & BOOT_STATE_MASK) == BOOT2_RUNNING;
+	if (vk->peer_alert.flags & ERR_LOG_RAMDUMP) {
+		/*
+		 * if card is in ramdump mode, it is hitting an error.  Don't
+		 * reset the reboot reason as it will contain valid info that
+		 * is important - simply use special reset
+		 */
+		vkwrite32(vk, VK_BAR0_RESET_RAMPDUMP, BAR_0, VK_BAR_FWSTS);
+		return VK_BAR0_RESET_RAMPDUMP;
+	} else if (is_stdalone && !is_boot2) {
+		dev_info(&vk->pdev->dev, "Hard reset on Standalone mode");
+		bcm_to_v_reset_doorbell(vk, VK_BAR0_RESET_DB_HARD);
+		return VK_BAR0_RESET_DB_HARD;
+	}
+
 	/* reset fw_status with proper reason, and press db */
 	vkwrite32(vk, VK_FWSTS_RESET_MBOX_DB, BAR_0, VK_BAR_FWSTS);
 	bcm_to_v_reset_doorbell(vk, VK_BAR0_RESET_DB_SOFT);
 
-	/* clear other necessary registers records */
+	/* clear other necessary registers and alert records */
 	for (i = 0; i < ARRAY_SIZE(bar0_reg_clr_list); i++)
 		vkwrite32(vk, 0, BAR_0, bar0_reg_clr_list[i]);
+	memset(&vk->host_alert, 0, sizeof(vk->host_alert));
+	memset(&vk->peer_alert, 0, sizeof(vk->peer_alert));
+	/* clear 4096 bits of bitmap */
+	bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
 
 	return 0;
 }
 
+static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct vk_reset reset;
+	int ret = 0;
+	u32 ramdump_reset;
+	int special_reset;
+
+	if (copy_from_user(&reset, arg, sizeof(struct vk_reset)))
+		return -EFAULT;
+
+	/* check if any download is in-progress, if so return error */
+	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0) {
+		dev_err(dev, "Download operation pending - skip reset.\n");
+		return -EPERM;
+	}
+
+	ramdump_reset = vk->peer_alert.flags & ERR_LOG_RAMDUMP;
+	dev_info(dev, "Issue Reset %s\n",
+		 ramdump_reset ? "in ramdump mode" : "");
+
+	/*
+	 * The following is the sequence of reset:
+	 * - send card level graceful shut down
+	 * - wait enough time for VK to handle its business, stopping DMA etc
+	 * - kill host apps
+	 * - Trigger interrupt with DB
+	 */
+	bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_GRACEFUL, 0, 0);
+
+	spin_lock(&vk->ctx_lock);
+	if (!vk->reset_pid) {
+		vk->reset_pid = task_pid_nr(current);
+	} else {
+		dev_err(dev, "Reset already launched by process pid %d\n",
+			vk->reset_pid);
+		ret = -EACCES;
+	}
+	spin_unlock(&vk->ctx_lock);
+	if (ret)
+		goto err_exit;
+
+	bcm_vk_blk_drv_access(vk);
+	special_reset = bcm_vk_trigger_reset(vk);
+
+	/*
+	 * Wait enough time for card os to deinit
+	 * and populate the reset reason.
+	 */
+	msleep(BCM_VK_DEINIT_TIME_MS);
+
+	if (special_reset) {
+		/* if it is special ramdump reset, return the type to user */
+		reset.arg2 = special_reset;
+		if (copy_to_user(arg, &reset, sizeof(reset)))
+			ret = -EFAULT;
+	} else {
+		ret = bcm_vk_reset_successful(vk);
+	}
+
+err_exit:
+	clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
+	return ret;
+}
+
 static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret = -EINVAL;
@@ -1075,6 +1217,10 @@ static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = bcm_vk_load_image(vk, argp);
 		break;
 
+	case VK_IOCTL_RESET:
+		ret = bcm_vk_reset(vk, argp);
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index b05e20a72a8b..eec90494777d 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -209,6 +209,15 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 
 	spin_lock(&vk->ctx_lock);
 
+	/* check if it is in reset, if so, don't allow */
+	if (vk->reset_pid) {
+		dev_err(&vk->pdev->dev,
+			"No context allowed during reset by pid %d\n",
+			vk->reset_pid);
+
+		goto in_reset_exit;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(vk->ctx); i++) {
 		if (!vk->ctx[i].in_use) {
 			vk->ctx[i].in_use = true;
@@ -237,6 +246,7 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 	init_waitqueue_head(&ctx->rd_wq);
 
 all_in_use_exit:
+in_reset_exit:
 	spin_unlock(&vk->ctx_lock);
 
 	return ctx;
@@ -381,6 +391,12 @@ static void bcm_vk_drain_all_pend(struct device *dev,
 			 num, ctx->idx);
 }
 
+void bcm_vk_drain_msg_on_reset(struct bcm_vk *vk)
+{
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->to_v_msg_chan, NULL);
+	bcm_vk_drain_all_pend(&vk->pdev->dev, &vk->to_h_msg_chan, NULL);
+}
+
 /*
  * Function to sync up the messages queue info that is provided by BAR1
  */
@@ -712,13 +728,22 @@ static int bcm_vk_handle_last_sess(struct bcm_vk *vk, const pid_t pid,
 
 	/*
 	 * don't send down or do anything if message queue is not initialized
+	 * and if it is the reset session, clear it.
 	 */
-	if (!bcm_vk_drv_access_ok(vk))
+	if (!bcm_vk_drv_access_ok(vk)) {
+		if (vk->reset_pid == pid)
+			vk->reset_pid = 0;
 		return -EPERM;
+	}
 
 	dev_dbg(dev, "No more sessions, shut down pid %d\n", pid);
 
-	rc = bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_PID, pid, q_num);
+	/* only need to do it if it is not the reset process */
+	if (vk->reset_pid != pid)
+		rc = bcm_vk_send_shutdown_msg(vk, VK_SHUTDOWN_PID, pid, q_num);
+	else
+		/* put reset_pid to 0 if it is exiting last session */
+		vk->reset_pid = 0;
 
 	return rc;
 }
@@ -1122,6 +1147,17 @@ ssize_t bcm_vk_write(struct file *p_file,
 		int dir;
 		struct _vk_data *data;
 
+		/*
+		 * check if we are in reset, if so, no buffer transfer is
+		 * allowed and return error.
+		 */
+		if (vk->reset_pid) {
+			dev_dbg(dev, "No Transfer allowed during reset, pid %d.\n",
+				ctx->pid);
+			rc = -EACCES;
+			goto write_free_msgid;
+		}
+
 		num_planes = entry->to_v_msg[0].cmd & VK_CMD_PLANES_MASK;
 		if ((entry->to_v_msg[0].cmd & VK_CMD_MASK) == VK_CMD_DOWNLOAD)
 			dir = DMA_FROM_DEVICE;
-- 
2.17.1

