Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D07281DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgJBVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:24:56 -0400
Received: from mail-ua1-x961.google.com (mail-ua1-x961.google.com [IPv6:2607:f8b0:4864:20::961])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B5C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:24:56 -0700 (PDT)
Received: by mail-ua1-x961.google.com with SMTP id n26so757110uao.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zzfQbC+4d0K3uSz/QthMD7HB+J/E52DFj8mFz8hIh5s=;
        b=Ms2u0aONgRYe5/9Bo5nHU5ZnBHVxP/4GrwiF2BRXobNMs/ixguXkSHr8bUUfEsgSIW
         SO31HAePzK3L519Byag9bnq/BP6CXWM6xmTa8V1YMYmIKjf2lZSx6FtU7+GRbB1tT7Bq
         K3JAJ0/y8rNDTGXKT8BJeJZu1T8BjAjXT5V+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zzfQbC+4d0K3uSz/QthMD7HB+J/E52DFj8mFz8hIh5s=;
        b=C7g7ymf2G9ieT9WfxHVkLaBnUrkkloPtbj+dZehThE3p6gPMwbNfZB2p3z29E+Pb21
         L+ywDs5rksUcUHzwdlIYzmiFQAS5imSHdPo+IaHQFIo6zrNHyyaZsji/RtiNlHpivaD4
         UhLX11/fTx7JFyEMfD6N5jSu8qzKO6MadzUbZS55YvAGmCDy6JVG9qfsvlIoNIJt0FDl
         6OW/osZuasfLtA4HH9XwlUO0T+hOnjJgQTY/iwyBtRK9uYg9ivLDWnRHYwkx0KzgdPPj
         FY62cue7JW7m8pvuMAtsYiskagnzuk8HkZXpSVazVR9LfECDuksb9rZfbG6isrXHUwRS
         Ko6g==
X-Gm-Message-State: AOAM530ruhvLqaV2xn0kbGBM1EeJIkI0qU2u3AEPGriwQHQf9GAAgqWw
        Pk+T8S+8fULvwz0Zn375SOcibGeEPIX5fZzsSBqeNO6skTQK
X-Google-Smtp-Source: ABdhPJw84icNZnlZ/9cJ83+GCi3JSDDGOqPUcj28/CUgyMM4HOu1MDUuq50rfC2WSOkN6jnqlqvCp4MjXZur
X-Received: by 2002:ab0:5b86:: with SMTP id y6mr2628262uae.101.1601673895632;
        Fri, 02 Oct 2020 14:24:55 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:24:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 10/14] misc: bcm-vk: reset_pid support
Date:   Fri,  2 Oct 2020 14:23:23 -0700
Message-Id: <20201002212327.18393-11-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002212327.18393-1-scott.branden@broadcom.com>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
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
---
 drivers/misc/bcm-vk/bcm_vk.h     |   1 +
 drivers/misc/bcm-vk/bcm_vk_dev.c | 158 +++++++++++++++++++++++++++++--
 drivers/misc/bcm-vk/bcm_vk_msg.c |  40 +++++++-
 3 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 775d892f13f8..ff8cb33d9882 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -462,6 +462,7 @@ irqreturn_t bcm_vk_msgq_irqhandler(int irq, void *dev_id);
 irqreturn_t bcm_vk_notf_irqhandler(int irq, void *dev_id);
 int bcm_vk_msg_init(struct bcm_vk *vk);
 void bcm_vk_msg_remove(struct bcm_vk *vk);
+void bcm_vk_drain_msg_on_reset(struct bcm_vk *vk);
 int bcm_vk_sync_msgq(struct bcm_vk *vk, bool force_sync);
 void bcm_vk_blk_drv_access(struct bcm_vk *vk);
 s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk);
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 4727d7617153..718badb53100 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -478,7 +478,9 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
 	int i;
 
 	/*
-	 * kill all the apps
+	 * kill all the apps except for the process that is resetting.
+	 * If not called during reset, reset_pid will be 0, and all will be
+	 * killed.
 	 */
 	spin_lock(&vk->ctx_lock);
 
@@ -489,10 +491,12 @@ void bcm_vk_blk_drv_access(struct bcm_vk *vk)
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
@@ -975,6 +979,49 @@ static long bcm_vk_load_image(struct bcm_vk *vk,
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
@@ -984,7 +1031,11 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 {
 	u32 i;
 	u32 value, boot_status;
+	bool is_stdalone, is_boot2;
 
+	/* clean up before pressing the door bell */
+	bcm_vk_drain_msg_on_reset(vk);
+	vkwrite32(vk, 0, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
 	/* make tag '\0' terminated */
 	vkwrite32(vk, 0, BAR_1, VK_BAR1_BOOT1_VER_TAG);
 
@@ -995,6 +1046,11 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
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
@@ -1015,17 +1071,103 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
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
 	vkwrite32(vk, 0, BAR_0, BAR_OS_UPTIME);
 	vkwrite32(vk, 0, BAR_0, BAR_INTF_VER);
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
@@ -1044,6 +1186,10 @@ static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
index 3f2876484b7a..e31d41400199 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -204,6 +204,15 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 
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
@@ -232,6 +241,7 @@ static struct bcm_vk_ctx *bcm_vk_get_ctx(struct bcm_vk *vk, const pid_t pid)
 	init_waitqueue_head(&ctx->rd_wq);
 
 all_in_use_exit:
+in_reset_exit:
 	spin_unlock(&vk->ctx_lock);
 
 	return ctx;
@@ -376,6 +386,12 @@ static void bcm_vk_drain_all_pend(struct device *dev,
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
@@ -700,13 +716,22 @@ static int bcm_vk_handle_last_sess(struct bcm_vk *vk, const pid_t pid,
 
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
@@ -1110,6 +1135,17 @@ ssize_t bcm_vk_write(struct file *p_file,
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

