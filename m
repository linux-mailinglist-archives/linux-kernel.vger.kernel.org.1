Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAF2A9E70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgKFUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:07:11 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:32789 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgKFUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:07:11 -0500
Received: by mail-ej1-f42.google.com with SMTP id 7so3620837ejm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 12:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bXVC7tc7L1SmsQ56PLiN6FwPY1yyIOcSqN2utAuNOs=;
        b=lTFEreWE/H2zkE6aspCzeIskE2zNuckHDpGz94KigQpUyTwk4vDnVwDDKKocctbDie
         SoHgHVingh89OhLQqJINsE4In1j8YB8FQHi2ODlCkiFSP8jw2D3DvpnOgJUOFvjQqvwf
         rlGwiq2JKWjnI1kSbkVQIcBWOo+FAH0GqGcuCBb7WUbPCAUI5h+c9roc9QLIWvkAbcCN
         iAf/RhtRw+L2QwayUrSAPm4UIUCrf3WCnOxW2aqHzSnNjT9dSBk9FZn2aKSmhN61hYPc
         sJuHiFYG2G0CSSYGdZAuwXW8bbvESZvG5BKFL/zy1BLZ+fgFBWeoLrHye/I2+vbaCA02
         O7PA==
X-Gm-Message-State: AOAM533Gtan2LpIobrLeKxrjqWCmecB3ogB6B9spZsQfSQtvwauI2PmH
        rSu6/ZR4UE0UoVQmGB9G1nKn7PTvZKwI7E8v
X-Google-Smtp-Source: ABdhPJyRrLPn1x2vJABzfbotoJdkV/nb83E/D1+ZTZw1UCQ+Of3AEuqMIDULjm5LS6Ewi4+jh5oGcw==
X-Received: by 2002:a17:906:39d1:: with SMTP id i17mr3630213eje.284.1604693227581;
        Fri, 06 Nov 2020 12:07:07 -0800 (PST)
Received: from msft-t490s.corp.microsoft.com (net-5-95-179-145.cust.vodafonedsl.it. [5.95.179.145])
        by smtp.gmail.com with ESMTPSA id rn2sm1630196ejb.94.2020.11.06.12.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:07:07 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: [PATCH v2] reboot: allow to specify reboot mode via sysfs
Date:   Fri,  6 Nov 2020 21:07:04 +0100
Message-Id: <20201106200704.192894-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The kernel cmdline reboot= option offers some sort of control
on how the reboot is issued.
Add handles in sysfs to allow setting these reboot options, so they
can be changed when the system is booted, other than at boot time.

The handlers are under <sysfs>/kernel/reboot, can be read to
get the current configuration and written to alter it.

	# cd /sys/kernel/reboot/

	# grep . *
	cpu:0
	force:0
	mode:cold
	type:acpi

	# echo 2 >cpu
	# echo 1 >force
	# echo soft >mode
	# echo bios >type

	# grep . *
	cpu:2
	force:1
	mode:soft
	type:bios

Before setting anything, check for CAP_SYS_BOOT capability, so it's
possible to allow an unpriviledged process to change these settings
simply by relaxing the handles permissions, without opening them to
the world.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 Documentation/ABI/testing/sysfs-kernel-reboot |  26 +++
 kernel/reboot.c                               | 193 ++++++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
new file mode 100644
index 000000000000..3fda90bdc644
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot
@@ -0,0 +1,26 @@
+What:		/sys/kernel/reboot
+Date:		October 2020
+KernelVersion:	5.11
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	Interface to set the kernel reboot mode, similarly to
+		what can be done via the reboot= cmdline option.
+		(see Documentation/admin-guide/kernel-parameters.txt)
+
+What:		/sys/kernel/reboot/mode
+What:		/sys/kernel/reboot/type
+What:		/sys/kernel/reboot/cpu
+What:		/sys/kernel/reboot/force
+
+Date:		October 2020
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	Tune reboot parameters.
+
+		mode: Reboot mode. Valid values are:
+		cold warm hard soft gpio
+
+		type: Reboot type. Valid values are:
+		bios acpi kbd triple efi pci
+
+		cpu: CPU number to use to reboot.
+
+		force: Force an immediate reboot.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index e7b78d5ae1ab..b9e607517ae3 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -594,3 +594,196 @@ static int __init reboot_setup(char *str)
 	return 1;
 }
 __setup("reboot=", reboot_setup);
+
+#ifdef CONFIG_SYSFS
+
+#define STARTS_WITH(s, sc) (!strncmp(s, sc, sizeof(sc)-1))
+
+static ssize_t mode_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	const char *val;
+
+	switch (reboot_mode) {
+	case REBOOT_COLD:
+		val = "cold\n";
+		break;
+	case REBOOT_WARM:
+		val = "warm\n";
+		break;
+	case REBOOT_HARD:
+		val = "hard\n";
+		break;
+	case REBOOT_SOFT:
+		val = "soft\n";
+		break;
+	case REBOOT_GPIO:
+		val = "gpio\n";
+		break;
+	default:
+		val = "undefined\n";
+	}
+
+	return strscpy(buf, val, 10);
+}
+static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (STARTS_WITH(buf, "cold"))
+		reboot_mode = REBOOT_COLD;
+	else if (STARTS_WITH(buf, "warm"))
+		reboot_mode = REBOOT_WARM;
+	else if (STARTS_WITH(buf, "hard"))
+		reboot_mode = REBOOT_HARD;
+	else if (STARTS_WITH(buf, "soft"))
+		reboot_mode = REBOOT_SOFT;
+	else if (STARTS_WITH(buf, "gpio"))
+		reboot_mode = REBOOT_GPIO;
+	else
+		return -EINVAL;
+
+	return count;
+}
+static struct kobj_attribute reboot_mode_attr = __ATTR_RW(mode);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	const char *val;
+
+	switch (reboot_type) {
+	case BOOT_TRIPLE:
+		val = "triple\n";
+		break;
+	case BOOT_KBD:
+		val = "kbd\n";
+		break;
+	case BOOT_BIOS:
+		val = "bios\n";
+		break;
+	case BOOT_ACPI:
+		val = "acpi\n";
+		break;
+	case BOOT_EFI:
+		val = "efi\n";
+		break;
+	case BOOT_CF9_FORCE:
+		val = "cf9_force\n";
+		break;
+	case BOOT_CF9_SAFE:
+		val = "cf9_safe\n";
+		break;
+	default:
+		val = "undefined\n";
+	}
+
+	return strscpy(buf, val, 10);
+}
+static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (STARTS_WITH(buf, "triple"))
+		reboot_type = BOOT_TRIPLE;
+	else if (STARTS_WITH(buf, "kbd"))
+		reboot_type = BOOT_KBD;
+	else if (STARTS_WITH(buf, "bios"))
+		reboot_type = BOOT_BIOS;
+	else if (STARTS_WITH(buf, "acpi"))
+		reboot_type = BOOT_ACPI;
+	else if (STARTS_WITH(buf, "efi"))
+		reboot_type = BOOT_EFI;
+	else if (STARTS_WITH(buf, "cf9_force"))
+		reboot_type = BOOT_CF9_FORCE;
+	else if (STARTS_WITH(buf, "cf9_safe"))
+		reboot_type = BOOT_CF9_SAFE;
+	else
+		return -EINVAL;
+
+	return count;
+}
+static struct kobj_attribute reboot_type_attr = __ATTR_RW(type);
+
+#undef STARTS_WITH
+
+static ssize_t cpu_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", reboot_cpu);
+}
+static ssize_t cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	unsigned int cpunum;
+	int rc;
+
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	rc = kstrtouint(buf, 0, &cpunum);
+
+	if (rc)
+		return rc;
+
+	if (cpunum >= num_possible_cpus())
+		return -ERANGE;
+
+	reboot_cpu = cpunum;
+
+	return count;
+}
+static struct kobj_attribute reboot_cpu_attr = __ATTR_RW(cpu);
+
+static ssize_t force_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", reboot_force);
+}
+static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (buf[0] != '0' && buf[0] != '1')
+		return -EINVAL;
+
+	reboot_force = buf[0] - '0';
+
+	return count;
+}
+static struct kobj_attribute reboot_force_attr = __ATTR_RW(force);
+
+static struct attribute *reboot_attrs[] = {
+	&reboot_mode_attr.attr,
+	&reboot_type_attr.attr,
+	&reboot_cpu_attr.attr,
+	&reboot_force_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group reboot_attr_group = {
+	.attrs = reboot_attrs,
+};
+
+static int __init reboot_ksysfs_init(void)
+{
+	struct kobject *reboot_kobj;
+	int ret;
+
+	reboot_kobj = kobject_create_and_add("reboot", kernel_kobj);
+	if (!reboot_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(reboot_kobj, &reboot_attr_group);
+	if (ret) {
+		kobject_put(reboot_kobj);
+		return ret;
+	}
+
+	return 0;
+}
+core_initcall(reboot_ksysfs_init);
+
+#endif
-- 
2.28.0

