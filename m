Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6B2B692D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKQP5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:57:49 -0500
Received: from foss.arm.com ([217.140.110.172]:60322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKQP5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:57:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA23E1FB;
        Tue, 17 Nov 2020 07:57:46 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B653F719;
        Tue, 17 Nov 2020 07:57:45 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh@kernel.org
Subject: [PATCH v3] firmware: arm_scmi: Add SCMI System Power Control driver
Date:   Tue, 17 Nov 2020 15:57:25 +0000
Message-Id: <20201117155725.13502-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an SCMI System Power control driver to handle platform's requests
carried by SYSTEM_POWER_STATE_NOTIFIER notifications: such platform
requested system-wide power state transitions are handled accordingly,
gracefully or forcefully, depending on the notifications' message flags.

Graceful requests are by default relayed to userspace using the same
Kernel API used to handle ACPI Shutdown bus events: alternatively, a few
available module parameters can be used to tunnel insted such requests to
userspace via signals addressed to CAD pid.

When handling graceful requests, grant userspace processes a maximum
(configurable) time to perform their duties and then revert to a forceful
transition, so avoiding completely timing out platform's maximum grace time
and hitting possible abrupt power-cuts.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
This patch, building on top of the recently introduced SCMI System Power
Protocol support, adds a new SCMI driver which, registering for such SCMI
System Power notifications, acts accordingly to satisfy such SCMI plaform
system-wide transition requests.

The basic assumption here is that the SCMI fw platform is finally in charge
of such system-wide power state transitions and can notify Kernel about
shutdown/reboot requests via notifications (graceful of forceful in kind),
so this driver can act accordingly to satisfy such requests as soon as they
are received but the SCMI fw implements the policy (and the timings) and
can anyway decide to brutally poweroff the system in conditions deemed
particularly critical or if Kernel delays too much the transition on its
side: so this driver just attempts to relay this request to userspace in
order to perform such transitions in the most possible clean way, but it's
a best effort attempt given the SCMI fw has anyway the last word on pulling
plug.

Given that this driver is called to react on SCMI System Power events, it
is potentially needed very early on during boot, so it has not been made
configurable as a loadable module: if you decide to use it, makes no sense
not have it buitin immediately ready once SCMI subsystem is activated; as
an additional side benefit of being builtin-only, it can call on some non
exported function (emergency_sync) when having to deal with some corner
case conditions. (this could be dropped anyway if full modularization was
to be preferred)

It is currently based on for-next/scmi [1] on top of:

commit e342bd145d76 ("firmware: arm_scmi: Fix missing destroy_workqueue()")

Thanks,

Cristian

v2 --> v3
- rebased
- some minor cleanup in codestyle and commit message

v1 --> v2
- split out of SCMI System Power Protocol series now merged

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
---
 drivers/firmware/Kconfig                      |  12 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 .../firmware/arm_scmi/scmi_power_control.c    | 387 ++++++++++++++++++
 3 files changed, 400 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 3315e3c21586..2c7eb5eff568 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -40,6 +40,18 @@ config ARM_SCMI_POWER_DOMAIN
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
 
+config ARM_SCMI_POWER_CONTROL
+	bool "SCMI system power control driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default n
+	help
+	  This enables System Power control logic which binds system shutdown or
+	  reboot actions to SCMI System Power notifications generated by SCP
+	  firmware.
+
+	  Graceful requests' methods and timeout and can be configured using
+	  a few available module parameters.
+
 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index bc0d54f8e861..ec2645f7cb7f 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -9,3 +9,4 @@ scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
+obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
new file mode 100644
index 000000000000..5d5ce9e061b8
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI Generic System Power Control driver.
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
+/**
+ * DOC: Theory of operation
+ *
+ * In order to handle platform originated SCMI System Power requests (like
+ * shutdowns or cold/warm resets) we register an SCMI Notification notifier
+ * block to react when such SCMI System Power events are emitted.
+ *
+ * Once such a notification is received we act accordingly to perform the
+ * required system transition depending on the kind of request.
+ *
+ * By default graceful requests are routed to userspace through the same
+ * API methods (orderly_poweroff/reboot()) used by ACPI when handling ACPI
+ * Shutdown bus events: alternatively, by properly setting a couple of module
+ * parameters, it is possible to choose to use signals to CAD pid as a mean
+ * to communicate such graceful requests.
+ *
+ * Forceful requests instead simply cause an immediate emergency_sync() and
+ * subsequent Kernel-only shutdown/reboot.
+ *
+ * The assumption here is that even graceful requests can be upper-bound by a
+ * maximum final timeout strictly enforced by the platform itself which can
+ * finally cuts the power off at will: in such a scenario, which we want to
+ * avoid, we track the graceful requests progress through the means of a
+ * reboot_notifier and promptly convert a timed-out graceful request to a
+ * forceful one when userspace is late, in order to at least perform a clean
+ * sync and shutdown/restart.
+ *
+ * Given that such platform hard-timeout, when present, is anyway highly
+ * platform/event specific and not exposed at run-time, we make it configurable
+ * via the Kernel module param @scmi_graceful_request_tmo_ms.
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/sched/signal.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#define DEFAULT_GRACE_TMO_MS	5000
+static unsigned int scmi_graceful_request_tmo_ms = DEFAULT_GRACE_TMO_MS;
+static unsigned int scmi_graceful_poweroff_signum;
+static unsigned int scmi_graceful_reboot_signum;
+
+enum scmi_system_request_status {
+	SCMI_SYSPOWER_IDLE,
+	SCMI_SYSPOWER_SERVED,
+	SCMI_SYSPOWER_INPROGRESS,
+	SCMI_SYSPOWER_FORCING,
+};
+
+struct scmi_syspower_config {
+	struct device *dev;
+
+	atomic_t status;
+
+	u32 required_state;
+
+	void (*request_graceful_transition)(struct scmi_syspower_config *conf);
+	void (*request_forceful_transition)(struct scmi_syspower_config *conf);
+
+	struct notifier_block userspace_nb;
+	struct notifier_block reboot_nb;
+
+	struct timer_list request_timer;
+	struct work_struct forceful_work;
+};
+
+static void scmi_forceful_work_func(struct work_struct *work)
+{
+	struct scmi_syspower_config *conf =
+		container_of(work, struct scmi_syspower_config, forceful_work);
+
+	conf->request_forceful_transition(conf);
+}
+
+/**
+ * scmi_request_timeout  - On timeout trigger a forceful transition
+ * @t: The timer reference
+ *
+ * Actual work is deferred out of the timer IRQ context since shutdown/reboot
+ * code do not play well when !in_task().
+ */
+static void scmi_request_timeout(struct timer_list *t)
+{
+	struct scmi_syspower_config *conf = from_timer(conf, t, request_timer);
+
+	dev_warn(conf->dev,
+		 "SCMI Graceful System Transition request timed out !\n");
+	atomic_set(&conf->status, SCMI_SYSPOWER_FORCING);
+	/* Ensure atomic values are updated */
+	smp_mb__after_atomic();
+	schedule_work(&conf->forceful_work);
+}
+
+/**
+ * scmi_reboot_notifier  - A reboot_notifier to catch an ongoing successful
+ * system transition
+ * @nb: Reference to the related notifier block
+ * @reason: The reason for the ongoing reboot
+ * @__unused: The cmd being executed on a restart request (unused)
+ *
+ * When an ongoing system transition is detected, compatible with the requested
+ * one, cancel the timer work.
+ *
+ * Return: NOTIFY_OK in any case
+ */
+static int scmi_reboot_notifier(struct notifier_block *nb,
+				unsigned long reason, void *__unused)
+{
+	struct scmi_syspower_config *conf;
+
+	conf = container_of(nb, struct scmi_syspower_config, reboot_nb);
+
+	/* Ensure atomic values are updated */
+	smp_mb__before_atomic();
+	if (unlikely(atomic_read(&conf->status) == SCMI_SYSPOWER_FORCING))
+		return NOTIFY_OK;
+
+	switch (reason) {
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		if (conf->required_state == SCMI_SYSTEM_SHUTDOWN)
+			atomic_set(&conf->status, SCMI_SYSPOWER_INPROGRESS);
+		break;
+	case SYS_RESTART:
+		if (conf->required_state == SCMI_SYSTEM_COLDRESET ||
+		    conf->required_state == SCMI_SYSTEM_WARMRESET)
+			atomic_set(&conf->status, SCMI_SYSPOWER_INPROGRESS);
+		break;
+	default:
+		break;
+	}
+
+	/* Ensure atomic values are updated */
+	smp_mb__after_atomic();
+	if (atomic_read(&conf->status) == SCMI_SYSPOWER_INPROGRESS) {
+		dev_info(conf->dev,
+			 "SCMI System State request in progress...\n");
+		del_timer_sync(&conf->request_timer);
+	}
+
+	return NOTIFY_OK;
+}
+
+static inline void scmi_send_cad_signal(struct device *dev, unsigned int sig)
+{
+	dev_info(dev, "SCMI Sending signal %d to CAD pid\n", sig);
+
+	kill_cad_pid(sig, 1);
+}
+
+/**
+ * scmi_request_graceful_transition  - Request graceful SystemPower transition
+ * @conf: The current SystemPower configuration descriptor
+ *
+ * Initiates the required SystemPower transition, requesting userspace
+ * co-operation using the same orderly_ methods used by ACPI Shutdown event
+ * processing.
+ *
+ * This takes care also to register a reboot notifier and a timer callback in
+ * order to detect if userspace actions are taking too long; in such a case
+ * the timeout callback will finally perform a forceful transition, ignoring
+ * lagging userspace: the aim here is to at least perform an emergency_sync()
+ * and a clean shutdown or reboot transition when userspace is late, avoiding
+ * the brutal final power-cut from platform.
+ */
+static void scmi_request_graceful_transition(struct scmi_syspower_config *conf)
+{
+	int ret;
+	u32 status;
+
+	if (conf->required_state >= SCMI_SYSTEM_POWERUP) {
+		dev_warn(conf->dev,
+			 "Received unexpected SYSTEM POWER request: %d\n",
+			 conf->required_state);
+		return;
+	}
+
+	status = atomic_cmpxchg(&conf->status, SCMI_SYSPOWER_IDLE,
+				SCMI_SYSPOWER_SERVED);
+	if (status != SCMI_SYSPOWER_IDLE)
+		return;
+
+	ret = devm_register_reboot_notifier(conf->dev, &conf->reboot_nb);
+	if (ret)
+		dev_warn(conf->dev, "Cannot register reboot notifier !\n");
+
+	INIT_WORK(&conf->forceful_work, scmi_forceful_work_func);
+	conf->request_timer.expires = jiffies +
+				msecs_to_jiffies(scmi_graceful_request_tmo_ms);
+	timer_setup(&conf->request_timer, scmi_request_timeout, 0);
+	add_timer(&conf->request_timer);
+
+	dev_info(conf->dev,
+		 "Serving SCMI Graceful request: %d (timeout_ms:%d)\n",
+		 conf->required_state, scmi_graceful_request_tmo_ms);
+
+	switch (conf->required_state) {
+	case SCMI_SYSTEM_SHUTDOWN:
+		/*
+		 * When received early at boot-time the 'orderly' part will
+		 * fail due to the lack of userspace itself, but the force=true
+		 * argument will anyway be able trigger a successful forced
+		 * shutdown.
+		 */
+		if (!scmi_graceful_poweroff_signum)
+			orderly_poweroff(true);
+		else
+			scmi_send_cad_signal(conf->dev,
+					     scmi_graceful_poweroff_signum);
+		break;
+	case SCMI_SYSTEM_COLDRESET:
+	case SCMI_SYSTEM_WARMRESET:
+		if (!scmi_graceful_reboot_signum)
+			orderly_reboot();
+		else
+			scmi_send_cad_signal(conf->dev,
+					     scmi_graceful_reboot_signum);
+		break;
+	default:
+		break;
+	}
+}
+
+static void scmi_request_forceful_transition(struct scmi_syspower_config *conf)
+{
+	/* Ensure atomic values are updated */
+	smp_mb__before_atomic();
+	if (unlikely(atomic_read(&conf->status) == SCMI_SYSPOWER_INPROGRESS))
+		return;
+
+	dev_info(conf->dev, "Serving SCMI FORCEFUL SystemPower request:%d\n",
+		 conf->required_state);
+
+	emergency_sync();
+	switch (conf->required_state) {
+	case SCMI_SYSTEM_SHUTDOWN:
+		kernel_power_off();
+		break;
+	case SCMI_SYSTEM_COLDRESET:
+	case SCMI_SYSTEM_WARMRESET:
+		kernel_restart(NULL);
+		break;
+	default:
+		break;
+	}
+}
+
+#define SCMI_IS_REQUEST_GRACEFUL(flags)		((flags) & BIT(0))
+
+/**
+ * scmi_userspace_notifier  - Notifier callback to act on SystemPower
+ * Notifications
+ * @nb: Reference to the related notifier block
+ * @event: The SystemPower notification event id
+ * @data: The SystemPower event report
+ *
+ * This callback is in charge of decoding the received SystemPower report
+ * and act accordingly triggering a graceful or forceful system transition.
+ *
+ * Return: NOTIFY_OK in any case
+ */
+static int scmi_userspace_notifier(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	struct scmi_system_power_state_notifier_report *er = data;
+	struct scmi_syspower_config *conf;
+
+	if (unlikely(system_state > SYSTEM_RUNNING))
+		return NOTIFY_OK;
+
+	conf = container_of(nb, struct scmi_syspower_config, userspace_nb);
+	conf->required_state = er->system_state;
+
+	if (conf->required_state >= SCMI_SYSTEM_MAX)
+		return NOTIFY_OK;
+
+	if (SCMI_IS_REQUEST_GRACEFUL(er->flags))
+		conf->request_graceful_transition(conf);
+	else
+		conf->request_forceful_transition(conf);
+
+	return NOTIFY_OK;
+}
+
+/**
+ * scmi_syspower_configure  - General SystemPower configuration init
+ * @dev: The associated struct device
+ *
+ * Return: SystemPower configuration descriptor on Success, NULL otherwise
+ */
+static void *scmi_syspower_configure(struct device *dev)
+{
+	struct scmi_syspower_config *conf;
+
+	conf = devm_kzalloc(dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return NULL;
+
+	conf->dev = dev;
+	conf->required_state = SCMI_SYSTEM_MAX;
+	conf->request_graceful_transition = &scmi_request_graceful_transition;
+	conf->request_forceful_transition = &scmi_request_forceful_transition;
+	conf->userspace_nb.notifier_call = &scmi_userspace_notifier;
+	conf->reboot_nb.notifier_call = &scmi_reboot_notifier;
+	atomic_set(&conf->status, SCMI_SYSPOWER_IDLE);
+	/* Ensure atomic values are updated */
+	smp_mb__after_atomic();
+
+	return conf;
+}
+
+static int scmi_syspower_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct scmi_handle *handle = sdev->handle;
+	struct scmi_syspower_config *syspower_conf;
+
+	if (!handle)
+		return -ENODEV;
+
+	syspower_conf = scmi_syspower_configure(&sdev->dev);
+	if (!syspower_conf)
+		return -ENOMEM;
+
+	dev_set_drvdata(&sdev->dev, syspower_conf);
+	ret = handle->notify_ops->register_event_notifier(handle,
+						SCMI_PROTOCOL_SYSTEM,
+					SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
+					    NULL, &syspower_conf->userspace_nb);
+	return ret;
+}
+
+static void scmi_syspower_remove(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_syspower_config *syspower_conf;
+
+	syspower_conf = dev_get_drvdata(&sdev->dev);
+	handle->notify_ops->unregister_event_notifier(handle,
+						      SCMI_PROTOCOL_SYSTEM,
+					 SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
+					    NULL, &syspower_conf->userspace_nb);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_SYSTEM, "syspower" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_system_power_driver = {
+	.name = "scmi-system-power",
+	.probe = scmi_syspower_probe,
+	.remove = scmi_syspower_remove,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_system_power_driver);
+
+module_param(scmi_graceful_request_tmo_ms, uint, 0644);
+MODULE_PARM_DESC(scmi_graceful_request_tmo_ms,
+		 "Maximum time(ms) allowed to userspace for complying to the request.");
+
+module_param(scmi_graceful_poweroff_signum, uint, 0644);
+MODULE_PARM_DESC(scmi_graceful_poweroff_signum,
+		 "Signal to request graceful poweroff to CAD process. Ignored if zero.");
+
+module_param(scmi_graceful_reboot_signum, uint, 0644);
+MODULE_PARM_DESC(scmi_graceful_reboot_signum,
+		 "Signal to request graceful reboot to CAD process. Ignored if zero.");
+
+MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI System Power Control driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

