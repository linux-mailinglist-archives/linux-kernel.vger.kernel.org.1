Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2012AE0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJU1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:27:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJU1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:27:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id l1so9743770wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 12:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpRK+zLOJHQp62DUrlIAHBuuljGkxUi0buGSEl1vNGg=;
        b=uk1F2+zh2g0/omvh/dqg+NqdiOPI0wDjmuEJY13IxF7K33MnEpyL2GF0wmd9ovpvpf
         9Q7angcEMGe9DTooRoW4mvWfADBNBbg4d5br3yv0ciUS2DOF9kZtOeI9V080iNq/ucw3
         Q143p0XNxbrlgy7sSZNyYPfVAxqR6m5mq8ljipjVR8U0zd4Wq2+tSOLTeQzQivEBAQzV
         Dm9j9csaZa4YdGF0FUEpXzjmTCMBAntitRI3y40aJoFC1HP6h3+gFPr0YkDNLI2kpGjg
         Aj2zkznPzP4nfsgqkk6jaZ7aHCChAsegt5Ub+T8oavvJvjVVIjV8Mj33Agqq4PlTA9lT
         Ujlw==
X-Gm-Message-State: AOAM531nf2Vou97QMRatPmNLJoMtHGyfI40g1Fx4+D+Eolx8LwRldtQJ
        53xkWJbZzIWtL+iULvzsib6TKbpgHVca0Ff0
X-Google-Smtp-Source: ABdhPJyS0weq8SMX8Xmwnv2CNkT1yP9zuQacHiAzbhtBydzzmJSXzCXXSMg/IfOzNHZ8kGxf8Cysew==
X-Received: by 2002:adf:9066:: with SMTP id h93mr27243325wrh.166.1605040069826;
        Tue, 10 Nov 2020 12:27:49 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id 89sm19620117wrp.58.2020.11.10.12.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:27:49 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: [PATCH v4] reboot: allow to specify reboot mode via sysfs
Date:   Tue, 10 Nov 2020 21:27:46 +0100
Message-Id: <20201110202746.9690-1-mcroce@linux.microsoft.com>
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
	# echo yes >force
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
 Documentation/ABI/testing/sysfs-kernel-reboot |  32 +++
 kernel/reboot.c                               | 206 ++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
new file mode 100644
index 000000000000..837330fb2511
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot
@@ -0,0 +1,32 @@
+What:		/sys/kernel/reboot
+Date:		November 2020
+KernelVersion:	5.11
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	Interface to set the kernel reboot behavior, similarly to
+		what can be done via the reboot= cmdline option.
+		(see Documentation/admin-guide/kernel-parameters.txt)
+
+What:		/sys/kernel/reboot/mode
+Date:		November 2020
+KernelVersion:	5.11
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	Reboot mode. Valid values are: cold warm hard soft gpio
+
+What:		/sys/kernel/reboot/type
+Date:		November 2020
+KernelVersion:	5.11
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci
+
+What:		/sys/kernel/reboot/cpu
+Date:		November 2020
+KernelVersion:	5.11
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	CPU number to use to reboot.
+
+What:		/sys/kernel/reboot/force
+Date:		November 2020
+KernelVersion:	5.11
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:	Don't wait for any other CPUs on reboot and
+		avoid anything that could hang.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index e7b78d5ae1ab..81cc0f0594c6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -594,3 +594,209 @@ static int __init reboot_setup(char *str)
 	return 1;
 }
 __setup("reboot=", reboot_setup);
+
+#ifdef CONFIG_SYSFS
+
+#define REBOOT_COLD_STR		"cold"
+#define REBOOT_WARM_STR		"warm"
+#define REBOOT_HARD_STR		"hard"
+#define REBOOT_SOFT_STR		"soft"
+#define REBOOT_GPIO_STR		"gpio"
+#define REBOOT_UNDEFINED_STR	"undefined"
+
+#define BOOT_TRIPLE_STR		"triple"
+#define BOOT_KBD_STR		"kbd"
+#define BOOT_BIOS_STR		"bios"
+#define BOOT_ACPI_STR		"acpi"
+#define BOOT_EFI_STR		"efi"
+#define BOOT_CF9_FORCE_STR	"cf9_force"
+#define BOOT_CF9_SAFE_STR	"cf9_safe"
+
+static ssize_t mode_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	const char *val;
+
+	switch (reboot_mode) {
+	case REBOOT_COLD:
+		val = REBOOT_COLD_STR;
+		break;
+	case REBOOT_WARM:
+		val = REBOOT_WARM_STR;
+		break;
+	case REBOOT_HARD:
+		val = REBOOT_HARD_STR;
+		break;
+	case REBOOT_SOFT:
+		val = REBOOT_SOFT_STR;
+		break;
+	case REBOOT_GPIO:
+		val = REBOOT_GPIO_STR;
+		break;
+	default:
+		val = REBOOT_UNDEFINED_STR;
+	}
+
+	return sprintf(buf, "%s\n", val);
+}
+static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (!strncmp(buf, REBOOT_COLD_STR, strlen(REBOOT_COLD_STR)))
+		reboot_mode = REBOOT_COLD;
+	else if (!strncmp(buf, REBOOT_WARM_STR, strlen(REBOOT_WARM_STR)))
+		reboot_mode = REBOOT_WARM;
+	else if (!strncmp(buf, REBOOT_HARD_STR, strlen(REBOOT_HARD_STR)))
+		reboot_mode = REBOOT_HARD;
+	else if (!strncmp(buf, REBOOT_SOFT_STR, strlen(REBOOT_SOFT_STR)))
+		reboot_mode = REBOOT_SOFT;
+	else if (!strncmp(buf, REBOOT_GPIO_STR, strlen(REBOOT_GPIO_STR)))
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
+		val = BOOT_TRIPLE_STR;
+		break;
+	case BOOT_KBD:
+		val = BOOT_KBD_STR;
+		break;
+	case BOOT_BIOS:
+		val = BOOT_BIOS_STR;
+		break;
+	case BOOT_ACPI:
+		val = BOOT_ACPI_STR;
+		break;
+	case BOOT_EFI:
+		val = BOOT_EFI_STR;
+		break;
+	case BOOT_CF9_FORCE:
+		val = BOOT_CF9_FORCE_STR;
+		break;
+	case BOOT_CF9_SAFE:
+		val = BOOT_CF9_SAFE_STR;
+		break;
+	default:
+		val = REBOOT_UNDEFINED_STR;
+	}
+
+	return sprintf(buf, "%s\n", val);
+}
+static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
+		reboot_mode = BOOT_TRIPLE;
+	else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
+		reboot_mode = BOOT_KBD;
+	else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
+		reboot_mode = BOOT_BIOS;
+	else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
+		reboot_mode = BOOT_ACPI;
+	else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
+		reboot_mode = BOOT_EFI;
+	else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
+		reboot_mode = BOOT_CF9_FORCE;
+	else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
+		reboot_mode = BOOT_CF9_SAFE;
+	else
+		return -EINVAL;
+
+	return count;
+}
+static struct kobj_attribute reboot_type_attr = __ATTR_RW(type);
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
+	bool res;
+
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (kstrtobool(buf, &res))
+		return -EINVAL;
+
+	reboot_force = res;
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
+late_initcall(reboot_ksysfs_init);
+
+#endif
-- 
2.28.0

