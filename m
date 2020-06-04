Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81A1EE023
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFDIun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:50:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:39770 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgFDIuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:50:40 -0400
IronPort-SDR: SNOIQQEi/MJo6gOkBgwEYxSYCyFR1N1ZTtBSi7gLP9iW3pk3mEivfjHY/M8AdsbzxsnSgUW4u3
 HaESRDTNIh4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 01:50:39 -0700
IronPort-SDR: YKliRi2zkOhPxf1GnbmC8tz29za46f44yqjpi0CCOGd5nFD5d86YasnUoFml8maAHlm5xHT5Uy
 zRuk8h2J8KMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="445435135"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2020 01:50:37 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mfd@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, mtosatti@redhat.com,
        gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v6 6/7] fpga: dfl: afu: add AFU interrupt support
Date:   Thu,  4 Jun 2020 16:46:27 +0800
Message-Id: <1591260388-15128-7-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591260388-15128-1-git-send-email-yilun.xu@intel.com>
References: <1591260388-15128-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFU (Accelerated Function Unit) is dynamic region of the DFL based FPGA,
and always defined by users. Some DFL based FPGA cards allow users to
implement their own interrupts in AFU. In order to support this,
hardware implements a new UINT (AFU Interrupt) private feature with
related capability register which describes the number of supported
AFU interrupts as well as the local index of the interrupts for
software enumeration, and from software side, driver follows the common
DFL interrupt notification and handling mechanism, and it implements
two ioctls below for user to query number of irqs supported and set/unset
interrupt triggers.

 Ioctls:
 * DFL_FPGA_PORT_UINT_GET_IRQ_NUM
   get the number of irqs, which is used to determine how many interrupts
   UINT feature supports.

 * DFL_FPGA_PORT_UINT_SET_IRQ
   set/unset eventfds as AFU interrupt triggers.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
----
v2: use DFL_FPGA_PORT_UINT_GET_IRQ_NUM instead of
    DFL_FPGA_PORT_UINT_GET_INFO
    Delete flags field for DFL_FPGA_PORT_UINT_SET_IRQ
v3: put_user() instead of copy_to_user()
    improves comments
v4: use common functions to handle irq ioctls
v5: Minor fixes for Hao's comments
v6: No change
---
 drivers/fpga/dfl-afu-main.c   | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 357cd5d..7c84fee 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -529,6 +529,30 @@ static const struct dfl_feature_ops port_stp_ops = {
 	.init = port_stp_init,
 };
 
+static long
+port_uint_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
+		unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case DFL_FPGA_PORT_UINT_GET_IRQ_NUM:
+		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
+	case DFL_FPGA_PORT_UINT_SET_IRQ:
+		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
+	default:
+		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
+		return -ENODEV;
+	}
+}
+
+static const struct dfl_feature_id port_uint_id_table[] = {
+	{.id = PORT_FEATURE_ID_UINT,},
+	{0,}
+};
+
+static const struct dfl_feature_ops port_uint_ops = {
+	.ioctl = port_uint_ioctl,
+};
+
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
 		.id_table = port_hdr_id_table,
@@ -547,6 +571,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 		.ops = &port_stp_ops,
 	},
 	{
+		.id_table = port_uint_id_table,
+		.ops = &port_uint_ops,
+	},
+	{
 		.ops = NULL,
 	}
 };
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index b6495ea..1621b07 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -187,6 +187,29 @@ struct dfl_fpga_irq_set {
 					     DFL_PORT_BASE + 6,	\
 					     struct dfl_fpga_irq_set)
 
+/**
+ * DFL_FPGA_PORT_UINT_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7,
+ *								__u32 num_irqs)
+ *
+ * Get the number of irqs supported by the fpga AFU interrupt private
+ * feature.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_PORT_UINT_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
+					     DFL_PORT_BASE + 7, __u32)
+
+/**
+ * DFL_FPGA_PORT_UINT_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8,
+ *						struct dfl_fpga_irq_set)
+ *
+ * Set fpga AFU interrupt trigger if evtfds[n] is valid.
+ * Unset related interrupt trigger if evtfds[n] is a negative value.
+ * Return: 0 on success, -errno on failure.
+ */
+#define DFL_FPGA_PORT_UINT_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
+					     DFL_PORT_BASE + 8,	\
+					     struct dfl_fpga_irq_set)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
2.7.4

