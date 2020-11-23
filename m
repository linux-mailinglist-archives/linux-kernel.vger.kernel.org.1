Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B322C1334
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgKWSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:31:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgKWSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:31:48 -0500
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c5:9900:2d00:fa7c:ed23:2f0a:448d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3DD761F44D56;
        Mon, 23 Nov 2020 18:31:45 +0000 (GMT)
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sjoerd Simons <sjoerd@collabora.co.uk>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH] um: ubd: Set device serial attribute from cmdline
Date:   Mon, 23 Nov 2020 18:31:37 +0000
Message-Id: <20201123183137.741647-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the ability to set the UBD device serial number from the
commandline, disabling the serial number functionality by default.

In some cases it may be useful to set a serial to the UBD device, such
that downstream users (i.e. udev) can use this information to better
describe the hardware to the user from the UML cmdline. In our case we
use this parameter to create some entries under /dev/disk/by-ubd-id/
for each of the UBD devices passed through the UML cmdline.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/um/drivers/ubd_kern.c | 78 ++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index a97b40432331..f59e23748c16 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -155,6 +155,7 @@ struct ubd {
 	/* name (and fd, below) of the file opened for writing, either the
 	 * backing or the cow file. */
 	char *file;
+	char *serial;
 	int count;
 	int fd;
 	__u64 size;
@@ -180,6 +181,7 @@ struct ubd {
 
 #define DEFAULT_UBD { \
 	.file = 		NULL, \
+	.serial =		NULL, \
 	.count =		0, \
 	.fd =			-1, \
 	.size =			-1, \
@@ -272,7 +274,7 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 {
 	struct ubd *ubd_dev;
 	struct openflags flags = global_openflags;
-	char *backing_file;
+	char *file, *backing_file, *serial;
 	int n, err = 0, i;
 
 	if(index_out) *index_out = -1;
@@ -368,24 +370,27 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 	goto out;
 
 break_loop:
-	backing_file = strchr(str, ',');
+	file = strsep(&str, ",:");
+	if (*file == '\0')
+		file = NULL;
 
-	if (backing_file == NULL)
-		backing_file = strchr(str, ':');
+	backing_file = strsep(&str, ",:");
+	if (*backing_file == '\0')
+		backing_file = NULL;
 
-	if(backing_file != NULL){
-		if(ubd_dev->no_cow){
-			*error_out = "Can't specify both 'd' and a cow file";
-			goto out;
-		}
-		else {
-			*backing_file = '\0';
-			backing_file++;
-		}
+	serial = strsep(&str, ",:");
+	if (*serial == '\0')
+		serial = NULL;
+
+	if (backing_file && ubd_dev->no_cow) {
+		*error_out = "Can't specify both 'd' and a cow file";
+		goto out;
 	}
+
 	err = 0;
-	ubd_dev->file = str;
+	ubd_dev->file = file;
 	ubd_dev->cow.file = backing_file;
+	ubd_dev->serial = serial;
 	ubd_dev->boot_openflags = flags;
 out:
 	mutex_unlock(&ubd_lock);
@@ -406,7 +411,7 @@ static int ubd_setup(char *str)
 
 __setup("ubd", ubd_setup);
 __uml_help(ubd_setup,
-"ubd<n><flags>=<filename>[(:|,)<filename2>]\n"
+"ubd<n><flags>=<filename>[(:|,)<filename2>][(:|,)<serial>]\n"
 "    This is used to associate a device with a file in the underlying\n"
 "    filesystem. When specifying two filenames, the first one is the\n"
 "    COW name and the second is the backing file name. As separator you can\n"
@@ -429,6 +434,12 @@ __uml_help(ubd_setup,
 "    UMLs and file locking will be turned off - this is appropriate for a\n"
 "    cluster filesystem and inappropriate at almost all other times.\n\n"
 "    't' will disable trim/discard support on the device (enabled by default).\n\n"
+"    An optional device serial number can be exposed using the serial parameter\n"
+"    on the cmdline which is exposed as a sysfs entry. This is particularly\n"
+"    useful when a unique number should be given to the device. Note when\n"
+"    specifying a label, the filename2 must be also presented. It can be\n"
+"    an empty string, in which case the backing file is not used:\n"
+"       ubd0=File,,Serial\n"
 );
 
 static int udb_setup(char *str)
@@ -868,6 +879,41 @@ static void ubd_device_release(struct device *dev)
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 }
 
+static ssize_t serial_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ubd *ubd_dev = disk->private_data;
+
+	if (!ubd_dev)
+		return 0;
+
+	return sprintf(buf, "%s", ubd_dev->serial);
+}
+
+static DEVICE_ATTR_RO(serial);
+
+static struct attribute *ubd_attrs[] = {
+	&dev_attr_serial.attr,
+	NULL,
+};
+
+static umode_t ubd_attrs_are_visible(struct kobject *kobj,
+				     struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+static const struct attribute_group ubd_attr_group = {
+	.attrs = ubd_attrs,
+	.is_visible = ubd_attrs_are_visible,
+};
+
+static const struct attribute_group *ubd_attr_groups[] = {
+	&ubd_attr_group,
+	NULL,
+};
+
 static int ubd_disk_register(int major, u64 size, int unit,
 			     struct gendisk **disk_out)
 {
@@ -899,7 +945,7 @@ static int ubd_disk_register(int major, u64 size, int unit,
 
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
-	device_add_disk(parent, disk, NULL);
+	device_add_disk(parent, disk, ubd_attr_groups);
 
 	*disk_out = disk;
 	return 0;
-- 
2.28.0

