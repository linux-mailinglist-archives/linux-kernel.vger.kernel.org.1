Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB92CE05E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgLCVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:11:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:57306 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCVLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:11:22 -0500
IronPort-SDR: 3Exn8CKZe4dNZTH+ei0l0KUKlsJoLmsfj2fdW5oY4VEpnc64kLuc+wdXmVkK4KanQEfy4AZefa
 rqWOinoyzclA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="169773016"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="169773016"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 13:10:02 -0800
IronPort-SDR: DtGWkLFQdBxkVj8nLbtSSSP3EJgcNjGUPdz2xD4i4ZsBUr+rGZ9vXe2mTu0vpkyXBDruvOnx47
 3C3RW1CSMDDw==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="330971719"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.23.110])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 13:10:02 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v7 3/7] fpga: sec-mgr: expose sec-mgr update status
Date:   Thu,  3 Dec 2020 13:09:54 -0800
Message-Id: <20201203210958.241329-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203210958.241329-1-russell.h.weight@intel.com>
References: <20201203210958.241329-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the FPGA Security Manager class driver to
include an update/status sysfs node that can be polled
and read to monitor the progress of an ongoing secure
update. Sysfs_notify() is used to signal transitions
between different phases of the update process.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v7:
  - Changed Date in documentation file to December 2020
v6:
  - No change
v5:
  - Use new function sysfs_emit() in the status_show() function
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - Use a local variable to read progress once in status_show()
  - Use dev_err to report invalid progress status
v2:
  - Bumped documentation date and version
  - Changed progress state "read_file" to "reading"
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 11 +++++
 drivers/fpga/fpga-sec-mgr.c                   | 42 +++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index e9334f986380..d3be25d63a08 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -16,3 +16,14 @@ Description:	Write only. Write the filename of an image
 		BMC images, BMC firmware, Static Region images,
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
+Date:		December 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the current
+		status of an update. The string will be one of the
+		following: idle, reading, preparing, writing,
+		programming. Userspace code can poll on this file,
+		as it will be signaled by sysfs_notify() on each
+		state change.
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 7347ba1ba73e..dd60014b7511 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -25,6 +25,13 @@ struct fpga_sec_mgr_devres {
 
 #define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
 
+static void update_progress(struct fpga_sec_mgr *smgr,
+			    enum fpga_sec_prog new_progress)
+{
+	smgr->progress = new_progress;
+	sysfs_notify(&smgr->dev.kobj, "update", "status");
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
@@ -35,7 +42,7 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 static void progress_complete(struct fpga_sec_mgr *smgr)
 {
 	mutex_lock(&smgr->lock);
-	smgr->progress = FPGA_SEC_PROG_IDLE;
+	update_progress(smgr, FPGA_SEC_PROG_IDLE);
 	complete_all(&smgr->update_done);
 	mutex_unlock(&smgr->lock);
 }
@@ -63,14 +70,14 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		goto release_fw_exit;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_PREPARING;
+	update_progress(smgr, FPGA_SEC_PROG_PREPARING);
 	ret = smgr->sops->prepare(smgr);
 	if (ret != FPGA_SEC_ERR_NONE) {
 		fpga_sec_dev_error(smgr, ret);
 		goto modput_exit;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_WRITING;
+	update_progress(smgr, FPGA_SEC_PROG_WRITING);
 	size = smgr->remaining_size;
 	while (size) {
 		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
@@ -85,7 +92,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		offset += blk_size;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_PROGRAMMING;
+	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
 	ret = smgr->sops->poll_complete(smgr);
 	if (ret != FPGA_SEC_ERR_NONE)
 		fpga_sec_dev_error(smgr, ret);
@@ -113,6 +120,32 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 	progress_complete(smgr);
 }
 
+static const char * const sec_mgr_prog_str[] = {
+	"idle",			/* FPGA_SEC_PROG_IDLE */
+	"reading",		/* FPGA_SEC_PROG_READING */
+	"preparing",		/* FPGA_SEC_PROG_PREPARING */
+	"writing",		/* FPGA_SEC_PROG_WRITING */
+	"programming"		/* FPGA_SEC_PROG_PROGRAMMING */
+};
+
+static ssize_t
+status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	const char *status = "unknown-status";
+	enum fpga_sec_prog progress;
+
+	progress = smgr->progress;
+	if (progress < FPGA_SEC_PROG_MAX)
+		status = sec_mgr_prog_str[progress];
+	else
+		dev_err(dev, "Invalid status during secure update: %d\n",
+			progress);
+
+	return sysfs_emit(buf, "%s\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -147,6 +180,7 @@ static DEVICE_ATTR_WO(filename);
 
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 
-- 
2.25.1

